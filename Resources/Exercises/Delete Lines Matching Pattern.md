### Goal:
Create a script named `line_deleter.sh` that removes lines matching specific patterns from files.
### Requirements:
- Delete lines by pattern (regex support)
- Delete by line number or range
- Delete empty lines
- Delete comments (various formats: #, //, /*, --)
- Options:
  - Delete matching lines
  - Delete non-matching lines (keep only matches)
  - Delete duplicates
  - Delete trailing/leading whitespace lines
- Preview before deletion
- Create backups
- Show what was deleted
- Statistics on deletion
- Support multiple patterns
- Batch processing
### Expected Output Example:
```bash
./line_deleter.sh --pattern "^DEBUG" --backup application.log
```
```
╔════════════════════════════════════════════════════════════════╗
║              LINE DELETION UTILITY                             ║
╚════════════════════════════════════════════════════════════════╝

Configuration:
────────────────────────────────────────────────────────────────
File:             application.log
Pattern:          ^DEBUG (lines starting with DEBUG)
Backup:           Yes (.bak)
Show deleted:     Yes

Analyzing file...
Original file:    1,247 lines
Matching lines:   342 lines (27.4%)

Preview of lines to be deleted:
────────────────────────────────────────────────────────────────
Line 5:   DEBUG: Initializing configuration
Line 12:  DEBUG: Loading modules
Line 18:  DEBUG: Connecting to database
Line 23:  DEBUG: Query execution time: 0.023s
Line 29:  DEBUG: Cache hit for key: user_123
[... showing first 10 of 342]

After deletion:   905 lines remaining

Proceed with deletion? [y/n]: y

Creating backup...
✓ Backup: application.log.bak

Deleting lines...
████████████████████████████████████████ 100%

╔════════════════════════════════════════════════════════════════╗
║                  DELETION COMPLETE                             ║
╚════════════════════════════════════════════════════════════════╝

Summary:
────────────────────────────────────────────────────────────────
Lines deleted:    342 (27.4%)
Lines remaining:  905 (72.6%)
File size before: 245 KB
File size after:  178 KB (27% reduction)
Backup location:  application.log.bak

Deleted lines saved to: deleted_lines_20251019.txt
```

```bash
./line_deleter.sh --empty --comments config.ini
```
```
╔════════════════════════════════════════════════════════════════╗
║         LINE DELETION - Multiple Pattern Mode                  ║
╚════════════════════════════════════════════════════════════════╝

File: config.ini (Original: 156 lines)

Patterns to delete:
────────────────────────────────────────────────────────────────
1. Empty lines (^$)
2. Comment lines (^[;#])

Analysis:
────────────────────────────────────────────────────────────────
Empty lines:         23 (14.7%)
Comment lines:       45 (28.8%)
Total to delete:     68 (43.6%)
Lines to keep:       88 (56.4%)

Preview (showing what will be kept):
────────────────────────────────────────────────────────────────
[database]
host=localhost
port=5432
name=production

[cache]
enabled=true
ttl=3600

[logging]
level=info
file=/var/log/app.log
────────────────────────────────────────────────────────────────

This will create a clean config file without comments/empty lines.
Proceed? [y/n]: y

Processing...
✓ Removed 23 empty lines
✓ Removed 45 comment lines
✓ Saved cleaned file

Result: 88 lines remaining (43.6% reduction)
```
### Bonus Challenge:
- Add pattern library (common deletion patterns)
- Support multi-file processing
- Create undo/redo functionality
- Add smart comment detection (preserve headers)
- Support keeping N lines before/after pattern
- Add deduplication options
- Create filters for structured data (JSON, XML)
- Support custom deletion rules
- Add compression for deleted content
- Create deletion audit log

***