### Goal:
Create a robust automated backup solution (`auto_backup.sh`) that runs from cron/anacron, maintains backup rotation, and includes logging, notification, and concurrency control.
### Requirements:
**Backup Features:**
- Full and incremental backups
- Timestamped archive naming
- Backup rotation (keep N most recent)
- Remove old backups automatically
- Compression options
- Logging (detailed, timestamped)
- Email notification on completion/failure
- Handled for cron/env (absolute paths)
- Uses lockfiles for concurrency
- Detects and removes stale locks
- Supports exclusion patterns
- Rotates logs as needed

**Extras:**
- Resume partial backups
- Verify backup integrity
- Support for remote backup targets (rsync/SFTP)
- Handling for missed/late jobs (anacron)
- System resource check (space, I/O)
- Self-test/ping mode for monitoring
### Expected Output Example:
```bash
./auto_backup.sh
```
```
╔════════════════════════════════════════════════════════════════╗
║              AUTOMATED BACKUP SYSTEM                           ║
╚════════════════════════════════════════════════════════════════╝

[INFO] Starting automated backup at 2025-10-20 00:28:30
[INFO] Using profile: daily
[INFO] Host: myserver.local
[INFO] Log file: /var/log/auto_backup.log

Lock Check:
────────────────────────────────────────────────────────────────
✓ Lock acquired (PID=12345 HOST=myserver.local)
Lockfile: /var/run/auto_backup.lock

Configuration:
────────────────────────────────────────────────────────────────
Source:          /home/user
Destination:     /backups
Backup type:     Full
Compression:     Enabled (gzip)
Exclusions:      .cache/*, *.tmp
Keep:            7 backups (rotation)
Log:             /var/log/auto_backup.log
Notification:    user@example.com

Pre-flight Checks:
────────────────────────────────────────────────────────────────
✓ Source exists and is readable
✓ Destination writable
✓ Minimum free space: 10 GB

Creating backup archive:
────────────────────────────────────────────────────────────────
Archive name:    backup_20251020_002830.tar.gz
Saving to:       /backups/backup_20251020_002830.tar.gz

Progress: ████████████████████████████████████████ 100%
Total size: 5.2 GB (compressed)

[INFO] Backup completed successfully

Rotating backups (keep last 7):
────────────────────────────────────────────────────────────────
Found:       8 backups
Removing:    /backups/backup_20251010_010200.tar.gz (oldest)

[INFO] 1 old backup removed. 7 backups remain.

Notification:
────────────────────────────────────────────────────────────────
✓ Email sent to: user@example.com
✓ Log attached: /var/log/auto_backup.log

Cleanup:
────────────────────────────────────────────────────────────────
✓ Lock released (PID=12345)
✓ Temporary files removed

Summary:
────────────────────────────────────────────────────────────────
Archive:      backup_20251020_002830.tar.gz
Source:       /home/user
Destination:  /backups
Size:         5.2 GB
Backups kept: 7
Rotation:     Oldest removed
Next run:     2025-10-21 00:28:00

Status:       ✓ COMPLETE
╔════════════════════════════════════════════════════════════════╗
║              BACKUP SYSTEM READY FOR NEXT RUN                  ║
╚════════════════════════════════════════════════════════════════╝
```

**On error or concurrent run:**
```
[ERROR] Failed to acquire lock - another backup is running (PID=5678)
[INFO] Exiting without performing backup
[WARN] Last backup succeeded (2025-10-19 00:28), no data loss risk

Orphaned lock detected (PID=21789 not running, age: 3h12m)
[INFO] Removing stale lock and retrying...
[INFO] Lock acquired, resuming backup...
```