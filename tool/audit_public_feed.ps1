param(
    [string]$ApiBase = 'https://glyphora-server-11129163384.asia-southeast1.run.app',
    [int[]]$PostIds = @(9, 17, 15),
    [string]$OutputPath = 'build/public-feed-audit.json'
)

$ErrorActionPreference = 'Stop'
$api = $ApiBase.TrimEnd('/')
function Read-Feed([string]$type) {
    $rows = Invoke-RestMethod -Uri "$api/video" -Method Post `
        -ContentType 'application/json' -Body (@{method = 'getVideos'; contentType = $type} | ConvertTo-Json)
    foreach ($row in $rows) { Write-Output $row }
}
$videos = @(Read-Feed 'video')
$shorts = @(Read-Feed 'short')
$records = @($videos | Where-Object { $_.id -in $PostIds })
$resources = @()
foreach ($record in $records) {
    foreach ($field in @('videoStorageKey', 'coverStorageKey')) {
        $key = $record.$field
        if (!$key) { continue }
        $url = Invoke-RestMethod -Uri "$api/video" -Method Post `
            -ContentType 'application/json' -Body (@{method = 'getVideoUrl'; path = $key} | ConvertTo-Json)
        $status = $null
        $failure = $null
        try {
            $response = Invoke-WebRequest -Uri $url -Method Head -UseBasicParsing
            $status = [int]$response.StatusCode
        } catch {
            if ($_.Exception.Response) { $status = [int]$_.Exception.Response.StatusCode }
            $failure = $_.Exception.GetType().Name
        }
        # Strip query/fragment in case storage uses signed URLs in the future.
        $safeUrl = if ($url) { ([uri]$url).GetLeftPart([System.UriPartial]::Path) } else { $null }
        $resources += @{postId = $record.id; field = $field; url = $safeUrl; httpStatus = $status; failure = $failure}
    }
}
$report = [ordered]@{
    capturedAtUtc = [DateTime]::UtcNow.ToString('o')
    api = $api
    authentication = 'anonymous; no credentials sent'
    source = 'deployed API records, not a direct database SQL dump'
    videoIds = @($videos.id)
    shortIds = @($shorts.id)
    records = $records
    resources = $resources
}
$directory = Split-Path -Parent $OutputPath
if ($directory) { New-Item -ItemType Directory -Force -Path $directory | Out-Null }
$report | ConvertTo-Json -Depth 20 | Set-Content -LiteralPath $OutputPath -Encoding utf8
Write-Output "Saved public record and media audit: $OutputPath"
$resources | Select-Object postId, field, httpStatus, failure | Format-Table
