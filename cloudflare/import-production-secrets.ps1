param(
    [string]$WorkerName = "glyphora-api",
    [switch]$AllowProductionSecretDeployment
)

$ErrorActionPreference = "Stop"

if ($WorkerName -ne "glyphora-api") {
    throw "This script only supports glyphora-api."
}

if (-not $AllowProductionSecretDeployment) {
    throw "Blocked: explicit deployment permission is required."
}

# Refuse to create a new Worker accidentally.
npx wrangler deployments list --name $WorkerName *> $null
if ($LASTEXITCODE -ne 0) {
    throw "Production Worker does not exist. Complete initial deployment first."
}

$mapPath = Join-Path $PSScriptRoot "production-secret-map.txt"

foreach ($line in Get-Content $mapPath -Encoding UTF8) {
    $line = $line.Trim()
    if (-not $line -or $line.StartsWith("#")) {
        continue
    }

    if ($line -notmatch '^([A-Za-z_][A-Za-z0-9_]*)=([A-Za-z0-9_-]+):([0-9]+)$') {
        throw "Invalid secret mapping."
    }

    $envName = $Matches[1]
    $secretName = $Matches[2]
    $version = $Matches[3]

    $tempFile = Join-Path $env:TEMP (
        "glyphora-secret-" + [guid]::NewGuid().ToString("N") + ".bin"
    )

    try {
        Write-Host "Transferring $envName ..."

        & gcloud secrets versions access $version `
            "--secret=$secretName" `
            "--out-file=$tempFile"

        if ($LASTEXITCODE -ne 0) {
            throw "Google Secret Manager read failed: $envName"
        }

        if (-not (Test-Path $tempFile) -or
            (Get-Item $tempFile).Length -eq 0) {
            throw "Secret is empty: $envName"
        }

        $command = 'npx wrangler secret put "{0}" --name "{1}" < "{2}"' -f `
            $envName, $WorkerName, $tempFile

        & cmd.exe /d /c $command

        if ($LASTEXITCODE -ne 0) {
            throw "Cloudflare upload failed: $envName"
        }

        Write-Host "Transferred: $envName"
    }
    finally {
        if (Test-Path $tempFile) {
            Remove-Item $tempFile -Force
        }
    }
}

Write-Host "Production Secret transfer completed."