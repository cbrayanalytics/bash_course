### Unit Testing in Bash
While Bash doesn't have built-in unit testing, we can create our own test framework.

**Basic assertion function:**
```bash
assert_equals() {
    local expected=$1
    local actual=$2
    local message=${3:-""}
    
    if [[ "$expected" == "$actual" ]]; then
        echo "✓ PASS: $message"
        return 0
    else
        echo "✗ FAIL: $message"
        echo "  Expected: $expected"
        echo "  Actual: $actual"
        return 1
    fi
}
```

**Usage:**
```bash
result=$(my_function "input")
assert_equals "expected_output" "$result" "my_function with input"
```
### Common Assertion Functions
**Assert true:**
```bash
assert_true() {
    if [[ $1 == true ]] || [[ $1 -eq 0 ]]; then
        echo "✓ PASS: $2"
        return 0
    else
        echo "✗ FAIL: $2"
        return 1
    fi
}
```

**Assert file exists:**
```bash
assert_file_exists() {
    if [[ -f "$1" ]]; then
        echo "✓ PASS: File exists: $1"
        return 0
    else
        echo "✗ FAIL: File does not exist: $1"
        return 1
    fi
}
```

**Assert contains:**
```bash
assert_contains() {
    local haystack=$1
    local needle=$2
    
    if [[ "$haystack" == *"$needle"* ]]; then
        echo "✓ PASS: Contains '$needle'"
        return 0
    else
        echo "✗ FAIL: Does not contain '$needle'"
        return 1
    fi
}
```
### Test Framework Pattern
```bash
#!/bin/bash

# Test counters
TESTS_RUN=0
TESTS_PASSED=0
TESTS_FAILED=0

# Test wrapper
run_test() {
    local test_name=$1
    ((TESTS_RUN++))
    
    echo "Running: $test_name"
    if $test_name; then
        ((TESTS_PASSED++))
    else
        ((TESTS_FAILED++))
    fi
    echo
}

# Individual tests
test_addition() {
    local result=$((2 + 2))
    assert_equals 4 "$result" "2 + 2 should equal 4"
}

test_string_length() {
    local str="hello"
    assert_equals 5 ${#str} "Length of 'hello' should be 5"
}

# Run all tests
run_test test_addition
run_test test_string_length

# Summary
echo "Tests run: $TESTS_RUN"
echo "Passed: $TESTS_PASSED"
echo "Failed: $TESTS_FAILED"
```
### Integration Testing

Test scripts in realistic scenarios:
```bash
test_backup_integration() {
    # Setup
    local test_dir=$(mktemp -d)
    echo "test data" > "$test_dir/file.txt"
    
    # Execute
    ./backup.sh --source "$test_dir" --dest /tmp/backup
    
    # Verify
    assert_file_exists "/tmp/backup/backup_*.tar.gz"
    
    # Cleanup
    rm -rf "$test_dir" /tmp/backup
}
```
### Inline Documentation
**Function documentation:**
```bash
#######################################
# Calculates the sum of two numbers.
# Globals:
#   None
# Arguments:
#   $1 - First number
#   $2 - Second number
# Outputs:
#   Writes sum to stdout
# Returns:
#   0 on success, 1 on error
#######################################
add_numbers() {
    local num1=$1
    local num2=$2
    echo $((num1 + num2))
}
```

**Google Shell Style Guide format:**
```bash
# Prints usage information
# Arguments:
#   None
# Returns:
#   0 always
print_usage() {
    cat << EOF
Usage: script.sh [OPTIONS]
Options:
    -h    Display this help
    -v    Verbose mode
EOF
}
```
### Comprehensive Help Messages
```bash
show_help() {
    cat << 'EOF'
NAME
    backup.sh - Automated backup utility

SYNOPSIS
    backup.sh [OPTIONS]

DESCRIPTION
    Create and manage system backups with rotation and compression.

OPTIONS
    -s, --source DIR
        Source directory to backup (required)
    
    -d, --dest DIR
        Destination directory (required)
    
    -c, --compress
        Enable compression (gzip)
    
    -v, --verbose
        Verbose output
    
    -h, --help
        Display this help message

EXAMPLES
    backup.sh -s /home/user -d /backup
    backup.sh -s /data -d /backup -c -v

EXIT STATUS
    0    Success
    1    General error
    2    Invalid option

AUTHOR
    Development Team

REPORTING BUGS
    https://github.com/user/backup/issues
EOF
}
```
### Dry-Run Mode
```bash
DRY_RUN=false

while getopts "n" opt; do
    case $opt in
        n) DRY_RUN=true ;;
    esac
done

execute() {
    if [[ $DRY_RUN == true ]]; then
        echo "[DRY-RUN] Would execute: $*"
    else
        "$@"
    fi
}

# Usage
execute rm -rf /tmp/old_data
# In dry-run: prints what would be done
# In normal: actually executes
```

***

- [ ] **Exercise 1:** [[Write Test Suite for Validation Functions]]
- [ ] **Exercise 2:** [[Create Comprehensive Help Documentation]]
- [ ] **Exercise 3:** [[Implement --dry-run Mode for Testing]]
- [ ] **Daily Project:** [[Add Tests and Documentation to Previous Projects]]


