### Goal:
Create a script named `notify_task.sh` that sends emails after scheduled tasks.
### Requirements:
- Compose email with subject/body
- Attach log/output
- Detect failures and change subject
- Use `mail`/`mailx` or SMTP relay
- Respect $MAILTO if set
- Support HTML email if available
### Expected Output Example:
```bash
./notify_task.sh
```
```
╔════════════════════════════════════════════════════════════════╗
║              SCHEDULED TASK WITH EMAIL NOTIFICATION            ║
╚════════════════════════════════════════════════════════════════╝

Task:       Database Backup
Status:     ✓ SUCCESS
Log:        /var/log/db_backup.log
Timestamp:  2025-10-20 00:28:10

[INFO] Sending success notification email to: admin@example.com

Email sent:
────────────────────────────────────────────────────────────────
Subject: [SUCCESS] Database Backup (2025-10-20 00:28)
Body:
    The scheduled task "Database Backup" completed successfully.

    Log excerpt:
    [2025-10-20 00:28:00] Starting...
    [2025-10-20 00:28:05] Success!

Attachment: /var/log/db_backup.log
```

**Failure notification:**
```
Subject: [FAILURE] Database Backup (2025-10-20 00:28)
Body:
    The scheduled task "Database Backup" FAILED.
    See logs for details.
```

***
