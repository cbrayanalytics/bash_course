### Goal:
Create a script named `process_visible.sh` that processes files in a directory but skips hidden files (starting with `.`) using the continue statement.
### Requirements:
- Accept directory path as argument (default: current directory)
- List all files in directory
- Use `continue` to skip:
  - Hidden files (starting with `.`)
  - Directories
  - Files without read permission
  - Files matching ignore patterns (e.g., `*.bak`, `*~`)
- For non-skipped files, perform processing:
  - Display filename
  - Show file size
  - Count lines (for text files)
  - Display file type
- Show statistics:
  - Total files found
  - Files processed
  - Files skipped (with reasons)
- Support configuration file for ignore patterns
### Hints:
- Check hidden: `[[ "$file" == .* ]]`
- Check directory: `[[ -d "$file" ]]`
- Check readable: `[[ -r "$file" ]]`
- Pattern matching: `[[ "$file" == *.bak ]]`
- Use `continue` for each skip condition
### Expected Output Example:
```bash
./process_visible.sh
```
```
╔════════════════════════════════════════════════════════════════╗
║         VISIBLE FILE PROCESSOR                                 ║
║         Directory: /home/user/documents                        ║
╚════════════════════════════════════════════════════════════════╝

Processing files...

Scanning: .bashrc
  ⊘ Skipped: Hidden file

Scanning: .git
  ⊘ Skipped: Hidden directory

Scanning: projects
  ⊘ Skipped: Directory (not a file)

Scanning: document.txt
  ✓ Processing...
  Size: 2.3 KB
  Lines: 87
  Type: ASCII text
  ✓ Processed successfully

Scanning: photo.jpg
  ✓ Processing...
  Size: 1.5 MB
  Type: JPEG image
  ✓ Processed successfully

Scanning: backup~
  ⊘ Skipped: Backup file (matches *~ pattern)

Scanning: notes.txt.bak
  ⊘ Skipped: Backup file (matches *.bak pattern)

Scanning: script.sh
  ✓ Processing...
  Size: 3.2 KB
  Lines: 125
  Type: Shell script
  Executable: Yes
  ✓ Processed successfully

Scanning: protected.txt
  ⊘ Skipped: No read permission

Scanning: README.md
  ✓ Processing...
  Size: 5.1 KB
  Lines: 230
  Type: Markdown document
  ✓ Processed successfully

╔════════════════════════════════════════════════════════════════╗
║                         SUMMARY                                ║
╚════════════════════════════════════════════════════════════════╝

Files scanned:        10
Files processed:      4
Files skipped:        6

Skip reasons:
  Hidden files:       2
  Directories:        1
  Backup files:       2
  No permission:      1

Processing time:      0.245 seconds
```

```bash
./process_visible.sh --verbose /tmp
```
```
╔════════════════════════════════════════════════════════════════╗
║         VISIBLE FILE PROCESSOR - Verbose Mode                  ║
╚════════════════════════════════════════════════════════════════╝

Configuration:
  Directory: /tmp
  Skip hidden files: Yes
  Skip directories: Yes
  Ignore patterns: *.bak, *~, *.tmp
  Process symbolic links: No

────────────────────────────────────────────────────────────────

[1/25] Scanning: .cache
       Type: Directory (hidden)
       Action: SKIP (hidden directory)
       Reason: Hidden files are excluded by default

[2/25] Scanning: file1.txt
       Type: Regular file
       Size: 1.2 KB
       Readable: Yes
       Action: PROCESS
       Lines: 42
       ✓ Success

[3/25] Scanning: tempfile.tmp
       Type: Regular file
       Pattern match: *.tmp
       Action: SKIP (matches ignore pattern)
       Reason: Temporary files excluded

[4/25] Scanning: link_to_file
       Type: Symbolic link
       Action: SKIP (symbolic link)
       Reason: Symbolic links excluded by default

...

────────────────────────────────────────────────────────────────
Detailed Statistics:
────────────────────────────────────────────────────────────────

Total items scanned: 25

Processed (10):
  Text files: 6
  Images: 2
  Scripts: 1
  Other: 1

Skipped (15):
  Hidden files: 3
  Hidden directories: 2
  Regular directories: 4
  Backup files: 3
  Temporary files: 2
  Symbolic links: 1

Performance:
  Average processing time per file: 0.024s
  Total time: 0.245s
```

```bash
./process_visible.sh --show-only
```
```
╔════════════════════════════════════════╗
║      FILES TO BE PROCESSED             ║
╚════════════════════════════════════════╝

The following files will be processed:

✓ document.txt (2.3 KB)
✓ photo.jpg (1.5 MB)
✓ script.sh (3.2 KB)
✓ README.md (5.1 KB)

The following files will be skipped:

⊘ .bashrc (hidden)
⊘ .git (hidden directory)
⊘ projects (directory)
⊘ backup~ (backup file)
⊘ notes.txt.bak (backup file)
⊘ protected.txt (no permission)

Total to process: 4
Total to skip: 6

Run without --show-only to process files
```
### Bonus Challenge:
- Add include patterns (only process certain extensions)
- Support recursive directory processing
- Add dry-run mode
- Implement custom filters via functions
- Support regex patterns
- Add parallel processing
- Create processing pipeline (multiple operations)
- Generate detailed report with charts
- Support undo for processed files
- Add file watching mode (process new files)

***