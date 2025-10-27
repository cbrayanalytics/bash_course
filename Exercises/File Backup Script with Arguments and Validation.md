## Goal:
Create a production-ready script named `backup.sh` that accepts source and destination paths as arguments, validates them, and performs a backup operation.
## Requirements:
**Arguments:**
- `$1` - Source file or directory to backup
- `$2` - Destination directory for backup
- Optional `$3` - Backup name/prefix (if not provided, use timestamp)

**Validations:**
1. Check that at least 2 arguments are provided
2. Verify source exists (file or directory)
3. Verify destination directory exists (or create it with confirmation)
4. Check if source is readable
5. Check if destination is writable
6. Prevent backing up to the same location as source

**Functionality:**
- Create a backup with timestamp in filename
- Use `cp -r` for directories, `cp` for files
- Display progress messages
- Display summary of what was backed up
- Show backup location and size
- Exit with appropriate exit codes (0=success, 1=error)

## Hints:
- Use `[[ -e "$1" ]]` to check if file/directory exists
- Use `[[ -d "$1" ]]` to check if it's a directory
- Use `[[ -r "$1" ]]` to check readability
- Use `[[ -w "$2" ]]` to check writability
- Use `date +%Y%m%d_%H%M%S` for timestamp
- Use `du -sh` to get size of backup
- Use `basename` to get filename from path
## Expected Output Example:
```bash
./backup.sh /home/user/project /backups/
```
```
╔════════════════════════════════════════╗
║         File Backup Utility            ║
╚════════════════════════════════════════╝

Source: /home/user/project
Destination: /backups/

✓ Validating source...
  - Source exists
  - Source is readable
  - Source type: directory

✓ Validating destination...
  - Destination exists
  - Destination is writable

Creating backup...
Backup name: project_20251017_204700

Copying files... Done!

════════════════════════════════════════
Backup Summary:
════════════════════════════════════════
Source:     /home/user/project
Backup:     /backups/project_20251017_204700
Size:       2.3 MB
Status:     ✓ Success
════════════════════════════════════════
```

```bash
./backup.sh /nonexistent /backups/
```
```
✗ Error: Source does not exist
Path: /nonexistent

Usage: ./backup.sh <source> <destination> [backup_name]
  source      - File or directory to backup
  destination - Directory where backup will be stored
  backup_name - Optional custom backup name (default: timestamp)
```

## Bonus Challenges:
- Add `-c` flag for compression (create .tar.gz)
- Add `-v` flag for verbose output
- Add dry-run mode to show what would be backed up
- Keep only last N backups in destination (rotation)
- Calculate and verify checksum after backup
- Send email notification on completion
- Support exclude patterns (like .git directories)

***