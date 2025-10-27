### Understanding Exit Codes
Every command in bash returns an **exit code** (also called exit status or return code) - a number between 0 and 255 that indicates whether the command succeeded or failed.

**Basic rule:**
- `0` = Success
- `1-255` = Various types of failures
```bash
ls /existing/directory
echo $?  # Output: 0 (success)

ls /nonexistent/directory
echo $?  # Output: 2 (error)
```
### The $? Variable
`$?` holds the exit code of the most recently executed command.
```bash
# Successful command
touch file.txt
echo $?  # 0

# Failed command
rm /nonexistent/file
echo $?  # 1

# Command not found
nonexistentcommand
echo $?  # 127
```

**Important:** `$?` is immediately overwritten by the next command, so capture it if needed:
```bash
command_that_might_fail
exit_code=$?  # Save it

if [[ $exit_code -ne 0 ]]; then
    echo "Command failed with code: $exit_code"
fi
```
### Standard Exit Codes
While you can use any code 0-255, some have conventional meanings:

**Reserved/Common codes:**
- `0` - Success
- `1` - General errors
- `2` - Misuse of shell command (syntax error)
- `126` - Command cannot execute (permission problem)
- `127` - Command not found
- `128` - Invalid exit argument
- `128+N` - Fatal error signal N (e.g., 130 = Ctrl+C)
- `130` - Script terminated by Ctrl+C
- `255` - Exit code out of range

**Custom codes (64-113 often used):**
You can define your own exit codes for specific errors in your scripts.
```bash
# Custom exit codes
readonly EXIT_SUCCESS=0
readonly EXIT_FILE_NOT_FOUND=64
readonly EXIT_PERMISSION_DENIED=65
readonly EXIT_INVALID_INPUT=66
readonly EXIT_NETWORK_ERROR=67
```
### The exit Command
Use `exit` to terminate your script with a specific code:
```bash
#!/bin/bash

if [[ ! -f "$1" ]]; then
    echo "Error: File not found"
    exit 1  # Exit with error code 1
fi

# Process file
echo "Processing file..."
exit 0  # Exit with success
```

**Exit without argument:**
```bash
exit  # Uses exit code of last command ($?)
```

**Exit with variable:**
```bash
result=$?
exit $result
```
### Return Codes in Functions
Functions use `return` (not `exit`) to set their return code. Like exit codes, return values must be 0-255.
```bash
check_file() {
    local file=$1
    
    if [[ ! -e "$file" ]]; then
        return 1  # File doesn't exist
    fi
    
    if [[ ! -r "$file" ]]; then
        return 2  # File not readable
    fi
    
    return 0  # Success
}

# Use the function
if check_file "/etc/passwd"; then
    echo "File is accessible"
else
    echo "File check failed with code: $?"
fi
```

**Important distinction:**
- `exit` terminates the entire script
- `return` only exits the function

**Returning data from functions:**
Functions can't return strings directly via return code. Use echo and command substitution:
```bash
get_username() {
    echo "john_doe"  # Output the value
    return 0         # Return success/failure
}

username=$(get_username)
echo "Username: $username"
```
### Using Exit Codes in Conditionals
**Direct test:**
```bash
if command; then
    echo "Command succeeded"
else
    echo "Command failed"
fi
```

**Test exit code explicitly:**
```bash
command
if [[ $? -eq 0 ]]; then
    echo "Success"
fi
```

**Multiple conditions:**
```bash
command
case $? in
    0)
        echo "Success"
        ;;
    1)
        echo "General error"
        ;;
    2)
        echo "Syntax error"
        ;;
    *)
        echo "Unknown error: $?"
        ;;
esac
```
### Chaining Commands with && and ||
**AND operator (&&):**
Execute next command only if previous succeeded (exit code 0):
```bash
# Only create file if directory was created successfully
mkdir mydir && touch mydir/file.txt

# Chain multiple commands
cd /tmp && rm old_file.txt && touch new_file.txt
```

**OR operator (||):**
Execute next command only if previous failed (non-zero exit code):
```bash
# Try to use cached file, or download if it doesn't exist
cat cached_file.txt || wget http://example.com/file.txt

# Provide fallback
command_that_might_fail || echo "Command failed, using default"
```

**Combining && and ||:**
```bash
# Try command, use fallback if fails
primary_command || fallback_command

# Do something if succeeds, something else if fails
command && echo "Success" || echo "Failed"

# Complex chains
mkdir backup && cp file.txt backup/ && echo "Backed up" || echo "Backup failed"
```

**Be careful with mixed chains:**
```bash
# This may not work as expected
command && success_action || failure_action
# Problem: If success_action fails, failure_action runs!

# Better approach
if command; then
    success_action
else
    failure_action
fi
```
### The set -e Option
`set -e` makes your script exit immediately if any command fails (returns non-zero).
```bash
#!/bin/bash
set -e  # Exit on error

mkdir /tmp/test
cd /tmp/test
rm important_file.txt  # If this fails, script exits immediately
# Lines below won't execute if rm fails
echo "File removed"
```

**Disable temporarily:**
```bash
set +e  # Disable exit on error
command_that_might_fail
set -e  # Re-enable exit on error
```

**Ignore specific command failures:**
```bash
set -e

# Method 1: Use || true
command_that_might_fail || true

# Method 2: Check explicitly
if ! command_that_might_fail; then
    echo "Command failed, but continuing..."
fi

# Method 3: Capture exit code
command_that_might_fail
result=$?
```

**Related set options:**
```bash
set -e  # Exit on error
set -u  # Exit on undefined variable
set -o pipefail  # Exit if any command in pipeline fails
set -x  # Print commands before executing (debug mode)

# Combine them
set -euxo pipefail
```
### Pipefail Option
By default, a pipeline's exit code is the exit code of the last command:
```bash
# Without pipefail
false | true
echo $?  # 0 (only checks 'true')

# With pipefail
set -o pipefail
false | true
echo $?  # 1 (checks all commands)
```
### Practical Patterns
**Error handling wrapper:**
```bash
run_command() {
    "$@"  # Run command with all arguments
    local exit_code=$?
    
    if [[ $exit_code -ne 0 ]]; then
        echo "Error: Command failed with code $exit_code"
        echo "Command: $*"
        return $exit_code
    fi
    
    return 0
}

run_command ls /nonexistent
```

**Retry with exit codes:**
```bash
max_attempts=3
attempt=1

while ((attempt <= max_attempts)); do
    if command_that_might_fail; then
        echo "Success!"
        exit 0
    fi
    
    echo "Attempt $attempt failed (exit code: $?)"
    ((attempt++))
    sleep 2
done

echo "Failed after $max_attempts attempts"
exit 1
```

**Validate prerequisites:**
```bash
validate_environment() {
    local errors=0
    
    # Check for required commands
    for cmd in git docker kubectl; do
        if ! command -v "$cmd" &> /dev/null; then
            echo "Error: $cmd not found"
            ((errors++))
        fi
    done
    
    # Check for required files
    for file in config.yaml secrets.env; do
        if [[ ! -f "$file" ]]; then
            echo "Error: $file missing"
            ((errors++))
        fi
    done
    
    return $errors
}

if ! validate_environment; then
    echo "Environment validation failed"
    exit 1
fi
```

***

**Exercise 1:** [[Error Conditions]]
**Exercise 2:** [[Check Exit Codes of External Commands and Respond Accordingly]]
**Exercise 3:** [[Chain Commands with AND and OR Operators]]

**Daily Project:** [[Comprehensive Validation Script]]
