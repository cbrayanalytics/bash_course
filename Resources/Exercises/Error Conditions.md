### Goal:
Create a script named `status_codes.sh` that demonstrates various exit codes for different scenarios.
### Requirements:
- Define custom exit codes for specific errors (use constants)
- Accept a command/operation as argument
- Implement at least 5 different operations, each with potential failure modes
- Use appropriate exit codes for each failure type
- Operations should include:
  - File operations (missing file, permission denied)
  - Validation operations (invalid input, out of range)
  - Network operations (connection failed, timeout)
  - System operations (insufficient resources, not supported)
- Document what each exit code means
- Provide detailed error messages
- Support `--help` flag showing exit codes
- Allow checking specific operations without running
### Hints:
- Define exit codes as readonly variables at top of script
- Use meaningful names: `EXIT_FILE_NOT_FOUND=64`
- Document codes in help message
- Use `exit $code` to return specific code
- Test with: `./script.sh operation; echo $?`
### Expected Output Example:
```bash
./status_codes.sh --help
```
```
╔════════════════════════════════════════════════════════════════╗
║              STATUS CODES DEMONSTRATION                        ║
╚════════════════════════════════════════════════════════════════╝

Usage: ./status_codes.sh <operation> [arguments]

Operations:
  read-file <file>       Read and display file
  validate-age <age>     Validate age input
  connect <host>         Simulate network connection
  allocate <size>        Simulate resource allocation
  check-permission       Check user permissions

Exit Codes:
  0   - Success
  1   - General error
  64  - File not found
  65  - Permission denied
  66  - Invalid input
  67  - Value out of range
  68  - Connection failed
  69  - Connection timeout
  70  - Insufficient resources
  71  - Operation not supported
  72  - Service unavailable

Examples:
  ./status_codes.sh read-file /etc/passwd
  ./status_codes.sh validate-age 25
  ./status_codes.sh connect example.com
```

```bash
./status_codes.sh read-file /etc/passwd
```
```
Operation: Read File
File: /etc/passwd

Checking file...
✓ File exists
✓ File is readable
✓ File is regular file

Reading file...
[File contents displayed]

Operation completed successfully
```
```bash
echo $?
# 0
```

```bash
./status_codes.sh read-file /nonexistent.txt
```
```
Operation: Read File
File: /nonexistent.txt

Checking file...
✗ Error: File does not exist

Error Code: 64 (FILE_NOT_FOUND)
Description: The specified file was not found
Suggestion: Check the file path and try again
```
```bash
echo $?
# 64
```

```bash
./status_codes.sh read-file /root/secret.txt
```
```
Operation: Read File
File: /root/secret.txt

Checking file...
✓ File exists
✗ Error: Permission denied

Error Code: 65 (PERMISSION_DENIED)
Description: You don't have permission to access this file
Suggestion: Contact system administrator or use sudo
```
```bash
echo $?
# 65
```

```bash
./status_codes.sh validate-age 250
```
```
Operation: Validate Age
Input: 250

Validating input...
✓ Input is numeric
✗ Error: Value out of range

Error Code: 67 (OUT_OF_RANGE)
Description: Age must be between 0 and 120
Received: 250
Valid range: 0-120
```
```bash
echo $?
# 67
```

```bash
./status_codes.sh validate-age "abc"
```
```
Operation: Validate Age
Input: abc

Validating input...
✗ Error: Invalid input format

Error Code: 66 (INVALID_INPUT)
Description: Input must be a valid number
Received: abc (non-numeric)
```
```bash
echo $?
# 66
```

```bash
./status_codes.sh connect unreachable.example.com
```
```
Operation: Network Connection
Host: unreachable.example.com

Attempting connection...
Timeout after 5 seconds

✗ Error: Connection timeout

Error Code: 69 (CONNECTION_TIMEOUT)
Description: Could not establish connection within timeout period
Host: unreachable.example.com
Timeout: 5 seconds
Suggestion: Check network connectivity and host availability
```
```bash
echo $?
# 69
```
### Bonus Challenge:
- Add exit code translation (number to description)
- Create exit code hierarchy (categories)
- Log all operations with exit codes
- Support exit code testing (simulate failures)
- Create exit code documentation generator
- Add exit code statistics tracking
- Support custom exit code ranges for plugins
- Implement exit code inheritance in functions

***