### Goal:
Create a script named `status_codes.sh` that demonstrates proper use of return codes in functions.
### Requirements:
- Create multiple functions that return different status codes
- Implement functions for common validation tasks:
  - `check_file_exists(path)` - return 0 if exists, 1 if not
  - `check_is_directory(path)` - return 0 if dir, 1 if not
  - `check_is_readable(path)` - return 0 if readable, 1 if not
  - `check_is_writable(path)` - return 0 if writable, 1 if not
  - `check_number_positive(num)` - return 0 if positive, 1 if not
  - `check_string_empty(str)` - return 0 if empty, 1 if not
- Demonstrate different ways to check return codes:
  - Using `if function; then`
  - Using `$?`
  - Chaining with `&&` and `||`
- Create a test suite that checks all functions
- Show both success and failure scenarios
### Hints:
- Return 0 for success/true
- Return non-zero for failure/false
- Use descriptive return code numbers for different errors
- Test return codes with `$?` or directly in conditions
- Document what each return code means
### Expected Output Example:
```bash
./status_codes.sh --test
```
```
╔════════════════════════════════════════════════════════════════╗
║        RETURN CODE DEMONSTRATION & TEST SUITE                  ║
╚════════════════════════════════════════════════════════════════╝

Testing functions that return success/failure codes...

══════════════════════════════════════════════════════════════
TEST 1: File Existence Check
══════════════════════════════════════════════════════════════

Testing with existing file (/etc/passwd):
  → check_file_exists("/etc/passwd")
  → Return code: 0
  → Status: ✓ SUCCESS (file exists)

Testing with non-existent file (/tmp/nonexistent.txt):
  → check_file_exists("/tmp/nonexistent.txt")
  → Return code: 1
  → Status: ✗ FAILURE (file does not exist)

Test 1: PASSED ✓

══════════════════════════════════════════════════════════════
TEST 2: Directory Check
══════════════════════════════════════════════════════════════

Testing with directory (/tmp):
  → check_is_directory("/tmp")
  → Return code: 0
  → Status: ✓ SUCCESS (is a directory)

Testing with regular file (/etc/passwd):
  → check_is_directory("/etc/passwd")
  → Return code: 1
  → Status: ✗ FAILURE (not a directory)

Test 2: PASSED ✓

══════════════════════════════════════════════════════════════
TEST 3: Readable Check
══════════════════════════════════════════════════════════════

Testing readable file (/etc/passwd):
  → check_is_readable("/etc/passwd")
  → Return code: 0
  → Status: ✓ SUCCESS (file is readable)

Testing unreadable file (/root/secret.txt):
  → check_is_readable("/root/secret.txt")
  → Return code: 1
  → Status: ✗ FAILURE (file not readable)

Test 3: PASSED ✓

══════════════════════════════════════════════════════════════
TEST 4: Positive Number Check
══════════════════════════════════════════════════════════════

Testing positive number (42):
  → check_number_positive(42)
  → Return code: 0
  → Status: ✓ SUCCESS (number is positive)

Testing negative number (-5):
  → check_number_positive(-5)
  → Return code: 1
  → Status: ✗ FAILURE (number is not positive)

Testing zero (0):
  → check_number_positive(0)
  → Return code: 1
  → Status: ✗ FAILURE (zero is not positive)

Test 4: PASSED ✓

══════════════════════════════════════════════════════════════
DEMONSTRATION: Different Ways to Check Return Codes
══════════════════════════════════════════════════════════════

Method 1: Direct if statement
────────────────────────────────────────────────────────────────
if check_file_exists "/etc/passwd"; then
    echo "File exists"
fi

Output: File exists ✓

Method 2: Using $? variable
────────────────────────────────────────────────────────────────
check_file_exists "/etc/passwd"
if [[ $? -eq 0 ]]; then
    echo "File exists"
fi

Output: File exists ✓

Method 3: Chaining with &&
────────────────────────────────────────────────────────────────
check_file_exists "/etc/passwd" && echo "File exists"

Output: File exists ✓

Method 4: Chaining with ||
────────────────────────────────────────────────────────────────
check_file_exists "/nonexistent" || echo "File not found"

Output: File not found ✓

Method 5: Complex chains
────────────────────────────────────────────────────────────────
check_file_exists "/etc/passwd" && \
    check_is_readable "/etc/passwd" && \
    echo "File exists and is readable"

Output: File exists and is readable ✓

══════════════════════════════════════════════════════════════
PRACTICAL EXAMPLE: Pre-deployment Validation
══════════════════════════════════════════════════════════════

validate_environment() {
    echo "Running validation checks..."
    
    check_file_exists "config.yaml" || {
        echo "✗ config.yaml not found"
        return 1
    }
    echo "✓ config.yaml found"
    
    check_is_readable "config.yaml" || {
        echo "✗ config.yaml not readable"
        return 1
    }
    echo "✓ config.yaml readable"
    
    check_is_directory "logs" || {
        echo "✗ logs directory not found"
        return 1
    }
    echo "✓ logs directory found"
    
    check_is_writable "logs" || {
        echo "✗ logs directory not writable"
        return 1
    }
    echo "✓ logs directory writable"
    
    echo "All validation checks passed!"
    return 0
}

Running validation...
✓ config.yaml found
✓ config.yaml readable
✓ logs directory found
✓ logs directory writable
All validation checks passed!

╔════════════════════════════════════════════════════════════════╗
║                    TEST SUMMARY                                ║
╚════════════════════════════════════════════════════════════════╝

Tests run: 4
Tests passed: 4 ✓
Tests failed: 0
Success rate: 100%

All return code functions working correctly!
```
### Bonus Challenge:
- Add custom return codes for specific errors (64-255)
- Create return code documentation generator
- Add return code translation (code to message)
- Implement retry logic based on return codes
- Create return code hierarchy
- Add return code logging
- Support return code ranges for categories
- Create return code testing framework

***