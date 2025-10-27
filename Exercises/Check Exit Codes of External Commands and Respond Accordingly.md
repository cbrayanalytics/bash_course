## Exercise 2: 

### Goal:
Create a script named `command_checker.sh` that runs external commands and takes different actions based on their exit codes.
### Requirements:
- Accept command(s) to execute as arguments
- Run the command and capture exit code
- Provide detailed response based on exit code:
  - 0: Success message
  - 1: General error handling
  - 2: Syntax error detection
  - 126: Permission fix suggestion
  - 127: Command not found handling
  - Other: Specific handling for recognized codes
- Support multiple commands in sequence
- Implement retry logic for recoverable errors
- Log all commands and their exit codes
- Provide actionable suggestions for failures
- Support dry-run mode (predict exit codes)
### Hints:
- Run command: `"$@"`
- Capture exit code: `exit_code=$?`
- Use case statement for different codes
- Use `command -v` to check if command exists
- Check permissions with `[[ -x "$file" ]]`
### Expected Output Example:
```bash
./command_checker.sh ls /tmp
```
```
╔════════════════════════════════════════════════════════════════╗
║              COMMAND CHECKER                                   ║
╚════════════════════════════════════════════════════════════════╝

Executing: ls /tmp

[Command Output]
file1.txt
file2.txt
temp_dir/

────────────────────────────────────────────────────────────────
✓ Command completed successfully
Exit Code: 0
Status: SUCCESS
────────────────────────────────────────────────────────────────
```

```bash
./command_checker.sh ls /nonexistent
```
```
╔════════════════════════════════════════════════════════════════╗
║              COMMAND CHECKER                                   ║
╚════════════════════════════════════════════════════════════════╝

Executing: ls /nonexistent

ls: cannot access '/nonexistent': No such file or directory

────────────────────────────────────────────────────────────────
✗ Command failed
Exit Code: 2
Status: MISUSE OF SHELL COMMAND (Syntax/Usage Error)
────────────────────────────────────────────────────────────────

Error Analysis:
  Category: File system error
  Issue: Directory does not exist
  
Suggestions:
  • Verify the path exists: ls -la /
  • Check spelling of directory name
  • Ensure you have proper permissions
  
Would you like to retry with corrected path? (y/n): 
────────────────────────────────────────────────────────────────
```

```bash
./command_checker.sh ./nopermission.sh
```
```
╔════════════════════════════════════════════════════════════════╗
║              COMMAND CHECKER                                   ║
╚════════════════════════════════════════════════════════════════╝

Executing: ./nopermission.sh

bash: ./nopermission.sh: Permission denied

────────────────────────────────────────────────────────────────
✗ Command failed
Exit Code: 126
Status: COMMAND CANNOT EXECUTE (Permission Problem)
────────────────────────────────────────────────────────────────

Error Analysis:
  Issue: File lacks execute permission
  File: ./nopermission.sh
  Current permissions: -rw-r--r-- (644)
  
Suggested Fix:
  chmod +x ./nopermission.sh
  
Apply fix automatically? (y/n): y

Applying fix...
✓ Execute permission added

Retrying command...
[Command now executes successfully]

✓ Command completed successfully after fix
Exit Code: 0
────────────────────────────────────────────────────────────────
```

```bash
./command_checker.sh nonexistentcommand
```
```
╔════════════════════════════════════════════════════════════════╗
║              COMMAND CHECKER                                   ║
╚════════════════════════════════════════════════════════════════╝

Executing: nonexistentcommand

bash: nonexistentcommand: command not found

────────────────────────────────────────────────────────────────
✗ Command failed
Exit Code: 127
Status: COMMAND NOT FOUND
────────────────────────────────────────────────────────────────

Error Analysis:
  Issue: Command does not exist in PATH
  Command: nonexistentcommand
  
Troubleshooting:
  • Check if command is installed
  • Verify spelling
  • Check PATH: /usr/local/bin:/usr/bin:/bin
  
Did you mean one of these?
  • nexistentcommand (typo fix)
  • existingcommand (similar command)
  
Search for package? (y/n): y

Searching package managers...
  apt: command not found in any package
  
The command might not be available on this system.
────────────────────────────────────────────────────────────────
```

```bash
./command_checker.sh --retry 3 flaky_command
```
```
╔════════════════════════════════════════════════════════════════╗
║         COMMAND CHECKER - Retry Mode (Max: 3)                  ║
╚════════════════════════════════════════════════════════════════╝

Attempt 1/3: flaky_command
✗ Failed (Exit code: 1)
  Waiting 2 seconds before retry...

Attempt 2/3: flaky_command
✗ Failed (Exit code: 1)
  Waiting 4 seconds before retry...

Attempt 3/3: flaky_command
✓ Success (Exit code: 0)

────────────────────────────────────────────────────────────────
✓ Command succeeded after 3 attempts
Total time: 8.2 seconds
────────────────────────────────────────────────────────────────
```
### Bonus Challenge:
- Add command suggestions for typos
- Implement exponential backoff for retries
- Create command alias suggestions
- Add command installation helpers
- Support command pipelines
- Track command success rates
- Create command wrapper functions
- Add environment debugging

***