### Goal:
Build a professional backup utility named `backup.sh` with comprehensive option parsing supporting multiple backup strategies and configurations.
### Requirements:
**Core Options:**
- `-s, --source DIR` - Source directory (required)
- `-d, --dest DIR` - Destination directory (required)
- `-c, --compress` - Enable compression
- `-v, --verbose` - Verbose output
- `-i, --incremental` - Incremental backup
- `-e, --exclude PATTERN` - Exclude pattern (can be used multiple times)
- `-t, --type TYPE` - Backup type (full, incremental, differential)
- `-n, --dry-run` - Show what would be backed up
- `-r, --retention DAYS` - Retention period
- `-l, --log FILE` - Log file path

**Advanced Features:**
- Multiple source directories
- Pattern-based exclusions
- Compression levels
- Integrity verification
- Progress indicators
- Resume capability
- Email notifications
- Encryption support
### Expected Output Example:
```bash
./backup.sh --help
```

```
╔════════════════════════════════════════════════════════════════╗
║              BACKUP UTILITY v2.0                               ║
║              Professional Backup Solution                      ║
╚════════════════════════════════════════════════════════════════╝

USAGE:
    backup.sh -s SOURCE -d DESTINATION [OPTIONS]

DESCRIPTION:
    Create backups with support for incremental, differential, and full
    backup strategies. Includes compression, encryption, and verification.

REQUIRED OPTIONS:
    -s, --source DIR        Source directory to backup
    -d, --dest DIR          Destination directory for backups

BACKUP OPTIONS:
    -t, --type TYPE         Backup type (default: full)
                            full        - Complete backup
                            incremental - Changes since last backup
                            differential- Changes since last full backup
    
    -i, --incremental       Shortcut for --type incremental
    -c, --compress          Enable compression (gzip)
    -z, --compression NUM   Compression level 1-9 (default: 6)
    -e, --exclude PATTERN   Exclude files matching pattern
                            (can be specified multiple times)

OUTPUT OPTIONS:
    -v, --verbose           Verbose output
    -q, --quiet             Quiet mode (errors only)
    -p, --progress          Show progress bar
    -l, --log FILE          Log file path (default: backup.log)
    --no-log                Disable logging

ADVANCED OPTIONS:
    -n, --dry-run           Show what would be backed up
    -V, --verify            Verify backup integrity
    -E, --encrypt           Encrypt backup (requires password)
    -r, --retention DAYS    Delete backups older than DAYS
    -m, --email ADDRESS     Send notification email
    --checksum              Generate checksums
    --resume                Resume interrupted backup

EXAMPLES:
    # Basic full backup
    backup.sh -s /home/user -d /backup

    # Incremental backup with compression
    backup.sh -s /home/user -d /backup -i -c

    # Full backup with exclusions
    backup.sh -s /data -d /backup -t full \
              -e "*.tmp" -e "*.log" -e ".cache/*"

    # Verbose compressed backup with verification
    backup.sh -s /data -d /backup -v -c -V

    # Dry run to preview
    backup.sh -s /data -d /backup -n

    # Encrypted backup with retention
    backup.sh -s /sensitive -d /backup -E -r 30

EXIT CODES:
    0    Backup completed successfully
    1    General error
    2    Invalid option
    3    Missing required option
    4    Source not found
    5    Destination not writable
    6    Backup failed
    7    Verification failed

AUTHOR:
    Development Team <dev@example.com>

REPORTING BUGS:
    https://github.com/example/backup/issues
```

```bash
sudo ./backup.sh -s /home/user/documents -d /backup -c -v -p
```

```
╔════════════════════════════════════════════════════════════════╗
║              BACKUP UTILITY v2.0                               ║
║              Starting Backup Process                           ║
╚════════════════════════════════════════════════════════════════╝

[INFO] Initializing backup...
[VERBOSE] User: root
[VERBOSE] Timestamp: 2025-10-20 00:16:00 MDT

Configuration:
════════════════════════════════════════════════════════════════
Source:          /home/user/documents
Destination:     /backup
Backup Type:     Full
Compression:     Enabled (gzip, level 6)
Verbose:         Enabled
Progress:        Enabled
Encryption:      Disabled
Verification:    Disabled
Dry Run:         Disabled

[VERBOSE] Validating configuration...

Pre-flight Checks:
────────────────────────────────────────────────────────────────
✓ Source exists: /home/user/documents
✓ Source readable
✓ Destination exists: /backup
✓ Destination writable
✓ Sufficient disk space: 45.2 GB available
✓ All dependencies found (tar, gzip)

[VERBOSE] Analyzing source directory...

Source Analysis:
────────────────────────────────────────────────────────────────
Total files:     1,247
Total size:      2.3 GB
Directories:     67
Largest file:    245 MB (video.mp4)
File types:      .pdf (234), .docx (156), .txt (423), .jpg (234), other (200)

Estimated backup size: 1.2 GB (with compression)
Estimated duration: 3-5 minutes

[VERBOSE] Creating backup metadata...

Backup Information:
────────────────────────────────────────────────────────────────
Backup ID:       backup_20251020_001600
Archive name:    backup_20251020_001600.tar.gz
Full path:       /backup/backup_20251020_001600.tar.gz
Type:            Full backup
Started:         2025-10-20 00:16:00

[VERBOSE] Starting backup process...

Creating Archive:
════════════════════════════════════════════════════════════════

Progress: ████████████████████████████████████████ 100% (2.3 GB / 2.3 GB)

Files:    ████████████████████████████████████████ 1,247 / 1,247
Time:     00:03:42
Speed:    10.4 MB/s

[VERBOSE] File list:
  /home/user/documents/project/report.pdf
  /home/user/documents/project/data.xlsx
  /home/user/documents/images/photo1.jpg
  [... 1,244 more files]

[VERBOSE] Compression complete

Compression Results:
────────────────────────────────────────────────────────────────
Original size:     2.3 GB
Compressed size:   1.2 GB
Compression ratio: 47.8% (saved 1.1 GB)
Compression time:  3m 42s

[VERBOSE] Writing backup metadata...
[VERBOSE] Calculating checksums...

Backup Complete:
════════════════════════════════════════════════════════════════
Archive:          /backup/backup_20251020_001600.tar.gz
Size:             1.2 GB
Files backed up:  1,247
Checksum (SHA256): 2c26b46b68ffc68ff99b453c1d30413413422d706483bfa0f98a5e886266e7ae
Duration:         3m 42s
Status:           ✓ Success

[VERBOSE] Updating backup catalog...

Backup Catalog Updated:
────────────────────────────────────────────────────────────────
Previous backups: 3
New backup added: backup_20251020_001600
Total backups:    4
Total size:       4.8 GB

╔════════════════════════════════════════════════════════════════╗
║              BACKUP COMPLETED SUCCESSFULLY                     ║
╚════════════════════════════════════════════════════════════════╝

Summary:
────────────────────────────────────────────────────────────────
Source:           /home/user/documents
Destination:      /backup/backup_20251020_001600.tar.gz
Files:            1,247 files backed up
Size:             1.2 GB (compressed from 2.3 GB)
Duration:         3m 42s
Status:           ✓ Complete

To restore:
  tar -xzf /backup/backup_20251020_001600.tar.gz -C /restore/path

To verify:
  ./backup.sh --verify /backup/backup_20251020_001600.tar.gz

Log file: /var/log/backup/backup_20251020_001600.log
```

```bash
./backup.sh -s /data -d /backup -e "*.log" -e "*.tmp" -e ".cache/*" -v
```

```
[VERBOSE] Exclusion patterns configured...

Exclusion Patterns:
────────────────────────────────────────────────────────────────
1. *.log        Exclude all log files
2. *.tmp        Exclude temporary files
3. .cache/*     Exclude cache directories

[VERBOSE] Scanning with exclusions...

Files Excluded:
────────────────────────────────────────────────────────────────
Log files:       234 files (456 MB)
Temp files:      89 files (123 MB)
Cache files:     567 files (1.2 GB)

Total excluded:  890 files (1.8 GB)
Remaining:       357 files (512 MB)

[VERBOSE] Creating backup of 357 files...

Progress: ████████████████████████████████████████ 100% (357 / 357)

✓ Backup complete (357 files, 512 MB)
```

```bash
./backup.sh -s /data -d /backup -i -v
```

```
[INFO] Incremental backup mode
[VERBOSE] Finding last full backup...

Backup History:
────────────────────────────────────────────────────────────────
Last full backup:  backup_20251019_120000.tar.gz
                   Date: 2025-10-19 12:00:00
                   Size: 2.3 GB

[VERBOSE] Scanning for changes since last backup...

Changes Detected:
────────────────────────────────────────────────────────────────
New files:       23 files (45 MB)
Modified files:  12 files (23 MB)
Deleted files:   5 files

Total to backup: 35 files (68 MB)

[VERBOSE] Creating incremental backup...

Progress: ████████████████████████████████████████ 100% (35 / 35)

Incremental Backup Complete:
────────────────────────────────────────────────────────────────
Archive:         backup_20251020_001600_incremental.tar.gz
Base backup:     backup_20251019_120000.tar.gz
Changes:         35 files (68 MB)
Duration:        12 seconds

To restore:
  1. Restore full backup: backup_20251019_120000.tar.gz
  2. Apply incremental: backup_20251020_001600_incremental.tar.gz
```

```bash
./backup.sh -s /data -d /backup -n
```

```
╔════════════════════════════════════════════════════════════════╗
║              DRY RUN MODE                                      ║
║              No actual backup will be created                  ║
╚════════════════════════════════════════════════════════════════╝

[DRY-RUN] Simulating backup process...

Would backup from:  /data
Would backup to:    /backup

Files that would be backed up:
────────────────────────────────────────────────────────────────
/data/file1.txt (2.3 KB)
/data/file2.pdf (1.2 MB)
/data/subfolder/document.docx (456 KB)
[... 1,244 more files]

Summary (simulation):
────────────────────────────────────────────────────────────────
Total files:      1,247
Total size:       2.3 GB
Estimated time:   3-5 minutes
Archive name:     backup_20251020_001600.tar.gz
Estimated size:   1.2 GB (compressed)

[DRY-RUN] No backup was created
[DRY-RUN] Run without -n to perform actual backup
```
