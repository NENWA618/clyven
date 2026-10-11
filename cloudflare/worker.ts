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
    ...(env.SMTP_EMAIL ? { SMTP_EMAIL: env.SMTP_EMAIL } : {}),
    ...(env.SMTP_APP_PASSWORD
      ? { SMTP_APP_PASSWORD: env.SMTP_APP_PASSWORD }
      : {}),
  };
}

export default {
  fetch(request: Request, environment: { GLYPHORA_SERVER: DurableObjectNamespace }) {
    return getContainer(environment.GLYPHORA_SERVER).fetch(request);
  },
};
