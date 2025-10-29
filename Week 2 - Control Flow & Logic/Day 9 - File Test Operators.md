### File Existence Test
The most fundamental file test is checking if a file exists[4]:
```bash
-e file    # True if file exists (any type)
```

**Example:**
```bash
if [[ -e "/etc/passwd" ]]; then
    echo "File exists"
fi
```

### File Type Tests
Different tests for different file types[2][4]:
```bash
-f file    # True if file exists and is a regular file
-d file    # True if file exists and is a directory
-L file    # True if file exists and is a symbolic link
-b file    # True if file exists and is a block device
-c file    # True if file exists and is a character device
-p file    # True if file exists and is a named pipe (FIFO)
-S file    # True if file exists and is a socket
```

**Examples:**
```bash
# Check if regular file
if [[ -f "document.txt" ]]; then
    echo "This is a regular file"
fi

# Check if directory
if [[ -d "/home/user" ]]; then
    echo "This is a directory"
fi

# Check if symbolic link
if [[ -L "link_to_file" ]]; then
    echo "This is a symbolic link"
fi
```
### Permission Tests
Check file permissions for the current user[7]:
```bash
-r file    # True if file exists and is readable
-w file    # True if file exists and is writable
-x file    # True if file exists and is executable
```

**Examples:**
```bash
file="/etc/passwd"

if [[ -r "$file" ]]; then
    echo "File is readable"
fi

if [[ -w "$file" ]]; then
    echo "File is writable"
else
    echo "File is not writable"
fi

if [[ -x "script.sh" ]]; then
    echo "Script is executable"
fi
```

**Important:** These tests check permissions for the **current user** running the script, not the file's permission bits in general.

### File Property Tests
Additional useful file tests:
```bash
-s file    # True if file exists and size > 0 (not empty)
-u file    # True if file has SUID bit set
-g file    # True if file has SGID bit set
-k file    # True if file has sticky bit set
-O file    # True if you own the file
-G file    # True if file's group matches your group
```

**Examples:**
```bash
# Check if file is not empty
if [[ -s "logfile.txt" ]]; then
    echo "File has content"
else
    echo "File is empty or doesn't exist"
fi

# Check if you own the file
if [[ -O "myfile.txt" ]]; then
    echo "You own this file"
fi

# Check for SUID bit
if [[ -u "/usr/bin/sudo" ]]; then
    echo "This binary has SUID bit set"
fi
```

### File Comparison Tests
Compare files based on modification times:
```bash
file1 -nt file2    # True if file1 is newer than file2
file1 -ot file2    # True if file1 is older than file2
file1 -ef file2    # True if file1 and file2 are hard links to same file
```

**Examples:**
```bash
# Check if file1 is newer than file2
if [[ "config.new" -nt "config.old" ]]; then
    echo "New config is more recent"
fi

# Check if file1 is older than file2
if [[ "backup.txt" -ot "original.txt" ]]; then
    echo "Backup is older than original"
    echo "Consider creating new backup"
fi

# Check if two files are the same (hard links)
if [[ "file1" -ef "file2" ]]; then
    echo "These are hard links to the same file"
fi
```

### Combining File Tests
Combine multiple tests with logical operators:
```bash
# File exists AND is readable
if [[ -e "$file" && -r "$file" ]]; then
    echo "File exists and is readable"
fi

# File is directory OR symbolic link
if [[ -d "$path" || -L "$path" ]]; then
    echo "Path is a directory or link"
fi

# File doesn't exist
if [[ ! -e "$file" ]]; then
    echo "File does not exist"
fi
```

### Practical Patterns
**Safe file reading:**
```bash
file="data.txt"

if [[ ! -e "$file" ]]; then
    echo "Error: File does not exist"
    exit 1
elif [[ ! -f "$file" ]]; then
    echo "Error: Path exists but is not a regular file"
    exit 1
elif [[ ! -r "$file" ]]; then
    echo "Error: File is not readable"
    exit 1
else
    # Safe to read
    cat "$file"
fi
```

**Create directory if missing:**
```bash
dir="/path/to/directory"

if [[ ! -d "$dir" ]]; then
    echo "Directory doesn't exist, creating..."
    mkdir -p "$dir"
fi
```

**Check before overwriting:**
```bash
output="result.txt"

if [[ -e "$output" ]]; then
    read -p "File exists. Overwrite? (y/n): " answer
    if [[ "$answer" != "y" ]]; then
        echo "Aborted"
        exit 0
    fi
fi

# Write to file
echo "data" > "$output"
```

### Getting File Modification Time
To get actual timestamps for comparison:
```bash
# Get modification time (seconds since epoch)
if [[ -e "$file" ]]; then
    # Linux
    mtime=$(stat -c %Y "$file" 2>/dev/null)
    
    # macOS
    mtime=$(stat -f %m "$file" 2>/dev/null)
    
    echo "Modified: $(date -d @$mtime)"
fi
```

***

- [ ] **Exercise 1:** [[Check if File Exists Before Attempting to Read]]
- [ ] **Exercise 2:** [[Verify Directory Existence and Create if Missing]]
- [ ] **Exercise 3:** [[Compare Modification Times of Two Files]]
- [ ] **Daily Project:** [[Pre-Deployment Validator]]
