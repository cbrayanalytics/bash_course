### Goal:
Create a script named `file_compare.sh` that compares two files and determines which is newer, older, or if they're the same.
### Requirements:
- Accept two file paths as arguments
- Verify both files exist
- Compare modification times using `-nt` and `-ot`
- Display which file is newer
- Show actual modification timestamps for both
- Calculate time difference between files
- Suggest actions based on comparison (backup recommendations)
### Hints:
- Use `-nt` (newer than) and `-ot` (older than)
- Use `stat` to get exact timestamps
- Use `date` command for formatting timestamps
- Calculate difference in seconds, convert to human-readable
- Consider edge case where files have same timestamp
### Expected Output Example:
```bash
./file_compare.sh config.txt config.backup
```
```
Comparing Files:
File 1: config.txt
File 2: config.backup

File Information:
-----------------
config.txt
  Modified: 2025-10-19 01:00:00
  Size: 2.3 KB

config.backup
  Modified: 2025-10-18 10:30:00
  Size: 2.1 KB

Comparison Result:
------------------
✓ config.txt is NEWER than config.backup
  Time difference: 14 hours, 30 minutes

Recommendation:
config.backup is outdated. Consider creating a fresh backup:
  cp config.txt config.backup
```

```bash
./file_compare.sh data.csv data_old.csv
```
```
Comparing Files:
File 1: data.csv
File 2: data_old.csv

File Information:
-----------------
data.csv
  Modified: 2025-10-15 08:00:00
  Size: 5.2 MB

data_old.csv
  Modified: 2025-10-18 16:00:00
  Size: 4.8 MB

Comparison Result:
------------------
⚠ data.csv is OLDER than data_old.csv
  Time difference: 3 days, 8 hours

Warning:
The file named 'old' is actually newer! This might indicate:
  - Incorrect naming
  - Files need to be renamed
  - data.csv may be outdated
```

```bash
./file_compare.sh file1.txt file1.txt
```
```
Comparing Files:
File 1: file1.txt
File 2: file1.txt

⚠ Both arguments point to the same file
Modified: 2025-10-19 01:00:00
Size: 1.5 KB
```

```bash
./file_compare.sh doc.txt missing.txt
```
```
Comparing Files:
File 1: doc.txt
File 2: missing.txt

✗ Error: missing.txt does not exist
Cannot compare files.
```
### Bonus Challenge:
- Compare content as well as timestamps (using diff or checksums)
- Support wildcard patterns to compare multiple files
- Create synchronization suggestion (which way to copy)
- Add recursive directory comparison
- Show file size differences as well
- Generate sync script to update older files
- Support three-way comparison
- Add visualization (timeline showing file ages)

***
