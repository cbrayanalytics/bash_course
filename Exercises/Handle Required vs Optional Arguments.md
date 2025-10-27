### Goal:
Create a script named `arg_handler.sh` that demonstrates handling both required and optional arguments with comprehensive validation.
### Requirements:
- Distinguish required vs optional options
- Validate required options are provided
- Provide defaults for optional options
- Clear error messages for missing requirements
- Support option dependencies
- Handle mutually exclusive options
- Validate argument types (file, number, string)
- Show which options are missing
### Expected Output Example:
```bash
./arg_handler.sh
```
```
╔════════════════════════════════════════════════════════════════╗
║              ARGUMENT HANDLER                                  ║
╚════════════════════════════════════════════════════════════════╝

[ERROR] Missing required options

Required Options Not Provided:
────────────────────────────────────────────────────────────────
✗ -s, --source SOURCE       Source file (REQUIRED)
✗ -d, --destination DEST    Destination file (REQUIRED)

Optional Options (with defaults):
────────────────────────────────────────────────────────────────
  -m, --mode MODE           Operation mode (default: copy)
  -v, --verbose             Verbose output (default: disabled)
  -b, --backup              Create backup (default: disabled)
  -t, --timeout SECONDS     Timeout in seconds (default: 30)

Usage:
    arg_handler.sh -s SOURCE -d DESTINATION [OPTIONS]

Examples:
    arg_handler.sh -s input.txt -d output.txt
    arg_handler.sh -s data.csv -d result.csv -m process -v

For full help: arg_handler.sh --help

Exit code: 3 (MISSING_REQUIRED_OPTIONS)
```

```bash
./arg_handler.sh -s input.txt -d output.txt
```
```
╔════════════════════════════════════════════════════════════════╗
║              ARGUMENT HANDLER                                  ║
╚════════════════════════════════════════════════════════════════╝

Validating arguments...

Required Options:
────────────────────────────────────────────────────────────────
✓ Source:           input.txt (provided)
✓ Destination:      output.txt (provided)

Optional Options:
────────────────────────────────────────────────────────────────
  Mode:             copy (default)
  Verbose:          disabled (default)
  Backup:           disabled (default)
  Timeout:          30 seconds (default)

Validation:
────────────────────────────────────────────────────────────────
✓ Source file exists
✓ Source file readable
✓ Destination directory writable
✓ All required options provided
✓ All options validated

Configuration Summary:
────────────────────────────────────────────────────────────────
Source:      input.txt
Destination: output.txt
Mode:        copy
Backup:      No
Timeout:     30s

Proceed with operation? [Y/n]: y

Processing...
✓ Operation completed successfully
```

```bash
./arg_handler.sh -s input.txt -d output.txt -m invalid
```
```
[ERROR] Invalid argument for option -m

Validation Failed:
────────────────────────────────────────────────────────────────
✗ Mode: invalid
  
Valid values for --mode:
  • copy       - Copy source to destination
  • move       - Move source to destination
  • sync       - Synchronize source and destination
  • process    - Process source and write to destination

Provided: invalid
Expected: One of [copy, move, sync, process]

Exit code: 2 (INVALID_ARGUMENT)
```

```bash
./arg_handler.sh -s input.txt -d output.txt -t abc
```
```
[ERROR] Invalid argument type for option -t

Validation Failed:
────────────────────────────────────────────────────────────────
✗ Timeout: abc
  
Option --timeout expects: Integer (number of seconds)
Provided: abc (not a valid integer)

Valid examples:
  -t 30      (30 seconds)
  -t 60      (1 minute)
  -t 300     (5 minutes)

Exit code: 2 (INVALID_ARGUMENT)
```
### Bonus Challenge:
- Add option groups (mutually exclusive)
- Implement conditional requirements
- Support range validation (min/max values)
- Add custom validators
- Create option profiles
- Support option aliases
- Add autocomplete for option values
- Implement option suggestion (did you mean?)

***