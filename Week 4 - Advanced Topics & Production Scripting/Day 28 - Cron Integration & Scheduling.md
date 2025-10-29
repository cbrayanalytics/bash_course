### Crontab Syntax
**Crontab** is used to schedule repeating jobs (cron jobs).

**Basic crontab line:**
```bash
# ┌─ minute (0 - 59)
# │ ┌─ hour (0 - 23)
# │ │ ┌─ day of month (1 - 31)
# │ │ │ ┌─ month (1 - 12)
# │ │ │ │ ┌─ day of week (0 - 6, Sunday=0)
# │ │ │ │ │
# * * * * * <command>
```

**Examples:**
```bash
0 2 * * * /usr/local/bin/backup.sh    # Every day at 2:00 AM
30 6 * * 1 /usr/local/bin/report.sh   # Every Monday at 6:30 AM
*/15 * * * * /usr/local/bin/ping.sh   # Every 15 minutes
```
### Environment Considerations
- Cron runs with a **minimal environment**.
- No `$PATH`, no user environment, no aliases or functions.
- Always use **absolute paths** for scripts and files.

**Get current environment:**
```bash
env > /tmp/cron_env.log
# Check what is available
```

**Inside scripts run by cron:**
- Set variables as needed
- Export all required env vars

**Good practice in cron scripts:**
```bash
#!/bin/bash
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
export PATH
```
### Logging
**Redirect output to log:**
```bash
* * * * * /usr/local/bin/task.sh >> /var/log/task.log 2>&1
```
- `1` = stdout
- `2` = stderr
- `2>&1` combines error and output

**Add timestamps:**
```bash
* * * * * /usr/local/bin/task.sh 2>&1 | ts '[%Y-%m-%d %H:%M:%S]' >> /var/log/task.log
# Use 'ts' from moreutils for timestamps
```
### Email Notifications
By default, cron mails output to `$MAILTO` if set.

**In crontab:**
```bash
MAILTO="user@example.com"
0 3 * * * /usr/local/bin/report.sh
```
- Only output (stdout/stderr) is emailed.

**Send custom email in script:**
```bash
mail -s "Backup Report" user@example.com < /tmp/backup.log
```

- Use `mail`, `mailx`, or `sendmail` as available.
### Anacron
- **Anacron** runs scheduled tasks with guaranteed execution, even if the system is not always on.
- Good for laptops/desktops that may not be up 24/7.

**/etc/anacrontab Example:**
```bash
# period  delay  job-identifier   command
1         10     backup.daily     /usr/local/bin/backup.sh
7         25     report.weekly    /usr/local/bin/weekly_report.sh
```
- `period`: days between runs
- `delay`: minutes to wait after anacron starts
### Cron Best Practices
- Use **absolute paths** everywhere.
- Ensure **scripts run non-interactively** (no user prompts).
- Always handle logging and errors.
- Locking: prevent overlapping runs (see lockfiles below).
- Validate environments (PATH, LANG).

***

- [ ] **Exercise 1:** [[Script for Cron, Absolute Paths, No TTY]]
- [ ] **Exercise 2:** [[Email Notifications for Scheduled Tasks]]
- [ ] **Exercise 3:** [[Handle Concurrent Execution with Lockfiles]]
- [ ] **Daily Project:** [[Automated Backup System with Rotation]]
