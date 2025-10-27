### Goal:
Create a comprehensive script named `permission_checker.sh` that analyzes and reports detailed file access permissions for files and directories.
### Requirements:
**Core Functionality:**
- Accept one or more file/directory paths as arguments
- For each path, analyze and report:
  - File existence
  - File type (regular file, directory, symlink, etc.)
  - Read permission
  - Write permission
  - Execute permission
  - Owner and group
  - Numeric permission mode (e.g., 755)
  - Symbolic permission mode (e.g., rwxr-xr-x)
  - Last modified date
  - File size (for files)

**Permission Analysis:**
- Check permissions for:
  - Current user
  - File owner
  - Group members
  - Others
- Identify potential security issues:
  - World-writable files
  - SUID/SGID bits set
  - Files with no read permissions
  - Directories without execute permission

**Display Format:**
- Clear, organized output
- Visual indicators for permissions (✓ for allowed, ✗ for denied)
- Color coding for security warnings (optional)
- Summary section with recommendations

### Hints:
**File test operators:**
```bash
-e    # File exists
-f    # Regular file
-d    # Directory
-L    # Symbolic link
-r    # Readable
-w    # Writable
-x    # Executable
-s    # File size > 0
-u    # SUID bit set
-g    # SGID bit set
```

**Getting file information:**
```bash
ls -l file                    # Detailed listing
stat file                     # Detailed file stats
stat -c "%a" file            # Numeric permissions (Linux)
stat -f "%A" file            # Numeric permissions (macOS)
stat -c "%U %G" file         # Owner and group (Linux)
```

**Permission extraction:**
```bash
# Get symbolic permissions
perms=$(ls -ld "$file" | cut -c1-10)

# Check specific permissions
if [[ -r "$file" ]]; then
    echo "Readable"
fi
```
### Expected Output Example:
```bash
./permission_checker.sh /home/user/script.sh /etc/passwd /tmp
```

```
╔════════════════════════════════════════════════════════════════╗
║           FILE PERMISSION CHECKER                              ║
║           Analyzing 3 items...                                ║
╚════════════════════════════════════════════════════════════════╝

┌────────────────────────────────────────────────────────────────┐
│ File 1: /home/user/script.sh                                   │
├────────────────────────────────────────────────────────────────┤
│ Status:           ✓ Exists                                     │
│ Type:             Regular file                                 │
│ Size:             2.4 KB                                       │
│ Owner:            user                                         │
│ Group:            user                                         │
│ Last Modified:    2025-10-18 10:30:45                         │
│                                                                 │
│ Permissions:      rwxr-xr-x (755)                             │
│                                                                 │
│ Current User Access:                                           │
│   Read:           ✓ Allowed                                    │
│   Write:          ✓ Allowed                                    │
│   Execute:        ✓ Allowed                                    │
│                                                                 │
│ Permission Breakdown:                                          │
│   Owner (user):   rwx (read, write, execute)                  │
│   Group (user):   r-x (read, execute)                         │
│   Others:         r-x (read, execute)                         │
│                                                                 │
│ Security Analysis:                                             │
│   ✓ Not world-writable                                        │
│   ✓ No special bits (SUID/SGID)                               │
│   Status: SAFE                                                 │
└────────────────────────────────────────────────────────────────┘

┌────────────────────────────────────────────────────────────────┐
│ File 2: /etc/passwd                                            │
├────────────────────────────────────────────────────────────────┤
│ Status:           ✓ Exists                                     │
│ Type:             Regular file                                 │
│ Size:             3.1 KB                                       │
│ Owner:            root                                         │
│ Group:            root                                         │
│ Last Modified:    2025-10-15 14:22:10                         │
│                                                                 │
│ Permissions:      rw-r--r-- (644)                             │
│                                                                 │
│ Current User Access:                                           │
│   Read:           ✓ Allowed                                    │
│   Write:          ✗ Denied (not owner)                        │
│   Execute:        ✗ Denied                                     │
│                                                                 │
│ Permission Breakdown:                                          │
│   Owner (root):   rw- (read, write)                           │
│   Group (root):   r-- (read only)                             │
│   Others:         r-- (read only)                             │
│                                                                 │
│ Security Analysis:                                             │
│   ✓ Not world-writable                                        │
│   ✓ No special bits (SUID/SGID)                               │
│   Status: SAFE                                                 │
└────────────────────────────────────────────────────────────────┘

┌────────────────────────────────────────────────────────────────┐
│ File 3: /tmp                                                   │
├────────────────────────────────────────────────────────────────┤
│ Status:           ✓ Exists                                     │
│ Type:             Directory                                    │
│ Owner:            root                                         │
│ Group:            wheel                                        │
│ Last Modified:    2025-10-19 01:05:33                         │
│                                                                 │
│ Permissions:      rwxrwxrwt (1777)                            │
│                                                                 │
│ Current User Access:                                           │
│   Read:           ✓ Allowed                                    │
│   Write:          ✓ Allowed                                    │
│   Execute:        ✓ Allowed (can enter directory)             │
│                                                                 │
│ Permission Breakdown:                                          │
│   Owner (root):   rwx (full access)                           │
│   Group (wheel):  rwx (full access)                           │
│   Others:         rwx (full access)                           │
│                                                                 │
│ Security Analysis:                                             │
│   ⚠ WARNING: World-writable directory                         │
│   ✓ Sticky bit set (prevents file deletion by non-owners)    │
│   Status: MONITORED (sticky bit provides protection)          │
└────────────────────────────────────────────────────────────────┘

╔════════════════════════════════════════════════════════════════╗
║ SUMMARY                                                        ║
╚════════════════════════════════════════════════════════════════╝

Files Analyzed:        3
Accessible:            3
Inaccessible:          0
Security Warnings:     1

Warnings:
  • /tmp is world-writable (but protected by sticky bit)

Recommendations:
  ✓ All critical files have appropriate permissions
  ✓ No unexpected SUID/SGID binaries found
  ✓ No unprotected world-writable files

Overall Status: GOOD
```

```bash
./permission_checker.sh /nonexistent/file.txt
```

```
╔════════════════════════════════════════════════════════════════╗
║           FILE PERMISSION CHECKER                              ║
╚════════════════════════════════════════════════════════════════╝

┌────────────────────────────────────────────────────────────────┐
│ File: /nonexistent/file.txt                                    │
├────────────────────────────────────────────────────────────────┤
│ Status:           ✗ Does not exist                             │
│                                                                 │
│ Error: Cannot analyze permissions for non-existent file        │
└────────────────────────────────────────────────────────────────┘

╔════════════════════════════════════════════════════════════════╗
║ SUMMARY                                                        ║
╚════════════════════════════════════════════════════════════════╝

Files Analyzed:        1
Accessible:            0
Inaccessible:          1
```
### Bonus Challenges:
**Level 1 (Intermediate):**
- Add `--recursive` flag to check all files in directory tree
- Compare permissions against a "secure baseline"
- Generate chmod commands to fix permission issues
- Export results to CSV or JSON format
- Add `--verbose` flag for more detailed output
- Check file ACLs (Access Control Lists) if available
- Identify files modified in last N days
- Group results by permission patterns

**Level 2 (Advanced):**
- Scan for common security misconfigurations
- Check for sensitive files with weak permissions (private keys, config files)
- Detect SUID binaries that could be security risks
- Compare against CIS security benchmarks
- Generate compliance reports
- Suggest SELinux/AppArmor contexts
- Audit permission changes over time (if run periodically)
- Integration with system logs to detect permission changes

**Level 3 (Expert):**
- Create interactive mode to fix permissions
- Implement permission templates (web server, database, etc.)
- Batch permission fixing with dry-run mode
- Role-based permission recommendations
- Detect and report on extended attributes
- Integration with configuration management (Ansible, etc.)
- Generate audit trails for compliance
- Machine learning to detect anomalous permissions
- Web interface for viewing results
- Email alerts for critical permission issues
### Testing Checklist:
Test your script with:
- [ ] Regular files with various permissions
- [ ] Directories with different access levels
- [ ] Symbolic links
- [ ] Files owned by different users
- [ ] SUID/SGID binaries (like /usr/bin/sudo)
- [ ] World-writable files
- [ ] Non-existent files
- [ ] Files in /tmp, /var, /etc, /home
- [ ] Multiple files at once
- [ ] Files with special characters in names
- [ ] Hidden files (starting with .)
- [ ] Device files (/dev/null, etc.)

***