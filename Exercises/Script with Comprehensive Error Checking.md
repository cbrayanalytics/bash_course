### Goal:
Create a script named `error_safe.sh` that demonstrates comprehensive error handling with all best practices.
### Requirements:
- Use strict mode (set -euo pipefail)
- Validate all inputs
- Check all prerequisites
- Handle all error conditions
- Provide meaningful error messages
- Clean up resources on exit
- Return appropriate exit codes
- Support verbose mode
- Include dry-run mode
- Log all operations
### Expected Output Example:
```bash
./error_safe.sh --input data.txt --output result.txt
```
```
╔════════════════════════════════════════════════════════════════╗
║              ERROR-SAFE SCRIPT EXECUTION                       ║
╚════════════════════════════════════════════════════════════════╝

[INFO] Initializing script...
[INFO] Validating configuration...

Prerequisites Check:
────────────────────────────────────────────────────────────────
✓ Bash version: 5.1.16 (minimum: 4.0)
✓ Required commands: awk, sed, grep
✓ Disk space: 45.2 GB available (minimum: 1 GB)
✓ Memory: 8.5 GB available (minimum: 512 MB)
✓ Permissions: write access to output directory

Input Validation:
────────────────────────────────────────────────────────────────
✓ Input file exists: data.txt
✓ Input file readable: data.txt
✓ Input file size: 2.3 MB (valid)
✓ Output directory exists: ./
✓ Output directory writable: ./

Configuration:
────────────────────────────────────────────────────────────────
Input:  data.txt
Output: result.txt
Mode:   production
Verbose: enabled

[INFO] Starting processing...

Processing Steps:
────────────────────────────────────────────────────────────────
[1/4] Reading input file... ✓ (2.3 MB read)
[2/4] Validating data format... ✓ (1,247 records)
[3/4] Processing data... ✓ (1,247 records processed)
[4/4] Writing output... ✓ (result.txt created, 1.8 MB)

[INFO] Processing completed successfully

Summary:
────────────────────────────────────────────────────────────────
Records processed: 1,247
Success rate: 100%
Warnings: 0
Errors: 0
Time elapsed: 2.34 seconds

Output: result.txt (1.8 MB)
Log file: error_safe_20251019_235400.log

[INFO] Cleanup completed
[INFO] Script finished successfully
```

```bash
./error_safe.sh --input missing.txt --output result.txt
```
```
╔════════════════════════════════════════════════════════════════╗
║              ERROR-SAFE SCRIPT EXECUTION                       ║
╚════════════════════════════════════════════════════════════════╝

[INFO] Initializing script...
[ERROR] Input validation failed

Input Validation:
────────────────────────────────────────────────────────────────
✗ Input file exists: missing.txt
  → File not found: missing.txt
  → Please provide a valid input file

Error Details:
────────────────────────────────────────────────────────────────
Error Type: FILE_NOT_FOUND
File: missing.txt
Line: 45
Function: validate_input
Suggestion: Check file path and permissions

[ERROR] Script failed with exit code 64

Cleanup:
────────────────────────────────────────────────────────────────
✓ Temporary files removed
✓ Processes terminated
✓ Resources released

Log file: error_safe_20251019_235405.log
Exit code: 64 (FILE_NOT_FOUND)
```

```bash
./error_safe.sh --input data.txt --output /root/result.txt
```
```
╔════════════════════════════════════════════════════════════════╗
║              ERROR-SAFE SCRIPT EXECUTION                       ║
╚════════════════════════════════════════════════════════════════╝

[INFO] Initializing script...
[INFO] Validating configuration...

Prerequisites Check:
────────────────────────────────────────────────────────────────
✓ All prerequisites met

Input Validation:
────────────────────────────────────────────────────────────────
✓ Input file exists: data.txt
✓ Input file readable: data.txt
✓ Output directory exists: /root/
✗ Output directory writable: /root/
  → Permission denied: /root/

[ERROR] Output validation failed

Error Details:
────────────────────────────────────────────────────────────────
Error Type: PERMISSION_DENIED
Directory: /root/
User: john (uid: 1000)
Required: write permission

Suggestions:
────────────────────────────────────────────────────────────────
1. Use a directory you have write access to:
   ./error_safe.sh --input data.txt --output ~/result.txt

2. Run with appropriate permissions:
   sudo ./error_safe.sh --input data.txt --output /root/result.txt

3. Change output directory ownership:
   sudo chown john:john /root/

[ERROR] Script failed with exit code 65 (PERMISSION_DENIED)

Log file: error_safe_20251019_235410.log
Exit code: 65
```
### Bonus Challenge:
- Add configurable retry logic
- Implement progressive backoff
- Add recovery strategies
- Create error correlation
- Support error reporting (email/webhook)
- Add audit logging
- Implement rate limiting
- Support parallel execution with error handling

***