### Goal:
Create a script named `config_generator.sh` that generates various configuration files using here documents.
### Requirements:
- Generate multiple config formats (INI, YAML, JSON, ENV)
- Support variable substitution
- Validate configuration values
- Create multiple config files from template
- Support configuration profiles (dev/staging/prod)
- Include comments and documentation
- Validate syntax after generation
- Backup existing configs
- Support config merging
- Generate with proper permissions
### Expected Output Example:
```bash
./config_generator.sh --format ini --profile production
```
```
╔════════════════════════════════════════════════════════════════╗
║         CONFIGURATION FILE GENERATOR                           ║
╚════════════════════════════════════════════════════════════════╝

Configuration:
────────────────────────────────────────────────────────────────
Format: INI
Profile: production
Output: /etc/myapp/config.ini

Loading profile settings...
✓ Production profile loaded

Variables:
────────────────────────────────────────────────────────────────
APP_NAME:        MyApplication
ENVIRONMENT:     production
SERVER_HOST:     prod.example.com
SERVER_PORT:     443
DATABASE_HOST:   db.example.com
DATABASE_PORT:   5432
DATABASE_NAME:   myapp_prod
CACHE_ENABLED:   true
LOG_LEVEL:       warning

Generating configuration file...
────────────────────────────────────────────────────────────────

Preview:
────────────────────────────────────────────────────────────────
# MyApplication Configuration
# Generated: 2025-10-20 00:06:00
# Profile: production
# DO NOT EDIT MANUALLY

[application]
name = MyApplication
environment = production
version = 2.5.3

[server]
host = prod.example.com
port = 443
ssl_enabled = true
workers = 4

[database]
host = db.example.com
port = 5432
name = myapp_prod
user = myapp_user
pool_size = 20
timeout = 30

[cache]
enabled = true
host = cache.example.com
port = 6379
ttl = 3600

[logging]
level = warning
file = /var/log/myapp/app.log
max_size = 100MB
rotation = daily

[security]
secret_key = ${SECRET_KEY}
session_timeout = 3600
csrf_protection = true
────────────────────────────────────────────────────────────────

Backup check:
✓ Existing config backed up to: /etc/myapp/config.ini.bak.20251020_000600

Writing configuration file...
████████████████████████████████████████ 100%

Validating configuration...
────────────────────────────────────────────────────────────────
✓ Syntax validation passed
✓ Required fields present
✓ Value types correct
✓ Port numbers valid (1-65535)
✓ File paths accessible

Setting permissions...
✓ File permissions: 640 (rw-r-----)
✓ Owner: myapp:myapp

╔════════════════════════════════════════════════════════════════╗
║              CONFIGURATION GENERATED                           ║
╚════════════════════════════════════════════════════════════════╝

Output file: /etc/myapp/config.ini
Size: 856 bytes
Backup: /etc/myapp/config.ini.bak.20251020_000600

To apply changes:
  sudo systemctl restart myapp
```

```bash
./config_generator.sh --format yaml --profile development
```
```
╔════════════════════════════════════════════════════════════════╗
║         CONFIGURATION FILE GENERATOR (YAML)                    ║
╚════════════════════════════════════════════════════════════════╝

Generating YAML configuration...

Preview:
────────────────────────────────────────────────────────────────
# MyApplication Configuration (YAML)
# Generated: 2025-10-20 00:06:05
# Profile: development

application:
  name: MyApplication
  environment: development
  version: 2.5.3
  debug: true

server:
  host: localhost
  port: 8080
  ssl_enabled: false
  workers: 2
  reload: true  # Auto-reload for development

database:
  host: localhost
  port: 5432
  name: myapp_dev
  user: dev_user
  password: ${DB_PASSWORD}
  pool_size: 5
  echo_sql: true  # Log all SQL queries

cache:
  enabled: false  # Disabled for development

logging:
  level: debug
  file: ./logs/dev.log
  console: true
  format: detailed

features:
  - api_v2
  - admin_panel
  - debug_toolbar
────────────────────────────────────────────────────────────────

✓ YAML syntax validated with yamllint

Output file: config/development.yaml
```

```bash
./config_generator.sh --format json --profile testing
```
```
Generating JSON configuration...

Preview:
────────────────────────────────────────────────────────────────
{
  "application": {
    "name": "MyApplication",
    "environment": "testing",
    "version": "2.5.3"
  },
  "server": {
    "host": "test.example.com",
    "port": 8080,
    "ssl_enabled": false
  },
  "database": {
    "host": "testdb.example.com",
    "port": 5432,
    "name": "myapp_test",
    "pool_size": 10
  },
  "testing": {
    "parallel": true,
    "coverage": true,
    "verbose": true
  },
  "logging": {
    "level": "info",
    "file": "/var/log/myapp/test.log"
  }
}
────────────────────────────────────────────────────────────────

✓ JSON syntax validated with jq

Output file: config/testing.json
```
### Bonus Challenge:
- Add config encryption support
- Implement config versioning
- Support config inheritance
- Add config diffing
- Create config migration tools
- Support remote config (etcd, Consul)
- Add config validation schemas
- Implement config hot-reload

***