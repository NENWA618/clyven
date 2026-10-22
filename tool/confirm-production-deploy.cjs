const { spawnSync } = require('node:child_process');

if (process.env.GLYPHORA_CONFIRM_PRODUCTION_DEPLOY !== 'yes') {
  console.error(
    'Production deployment blocked. Set GLYPHORA_CONFIRM_PRODUCTION_DEPLOY=yes to deploy.'
  );
  process.exit(1);
}

const result = spawnSync(
  process.platform === 'win32' ? 'npx.cmd' : 'npx',
  ['wrangler', 'deploy', '--config', 'wrangler.jsonc'],
  { stdio: 'inherit', shell: process.platform === 'win32' }
);

process.exit(result.status ?? 1);