## Goal:
Create a script named `path_parser.sh` that accepts a full file path and extracts various components.
## Requirements:
- Accept one argument: a full file path
- Extract and display:
  - Full path
  - Directory path (without filename)
  - Filename with extension
  - Filename without extension (basename)
  - File extension only
- Handle paths with multiple dots (e.g., `archive.tar.gz`)
## Hints:
- Use `${path##*/}` to get filename from path
- Use `${path%/*}` to get directory from path
- Use `${filename%.*}` to remove last extension
- Use `${filename##*.}` to get last extension
- For double extensions, you'll need different patterns
## Expected Output Example:
```bash
./path_parser.sh /home/user/documents/report.pdf
```
```
Full path:      /home/user/documents/report.pdf
Directory:      /home/user/documents
Filename:       report.pdf
Base name:      report
Extension:      pdf
```

```bash
./path_parser.sh /var/log/archive.tar.gz
```
```
Full path:      /var/log/archive.tar.gz
Directory:      /var/log
Filename:       archive.tar.gz
Base name:      archive
Extension:      tar.gz
Last extension: gz
```

## Bonus Challenge:
Validate that the argument is a valid path format and handle edge cases like paths without extensions or directories.

***
