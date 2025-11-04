### Goal:
Build a production-ready installer script named `robust_installer.sh` that installs software with comprehensive error handling, validation, and rollback capabilities.
### Requirements:
**Core Installation Features:**
- Pre-installation validation
- Dependency checking
- Download and verify packages
- Install with progress tracking
- Post-installation configuration
- Verification tests
- Complete uninstallation
- Upgrade support

**Error Handling:**
- Comprehensive error checking at every step
- Meaningful error messages
- Error categorization (recoverable/fatal)
- Error logging with timestamps
- Stack traces for debugging

**Rollback Capabilities:**
- Transaction-like behavior (all-or-nothing)
- Automatic rollback on failure
- State snapshots before changes
- Restore previous state
- Rollback verification
- Manual rollback support

**Safety Features:**
- Dry-run mode (simulate installation)
- Backup before changes
- Disk space validation
- Permission checking
- Conflict detection
- Recovery from partial installs

**User Experience:**
- Interactive mode with confirmations
- Silent mode for automation
- Progress indicators
- Status updates
- Clear success/failure messages
- Post-install instructions
### Expected Output Example:
```bash
sudo ./robust_installer.sh --package myapp
```

```
╔════════════════════════════════════════════════════════════════╗
║         ROBUST APPLICATION INSTALLER v1.0                      ║
║         Package: myapp v2.5.3                                  ║
╚════════════════════════════════════════════════════════════════╝

[INFO] Installation initiated
[INFO] User: root
[INFO] Date: 2025-10-19 23:54:00
[INFO] Installation ID: inst_20251019_235400_12345

══════════════════════════════════════════════════════════════
PHASE 1: PRE-INSTALLATION VALIDATION
══════════════════════════════════════════════════════════════

System Requirements Check:
────────────────────────────────────────────────────────────────
✓ Operating System: Ubuntu 22.04 LTS (supported)
✓ Architecture: x86_64 (supported)
✓ Kernel: 5.15.0-91-generic (minimum: 4.0)
✓ Bash version: 5.1.16 (minimum: 4.0)

Resource Requirements:
────────────────────────────────────────────────────────────────
✓ Disk space: 45.2 GB available (required: 500 MB)
✓ Memory: 8.5 GB available (required: 512 MB)
✓ CPU cores: 8 available (recommended: 2)

Permission Check:
────────────────────────────────────────────────────────────────
✓ Running as root
✓ Write access: /usr/local/bin
✓ Write access: /etc/myapp
✓ Write access: /var/log/myapp

Dependency Check:
────────────────────────────────────────────────────────────────
✓ Required: python3 (found: v3.10.12)
✓ Required: curl (found: v7.81.0)
✓ Required: tar (found: v1.34)
✓ Optional: docker (found: v24.0.7)
⚠ Optional: nodejs (not found - some features unavailable)

Conflict Detection:
────────────────────────────────────────────────────────────────
ℹ Checking for existing installations...
⚠ Found previous installation: myapp v2.3.1
  Location: /usr/local/myapp
  Status: Inactive
  
Action required: This will upgrade from v2.3.1 to v2.5.3

Network Connectivity:
────────────────────────────────────────────────────────────────
✓ Internet connection: Available
✓ Download server: Reachable (downloads.myapp.com)
✓ License server: Reachable (license.myapp.com)

[INFO] Pre-installation validation: PASSED
[INFO] Creating installation snapshot...

Snapshot Created:
────────────────────────────────────────────────────────────────
Snapshot ID: snap_20251019_235401
Backup location: /var/backups/myapp/snap_20251019_235401.tar.gz
Size: 12.3 MB
Files backed up: 47

═════════════════════════════════════════════════════════════
PHASE 2: DOWNLOAD & VERIFICATION
══════════════════════════════════════════════════════════════

Downloading myapp v2.5.3...
────────────────────────────────────────────────────────────────
Source: https://downloads.myapp.com/myapp-2.5.3.tar.gz
████████████████████████████████████████ 100% (45.6 MB / 45.6 MB)
Download speed: 12.3 MB/s
Time elapsed: 3.7 seconds

✓ Download complete: /tmp/myapp-2.5.3.tar.gz

Verifying package integrity...
────────────────────────────────────────────────────────────────
[1/3] Checking file integrity...
  → File size: 45.6 MB (expected: 45.6 MB) ✓
  
[2/3] Verifying checksums...
  → MD5: 5d41402abc4b2a76b9719d911017c592 ✓
  → SHA256: 2c26b46b68ffc68ff99b453c1d30413413422d706483bfa0f98a5e886266e7ae ✓
  
[3/3] Verifying GPG signature...
  → Signature: Valid ✓
  → Signed by: MyApp Release Team <release@myapp.com>
  → Key ID: 0x1234ABCD
  → Trust level: Ultimate ✓

✓ Package verification: PASSED

Extracting package...
────────────────────────────────────────────────────────────────
Destination: /tmp/myapp-install-12345/
████████████████████████████████████████ 100%

✓ Extraction complete (1,247 files extracted)

Validating package contents...
────────────────────────────────────────────────────────────────
✓ Required binaries: Present
✓ Configuration files: Present
✓ Documentation: Present
✓ License files: Present

══════════════════════════════════════════════════════════════
PHASE 3: INSTALLATION
══════════════════════════════════════════════════════════════

Installation Summary:
────────────────────────────────────────────────────────────────
Action: Upgrade
Current version: v2.3.1 → New version: v2.5.3
Installation path: /usr/local/myapp
Configuration: /etc/myapp
Data directory: /var/lib/myapp
Log directory: /var/log/myapp

Confirm installation? [Y/n]: y

[INFO] Starting installation...

[Step 1/8] Stopping existing services...
────────────────────────────────────────────────────────────────
→ Stopping myapp service...
  systemctl stop myapp
  ✓ Service stopped (PID 45678 terminated)

[Step 2/8] Backing up configuration...
────────────────────────────────────────────────────────────────
→ Backing up /etc/myapp/config.yaml
  ✓ Backup created: /var/backups/myapp/config.yaml.bak
→ Backing up /etc/myapp/secrets.conf
  ✓ Backup created: /var/backups/myapp/secrets.conf.bak

[Step 3/8] Installing binaries...
────────────────────────────────────────────────────────────────
→ Installing myapp binary to /usr/local/bin/
  ✓ Binary installed (15.2 MB)
→ Installing myapp-cli to /usr/local/bin/
  ✓ Binary installed (3.4 MB)
→ Setting permissions (755)
  ✓ Permissions set

[Step 4/8] Installing libraries...
────────────────────────────────────────────────────────────────
→ Installing to /usr/local/lib/myapp/
  ████████████████████████████████████████ 100% (234 files)
  ✓ Libraries installed (23.4 MB)

[Step 5/8] Installing configuration...
────────────────────────────────────────────────────────────────
→ Creating configuration directory: /etc/myapp/
  ✓ Directory created
→ Installing default configuration
  ✓ config.yaml installed
→ Merging with existing configuration
  ✓ Settings preserved
→ Installing systemd service file
  ✓ Service file installed: /etc/systemd/system/myapp.service

[Step 6/8] Setting up data directories...
────────────────────────────────────────────────────────────────
→ Creating /var/lib/myapp/
  ✓ Data directory created
→ Creating /var/log/myapp/
  ✓ Log directory created
→ Setting permissions
  ✓ Ownership: myapp:myapp
  ✓ Permissions: 750

[Step 7/8] Running post-install scripts...
────────────────────────────────────────────────────────────────
→ Running database migrations...
  Migration 001_initial_schema... ✓
  Migration 002_add_users_table... ✓
  Migration 003_add_indexes... ✓
  ✓ All migrations applied (3/3)

→ Generating SSL certificates...
  ✓ Certificate generated: /etc/myapp/ssl/cert.pem
  ✓ Private key generated: /etc/myapp/ssl/key.pem

→ Initializing cache...
  ✓ Cache initialized

[Step 8/8] Starting services...
────────────────────────────────────────────────────────────────
→ Reloading systemd daemon
  ✓ Daemon reloaded
→ Enabling myapp service
  ✓ Service enabled (starts on boot)
→ Starting myapp service
  ✓ Service started (PID 67890)

══════════════════════════════════════════════════════════════
PHASE 4: VERIFICATION
══════════════════════════════════════════════════════════════

Running post-installation tests...
────────────────────────────────────────────────────────────────
[Test 1/5] Service status check...
  → Checking if service is running
  ✓ Service is active and running

[Test 2/5] Binary verification...
  → Testing myapp binary
  $ myapp --version
  myapp v2.5.3
  ✓ Binary works correctly

[Test 3/5] Configuration validation...
  → Parsing configuration files
  ✓ Configuration is valid

[Test 4/5] Network connectivity test...
  → Testing HTTP endpoint
  $ curl -s http://localhost:8080/health
  {"status": "healthy"}
  ✓ Application responding on port 8080

[Test 5/5] Database connection test...
  → Testing database connectivity
  ✓ Database connection successful

All verification tests: PASSED ✓

══════════════════════════════════════════════════════════════
INSTALLATION COMPLETE
══════════════════════════════════════════════════════════════

Summary:
────────────────────────────────────────────────────────────────
✓ Installation successful
✓ Version: v2.5.3
✓ Installation time: 45.6 seconds
✓ All tests passed

Installed Components:
────────────────────────────────────────────────────────────────
• Binary: /usr/local/bin/myapp
• CLI tool: /usr/local/bin/myapp-cli
• Configuration: /etc/myapp/
• Service: myapp.service (enabled)
• Data: /var/lib/myapp/
• Logs: /var/log/myapp/

Service Information:
────────────────────────────────────────────────────────────────
Status: Active (running)
PID: 67890
Port: 8080
URL: http://localhost:8080

Next Steps:
────────────────────────────────────────────────────────────────
1. Review configuration:
   sudo nano /etc/myapp/config.yaml

2. View logs:
   sudo journalctl -u myapp -f

3. Access web interface:
   http://localhost:8080

4. Read documentation:
   man myapp
   /usr/share/doc/myapp/README.md

Useful Commands:
────────────────────────────────────────────────────────────────
Start service:    sudo systemctl start myapp
Stop service:     sudo systemctl stop myapp
Restart service:  sudo systemctl restart myapp
Check status:     sudo systemctl status myapp
View logs:        sudo journalctl -u myapp

Uninstall:
────────────────────────────────────────────────────────────────
To uninstall: sudo ./robust_installer.sh --uninstall

Backups:
────────────────────────────────────────────────────────────────
Installation snapshot: /var/backups/myapp/snap_20251019_235401.tar.gz
Configuration backup: /var/backups/myapp/*.bak

Installation log: /var/log/installer/myapp_20251019_235400.log

Thank you for installing myapp!
```

**With error and automatic rollback:**
```bash
sudo ./robust_installer.sh --package myapp
```

```
[... installation proceeds normally until ...]

══════════════════════════════════════════════════════════════
PHASE 3: INSTALLATION
══════════════════════════════════════════════════════════════

[Step 1/8] Stopping existing services... ✓
[Step 2/8] Backing up configuration... ✓
[Step 3/8] Installing binaries... ✓
[Step 4/8] Installing libraries... ✓
[Step 5/8] Installing configuration... ✓
[Step 6/8] Setting up data directories...
────────────────────────────────────────────────────────────────
→ Creating /var/lib/myapp/
  ✗ ERROR: Insufficient disk space

[ERROR] Installation failed at step 6/8

Error Details:
────────────────────────────────────────────────────────────────
Error Type: INSUFFICIENT_DISK_SPACE
Required: 500 MB
Available: 234 MB
Location: /var/lib/myapp
Line: 234
Function: create_data_directory

══════════════════════════════════════════════════════════════
INITIATING AUTOMATIC ROLLBACK
══════════════════════════════════════════════════════════════

[INFO] Rolling back changes to restore system state...

Rollback Progress:
────────────────────────────────────────────────────────────────
[1/6] Restoring previous version...
  → Stopping failed installation services
  ✓ Services stopped

[2/6] Removing newly installed files...
  → Removing /usr/local/bin/myapp
  ✓ Binary removed
  → Removing /usr/local/lib/myapp/
  ✓ Libraries removed (234 files)

[3/6] Restoring configuration...
  → Restoring /etc/myapp/config.yaml
  ✓ Configuration restored from backup
  → Restoring /etc/myapp/secrets.conf
  ✓ Secrets restored from backup

[4/6] Restoring previous version...
  → Reinstalling myapp v2.3.1 from snapshot
  ✓ Previous version restored

[5/6] Restarting services...
  → Starting myapp service (previous version)
  ✓ Service started (PID 78901)

[6/6] Verifying rollback...
  → Checking service status
  ✓ Service is running
  → Testing functionality
  ✓ Application responding correctly

✓ Rollback completed successfully

System Status:
────────────────────────────────────────────────────────────────
✓ System restored to pre-installation state
✓ myapp v2.3.1 is running normally
✓ All services operational

══════════════════════════════════════════════════════════════
INSTALLATION FAILED
══════════════════════════════════════════════════════════════

Summary:
────────────────────────────────────────────────────────────────
✗ Installation failed
✓ Rollback successful
⚠ System state: Restored to v2.3.1
⚠ No data loss occurred

Failure Reason:
────────────────────────────────────────────────────────────────
Insufficient disk space in /var/lib/myapp
Required: 500 MB
Available: 234 MB

Recommendations:
────────────────────────────────────────────────────────────────
1. Free up disk space:
   # Check disk usage
   df -h
   
   # Clean package cache
   sudo apt clean
   
   # Remove old logs
   sudo journalctl --vacuum-time=7d

2. Install to different location:
   sudo ./robust_installer.sh --package myapp --data-dir /home/data

3. Contact support:
   support@myapp.com
   Include log file: /var/log/installer/myapp_20251019_235400.log

Installation log: /var/log/installer/myapp_20251019_235400.log
Error log: /var/log/installer/myapp_20251019_235400_error.log

Exit code: 67 (INSUFFICIENT_DISK_SPACE)
```
### Bonus Challenges:
**Level 1 (Complete the basics):**
- Add partial installation resume capability
- Support multiple installation profiles
- Implement configuration import/export
- Add health monitoring post-install
- Create installation analytics

**Level 2 (Advanced features):**
- Support distributed installation (cluster)
- Add blue-green deployment
- Implement canary releases
- Add A/B testing support
- Create installation orchestration

**Level 3 (Production-ready):**
- Full CI/CD integration
- Container/Kubernetes deployment
- Infrastructure as code integration
- Automated testing framework
- Enterprise configuration management
### Goal:
Build a production-ready installer script named `robust_installer.sh` that installs software with comprehensive error handling, validation, and rollback capabilities.
### Requirements:
**Core Installation Features:**
- Pre-installation validation
- Dependency checking
- Download and verify packages
- Install with progress tracking
- Post-installation configuration
- Verification tests
- Complete uninstallation
- Upgrade support

**Error Handling:**
- Comprehensive error checking at every step
- Meaningful error messages
- Error categorization (recoverable/fatal)
- Error logging with timestamps
- Stack traces for debugging

**Rollback Capabilities:**
- Transaction-like behavior (all-or-nothing)
- Automatic rollback on failure
- State snapshots before changes
- Restore previous state
- Rollback verification
- Manual rollback support

**Safety Features:**
- Dry-run mode (simulate installation)
- Backup before changes
- Disk space validation
- Permission checking
- Conflict detection
- Recovery from partial installs

**User Experience:**
- Interactive mode with confirmations
- Silent mode for automation
- Progress indicators
- Status updates
- Clear success/failure messages
- Post-install instructions

### Expected Output Example:
```bash
sudo ./robust_installer.sh --package myapp
```

```
╔════════════════════════════════════════════════════════════════╗
║         ROBUST APPLICATION INSTALLER v1.0                      ║
║         Package: myapp v2.5.3                                  ║
╚════════════════════════════════════════════════════════════════╝

[INFO] Installation initiated
[INFO] User: root
[INFO] Date: 2025-10-19 23:54:00
[INFO] Installation ID: inst_20251019_235400_12345

══════════════════════════════════════════════════════════════
PHASE 1: PRE-INSTALLATION VALIDATION
══════════════════════════════════════════════════════════════

System Requirements Check:
────────────────────────────────────────────────────────────────
✓ Operating System: Ubuntu 22.04 LTS (supported)
✓ Architecture: x86_64 (supported)
✓ Kernel: 5.15.0-91-generic (minimum: 4.0)
✓ Bash version: 5.1.16 (minimum: 4.0)

Resource Requirements:
────────────────────────────────────────────────────────────────
✓ Disk space: 45.2 GB available (required: 500 MB)
✓ Memory: 8.5 GB available (required: 512 MB)
✓ CPU cores: 8 available (recommended: 2)

Permission Check:
────────────────────────────────────────────────────────────────
✓ Running as root
✓ Write access: /usr/local/bin
✓ Write access: /etc/myapp
✓ Write access: /var/log/myapp

Dependency Check:
────────────────────────────────────────────────────────────────
✓ Required: python3 (found: v3.10.12)
✓ Required: curl (found: v7.81.0)
✓ Required: tar (found: v1.34)
✓ Optional: docker (found: v24.0.7)
⚠ Optional: nodejs (not found - some features unavailable)

Conflict Detection:
────────────────────────────────────────────────────────────────
ℹ Checking for existing installations...
⚠ Found previous installation: myapp v2.3.1
  Location: /usr/local/myapp
  Status: Inactive
  
Action required: This will upgrade from v2.3.1 to v2.5.3

Network Connectivity:
────────────────────────────────────────────────────────────────
✓ Internet connection: Available
✓ Download server: Reachable (downloads.myapp.com)
✓ License server: Reachable (license.myapp.com)

[INFO] Pre-installation validation: PASSED
[INFO] Creating installation snapshot...

Snapshot Created:
────────────────────────────────────────────────────────────────
Snapshot ID: snap_20251019_235401
Backup location: /var/backups/myapp/snap_20251019_235401.tar.gz
Size: 12.3 MB
Files backed up: 47

═════════════════════════════════════════════════════════════
PHASE 2: DOWNLOAD & VERIFICATION
══════════════════════════════════════════════════════════════

Downloading myapp v2.5.3...
────────────────────────────────────────────────────────────────
Source: https://downloads.myapp.com/myapp-2.5.3.tar.gz
████████████████████████████████████████ 100% (45.6 MB / 45.6 MB)
Download speed: 12.3 MB/s
Time elapsed: 3.7 seconds

✓ Download complete: /tmp/myapp-2.5.3.tar.gz

Verifying package integrity...
────────────────────────────────────────────────────────────────
[1/3] Checking file integrity...
  → File size: 45.6 MB (expected: 45.6 MB) ✓
  
[2/3] Verifying checksums...
  → MD5: 5d41402abc4b2a76b9719d911017c592 ✓
  → SHA256: 2c26b46b68ffc68ff99b453c1d30413413422d706483bfa0f98a5e886266e7ae ✓
  
[3/3] Verifying GPG signature...
  → Signature: Valid ✓
  → Signed by: MyApp Release Team <release@myapp.com>
  → Key ID: 0x1234ABCD
  → Trust level: Ultimate ✓

✓ Package verification: PASSED

Extracting package...
────────────────────────────────────────────────────────────────
Destination: /tmp/myapp-install-12345/
████████████████████████████████████████ 100%

✓ Extraction complete (1,247 files extracted)

Validating package contents...
────────────────────────────────────────────────────────────────
✓ Required binaries: Present
✓ Configuration files: Present
✓ Documentation: Present
✓ License files: Present

══════════════════════════════════════════════════════════════
PHASE 3: INSTALLATION
══════════════════════════════════════════════════════════════

Installation Summary:
────────────────────────────────────────────────────────────────
Action: Upgrade
Current version: v2.3.1 → New version: v2.5.3
Installation path: /usr/local/myapp
Configuration: /etc/myapp
Data directory: /var/lib/myapp
Log directory: /var/log/myapp

Confirm installation? [Y/n]: y

[INFO] Starting installation...

[Step 1/8] Stopping existing services...
────────────────────────────────────────────────────────────────
→ Stopping myapp service...
  systemctl stop myapp
  ✓ Service stopped (PID 45678 terminated)

[Step 2/8] Backing up configuration...
────────────────────────────────────────────────────────────────
→ Backing up /etc/myapp/config.yaml
  ✓ Backup created: /var/backups/myapp/config.yaml.bak
→ Backing up /etc/myapp/secrets.conf
  ✓ Backup created: /var/backups/myapp/secrets.conf.bak

[Step 3/8] Installing binaries...
────────────────────────────────────────────────────────────────
→ Installing myapp binary to /usr/local/bin/
  ✓ Binary installed (15.2 MB)
→ Installing myapp-cli to /usr/local/bin/
  ✓ Binary installed (3.4 MB)
→ Setting permissions (755)
  ✓ Permissions set

[Step 4/8] Installing libraries...
────────────────────────────────────────────────────────────────
→ Installing to /usr/local/lib/myapp/
  ████████████████████████████████████████ 100% (234 files)
  ✓ Libraries installed (23.4 MB)

[Step 5/8] Installing configuration...
────────────────────────────────────────────────────────────────
→ Creating configuration directory: /etc/myapp/
  ✓ Directory created
→ Installing default configuration
  ✓ config.yaml installed
→ Merging with existing configuration
  ✓ Settings preserved
→ Installing systemd service file
  ✓ Service file installed: /etc/systemd/system/myapp.service

[Step 6/8] Setting up data directories...
────────────────────────────────────────────────────────────────
→ Creating /var/lib/myapp/
  ✓ Data directory created
→ Creating /var/log/myapp/
  ✓ Log directory created
→ Setting permissions
  ✓ Ownership: myapp:myapp
  ✓ Permissions: 750

[Step 7/8] Running post-install scripts...
────────────────────────────────────────────────────────────────
→ Running database migrations...
  Migration 001_initial_schema... ✓
  Migration 002_add_users_table... ✓
  Migration 003_add_indexes... ✓
  ✓ All migrations applied (3/3)

→ Generating SSL certificates...
  ✓ Certificate generated: /etc/myapp/ssl/cert.pem
  ✓ Private key generated: /etc/myapp/ssl/key.pem

→ Initializing cache...
  ✓ Cache initialized

[Step 8/8] Starting services...
────────────────────────────────────────────────────────────────
→ Reloading systemd daemon
  ✓ Daemon reloaded
→ Enabling myapp service
  ✓ Service enabled (starts on boot)
→ Starting myapp service
  ✓ Service started (PID 67890)

══════════════════════════════════════════════════════════════
PHASE 4: VERIFICATION
══════════════════════════════════════════════════════════════

Running post-installation tests...
────────────────────────────────────────────────────────────────
[Test 1/5] Service status check...
  → Checking if service is running
  ✓ Service is active and running

[Test 2/5] Binary verification...
  → Testing myapp binary
  $ myapp --version
  myapp v2.5.3
  ✓ Binary works correctly

[Test 3/5] Configuration validation...
  → Parsing configuration files
  ✓ Configuration is valid

[Test 4/5] Network connectivity test...
  → Testing HTTP endpoint
  $ curl -s http://localhost:8080/health
  {"status": "healthy"}
  ✓ Application responding on port 8080

[Test 5/5] Database connection test...
  → Testing database connectivity
  ✓ Database connection successful

All verification tests: PASSED ✓

══════════════════════════════════════════════════════════════
INSTALLATION COMPLETE
══════════════════════════════════════════════════════════════

Summary:
────────────────────────────────────────────────────────────────
✓ Installation successful
✓ Version: v2.5.3
✓ Installation time: 45.6 seconds
✓ All tests passed

Installed Components:
────────────────────────────────────────────────────────────────
• Binary: /usr/local/bin/myapp
• CLI tool: /usr/local/bin/myapp-cli
• Configuration: /etc/myapp/
• Service: myapp.service (enabled)
• Data: /var/lib/myapp/
• Logs: /var/log/myapp/

Service Information:
────────────────────────────────────────────────────────────────
Status: Active (running)
PID: 67890
Port: 8080
URL: http://localhost:8080

Next Steps:
────────────────────────────────────────────────────────────────
1. Review configuration:
   sudo nano /etc/myapp/config.yaml

2. View logs:
   sudo journalctl -u myapp -f

3. Access web interface:
   http://localhost:8080

4. Read documentation:
   man myapp
   /usr/share/doc/myapp/README.md

Useful Commands:
────────────────────────────────────────────────────────────────
Start service:    sudo systemctl start myapp
Stop service:     sudo systemctl stop myapp
Restart service:  sudo systemctl restart myapp
Check status:     sudo systemctl status myapp
View logs:        sudo journalctl -u myapp

Uninstall:
────────────────────────────────────────────────────────────────
To uninstall: sudo ./robust_installer.sh --uninstall

Backups:
────────────────────────────────────────────────────────────────
Installation snapshot: /var/backups/myapp/snap_20251019_235401.tar.gz
Configuration backup: /var/backups/myapp/*.bak

Installation log: /var/log/installer/myapp_20251019_235400.log

Thank you for installing myapp!
```

**With error and automatic rollback:**
```bash
sudo ./robust_installer.sh --package myapp
```

```
[... installation proceeds normally until ...]

══════════════════════════════════════════════════════════════
PHASE 3: INSTALLATION
══════════════════════════════════════════════════════════════

[Step 1/8] Stopping existing services... ✓
[Step 2/8] Backing up configuration... ✓
[Step 3/8] Installing binaries... ✓
[Step 4/8] Installing libraries... ✓
[Step 5/8] Installing configuration... ✓
[Step 6/8] Setting up data directories...
────────────────────────────────────────────────────────────────
→ Creating /var/lib/myapp/
  ✗ ERROR: Insufficient disk space

[ERROR] Installation failed at step 6/8

Error Details:
────────────────────────────────────────────────────────────────
Error Type: INSUFFICIENT_DISK_SPACE
Required: 500 MB
Available: 234 MB
Location: /var/lib/myapp
Line: 234
Function: create_data_directory

══════════════════════════════════════════════════════════════
INITIATING AUTOMATIC ROLLBACK
══════════════════════════════════════════════════════════════

[INFO] Rolling back changes to restore system state...

Rollback Progress:
────────────────────────────────────────────────────────────────
[1/6] Restoring previous version...
  → Stopping failed installation services
  ✓ Services stopped

[2/6] Removing newly installed files...
  → Removing /usr/local/bin/myapp
  ✓ Binary removed
  → Removing /usr/local/lib/myapp/
  ✓ Libraries removed (234 files)

[3/6] Restoring configuration...
  → Restoring /etc/myapp/config.yaml
  ✓ Configuration restored from backup
  → Restoring /etc/myapp/secrets.conf
  ✓ Secrets restored from backup

[4/6] Restoring previous version...
  → Reinstalling myapp v2.3.1 from snapshot
  ✓ Previous version restored

[5/6] Restarting services...
  → Starting myapp service (previous version)
  ✓ Service started (PID 78901)

[6/6] Verifying rollback...
  → Checking service status
  ✓ Service is running
  → Testing functionality
  ✓ Application responding correctly

✓ Rollback completed successfully

System Status:
────────────────────────────────────────────────────────────────
✓ System restored to pre-installation state
✓ myapp v2.3.1 is running normally
✓ All services operational

══════════════════════════════════════════════════════════════
INSTALLATION FAILED
══════════════════════════════════════════════════════════════

Summary:
────────────────────────────────────────────────────────────────
✗ Installation failed
✓ Rollback successful
⚠ System state: Restored to v2.3.1
⚠ No data loss occurred

Failure Reason:
────────────────────────────────────────────────────────────────
Insufficient disk space in /var/lib/myapp
Required: 500 MB
Available: 234 MB

Recommendations:
────────────────────────────────────────────────────────────────
1. Free up disk space:
   # Check disk usage
   df -h
   
   # Clean package cache
   sudo apt clean
   
   # Remove old logs
   sudo journalctl --vacuum-time=7d

2. Install to different location:
   sudo ./robust_installer.sh --package myapp --data-dir /home/data

3. Contact support:
   support@myapp.com
   Include log file: /var/log/installer/myapp_20251019_235400.log

Installation log: /var/log/installer/myapp_20251019_235400.log
Error log: /var/log/installer/myapp_20251019_235400_error.log

Exit code: 67 (INSUFFICIENT_DISK_SPACE)
```
### Bonus Challenges:
**Level 1 (Complete the basics):**
- Add partial installation resume capability
- Support multiple installation profiles
- Implement configuration import/export
- Add health monitoring post-install
- Create installation analytics

**Level 2 (Advanced features):**
- Support distributed installation (cluster)
- Add blue-green deployment
- Implement canary releases
- Add A/B testing support
- Create installation orchestration

**Level 3 (Production-ready):**
- Full CI/CD integration
- Container/Kubernetes deployment
- Infrastructure as code integration
- Automated testing framework
- Enterprise configuration management
