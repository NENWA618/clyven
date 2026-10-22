import { Container, getContainer } from '@cloudflare/containers';
import { env } from 'cloudflare:workers';

/**
 * Proxy the existing Serverpod HTTP API without rewriting Dart endpoints.
 * The current single-instance setting is intentional: review session state,
 * database connections and scheduled background work before scaling out.
 */
export class GlyphoraServer extends Container {
  defaultPort = 8080;
  sleepAfter = '30m';
  enableInternet = true;

  envVars = {
    runmode: 'production',
    role: 'monolith',
    ...(env.GLYPHORA_STAGING ? { GLYPHORA_STAGING: env.GLYPHORA_STAGING } : {}),
    ...(env.GLYPHORA_STAGING_DB_HOST ? { GLYPHORA_STAGING_DB_HOST: env.GLYPHORA_STAGING_DB_HOST } : {}),
    ...(env.GLYPHORA_STAGING_DB_NAME ? { GLYPHORA_STAGING_DB_NAME: env.GLYPHORA_STAGING_DB_NAME } : {}),
    ...(env.GLYPHORA_STAGING_DB_USER ? { GLYPHORA_STAGING_DB_USER: env.GLYPHORA_STAGING_DB_USER } : {}),
    GLYPHORA_REQUIRE_CLOUDFLARE: 'true',
    // Staging-only experiment: test whether startup schema analysis exhausts
    // the configured 5-connection pool. Production retains its existing limit.
    ...(env.GLYPHORA_STAGING === 'true'
      ? { SERVERPOD_DATABASE_MAX_CONNECTION_COUNT: '10' }
      : {}),
    // Explicitly forward fault injection only in staging. Never activate in production.
    ...(env.GLYPHORA_STAGING === 'true' && env.GLYPHORA_DELETE_FAULT_ENABLE === 'true'
      ? {
          GLYPHORA_DELETE_FAULT_ENABLE: 'true',
          ...(env.GLYPHORA_DELETE_FAULT_VIDEO_ID
            ? { GLYPHORA_DELETE_FAULT_VIDEO_ID: env.GLYPHORA_DELETE_FAULT_VIDEO_ID }
            : {}),
          ...(env.GLYPHORA_DELETE_FAULT_STEP
            ? { GLYPHORA_DELETE_FAULT_STEP: env.GLYPHORA_DELETE_FAULT_STEP }
            : {}),
        }
      : {}),
    ...(env.GLYPHORA_CLOUDFLARE_PUBLIC_HOST ? { GLYPHORA_CLOUDFLARE_PUBLIC_HOST: env.GLYPHORA_CLOUDFLARE_PUBLIC_HOST } : {}),
    serverid: 'default',
    ...(env.SERVERPOD_PASSWORD_database
      ? { SERVERPOD_PASSWORD_database: env.SERVERPOD_PASSWORD_database }
      : {}),
    ...(env.SERVERPOD_PASSWORD_serviceSecret
      ? { SERVERPOD_PASSWORD_serviceSecret: env.SERVERPOD_PASSWORD_serviceSecret }
      : {}),
    ...(env.SERVERPOD_PASSWORD_jwtHmacSha512PrivateKey
      ? { SERVERPOD_PASSWORD_jwtHmacSha512PrivateKey: env.SERVERPOD_PASSWORD_jwtHmacSha512PrivateKey }
      : {}),
    ...(env.SERVERPOD_PASSWORD_jwtRefreshTokenHashPepper
      ? { SERVERPOD_PASSWORD_jwtRefreshTokenHashPepper: env.SERVERPOD_PASSWORD_jwtRefreshTokenHashPepper }
      : {}),
    ...(env.SERVERPOD_PASSWORD_emailSecretHashPepper
      ? { SERVERPOD_PASSWORD_emailSecretHashPepper: env.SERVERPOD_PASSWORD_emailSecretHashPepper }
      : {}),
    ...(env.GLYPHORA_ADMIN_EMAIL
      ? { GLYPHORA_ADMIN_EMAIL: env.GLYPHORA_ADMIN_EMAIL }
      : {}),
    ...(env.CLOUDFLARE_ACCOUNT_ID ? { CLOUDFLARE_ACCOUNT_ID: env.CLOUDFLARE_ACCOUNT_ID } : {}),
    ...(env.CLOUDFLARE_R2_BUCKET ? { CLOUDFLARE_R2_BUCKET: env.CLOUDFLARE_R2_BUCKET } : {}),
    ...(env.CLOUDFLARE_R2_PUBLIC_HOST ? { CLOUDFLARE_R2_PUBLIC_HOST: env.CLOUDFLARE_R2_PUBLIC_HOST } : {}),
    ...(env.SERVERPOD_R2_ACCESS_KEY_ID ? { SERVERPOD_R2_ACCESS_KEY_ID: env.SERVERPOD_R2_ACCESS_KEY_ID } : {}),
    ...(env.SERVERPOD_R2_SECRET_KEY ? { SERVERPOD_R2_SECRET_KEY: env.SERVERPOD_R2_SECRET_KEY } : {}),
    // Private R2 credentials are separate from the public R2 token.
    // Staging/prod secrets must be provisioned separately in Cloudflare.
    ...(env.CLOUDFLARE_R2_PRIVATE_BUCKET
      ? { CLOUDFLARE_R2_PRIVATE_BUCKET: env.CLOUDFLARE_R2_PRIVATE_BUCKET }
      : {}),
    ...(env.SERVERPOD_R2_PRIVATE_ACCESS_KEY_ID
      ? { SERVERPOD_R2_PRIVATE_ACCESS_KEY_ID: env.SERVERPOD_R2_PRIVATE_ACCESS_KEY_ID }
      : {}),
    ...(env.SERVERPOD_R2_PRIVATE_SECRET_KEY
      ? { SERVERPOD_R2_PRIVATE_SECRET_KEY: env.SERVERPOD_R2_PRIVATE_SECRET_KEY }
      : {}),
    ...(env.GLYPHORA_PRIVATE_INGEST_KEY
      ? { GLYPHORA_PRIVATE_INGEST_KEY: env.GLYPHORA_PRIVATE_INGEST_KEY }
      : {}),
    ...(env.GLYPHORA_PRIVATE_INGEST_BASE_URL
      ? { GLYPHORA_PRIVATE_INGEST_BASE_URL: env.GLYPHORA_PRIVATE_INGEST_BASE_URL }
      : {}),
    GLYPHORA_TRANSCODER: 'cloudflare_stream',
    ...(env.CLOUDFLARE_STREAM_API_TOKEN ? { CLOUDFLARE_STREAM_API_TOKEN: env.CLOUDFLARE_STREAM_API_TOKEN } : {}),
    ...(env.SMTP_EMAIL ? { SMTP_EMAIL: env.SMTP_EMAIL } : {}),
    ...(env.SMTP_APP_PASSWORD
      ? { SMTP_APP_PASSWORD: env.SMTP_APP_PASSWORD }
      : {}),
  };
}

// GLYPHORA_PRIVATE_INGEST_STAGE3C3
// Temporary origin used solely by Cloudflare Stream URL imports.
// It is NOT a user-facing video playback endpoint.
// The backend must sign `${expires}.${encodedKey}` with HMAC-SHA256.
type GlyphoraIngestEnv = {
  GLYPHORA_SERVER: DurableObjectNamespace;
  GLYPHORA_PRIVATE_R2?: R2Bucket;
  GLYPHORA_PRIVATE_INGEST_KEY?: string;
};

function bytesToHex(bytes: ArrayBuffer): string {
  return Array.from(new Uint8Array(bytes), (b) => b.toString(16).padStart(2, '0')).join('');
}

async function servePrivateStreamImport(request: Request, environment: GlyphoraIngestEnv): Promise<Response> {
  const denied = () => new Response('Not found', { status: 404, headers: { 'Cache-Control': 'no-store' } });
  if (request.method !== 'HEAD' && request.method !== 'GET') return denied();
  const bucket = environment.GLYPHORA_PRIVATE_R2;
  const secret = environment.GLYPHORA_PRIVATE_INGEST_KEY;
  if (!bucket || !secret || secret.length < 32) return denied();

  const url = new URL(request.url);
  const encodedKey = url.pathname.slice('/__glyphora_private_ingest/'.length);
  const expText = url.searchParams.get('exp') ?? '';
  const signature = url.searchParams.get('sig') ?? '';
  if (!/^[A-Za-z0-9_-]{4,2048}$/.test(encodedKey) || !/^\d{10,13}$/.test(expText) ||
      !/^[a-f0-9]{64}$/.test(signature)) return denied();
  const expires = Number(expText);
  const now = Math.floor(Date.now() / 1000);
  // A replayed URL must not outlive its short-lived authorization.
  if (!Number.isSafeInteger(expires) || expires <= now || expires > now + 7200) return denied();

  const keyBytes = await crypto.subtle.importKey('raw', new TextEncoder().encode(secret),
    { name: 'HMAC', hash: 'SHA-256' }, false, ['sign']);
  const expected = bytesToHex(await crypto.subtle.sign('HMAC', keyBytes,
    new TextEncoder().encode(`${expText}.${encodedKey}`)));
  // Compare every position; never rely on an early-exit string comparison.
  let mismatch = 0;
  for (let i = 0; i < 64; i++) mismatch |= expected.charCodeAt(i) ^ signature.charCodeAt(i);
  if (mismatch !== 0) return denied();

  let objectKey: string;
  try {
    const base64 = encodedKey.replace(/-/g, '+').replace(/_/g, '/');
    objectKey = new TextDecoder('utf-8', { fatal: true }).decode(
      Uint8Array.from(atob(base64), (c) => c.charCodeAt(0)));
  } catch { return denied(); }
  if (!/^videos\/[A-Za-z0-9_-]+\/[A-Za-z0-9._-]+$/.test(objectKey)) return denied();

  const head = await bucket.head(objectKey);
  if (!head || head.size <= 0) return denied();
  const baseHeaders = new Headers({
    'Cache-Control': 'no-store, private',
    'Accept-Ranges': 'bytes',
    'Content-Type': head.httpMetadata?.contentType ?? 'application/octet-stream',
  });
  if (request.method === 'HEAD') {
    baseHeaders.set('Content-Length', String(head.size));
    baseHeaders.set('Content-Range', `bytes 0-${head.size - 1}/${head.size}`);
    return new Response(null, { status: 200, headers: baseHeaders });
  }

  const range = request.headers.get('Range');
  if (range && !/^bytes=\d+-\d*$/.test(range) && !/^bytes=-\d+$/.test(range)) {
    baseHeaders.set('Content-Range', `bytes */${head.size}`);
    return new Response(null, { status: 416, headers: baseHeaders });
  }
  const obj = range
    ? await bucket.get(objectKey, { range: request.headers })
    : await bucket.get(objectKey);
  if (!obj || !('body' in obj)) return denied();
  if (range && obj.range) {
    const r = obj.range;
    if ('offset' in r && 'length' in r) {
      baseHeaders.set('Content-Range', `bytes ${r.offset}-${r.offset + r.length - 1}/${obj.size}`);
    } else {
      return denied();
    }
  }
  baseHeaders.set('Content-Length', String(range && obj.range && 'length' in obj.range ? obj.range.length : obj.size));
  return new Response(obj.body, { status: range ? 206 : 200, headers: baseHeaders });
}

export class GlyphoraServerStaging extends GlyphoraServer {}

export default {
  async fetch(request: Request, environment: GlyphoraIngestEnv) {
    if (new URL(request.url).pathname.startsWith('/__glyphora_private_ingest/')) {
      return servePrivateStreamImport(request, environment);
    }
    // Fail closed before Container startup if required Cloudflare credentials
    // are missing. Do not return secret names or values to public callers.
    const required = [
      env.SERVERPOD_PASSWORD_database,
      env.SERVERPOD_PASSWORD_serviceSecret,
      env.SERVERPOD_PASSWORD_jwtHmacSha512PrivateKey,
      env.SERVERPOD_PASSWORD_jwtRefreshTokenHashPepper,
      env.SERVERPOD_PASSWORD_emailSecretHashPepper,
      env.CLOUDFLARE_ACCOUNT_ID,
      env.CLOUDFLARE_R2_BUCKET,
      env.CLOUDFLARE_R2_PUBLIC_HOST,
      env.SERVERPOD_R2_ACCESS_KEY_ID,
      env.SERVERPOD_R2_SECRET_KEY,
      env.CLOUDFLARE_STREAM_API_TOKEN,
      env.GLYPHORA_CLOUDFLARE_PUBLIC_HOST,
    ];
    // Staging requests must never spin up a Container with production DB settings.
    // The container validates them again, but reject at the edge before startup.
    if (env.GLYPHORA_STAGING === 'true') {
      const dbHost = env.GLYPHORA_STAGING_DB_HOST?.trim();
      const dbName = env.GLYPHORA_STAGING_DB_NAME?.trim();
      const dbUser = env.GLYPHORA_STAGING_DB_USER?.trim();
      if (
        !dbHost ||
        !dbName ||
        !dbUser ||
        dbHost === 'ep-wandering-frog-azudrqv6.c-3.ap-southeast-1.aws.neon.tech' ||
        dbName === 'neondb' ||
        dbUser === 'neondb_owner'
      ) {
        return new Response('Glyphora staging database is not configured.', {
          status: 503,
          headers: { 'cache-control': 'no-store' },
        });
      }
    }
    if (required.some((value) => typeof value !== 'string' || !value.trim())) {
      return new Response('Glyphora API is not configured.', {
        status: 503,
        headers: { 'cache-control': 'no-store' },
      });
    }
    return getContainer(environment.GLYPHORA_SERVER).fetch(request);
  },
};
