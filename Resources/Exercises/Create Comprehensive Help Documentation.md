### Goal:
Create a script named `documented_script.sh` with comprehensive inline and help documentation.
### Requirements:
- Man page style help
- Usage examples
- Exit codes documented
- Environment variables
- Configuration files
- Troubleshooting section
- ASCII diagrams if helpful
- Version information
### Expected Output Example:
```bash
./documented_script.sh --help
```
```
╔════════════════════════════════════════════════════════════════╗
║              BACKUP UTILITY - COMPREHENSIVE HELP               ║
║              Version 2.5.3                                     ║
╚════════════════════════════════════════════════════════════════╝

NAME
    backup.sh - Automated backup utility with rotation and compression

SYNOPSIS
    backup.sh [OPTIONS]
    backup.sh -s SOURCE -d DESTINATION [OPTIONS]

DESCRIPTION
    Create and manage system backups with support for full and incremental
    backups, automatic rotation, compression, and email notifications.
    
    This tool is designed for automated scheduled backups via cron/anacron
    with comprehensive logging and error handling.

REQUIRED OPTIONS
    -s, --source DIRECTORY
        Source directory to backup. Must exist and be readable.
        Multiple sources can be specified with multiple -s flags.
        
    -d, --destination DIRECTORY
        Destination directory for backups. Must be writable.
        Backups are stored as: DEST/backup_YYYYMMDD_HHMMSS.tar.gz

BACKUP OPTIONS
    -t, --type TYPE
        Backup type. Valid values:
            full         Complete backup of all files (default)
            incremental  Only files changed since last backup
            differential Files changed since last full backup
        
    -c, --compress [LEVEL]
        Enable compression using gzip.
        Optional LEVEL: 1-9 (default: 6)
            1 = fastest, least compression
            9 = slowest, best compression
        
    -e, --exclude PATTERN
        Exclude files matching PATTERN. Can be specified multiple times.
        Supports glob patterns:
            *.log       Exclude all log files
            .cache/*    Exclude cache directories
            temp*       Exclude files starting with 'temp'

ROTATION OPTIONS
    -r, --retention DAYS
        Keep backups for DAYS days. Older backups are deleted.
        Default: 7 days
        
    -k, --keep COUNT
        Keep COUNT most recent backups. Older backups are deleted.
        Takes precedence over --retention if both specified.

OUTPUT OPTIONS
    -v, --verbose
        Verbose output. Shows detailed progress and file list.
        
    -q, --quiet
        Quiet mode. Only errors are displayed.
        
    -l, --log FILE
        Write log to FILE. Default: /var/log/backup.log
        Use --no-log to disable logging.
        
    -p, --progress
        Show progress bar during backup operation.

NOTIFICATION OPTIONS
    -m, --email ADDRESS
        Send completion email to ADDRESS.
        Requires mail/mailx to be configured.
        
    --email-on-error
        Only send email if backup fails (default: send always)

ADVANCED OPTIONS
    -n, --dry-run
        Show what would be backed up without actually creating backup.
        Useful for testing exclusion patterns.
        
    -V, --verify
        Verify backup integrity after creation using checksums.
        
    -E, --encrypt
        Encrypt backup using GPG. Requires GPG key to be configured.
        
    --resume
        Resume interrupted backup if possible.
        
    --checksum
        Generate SHA256 checksums for all backed up files.

GENERAL OPTIONS
    -h, --help
        Display this help message and exit.
        
    --version
        Display version information and exit.
        
    --config FILE
        Use FILE as configuration file.
        Default: /etc/backup/backup.conf

ENVIRONMENT VARIABLES
    BACKUP_SOURCE
        Default source directory if -s not specified.
        
    BACKUP_DEST
        Default destination directory if -d not specified.
        
    BACKUP_RETENTION
        Default retention period in days.
        
    MAILTO
        Default email address for notifications.

CONFIGURATION FILE
    Configuration can be specified in /etc/backup/backup.conf
    or ~/.backup.conf (user-specific).
    
    Format:
        SOURCE=/home/user
        DESTINATION=/backups
        RETENTION=7
        COMPRESS=true
        EMAIL=user@example.com

EXIT STATUS
    0    Backup completed successfully
    1    General error
    2    Invalid option or argument
    3    Missing required option
    4    Source directory not found or not readable
    5    Destination directory not writable
    6    Backup creation failed
    7    Verification failed
    8    Lock file exists (another backup running)
    9    Insufficient disk space

EXAMPLES
    Basic full backup:
        backup.sh -s /home/user -d /backups

    Compressed backup with retention:
        backup.sh -s /home/user -d /backups -c -r 30

    Multiple sources with exclusions:
        backup.sh -s /home/user -s /etc -d /backups \
                  -e "*.log" -e "*.tmp" -e ".cache/*"

    Incremental backup with email notification:
        backup.sh -s /data -d /backups -t incremental \
                  -m admin@example.com

    Dry run to test exclusions:
        backup.sh -s /home/user -d /backups -n -v \
                  -e "Downloads/*"

    Encrypted backup with verification:
        backup.sh -s /sensitive -d /backups -E -V

    Resume interrupted backup:
        backup.sh -s /large -d /backups --resume

SCHEDULED BACKUPS (CRON)
    For automated backups, add to crontab:
    
    Daily backup at 2 AM:
        0 2 * * * /usr/local/bin/backup.sh -s /data -d /backups -c -m admin@example.com

    Weekly full backup on Sunday at 1 AM:
        0 1 * * 0 /usr/local/bin/backup.sh -s /data -d /backups -t full

FILES
    /etc/backup/backup.conf
        System-wide configuration file
        
    ~/.backup.conf
        User-specific configuration file
        
    /var/log/backup.log
        Default log file location
        
    /var/run/backup.lock
        Lock file to prevent concurrent backups

TROUBLESHOOTING
    Q: Backup fails with "Permission denied"
    A: Ensure script is run with sufficient permissions (sudo/root)
       or source/destination have correct permissions.

    Q: "Lock file exists" error
    A: Another backup is running, or previous backup was interrupted.
       Check process list: ps aux | grep backup
       Remove stale lock: rm /var/run/backup.lock

    Q: Email notifications not working
    A: Ensure mail/mailx is installed and configured.
       Test: echo "test" | mail -s "Test" user@example.com

    Q: Running out of disk space
    A: Reduce retention period (-r) or keep count (-k).
       Increase compression level (-c 9).
       Add more exclusions (-e).

    Q: Backup is very slow
    A: Reduce compression level (-c 1).
       Check disk I/O: iostat
       Consider incremental backups (-t incremental).

DEPENDENCIES
    Required:
        - tar (GNU tar recommended)
        - gzip (for compression)
    
    Optional:
        - mail/mailx (for email notifications)
        - gpg (for encryption)
        - sha256sum (for checksums)

SEE ALSO
    tar(1), gzip(1), cron(8), anacron(8)
    
    Online documentation:
        https://github.com/user/backup

AUTHOR
    Written by Development Team <dev@example.com>

COPYRIGHT
    Copyright © 2025 Development Team
    License: MIT
    
REPORTING BUGS
    Report bugs to: https://github.com/user/backup/issues
    
VERSION
    backup.sh version 2.5.3
    Released: 2025-10-15
```
### Bonus Challenge:
- Generate man pages automatically
- Create quick reference card
- Add interactive help mode
- Support multiple languages
- Generate HTML documentation
- Add video tutorial links
- Create FAQ section
- Add troubleshooting wizard

***
