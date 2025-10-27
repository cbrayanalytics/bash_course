### Goal:
Create a script named `ensure_dir.sh` that checks for directory existence and creates it if missing, with proper validation.
### Requirements:
- Accept directory path as argument
- Check if path exists
- If exists, verify it's actually a directory (not a file)
- If doesn't exist, ask user for confirmation to create
- Create directory with parent directories if needed
- Verify creation was successful
- Check if directory is writable
- Display final status with permissions
### Hints:
- Use `-e` to check if path exists
- Use `-d` to check if it's a directory
- Use `-w` to check if writable
- Use `mkdir -p` to create with parents
- Use `$?` to check if mkdir succeeded
- Use `ls -ld` to show directory details
### Expected Output Example:
```bash
./ensure_dir.sh /home/user/projects/new_project
```
```
Checking directory: /home/user/projects/new_project

⚠ Directory does not exist

Create directory? (y/n): y

Creating directory (including parent directories)...
✓ Directory created successfully

Directory Information:
---------------------
Path: /home/user/projects/new_project
Permissions: drwxr-xr-x (755)
Owner: user
Writable: Yes
Status: Ready to use
```

```bash
./ensure_dir.sh /home/user/existing_dir
```
```
Checking directory: /home/user/existing_dir

✓ Directory already exists
✓ Path is a directory
✓ Directory is writable

Directory Information:
---------------------
Path: /home/user/existing_dir
Permissions: drwxr-xr-x (755)
Owner: user
Contents: 12 files, 3 subdirectories
Last Modified: 2025-10-18 10:45:00
Status: Ready to use
```

```bash
./ensure_dir.sh /home/user/file.txt
```
```
Checking directory: /home/user/file.txt

✓ Path exists
✗ Error: Path exists but is a regular file, not a directory

Cannot proceed. Please provide a valid directory path or non-existent path.
```

```bash
./ensure_dir.sh /root/protected
```
```
Checking directory: /root/protected

⚠ Directory does not exist

Create directory? (y/n): y

Creating directory...
✗ Error: Failed to create directory (permission denied)

You may need elevated privileges (sudo) to create this directory.
```
### Bonus Challenge:
- Add `--force` flag to skip confirmation
- Add `--mode` flag to set custom permissions
- Support creating multiple directories at once
- Add `--template` flag to copy structure from another directory
- Create `.gitkeep` or similar marker file
- Set up directory with initial structure (subdirs)
- Add ownership setting option (if running as root)

***
