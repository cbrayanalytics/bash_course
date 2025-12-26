## Goal:
Create a production-ready script named `backup.sh` that accepts source and destination paths as arguments, validates them, and performs a backup operation.

***
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

***
## Hints:
- Use `[[ -e "$1" ]]` to check if file/directory exists
- Use `[[ -d "$1" ]]` to check if it's a directory
- Use `[[ -r "$1" ]]` to check readability
- Use `[[ -w "$2" ]]` to check writability
- Use `date +%Y%m%d_%H%M%S` for timestamp
- Use `du -sh` to get size of backup
- Use `basename` to get filename from path

***

## Pseudocode:
```bash
BEGIN backup.sh

  // Banner Function
  FUNCTION display_banner()
    DISPLAY decorative backup utility header
  ENDFUNCTION

  // Usage/Help Function
  FUNCTION display_usage()
    DISPLAY usage instructions and argument descriptions
  ENDFUNCTION

  // Error Display Function
  FUNCTION display_error(message)
    DISPLAY "✗ Error: " + message
  ENDFUNCTION

  // Argument Validation
  FUNCTION validate_arguments(argc)
    IF argc < 2 THEN
      CALL display_error("At least 2 arguments required")
      CALL display_usage()
      EXIT 1
    END IF
  ENDFUNCTION

  // Source Validation
  FUNCTION validate_source(path)
    DISPLAY "✓ Validating source..."
    IF path does NOT exist THEN
      CALL display_error("Source does not exist")
      DISPLAY "Path: " + path
      CALL display_usage()
      EXIT 1
    END IF
    IF NOT readable THEN
      CALL display_error("Source is not readable")
      EXIT 1
    END IF
    IF is directory THEN
      DISPLAY "  - Source type: directory"
    ELSE
      DISPLAY "  - Source type: file"
    END IF
  ENDFUNCTION

  // Destination Validation
  FUNCTION validate_destination(path)
    DISPLAY "✓ Validating destination..."
    IF path does NOT exist THEN
      ASK user to create directory, "Create destination directory? (y/n):"
      IF user says yes THEN
        CREATE directory
      ELSE
        EXIT 1
      END IF
    END IF
    IF NOT a directory THEN
      CALL display_error("Destination must be a directory")
      EXIT 1
    END IF
    IF NOT writable THEN
      CALL display_error("Destination is not writable")
      EXIT 1
    END IF
  ENDFUNCTION

  // Prevent Backup to Same Location
  FUNCTION check_same_location(src, dst)
    IF realpath(src) == realpath(dst) THEN
      CALL display_error("Cannot backup to the same location")
      EXIT 1
    END IF
    IF src is directory AND dst path is within src THEN
      CALL display_error("Destination cannot be inside source directory")
      EXIT 1
    END IF
  ENDFUNCTION

  // Backup Name and Path
  FUNCTION get_backup_name(src, prefix)
    IF prefix is empty THEN
      SET timestamp to current date+time
      RETURN basename(src) + "_" + timestamp
    ELSE
      RETURN basename(src) + "_" + prefix
    END IF
  ENDFUNCTION

  // Run Backup
  FUNCTION run_backup(src, dst, backup_name)
    SET backup_path = dst + "/" + backup_name
    DISPLAY "Creating backup..."
    DISPLAY "Backup name: " + backup_name
    IF src is directory THEN
      COPY recursively from src to backup_path
    ELSE
      COPY src to backup_path
    END IF
    DISPLAY "Copying files... Done!"
    RETURN backup_path
  ENDFUNCTION

  // Size Function
  FUNCTION get_size(path)
    RETURN result of du -sh path
  ENDFUNCTION

  // Summary Function
  FUNCTION display_summary(src, backup_path, size)
    DISPLAY summary with source, backup path, size, and status
  ENDFUNCTION

  // Main Section
  CALL display_banner()
  CALL validate_arguments($#)
  SET source = $1
  SET destination = $2
  SET prefix = $3 (if exists else empty)
  CALL validate_source(source)
  CALL validate_destination(destination)
  CALL check_same_location(source, destination)
  SET backup_name = get_backup_name(source, prefix)
  SET backup_path = run_backup(source, destination, backup_name)
  SET size = get_size(backup_path)
  CALL display_summary(source, backup_path, size)
  EXIT 0

END backup.sh
```

***
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

***
## Bonus Pseudocode:

### Compression flag (-c)
```
FUNCTION perform_compression(src, dst, backup_name, verbose)
  SET archive_path = dst + "/" + backup_name + ".tar.gz"
  IF verbose THEN
    DISPLAY "Creating compressed archive with verbose mode..."
  END IF
  CREATE tar.gz from src as archive_path (run tar command, use verbose flag if enabled)
  RETURN archive_path
ENDFUNCTION
```

### Verbose flag (-v)
```
PARSE arguments for "-v" flag
SET verbose_mode = true if found

IN ALL COPY/ARCHIVE OPERATIONS:
  IF verbose_mode THEN
    DISPLAY detailed operation logs/messages
  END IF
```

### Dry-run Mode
```
IF dry-run flag set THEN
  DISPLAY what would be copied, skipped, or compressed
  DO NOT perform actual backup/archiving operations
  EXIT 0
END IF
```

### Backup rotation
```
FUNCTION rotate_backups(dst, base, N)
  GET list of backups in dst matching "base_*" sorted oldest first
  WHILE number of backups > N DO
    DELETE oldest backup
  END WHILE
ENDFUNCTION
```

### Checksum Verification
```
FUNCTION verify_checksum(original, backup)
  CALCULATE checksum of original
  CALCULATE checksum of backup
  IF values match THEN
    DISPLAY "Checksum verified: PASSED"
  ELSE
    DISPLAY "Checksum FAILED: Possible corruption"
    EXIT 1
  END IF
ENDFUNCTION
```

### Email Notification
```
FUNCTION send_email_notification(status, details)
  IF configured THEN
    SEND email with backup status/details to recipient
  END IF
ENDFUNCTION
```

### Exclude Patterns
```
FUNCTION build_excludes()
  SET exclude_patterns to [".git", "*.tmp", ...]
  RETURN exclude arguments for tar/rsync command
ENDFUNCTION

IN archiving/copy functions:
  USE exclude arguments returned by build_excludes()
```

***
## Bonus Challenges:
- Add `-c` flag for compression (create .tar.gz)
- Add `-v` flag for verbose output
- Add dry-run mode to show what would be backed up
- Keep only last N backups in destination (rotation)
- Calculate and verify checksum after backup
- Send email notification on completion
- Support exclude patterns (like .git directories)

***