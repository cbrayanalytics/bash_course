### Goal:
Create a script named `safe_read.sh` that safely reads a file only after verifying it exists and is readable.
### Requirements:
- Accept filename as argument
- Check if file exists
- Check if it's a regular file (not directory or link)
- Check if it's readable
- Check if it's not empty
- Display appropriate error messages for each failure case
- If all checks pass, display file contents
- Show file metadata (size, last modified)
### Hints:
- Use `-e` to check existence
- Use `-f` to check if regular file
- Use `-r` to check readability
- Use `-s` to check if not empty
- Use `stat` command for file metadata
- Use `cat` to display contents
- Exit with different codes for different errors
### Expected Output Example:
```bash
./safe_read.sh document.txt
```
```
Checking file: document.txt

✓ File exists
✓ Is a regular file
✓ File is readable
✓ File is not empty

File Information:
-----------------
Name: document.txt
Size: 1.2 KB
Last Modified: 2025-10-18 15:30:22
Lines: 45

Contents:
---------
[file contents displayed here]
```

```bash
./safe_read.sh /nonexistent.txt
```
```
Checking file: /nonexistent.txt

✗ Error: File does not exist
```

```bash
./safe_read.sh /etc/
```
```
Checking file: /etc/

✓ File exists
✗ Error: Path is a directory, not a regular file
```

```bash
./safe_read.sh /root/secret.txt
```
```
Checking file: /root/secret.txt

✓ File exists
✓ Is a regular file
✗ Error: File is not readable (permission denied)
```

```bash
./safe_read.sh empty.txt
```
```
Checking file: empty.txt

✓ File exists
✓ Is a regular file
✓ File is readable
⚠ Warning: File is empty (0 bytes)

No contents to display.
```
### Bonus Challenge:
- Add `-n` flag to display only first N lines
- Add `-v` flag for verbose output showing all checks
- Support reading from multiple files
- Add option to follow symbolic links
- Display file type (text/binary) before reading
- Add syntax highlighting for code files

***
