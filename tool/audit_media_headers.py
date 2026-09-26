"""Read bounded public MP4 byte ranges; inspect container/codec, not image content."""
import json
import struct
import urllib.request
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
audit = json.loads((ROOT / 'build/public-feed-audit.json').read_text(encoding='utf-8-sig'))
output = []

def boxes(data, begin=0, end=None):
    end = min(len(data), end if end is not None else len(data))
    pos = begin
    while pos + 8 <= end:
        size, kind = struct.unpack_from('>I4s', data, pos)
        header = 8
        if size == 1:
            if pos + 16 > end:
                return
            size = struct.unpack_from('>Q', data, pos + 8)[0]
            header = 16
        if size == 0:
            size = end - pos
        if size < header:
            return
        yield kind.decode('ascii', errors='replace'), pos + header, min(pos + size, end), size
        pos += size

def tracks(data, start=0, end=None):
    found = []
    for kind, payload, finish, size in boxes(data, start, end):
        if kind in ('moov', 'trak', 'mdia', 'minf', 'stbl'):
            found.extend(tracks(data, payload, finish))
        elif kind == 'stsd':
            for codec, entry, entry_end, entry_size in boxes(data, payload + 8, finish):
                record = {'codec': codec}
                if codec in ('avc1', 'avc3', 'hvc1', 'hev1', 'av01', 'vp09') and entry + 28 <= entry_end:
                    record['width'], record['height'] = struct.unpack_from('>HH', data, entry + 24)
                    for config, config_start, config_end, _ in boxes(data, entry + 78, entry_end):
                        if config == 'avcC' and config_start + 4 <= config_end:
                            record['avcProfile'] = data[config_start + 1]
                            record['avcLevel'] = data[config_start + 3]
                found.append(record)
    return found

for resource in audit['resources']:
    if resource['field'] != 'videoStorageKey':
        continue
    request = urllib.request.Request(resource['url'], headers={'Range': 'bytes=0-1048575'})
    with urllib.request.urlopen(request, timeout=30) as response:
        data = response.read(1048576)
        output.append({
            'postId': resource['postId'], 'httpStatus': response.status,
            'contentType': response.headers.get('Content-Type'),
            'contentRange': response.headers.get('Content-Range'),
            'bytesInspected': len(data),
            'topLevelBoxes': [kind for kind, _, _, _ in boxes(data)],
            'sampleDescriptions': tracks(data),
        })

path = ROOT / 'build/media-header-audit.json'
path.write_text(json.dumps(output, indent=2), encoding='utf-8')
print(json.dumps(output, indent=2))
