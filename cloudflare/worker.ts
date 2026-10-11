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
    ...(env.GLYPHORA_ADMIN_EMAIL
      ? { GLYPHORA_ADMIN_EMAIL: env.GLYPHORA_ADMIN_EMAIL }
      : {}),
    ...(env.CLOUDFLARE_ACCOUNT_ID ? { CLOUDFLARE_ACCOUNT_ID: env.CLOUDFLARE_ACCOUNT_ID } : {}),
    ...(env.CLOUDFLARE_R2_BUCKET ? { CLOUDFLARE_R2_BUCKET: env.CLOUDFLARE_R2_BUCKET } : {}),
    ...(env.CLOUDFLARE_R2_PUBLIC_HOST ? { CLOUDFLARE_R2_PUBLIC_HOST: env.CLOUDFLARE_R2_PUBLIC_HOST } : {}),
    ...(env.SERVERPOD_R2_ACCESS_KEY_ID ? { SERVERPOD_R2_ACCESS_KEY_ID: env.SERVERPOD_R2_ACCESS_KEY_ID } : {}),
    ...(env.SERVERPOD_R2_SECRET_KEY ? { SERVERPOD_R2_SECRET_KEY: env.SERVERPOD_R2_SECRET_KEY } : {}),
    GLYPHORA_TRANSCODER: 'cloudflare_stream',
    ...(env.CLOUDFLARE_STREAM_API_TOKEN ? { CLOUDFLARE_STREAM_API_TOKEN: env.CLOUDFLARE_STREAM_API_TOKEN } : {}),
    ...(env.SMTP_EMAIL ? { SMTP_EMAIL: env.SMTP_EMAIL } : {}),
    ...(env.SMTP_APP_PASSWORD
      ? { SMTP_APP_PASSWORD: env.SMTP_APP_PASSWORD }
      : {}),
  };
}

export default {
  fetch(request: Request, environment: { GLYPHORA_SERVER: DurableObjectNamespace }) {
    // Fail closed before Container startup if required Cloudflare credentials
    // are missing. Do not return secret names or values to public callers.
    const required = [
      env.SERVERPOD_PASSWORD_database,
      env.SERVERPOD_PASSWORD_serviceSecret,
      env.SERVERPOD_PASSWORD_jwtHmacSha512PrivateKey,
      env.CLOUDFLARE_ACCOUNT_ID,
      env.CLOUDFLARE_R2_BUCKET,
      env.CLOUDFLARE_R2_PUBLIC_HOST,
      env.SERVERPOD_R2_ACCESS_KEY_ID,
      env.SERVERPOD_R2_SECRET_KEY,
      env.CLOUDFLARE_STREAM_API_TOKEN,
      env.GLYPHORA_CLOUDFLARE_PUBLIC_HOST,
    ];
    if (required.some((value) => typeof value !== 'string' || !value.trim())) {
      return new Response('Glyphora API is not configured.', {
        status: 503,
        headers: { 'cache-control': 'no-store' },
      });
    }
    return getContainer(environment.GLYPHORA_SERVER).fetch(request);
  },
};
