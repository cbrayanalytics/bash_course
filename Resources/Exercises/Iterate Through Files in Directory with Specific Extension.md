### Goal:
Create a script named `file_iterator.sh` that finds and processes files with specific extensions.
### Requirements:
- Accept file extension as argument (e.g., `.txt`, `.jpg`)
- If no argument, default to `.txt`
- Find all files with that extension in current directory
- For each file, display:
  - Filename
  - File size
  - Last modified date
  - Line count (for text files)
  - File permissions
- Count total files found
- Calculate total size of all files
- Handle case where no files found
- Support multiple extensions
### Hints:
- Use glob pattern: `*.txt`
- Check if glob matches anything: `shopt -s nullglob`
- File size: `stat -f%z "$file"` (macOS) or `stat -c%s "$file"` (Linux)
- Or use: `ls -lh "$file" | awk '{print $5}'`
- Line count: `wc -l < "$file"`
- Modified date: `stat -f%Sm "$file"` or `stat -c%y "$file"`

### Expected Output Example:
```bash
./file_iterator.sh txt
```

```
╔════════════════════════════════════════════════════════════════╗
║      FILE ITERATOR - Searching for .txt files                  ║
╚════════════════════════════════════════════════════════════════╝

Scanning current directory...

┌────────────────────────────────────────────────────────────────┐
│ File 1: document.txt                                           │
├────────────────────────────────────────────────────────────────┤
│ Size:         2,345 bytes (2.3 KB)                            │
│ Modified:     2025-10-18 15:30:22                             │
│ Permissions:  rw-r--r-- (644)                                  │
│ Lines:        87                                               │
│ Type:         ASCII text                                       │
└────────────────────────────────────────────────────────────────┘

┌────────────────────────────────────────────────────────────────┐
│ File 2: notes.txt                                              │
├────────────────────────────────────────────────────────────────┤
│ Size:         1,024 bytes (1.0 KB)                            │
│ Modified:     2025-10-19 01:00:00                             │
│ Permissions:  rw-r--r-- (644)                                  │
│ Lines:        42                                               │
│ Type:         ASCII text                                       │
└────────────────────────────────────────────────────────────────┘

┌────────────────────────────────────────────────────────────────┐
│ File 3: todo.txt                                               │
├────────────────────────────────────────────────────────────────┤
│ Size:         512 bytes (512 bytes)                           │
│ Modified:     2025-10-17 10:15:30                             │
│ Permissions:  rw-r--r-- (644)                                  │
│ Lines:        15                                               │
│ Type:         ASCII text                                       │
└────────────────────────────────────────────────────────────────┘

╔════════════════════════════════════════════════════════════════╗
║                         SUMMARY                                ║
╚════════════════════════════════════════════════════════════════╝

Extension:     .txt
Files found:   3
Total size:    3,881 bytes (3.8 KB)
Total lines:   144
Average size:  1,293.67 bytes
Largest file:  document.txt (2.3 KB)
Smallest file: todo.txt (512 bytes)
Newest file:   notes.txt (2025-10-19 01:00:00)
Oldest file:   todo.txt (2025-10-17 10:15:30)
```

```bash
./file_iterator.sh jpg
```

```
╔════════════════════════════════════════════════════════════════╗
║      FILE ITERATOR - Searching for .jpg files                  ║
╚════════════════════════════════════════════════════════════════╝

Scanning current directory...

⚠ No .jpg files found in current directory

Suggestions:
  • Check if files exist with different extensions
  • Try: ./file_iterator.sh png
  • Use -r flag for recursive search (if supported)
```

```bash
./file_iterator.sh "txt|log|md"
```

```
╔════════════════════════════════════════════════════════════════╗
║      FILE ITERATOR - Multiple Extensions                       ║
╚════════════════════════════════════════════════════════════════╝

Searching for: .txt .log .md files

Processing .txt files... (3 found)
Processing .log files... (2 found)
Processing .md files... (1 found)

Total files across all extensions: 6
Total size: 15.2 KB
```
### Bonus Challenge:
- Add recursive directory search
- Filter by file age (modified in last N days)
- Filter by file size (larger/smaller than X)
- Sort files by different criteria (size, date, name)
- Preview first N lines of text files
- Generate detailed CSV report
- Support exclude patterns (skip certain files)
- Add progress bar for large directories

***