
### Goal:
Create a script named `cron_ready.sh` that satisfies all cron compatibility standards.
### Requirements:
- Uses absolute paths for all commands and files
- No need for interactive input/TTY
- Manual PATH export in script
- Writes logs to file
- Sends alerts via email for failures
- Fit for system or user crontab
### Expected Output Example:
```bash
./cron_ready.sh
```
```
╔════════════════════════════════════════════════════════════════╗
║              CRON-READY SCRIPT                                 ║
╚════════════════════════════════════════════════════════════════╝

[INFO] Setting PATH...
[INFO] Starting at: 2025-10-20 00:28:00

Running backup routine...
→ /usr/bin/tar -czf /var/backups/home_20251020.tar.gz /home/user

Status: ✓ Success
Log file: /var/log/cron_ready.log

[INFO] Finished at: 2025-10-20 00:28:05
```

**Script errors (emailed to user):**
```
[ERROR] Backup failed!
Command: /usr/bin/tar -czf /var/backups/home_20251020.tar.gz /home/user
Exit code: 2
See log: /var/log/cron_ready.log

[INFO] Sending alert email to: user@example.com

[INFO] Script finished with errors
```

***
