### Goal:
Build a comprehensive configuration file management tool named `config_updater.sh` that safely modifies configuration files with backups, validation, and rollback capabilities.
### Requirements:

**Core Functionality:**
1. **Update Configuration Values:**
   - Detect config format (INI, YAML, JSON, ENV, XML)
   - Parse key-value pairs
   - Update values while preserving format
   - Handle nested configurations
   - Preserve comments
   - Maintain indentation

2. **Safety Features:**
   - Always create timestamped backups
   - Validate syntax before/after changes
   - Atomic operations (all or nothing)
   - Rollback capability
   - Change preview
   - Diff viewer

3. **Supported Formats:**
   - **INI files:** `key=value`, `[section]`
   - **ENV files:** `KEY=value`
   - **YAML:** indentation-based
   - **JSON:** structured data
   - **Properties:** Java-style
   - **TOML:** modern config format
   - **Apache/Nginx:** specific syntax

4. **Operations:**
   - Set value (create or update)
   - Get value (query)
   - Delete key
   - Add section
   - Comment/uncomment lines
   - Validate configuration
   - Merge configurations
   - Compare versions

5. **Advanced Features:**
   - Template variable substitution
   - Environment-specific configs (dev/staging/prod)
   - Batch updates from file
   - Configuration drift detection
   - Secret management (mask passwords)
   - Schema validation
   - Auto-formatting
   - Migration between formats
### Expected Output Example:
```bash
./config_updater.sh --file config.ini --set "database.host=localhost"
```
```
╔════════════════════════════════════════════════════════════════╗
║           CONFIGURATION FILE UPDATER v1.0                      ║
╚════════════════════════════════════════════════════════════════╝

Target file: config.ini
Format detected: INI
Operation: SET database.host = localhost

Analyzing configuration...
────────────────────────────────────────────────────────────────
File size: 2.3 KB
Lines: 87
Sections: 4 ([database], [cache], [logging], [api])
Comments: 23

Current configuration:
────────────────────────────────────────────────────────────────
[database]
host=db.example.com
port=5432
name=production
user=admin
# password is encrypted
password=${DB_PASSWORD}

Changes to be made:
────────────────────────────────────────────────────────────────
Section: [database]
Key: host
Old value: db.example.com
New value: localhost

Preview:
────────────────────────────────────────────────────────────────
[database]
- host=db.example.com
+ host=localhost
  port=5432
  name=production
  user=admin
  # password is encrypted
  password=${DB_PASSWORD}

Validation:
────────────────────────────────────────────────────────────────
✓ Syntax check passed
✓ All required keys present
✓ No duplicate sections
⚠ Warning: Changing host from remote to localhost
   This may affect production connectivity

Apply change? [y/n/d] (d=detailed preview): y

Creating backup...
✓ Backup created: config.ini.backup.20251019_232600

Applying changes...
✓ Configuration updated successfully

Validating updated file...
✓ Syntax validation passed
✓ Configuration is valid

╔════════════════════════════════════════════════════════════════╗
║                    UPDATE COMPLETE                             ║
╚════════════════════════════════════════════════════════════════╝

Summary:
────────────────────────────────────────────────────────────────
File: config.ini
Operation: SET database.host
Old value: db.example.com
New value: localhost
Backup: config.ini.backup.20251019_232600

To rollback:
  ./config_updater.sh --rollback config.ini.backup.20251019_232600

To verify:
  ./config_updater.sh --get database.host config.ini
```

```bash
./config_updater.sh --file app.yaml --batch updates.txt
```
```
╔════════════════════════════════════════════════════════════════╗
║         BATCH CONFIGURATION UPDATE                             ║
╚════════════════════════════════════════════════════════════════╝

Target: app.yaml
Update file: updates.txt
Format: YAML

Loading batch updates...
────────────────────────────────────────────────────────────────
Found 8 updates to apply:

1. server.port: 8080 → 9000
2. server.host: 0.0.0.0 → localhost
3. logging.level: info → debug
4. database.pool.size: 10 → 20
5. cache.enabled: true → false
6. api.timeout: 30 → 60
7. features.new_ui: false → true
8. monitoring.enabled: false → true

Current vs. New Configuration:
────────────────────────────────────────────────────────────────
server:
- port: 8080
+ port: 9000
- host: 0.0.0.0
+ host: localhost

logging:
- level: info
+ level: debug

database:
  pool:
-   size: 10
+   size: 20

cache:
- enabled: true
+ enabled: false

api:
- timeout: 30
+ timeout: 60

features:
- new_ui: false
+ new_ui: true

monitoring:
- enabled: false
+ enabled: true

Validation Results:
────────────────────────────────────────────────────────────────
✓ YAML syntax valid
✓ All paths exist or will be created
✓ Type constraints satisfied
⚠ Warning: Disabling cache may impact performance
⚠ Warning: Debug logging increases disk usage

Impact Analysis:
────────────────────────────────────────────────────────────────
Performance impact:  Medium (cache disabled)
Security impact:     Low
Compatibility:       High (all changes backward compatible)
Risk level:          Medium

Apply all 8 updates? [y/n/s] (s=selective): y

Creating backup...
✓ Backup: app.yaml.backup.20251019_232615

Applying updates...
1/8 ████░░░░░░░░░░░░░░░░░░░░░░░░░░  server.port
2/8 ████████░░░░░░░░░░░░░░░░░░░░░░  server.host
3/8 ████████████░░░░░░░░░░░░░░░░░░  logging.level
4/8 ████████████████░░░░░░░░░░░░░░  database.pool.size
5/8 ████████████████████░░░░░░░░░░  cache.enabled
6/8 ████████████████████████░░░░░░  api.timeout
7/8 ████████████████████████████░░  features.new_ui
8/8 ████████████████████████████████ monitoring.enabled

✓ All 8 updates applied successfully

Post-update validation...
✓ YAML syntax valid
✓ Configuration schema valid
✓ No conflicts detected

╔════════════════════════════════════════════════════════════════╗
║                  BATCH UPDATE COMPLETE                         ║
╚════════════════════════════════════════════════════════════════╝

Summary:
────────────────────────────────────────────────────────────────
Updates applied: 8 of 8 (100%)
Warnings: 2
Errors: 0
Backup: app.yaml.backup.20251019_232615

Changes by category:
  Server config:    2 changes
  Database:         1 change
  Performance:      2 changes
  Features:         2 changes
  Monitoring:       1 change

Recommendations:
────────────────────────────────────────────────────────────────
⚠ Test application with cache disabled
⚠ Monitor disk space with debug logging
✓ New features enabled - review documentation
✓ Monitoring enabled - configure alerts

Next steps:
────────────────────────────────────────────────────────────────
1. Restart application to apply changes
2. Verify functionality in staging
3. Monitor logs for issues
4. Update documentation if needed

Restart command:
  sudo systemctl restart myapp
```

```bash
./config_updater.sh --compare config.ini config.ini.backup.20251019_232600
```
```
╔════════════════════════════════════════════════════════════════╗
║           CONFIGURATION COMPARISON                             ║
╚════════════════════════════════════════════════════════════════╝

File 1 (Current):  config.ini
File 2 (Backup):   config.ini.backup.20251019_232600

Differences found: 3

══════════════════════════════════════════════════════════════
SECTION: [database]
══════════════════════════════════════════════════════════════

Changed Keys:
────────────────────────────────────────────────────────────────
host:
  Old: db.example.com
  New: localhost
  Changed: 2025-10-19 23:26:00

port:
  Old: 5432
  New: 5433
  Changed: 2025-10-19 23:26:15

══════════════════════════════════════════════════════════════
SECTION: [cache]
══════════════════════════════════════════════════════════════

Changed Keys:
────────────────────────────────────────────────────────────────
ttl:
  Old: 3600
  New: 7200
  Changed: 2025-10-19 23:26:20

Summary:
────────────────────────────────────────────────────────────────
Total changes: 3
Sections affected: 2
Keys modified: 3
Keys added: 0
Keys removed: 0

Drift analysis:
────────────────────────────────────────────────────────────────
Time since backup: 2 minutes
Change rate: 1.5 changes/minute
Risk level: Low (few changes)

Actions:
────────────────────────────────────────────────────────────────
[1] Rollback to backup
[2] Export diff to file
[3] Merge changes
[4] Exit

Select action [1-4]:
```
### Bonus Challenges:
**Level 1 (Intermediate):**
- Add configuration templating (Jinja2-style)
- Support encrypted values
- Add configuration inheritance
- Create configuration profiles
- Add validation schemas (JSON Schema)
- Support includes/imports
- Add variable interpolation
- Create configuration migration tools

**Level 2 (Advanced):**
- Build configuration management system
- Add version control integration (git)
- Create configuration drift detection
- Add compliance checking
- Support remote configuration (HTTP/S3)
- Add multi-environment management
- Create configuration as code
- Add secret rotation

**Level 3 (Expert):**
- Build distributed configuration service
- Add real-time configuration sync
- Create configuration policies
- Add audit logging and compliance
- Support A/B testing configs
- Add canary deployments
- Create configuration analytics
- Build self-healing configurations