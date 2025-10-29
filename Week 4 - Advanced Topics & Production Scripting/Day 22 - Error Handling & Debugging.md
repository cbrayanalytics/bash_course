### The Set Command
`set` configures shell behavior and enables/disables options.

**Basic syntax:**
```bash
set -option    # Enable option
set +option    # Disable option
```
### Set -e (Exit on Error)
Exit immediately if any command returns non-zero.
```bash
#!/bin/bash
set -e

echo "Step 1"
false           # This fails (returns 1)
echo "Step 2"  # This won't execute
```

**When to use:**
- Build scripts that must succeed completely
- Installation scripts
- CI/CD pipelines

**Gotchas:**
```bash
set -e

# These DON'T trigger exit:
if false; then
    echo "won't execute"
fi

command || echo "fallback"

! false  # Negation doesn't trigger
```

**Disable temporarily:**
```bash
set -e

set +e  # Disable
risky_command
set -e  # Re-enable
```
### Set -u (Unset Variables)
Exit if you reference an undefined variable.
```bash
#!/bin/bash
set -u

echo "$undefined_var"  # Error: unbound variable
```

**Provides default value:**
```bash
set -u

# Use default if unset
echo "${var:-default}"

# Check if set
if [[ -n "${var:-}" ]]; then
    echo "var is set"
fi
```
### Set -x (Debug Mode)
Print each command before executing (with variable expansion).
```bash
#!/bin/bash
set -x

name="Alice"
echo "Hello, $name"
```

**Output:**
```
+ name=Alice
+ echo 'Hello, Alice'
Hello, Alice
```

**Toggle debugging:**
```bash
set -x  # Enable debug
complex_function
set +x  # Disable debug
```

**Debug specific sections:**
```bash
#!/bin/bash

echo "Normal execution"

set -x  # Start debugging
critical_section
complex_calculation
set +x  # Stop debugging

echo "Back to normal"
```
### Set -o pipefail
Fail if any command in a pipeline fails (not just the last one).
```bash
#!/bin/bash
set -o pipefail

# Without pipefail
false | true
echo $?  # 0 (only checks 'true')

# With pipefail
set -o pipefail
false | true
echo $?  # 1 (checks all commands)
```

**Practical example:**
```bash
#!/bin/bash
set -eo pipefail

# This will fail the script if grep finds nothing
cat file.txt | grep "pattern" | process_data

# All three commands must succeed
```
### Combining Set Options
**Common combinations:**
```bash
#!/bin/bash
# Strict mode
set -euo pipefail

# Or use long form
set -e           # Exit on error
set -u           # Error on undefined variable
set -o pipefail  # Fail on pipe errors
```

**With debug for development:**
```bash
#!/bin/bash
# Development mode
set -euxo pipefail
```
### The Trap Command
`trap` executes commands when the script receives signals or exits.

**Basic syntax:**
```bash
trap 'commands' SIGNAL [SIGNAL...]
```

**Common signals:**
- `EXIT` - Script exits (normal or error)
- `INT` - Ctrl+C (SIGINT)
- `TERM` - Termination signal (SIGTERM)
- `ERR` - Command fails (requires `set -E`)
- `DEBUG` - Before each command
- `RETURN` - Function returns

**Cleanup on exit:**
```bash
#!/bin/bash

# Create temp file
temp_file=$(mktemp)

# Ensure cleanup happens
trap "rm -f $temp_file" EXIT

# Use temp file
echo "data" > "$temp_file"
# ...

# Cleanup happens automatically on exit
```

**Handle Ctrl+C:**
```bash
#!/bin/bash

trap 'echo "Interrupted!"; exit 130' INT

echo "Press Ctrl+C to interrupt"
sleep 100
```

**Multiple cleanup tasks:**
```bash
#!/bin/bash

cleanup() {
    echo "Cleaning up..."
    rm -f "$temp_file"
    kill "$background_pid" 2>/dev/null
    restore_settings
}

trap cleanup EXIT

# Script continues...
```

**Trap errors:**
```bash
#!/bin/bash
set -E  # Inherit trap in functions

error_handler() {
    echo "Error on line $1"
    exit 1
}

trap 'error_handler $LINENO' ERR

# Script continues...
```

**Disable trap:**
```bash
trap - EXIT  # Remove EXIT trap
trap - INT   # Remove INT trap
```
### Error Messages to Stderr
**Standard streams:**
- stdout (1): Normal output
- stderr (2): Error messages

**Write to stderr:**
```bash
echo "Error message" >&2

# Or
echo "Error: File not found" 1>&2
```

**Helper function:**
```bash
error() {
    echo "ERROR: $*" >&2
}

warn() {
    echo "WARNING: $*" >&2
}

info() {
    echo "INFO: $*"
}

# Use them
error "Failed to connect"
warn "Deprecated function"
info "Processing complete"
```

**Exit with error message:**
```bash
die() {
    echo "FATAL: $*" >&2
    exit 1
}

# Use it
[[ -f "$file" ]] || die "File not found: $file"
```
### Comprehensive Error Handling Pattern
```bash
#!/bin/bash

# Strict mode
set -euo pipefail

# Error handling
error() {
    echo "ERROR: $*" >&2
}

die() {
    error "$*"
    exit 1
}

# Cleanup function
cleanup() {
    local exit_code=$?
    
    # Cleanup tasks
    rm -f "$temp_file"
    
    if [[ $exit_code -ne 0 ]]; then
        error "Script failed with exit code $exit_code"
    fi
    
    exit $exit_code
}

# Set trap
trap cleanup EXIT

# Create temp file
temp_file=$(mktemp)

# Script logic with validation
[[ -f "$input_file" ]] || die "Input file not found"

# Process data
process_data "$input_file" > "$temp_file"

# Move result
mv "$temp_file" "$output_file"

echo "Success!"
```

***

- [ ] **Exercise 1:** [[Script with Comprehensive Error Checking]]
- [ ] **Exercise 2:** [[Implement Trap to Clean Up Temporary Files on Exit]]
- [ ] **Exercise 3:** [[Debug Script Using set -x]]
- [ ] **Daily Project:** [[Robust Installer Script with Error Handling and Rollback]]

