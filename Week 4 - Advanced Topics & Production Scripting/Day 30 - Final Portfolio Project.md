## Project Overview

Build a comprehensive, production-ready system administration toolkit that demonstrates mastery of all bash scripting concepts covered in the 30-day course.
## Project Structure
```
sysadmin-suite/
├── sysadmin.sh                    # Main executable
├── lib/
│   ├── core.sh                    # Core functions and utilities
│   ├── user_management.sh         # User management functions
│   ├── backup.sh                  # Backup functions
│   ├── monitoring.sh              # System monitoring functions
│   ├── log_analysis.sh            # Log analysis functions
│   ├── service_checks.sh          # Service health check functions
│   ├── security.sh                # Security audit functions
│   └── notifications.sh           # Email/alert functions
├── config/
│   ├── sysadmin.conf              # Main configuration
│   ├── backup.conf                # Backup configuration
│   ├── monitoring.conf            # Monitoring thresholds
│   └── security.conf              # Security policies
├── tests/
│   ├── test_runner.sh             # Test suite runner
│   ├── test_user_management.sh    # User management tests
│   ├── test_backup.sh             # Backup tests
│   ├── test_monitoring.sh         # Monitoring tests
│   └── test_security.sh           # Security tests
├── docs/
│   ├── README.md                  # Project documentation
│   ├── INSTALL.md                 # Installation guide
│   ├── API.md                     # Function reference
│   └── sysadmin.1                 # Man page
├── logs/
│   └── .gitkeep                   # Log directory
├── cron/
│   ├── daily.sh                   # Daily cron jobs
│   ├── hourly.sh                  # Hourly cron jobs
│   └── install_cron.sh            # Cron installation script
└── LICENSE

```
## Expected Output

### Main Menu Interface
```bash
sudo ./sysadmin.sh
```

```
╔════════════════════════════════════════════════════════════════╗
║         AUTOMATED SYSTEM ADMINISTRATION SUITE v3.0             ║
║         Production-Ready SysAdmin Toolkit                      ║
╚════════════════════════════════════════════════════════════════╝

System: Ubuntu 22.04 LTS (myserver.local)
User: root
Date: Monday, October 20, 2025, 12:33 AM MDT

MAIN MENU
════════════════════════════════════════════════════════════════

1. User Management
   → Add, remove, modify, list users
   → Password policies and expiration
   → Group management
   
2. Automated Backups
   → Create backups with compression
   → Rotation and retention policies
   → Verify backup integrity
   
3. System Monitoring
   → Real-time dashboard
   → Resource usage alerts
   → Performance trends
   
4. Log Analysis
   → Parse and analyze logs
   → Generate reports
   → Detect anomalies
   
5. Service Health Checks
   → Check service status
   → Restart failed services
   → Monitor dependencies
   
6. Security Audit
   → System security scan
   → Vulnerability assessment
   → Compliance checks
   
7. Configuration
   → View/edit settings
   → Set monitoring thresholds
   → Configure notifications
   
8. Reports
   → Generate system reports
   → Export to PDF/HTML
   → Email reports
   
9. Automated Tasks
   → View scheduled jobs
   → Configure cron jobs
   → Task history

10. Exit

Select option [0-9]: _
```
### 1. User Management Module
```bash
sudo ./sysadmin.sh --user-management
```

```
╔════════════════════════════════════════════════════════════════╗
║              USER MANAGEMENT MODULE                            ║
╚════════════════════════════════════════════════════════════════╝

USER MANAGEMENT OPTIONS
════════════════════════════════════════════════════════════════

1. Add New User
2. Remove User
3. Modify User
4. List Users
5. Manage Groups
6. Password Policy
7. User Activity Report
8. Lock/Unlock User
9. Set Password Expiration
10. Back to Main Menu

Select option [0-9]: 1

╔════════════════════════════════════════════════════════════════╗
║              ADD NEW USER                                      ║
╚════════════════════════════════════════════════════════════════╝

Enter username: jdoe
Enter full name: John Doe
Enter email: jdoe@example.com

Create home directory? [Y/n]: y
Add to sudo group? [y/N]: n

Additional groups (comma-separated, optional): developers,docker

Password generation:
  1. Generate secure password
  2. Manually enter password
Select option [1-2]: 1

Validating username...
✓ Username valid (3-20 alphanumeric characters)
✓ Username available (not taken)

Creating user account...
────────────────────────────────────────────────────────────────
[INFO] Creating user: jdoe
[INFO] Setting full name: John Doe
[INFO] Creating home directory: /home/jdoe
[INFO] Adding to groups: developers, docker
[INFO] Generating secure password

✓ User created successfully

User Details:
────────────────────────────────────────────────────────────────
Username:        jdoe
UID:             1042
GID:             1042 (jdoe)
Full name:       John Doe
Home directory:  /home/jdoe
Shell:           /bin/bash
Groups:          jdoe, developers, docker
Email:           jdoe@example.com

Generated Password: mK9$pL2#qR8@vN4!
⚠️  Save this password securely - it will not be shown again

Password Policy Applied:
────────────────────────────────────────────────────────────────
Minimum length:      12 characters
Must change:         First login
Password expiry:     90 days
Warning period:      7 days before expiry
Lockout after:       5 failed attempts

Welcome Email:
────────────────────────────────────────────────────────────────
✓ Email sent to: jdoe@example.com
  Subject: Welcome to myserver.local
  Contains: Login credentials and getting started guide

Audit Log:
────────────────────────────────────────────────────────────────
✓ User creation logged
  Timestamp: 2025-10-20 00:33:15
  Performed by: root
  Log file: /var/log/sysadmin/user_management.log

╔════════════════════════════════════════════════════════════════╗
║              USER CREATED SUCCESSFULLY                         ║
╚════════════════════════════════════════════════════════════════╝

Next Steps:
  1. User should change password on first login
  2. Configure SSH keys (optional)
  3. Grant additional permissions as needed

Press Enter to continue...
```
### 2. Automated Backups Module
```bash
sudo ./sysadmin.sh --backup
```

```
╔════════════════════════════════════════════════════════════════╗
║              AUTOMATED BACKUP SYSTEM                           ║
╚════════════════════════════════════════════════════════════════╝

BACKUP OPTIONS
════════════════════════════════════════════════════════════════

1. Create Backup Now
2. Schedule Automatic Backups
3. Restore from Backup
4. Verify Backup Integrity
5. Manage Backup Rotation
6. View Backup History
7. Configure Backup Settings
8. Back to Main Menu

Select option [0-7]: 1

╔════════════════════════════════════════════════════════════════╗
║              CREATE BACKUP                                     ║
╚════════════════════════════════════════════════════════════════╝

Select backup type:
  1. Full backup (all files)
  2. Incremental backup (changes since last backup)
  3. Differential backup (changes since last full)
  4. Custom (select directories)
  
Backup type [1-4]: 1

Select directories to backup:
  [✓] 1. /home (All user home directories)
  [✓] 2. /etc (System configuration)
  [ ] 3. /var/www (Web files)
  [ ] 4. /var/lib (Application data)
  [ ] 5. Custom path
  
Select items (space-separated) or 'a' for all [1-5,a]: 1 2

Backup Configuration:
────────────────────────────────────────────────────────────────
Type:            Full backup
Sources:         /home, /etc
Destination:     /backup
Compression:     gzip (level 6)
Encryption:      Disabled
Exclusions:      *.tmp, *.log, .cache/*, __pycache__/

Estimated size:  ~8.5 GB (compressed: ~4.2 GB)
Estimated time:  8-12 minutes
Available space: 156 GB

Proceed with backup? [Y/n]: y

[INFO] Initializing backup system...
[INFO] Backup ID: backup_20251020_003330

Pre-flight Checks:
────────────────────────────────────────────────────────────────
✓ Lock acquired (no concurrent backups)
✓ All source paths exist and readable
✓ Destination writable
✓ Sufficient disk space (156 GB available)
✓ Dependencies available (tar, gzip)

Creating Backup:
════════════════════════════════════════════════════════════════

[1/2] Scanning source directories...
  /home: 2,347 files (3.2 GB)
  /etc: 1,834 files (145 MB)
  Total: 4,181 files (3.3 GB)

[2/2] Creating compressed archive...

Progress: ████████████████████████████████████████ 100%

Files:    ████████████████████████████████████████ 4,181 / 4,181
Data:     ████████████████████████████████████████ 3.3 GB / 3.3 GB
Time:     00:08:23
Speed:    6.7 MB/s

Compression Results:
────────────────────────────────────────────────────────────────
Original size:     3.3 GB
Compressed size:   1.6 GB
Compression ratio: 51.5% (saved 1.7 GB)
Compression time:  8m 23s

Generating Checksums:
────────────────────────────────────────────────────────────────
[INFO] Computing SHA256 checksums...
✓ Checksum file created: backup_20251020_003330.sha256

Archive Details:
────────────────────────────────────────────────────────────────
Filename:  backup_20251020_003330.tar.gz
Path:      /backup/backup_20251020_003330.tar.gz
Size:      1.6 GB
Files:     4,181
Created:   2025-10-20 00:33:30
Duration:  8m 23s
Checksum:  a3d5c8f7e9b2d4a1c6f8e0b3a7d9c5f2e4b6a8d0c3e5f7a9b1d3c5e7f9a1b3d5

Backup Catalog:
────────────────────────────────────────────────────────────────
Current backups: 8
Total size: 12.8 GB
Oldest: backup_20251013_003300.tar.gz (7 days old)
Newest: backup_20251020_003330.tar.gz (now)

Rotation Policy Applied:
────────────────────────────────────────────────────────────────
Keep: 7 most recent backups
Action: No backups removed (within limit)

Verification:
────────────────────────────────────────────────────────────────
[INFO] Verifying backup integrity...
✓ Archive structure valid
✓ Checksum matches
✓ Sample files extractable
✓ Backup integrity verified

Notification:
────────────────────────────────────────────────────────────────
✓ Email sent to: admin@example.com
  Subject: [SUCCESS] Backup completed (backup_20251020_003330)
  Attached: backup_report.txt

╔════════════════════════════════════════════════════════════════╗
║              BACKUP COMPLETED SUCCESSFULLY                     ║
╚════════════════════════════════════════════════════════════════╝

Summary:
────────────────────────────────────────────────────────────────
Status:         ✓ Success
Files backed up: 4,181
Size:           1.6 GB (compressed from 3.3 GB)
Duration:       8m 23s
Location:       /backup/backup_20251020_003330.tar.gz

To restore this backup:
  sudo ./sysadmin.sh --restore backup_20251020_003330.tar.gz

To verify integrity:
  sudo ./sysadmin.sh --verify backup_20251020_003330.tar.gz

Log file: /var/log/sysadmin/backup_20251020_003330.log

Press Enter to continue...
```
### 3. System Monitoring Dashboard
```bash
sudo ./sysadmin.sh --monitor
```

```
╔════════════════════════════════════════════════════════════════╗
║              SYSTEM MONITORING DASHBOARD                       ║
║              Press 'q' to quit, 'r' to refresh                 ║
║              Auto-refresh: 5 seconds                           ║
╚════════════════════════════════════════════════════════════════╝

System: myserver.local (192.168.1.100)
Uptime: 15 days, 8 hours, 33 minutes
Last updated: 2025-10-20 00:33:45

SYSTEM HEALTH: ⚠️  WARNING (2 issues detected)
════════════════════════════════════════════════════════════════

CPU Usage
────────────────────────────────────────────────────────────────
Current:    34.2%  ███████████████████░░░░░░░░░░░░░░░░░░░░░ OK
1-min avg:  1.25   (8 cores available)
5-min avg:  1.45
15-min avg: 1.67

Top CPU Consumers:
  mysql        12.5%  [PID: 1234]
  java          8.7%  [PID: 2345]
  python        5.3%  [PID: 3456]

Memory Usage
────────────────────────────────────────────────────────────────
Physical:   11.2 GB / 16.0 GB (70%)  ███████████████████████░░░░ OK
  Used:     11.2 GB
  Free:      1.8 GB
  Cache:     3.0 GB

Swap:        0.5 GB / 4.0 GB (12%)  ████░░░░░░░░░░░░░░░░░░░░░░ OK

Top Memory Consumers:
  java          2.4 GB  [PID: 2345]
  mysql         1.3 GB  [PID: 1234]
  postgres      1.1 GB  [PID: 5678]

Disk Usage
────────────────────────────────────────────────────────────────
/           35 GB / 50 GB  (73%)  ████████████████████████░░░░ OK
/home      145 GB / 200 GB (76%)  ████████████████████████████ OK
/var        82 GB / 100 GB (85%)  █████████████████████████████ ⚠️ HIGH
/backup     96 GB / 500 GB (19%)  ███████░░░░░░░░░░░░░░░░░░░░ OK

⚠️ Alert: /var at 85% capacity (threshold: 80%)

Network
────────────────────────────────────────────────────────────────
Interface: eth0
IP:        192.168.1.100
Status:    ✓ UP

Current:   ↓ 12.3 Mbps  ↑ 4.5 Mbps
Peak:      ↓ 45.6 Mbps  ↑ 23.4 Mbps
Connections: 234 established, 12 time_wait

Services Status
────────────────────────────────────────────────────────────────
✓ nginx       Running    [PID: 1001]  Port: 80, 443
✓ mysql       Running    [PID: 1234]  Port: 3306
✓ postgresql  Running    [PID: 5678]  Port: 5432
✓ redis       Running    [PID: 2468]  Port: 6379
✗ worker      Stopped    [---]        ⚠️ Service down
✓ docker      Running    [PID: 9012]  Socket: /var/run/docker.sock

⚠️ Alert: worker service is not running

System Alerts (Last 24 Hours)
════════════════════════════════════════════════════════════════

🔴 CRITICAL (0)
⚠️  WARNING (2)
  • /var disk usage at 85% (00:30:00)
  • worker service stopped (00:15:23)
  
ℹ️  INFO (5)
  • Backup completed successfully (00:33:30)
  • User jdoe created (00:33:15)
  • System updates available (yesterday)
  • SSL certificate expires in 30 days
  • Log rotation completed (00:00:05)

Performance Trends (24 hours)
════════════════════════════════════════════════════════════════

CPU Usage:
  100% ┤
   75% ┤     ╭─╮
   50% ┤   ╭─╯ ╰─╮     ╭──╮
   25% ┤───╯     ╰─────╯  ╰────────────
    0% ┼────────────────────────────────────
       0h  4h  8h  12h 16h 20h 24h

Memory Usage:
  100% ┤
   75% ┤─────────────────────────────────── Stable
   50% ┤
   25% ┤
    0% ┼────────────────────────────────────
       0h  4h  8h  12h 16h 20h 24h

Quick Actions
════════════════════════════════════════════════════════════════
1. Restart worker service
2. Clean /var logs
3. View detailed logs
4. Send test alert
5. Generate report
6. Configure thresholds

Enter action [1-6] or 'q' to quit: _
```
### 4. Log Analysis Module
```bash
sudo ./sysadmin.sh --analyze-logs
```

```
╔════════════════════════════════════════════════════════════════╗
║              LOG ANALYSIS MODULE                               ║
╚════════════════════════════════════════════════════════════════╝

LOG ANALYSIS OPTIONS
════════════════════════════════════════════════════════════════

1. Analyze System Logs
2. Analyze Web Server Logs
3. Analyze Application Logs
4. Security Log Analysis
5. Error Report
6. Custom Log Analysis
7. Generate Report
8. Back to Main Menu

Select option [0-7]: 1

╔════════════════════════════════════════════════════════════════╗
║              SYSTEM LOG ANALYSIS                               ║
╚════════════════════════════════════════════════════════════════╝

Analyzing logs from: /var/log/syslog
Date range: Last 24 hours (2025-10-19 00:33 to 2025-10-20 00:33)

Processing logs...
████████████████████████████████████████ 100% (456,789 lines)

Log Analysis Report
════════════════════════════════════════════════════════════════

Summary Statistics:
────────────────────────────────────────────────────────────────
Total log entries:   456,789
Time period:         24 hours
Log file size:       234 MB
Processing time:     3.42 seconds

Severity Breakdown:
────────────────────────────────────────────────────────────────
CRITICAL:    12    (0.003%)  🔴
ERROR:       234   (0.051%)  🔴
WARNING:     1,456 (0.319%)  ⚠️
INFO:        455,087 (99.627%) ℹ️

Top 10 Error Messages:
────────────────────────────────────────────────────────────────
1. Database connection timeout          45 occurrences
2. Failed to write to disk              23 occurrences
3. Memory allocation failed             18 occurrences
4. Network unreachable                  15 occurrences
5. Permission denied                    12 occurrences
6. File not found                       11 occurrences
7. Service unavailable                   9 occurrences
8. Timeout waiting for lock              8 occurrences
9. Invalid configuration                 7 occurrences
10. SSL handshake failed                 6 occurrences

Critical Events:
────────────────────────────────────────────────────────────────
[2025-10-19 15:23:45] Disk /var reached 85% capacity
[2025-10-19 18:45:12] Service worker crashed (OOM)
[2025-10-20 00:15:23] Worker service failed to start
[... 9 more critical events]

Most Active Services:
────────────────────────────────────────────────────────────────
systemd:     123,456 entries (27.0%)
nginx:        89,012 entries (19.5%)
mysql:        67,890 entries (14.9%)
sshd:         45,678 entries (10.0%)
cron:         34,567 entries (7.6%)

Authentication Activity:
────────────────────────────────────────────────────────────────
Successful logins:   234
Failed logins:       12
Sudo usage:          89
SSH connections:     156

Failed Login Attempts:
────────────────────────────────────────────────────────────────
root:        5 attempts (192.168.1.50)
admin:       4 attempts (203.0.113.42)
test:        3 attempts (198.51.100.23)

Anomalies Detected:
────────────────────────────────────────────────────────────────
⚠️ Unusual spike in errors at 15:00-16:00 (45 errors vs avg 10/hour)
⚠️ Service restarts: worker restarted 3 times
⚠️ Disk space warnings: 12 occurrences in last 24h
⚠️ Failed login attempts from 3 different IPs

Recommendations:
────────────────────────────────────────────────────────────────
1. Investigate database connection timeouts
2. Monitor /var disk usage (currently 85%)
3. Review worker service stability (3 restarts)
4. Block suspicious IPs attempting failed logins
5. Review disk write failures

╔════════════════════════════════════════════════════════════════╗
║              ANALYSIS COMPLETE                                 ║
╚════════════════════════════════════════════════════════════════╝

Report saved to: /var/log/sysadmin/log_analysis_20251020_003345.txt
HTML report: /var/log/sysadmin/log_analysis_20251020_003345.html

Press Enter to continue...
```
### 5. Service Health Checks
```bash
sudo ./sysadmin.sh --health-check
```

```
╔════════════════════════════════════════════════════════════════╗
║              SERVICE HEALTH CHECK                              ║
╚════════════════════════════════════════════════════════════════╝

Running comprehensive health checks...

System Services
════════════════════════════════════════════════════════════════

[1/6] Checking nginx...
  Status:       ✓ Running (PID: 1001)
  Uptime:       15d 8h 33m
  Port 80:      ✓ Listening
  Port 443:     ✓ Listening
  SSL cert:     ✓ Valid (expires in 65 days)
  Config:       ✓ Valid
  Response:     ✓ HTTP 200 OK (42ms)
  
[2/6] Checking mysql...
  Status:       ✓ Running (PID: 1234)
  Uptime:       15d 8h 33m
  Port 3306:    ✓ Listening
  Connections:  45 / 151 (max: 151)
  Database:     ✓ Accessible
  Replication:  ✓ Slave OK (0s behind master)
  Performance:  ✓ Query time avg: 12ms
  
[3/6] Checking postgresql...
  Status:       ✓ Running (PID: 5678)
  Uptime:       15d 8h 33m
  Port 5432:    ✓ Listening
  Connections:  23 / 100 (max: 100)
  Database:     ✓ Accessible
  Replication:  N/A (standalone)
  Performance:  ✓ Query time avg: 8ms
  
[4/6] Checking redis...
  Status:       ✓ Running (PID: 2468)
  Uptime:       15d 8h 33m
  Port 6379:    ✓ Listening
  Memory:       89 MB / 512 MB
  Connections:  10 / 10000
  Response:     ✓ PONG (1ms)
  Persistence:  ✓ RDB last save: 5m ago
  
[5/6] Checking docker...
  Status:       ✓ Running (PID: 9012)
  Containers:   5 running, 2 stopped
  Images:       23 total (12.3 GB)
  Volumes:      8 (4.5 GB)
  Networks:     3
  Health:       ✓ All services healthy
  
[6/6] Checking worker...
  Status:       ✗ Stopped
  Last seen:    15 minutes ago
  Exit code:    137 (OOM killed)
  Restart:      Failed (3 attempts)
  
  ⚠️ ALERT: Service needs attention

Dependency Health
════════════════════════════════════════════════════════════════

Network Connectivity:
  ✓ Internet: Online (ping google.com: 12ms)
  ✓ DNS: Working (resolves example.com)
  ✓ NTP: Synchronized (offset: 0.002s)

External Dependencies:
  ✓ API endpoint: https://api.example.com (200 OK, 45ms)
  ✓ Database: prod-db.example.com (reachable, 8ms)
  ⚠️ Email server: smtp.example.com (slow, 234ms)

File Systems:
  ✓ / (ext4): Mounted, Read/Write
  ✓ /home (ext4): Mounted, Read/Write
  ⚠️ /var (ext4): 85% full (threshold: 80%)
  ✓ /backup (ext4): Mounted, Read/Write

╔════════════════════════════════════════════════════════════════╗
║              HEALTH CHECK SUMMARY                              ║
╚════════════════════════════════════════════════════════════════╝

Overall Status: ⚠️ WARNING

Services:
  Running:   5 / 6  (83.3%)
  Healthy:   5 / 6  (83.3%)
  
Issues Found: 2
  🔴 worker service is down (needs restart)
  ⚠️ /var disk usage at 85%

Recommendations:
────────────────────────────────────────────────────────────────
1. Restart worker service (may need memory increase)
2. Clean /var logs to free disk space
3. Investigate worker OOM kills
4. Monitor email server performance

Actions:
────────────────────────────────────────────────────────────────
1. Auto-fix issues now
2. Restart failed services
3. View detailed logs
4. Schedule maintenance
5. Send alert

Select action [1-5] or Enter to continue: 1

[INFO] Applying auto-fix...

[1/2] Restarting worker service...
  → Stopping worker (if running)...
  → Starting worker...
  → Waiting for startup...
  ✓ Worker service started (PID: 12345)
  
[2/2] Cleaning /var logs...
  → Rotating logs...
  → Compressing old logs...
  → Removing logs older than 90 days...
  ✓ Freed 4.2 GB of disk space
  → /var now at 78% (below threshold)

╔════════════════════════════════════════════════════════════════╗
║              AUTO-FIX COMPLETE                                 ║
╚════════════════════════════════════════════════════════════════╝

Issues Resolved: 2 / 2 (100%)
System Status: ✓ HEALTHY

Health check log: /var/log/sysadmin/health_check_20251020_003400.log

Press Enter to continue...
```
### 6. Security Audit
```bash
sudo ./sysadmin.sh --security-audit
```

```
╔════════════════════════════════════════════════════════════════╗
║              SECURITY AUDIT                                    ║
╚════════════════════════════════════════════════════════════════╝

Running comprehensive security audit...

[INFO] This may take several minutes...

User & Authentication Security
════════════════════════════════════════════════════════════════

[1/10] Password Policy Compliance...
  ✓ Minimum password length: 12 characters
  ✓ Password complexity: Enforced
  ✓ Password history: Last 5 passwords remembered
  ✓ Password expiration: 90 days
  ⚠️ 3 users have passwords older than 90 days

[2/10] User Account Security...
  ✓ No accounts with empty passwords
  ✓ Root login via SSH: Disabled
  ⚠️ 2 users have sudo access without password
  ✓ No duplicate UIDs
  ✓ No users with UID 0 except root

[3/10] SSH Configuration...
  ✓ SSH protocol: Version 2
  ✓ Root login: Disabled
  ✓ Password authentication: Disabled (key-only)
  ✓ Empty passwords: Not allowed
  ✓ X11 forwarding: Disabled
  ✗ SSH port: Default (22) - recommend changing

[4/10] Firewall Configuration...
  ✓ UFW: Active
  ✓ Default policy: Deny incoming
  ✓ Open ports: 22, 80, 443 (all justified)
  ⚠️ Rate limiting not configured for SSH

System Security
════════════════════════════════════════════════════════════════

[5/10] File System Security...
  ✓ No world-writable files in system directories
  ⚠️ 5 SUID files found (review required)
  ✓ /tmp mounted with noexec
  ✓ File integrity monitoring: Active (AIDE)

[6/10] Service Security...
  ✓ Unnecessary services: Disabled
  ✓ Services running as non-root: 11/12 (92%)
  ⚠️ mysql running as root (review required)
  ✓ AppArmor profiles: Loaded and enforcing

[7/10] Network Security...
  ✓ IP forwarding: Disabled
  ✓ SYN cookies: Enabled
  ✓ ICMP redirects: Disabled
  ✓ Source routing: Disabled

[8/10] Updates & Patches...
  ⚠️ 23 security updates available
  ⚠️ Kernel version: 5.15.0-91 (newer available: 5.15.0-94)
  ✓ Automatic security updates: Enabled

[9/10] Log Security...
  ✓ Log rotation: Configured
  ✓ Remote logging: Enabled
  ✓ Failed login attempts: Monitored
  ✓ Sudo usage: Logged

[10/10] Compliance Checks...
  ✓ CIS Benchmark: 92% compliance
  ⚠️ PCI-DSS: 87% compliance (3 items need attention)
  ✓ HIPAA: Not applicable
  
Vulnerability Scan
════════════════════════════════════════════════════════════════

Scanning for known vulnerabilities...

[INFO] Checking against CVE database...
  ✓ No critical vulnerabilities found
  ⚠️ 2 medium severity vulnerabilities:
    - CVE-2024-12345 (nginx < 1.24.1)
    - CVE-2024-54321 (openssl < 3.0.2)

[INFO] Checking installed packages...
  ⚠️ 5 packages with known vulnerabilities
  ✓ All can be patched with available updates

Permission Audit
════════════════════════════════════════════════════════════════

Sensitive Files:
  ✓ /etc/shadow: 640 root:shadow
  ✓ /etc/passwd: 644 root:root
  ✓ /etc/ssh/sshd_config: 600 root:root
  ⚠️ /var/www/html/.env: 644 (should be 600)

SUID/SGID Files:
  /usr/bin/sudo          (expected)
  /usr/bin/passwd        (expected)
  /usr/bin/chsh          (expected)
  ⚠️ /usr/local/bin/custom  (review required)
  
╔════════════════════════════════════════════════════════════════╗
║              SECURITY AUDIT SUMMARY                            ║
╚════════════════════════════════════════════════════════════════╝

Overall Security Score: 87/100 (Good)

Risk Breakdown:
  🔴 Critical:  0 issues
  ⚠️  High:     2 issues
  ⚠️  Medium:   7 issues
  ℹ️  Low:      3 issues

Critical Issues (Immediate Action Required):
────────────────────────────────────────────────────────────────
None found ✓

High Priority Issues:
────────────────────────────────────────────────────────────────
1. 23 security updates available
2. SSH running on default port 22

Medium Priority Issues:
────────────────────────────────────────────────────────────────
1. 3 users with expired passwords
2. 2 users have passwordless sudo
3. MySQL running as root
4. No SSH rate limiting
5. .env file permissions too open
6. Custom SUID binary needs review
7. 2 CVE vulnerabilities (patchable)

Recommendations:
────────────────────────────────────────────────────────────────
Immediate (Within 24 hours):
  1. Apply security updates: sudo apt update && sudo apt upgrade
  2. Fix .env file permissions: chmod 600 /var/www/html/.env
  3. Force password change for expired accounts

Short-term (Within 1 week):
  4. Change SSH port from 22 to custom port
  5. Configure SSH rate limiting (fail2ban)
  6. Review custom SUID binary: /usr/local/bin/custom
  7. Review passwordless sudo users

Long-term (Within 1 month):
  8. Migrate MySQL to run as mysql user
  9. Implement intrusion detection (OSSEC/Wazuh)
  10. Schedule regular security audits (monthly)

Compliance:
────────────────────────────────────────────────────────────────
CIS Benchmark:     92% (Good)
PCI-DSS:           87% (Needs improvement)
Overall:           90% (Acceptable)

Next Audit: Recommended in 30 days

Report saved to: /var/log/sysadmin/security_audit_20251020_003430.pdf
Email sent to: security@example.com

Press Enter to continue...
```
### Installation & Setup
```bash
sudo ./install.sh
```

```
╔════════════════════════════════════════════════════════════════╗
║         SYSADMIN SUITE INSTALLER                               ║
╚════════════════════════════════════════════════════════════════╝

[INFO] Starting installation...

Pre-installation Checks:
────────────────────────────────────────────────────────────────
✓ Running as root
✓ Operating system: Ubuntu 22.04 LTS (supported)
✓ Bash version: 5.1.16 (minimum: 4.0)
✓ Required commands available

Installing Dependencies:
────────────────────────────────────────────────────────────────
[1/5] System tools... ✓ (tar, gzip, curl, jq)
[2/5] Monitoring tools... ✓ (htop, iotop, nethogs)
[3/5] Mail utilities... ✓ (mailutils, sendmail)
[4/5] Security tools... ✓ (fail2ban, aide, chkrootkit)
[5/5] Documentation... ✓ (man-db)

Installing SysAdmin Suite:
────────────────────────────────────────────────────────────────
→ Creating directories...
  ✓ /usr/local/sysadmin
  ✓ /etc/sysadmin
  ✓ /var/log/sysadmin
  ✓ /var/lib/sysadmin

→ Copying files...
  ✓ Main executable
  ✓ Library modules (8 files)
  ✓ Configuration files (4 files)
  ✓ Documentation (man page, README)

→ Setting permissions...
  ✓ Executable: 755
  ✓ Config files: 640
  ✓ Log directory: 750

→ Creating symbolic links...
  ✓ /usr/local/bin/sysadmin → /usr/local/sysadmin/sysadmin.sh

Installing Cron Jobs:
────────────────────────────────────────────────────────────────
→ Daily backup (2:00 AM)... ✓
→ Hourly monitoring (every hour)... ✓
→ Daily log rotation (3:00 AM)... ✓
→ Weekly security audit (Sunday 1:00 AM)... ✓

Configuring Email Notifications:
────────────────────────────────────────────────────────────────
Email address for alerts: admin@example.com
✓ Email configuration saved

Running Initial System Scan:
────────────────────────────────────────────────────────────────
→ Baseline system snapshot... ✓
→ Security audit... ✓ (Score: 87/100)
→ Disk usage baseline... ✓

╔════════════════════════════════════════════════════════════════╗
║         INSTALLATION COMPLETE                                  ║
╚════════════════════════════════════════════════════════════════╝

SysAdmin Suite is now installed and ready to use.

Quick Start:
────────────────────────────────────────────────────────────────
Launch suite:         sudo sysadmin
Show help:            sudo sysadmin --help
Run backup:           sudo sysadmin --backup
View dashboard:       sudo sysadmin --monitor
Security audit:       sudo sysadmin --security-audit

Documentation:
────────────────────────────────────────────────────────────────
Man page:             man sysadmin
README:               /usr/local/sysadmin/docs/README.md
Online docs:          https://docs.example.com/sysadmin-suite

Scheduled Tasks:
────────────────────────────────────────────────────────────────
Daily backup:         02:00
Hourly monitoring:    Every hour
Log rotation:         03:00
Security audit:       Sunday 01:00

Configuration:
────────────────────────────────────────────────────────────────
Main config:          /etc/sysadmin/sysadmin.conf
Edit config:          sudo nano /etc/sysadmin/sysadmin.conf

Logs:
────────────────────────────────────────────────────────────────
Log directory:        /var/log/sysadmin
View logs:            sudo tail -f /var/log/sysadmin/sysadmin.log

Next Steps:
────────────────────────────────────────────────────────────────
1. Review configuration: /etc/sysadmin/sysadmin.conf
2. Configure backup destinations
3. Set monitoring thresholds
4. Test email notifications
5. Run initial backup: sudo sysadmin --backup

Installation log: /var/log/sysadmin/install_20251020_003445.log
```