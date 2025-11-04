### Goal:
Create a script named `options_demo.sh` that demonstrates proper getopts usage with help, verbose, and file options.
### Requirements:
- `-h` or `--help`: Display help message
- `-v` or `--verbose`: Enable verbose output
- `-f FILE` or `--file FILE`: Specify input file
- `-o OUTPUT` or `--output OUTPUT`: Specify output file
- Support combined options (`-vf file.txt`)
- Validate file existence
- Show usage examples
- Handle errors gracefully
### Expected Output Example:
```bash
./options_demo.sh -h
```
```
╔════════════════════════════════════════════════════════════════╗
║              OPTIONS DEMONSTRATION SCRIPT                      ║
║              Version 1.0.0                                     ║
╚════════════════════════════════════════════════════════════════╝

USAGE:
    options_demo.sh [OPTIONS] [ARGUMENTS]

DESCRIPTION:
    Demonstrates proper command-line option parsing using getopts.
    Processes files with various options and configurations.

OPTIONS:
    -h, --help              Display this help message and exit
    -v, --verbose           Enable verbose output mode
    -f, --file FILE         Specify input file to process (required)
    -o, --output FILE       Specify output file (default: output.txt)
    -q, --quiet             Suppress all output except errors
    -n, --dry-run           Show what would be done without doing it
    -V, --version           Display version information

ARGUMENTS:
    Additional arguments are passed to the processing function.

EXAMPLES:
    # Basic usage
    options_demo.sh -f input.txt

    # Verbose mode with custom output
    options_demo.sh -v -f input.txt -o result.txt

    # Combined short options
    options_demo.sh -vf input.txt

    # Long options
    options_demo.sh --verbose --file input.txt --output result.txt

    # Dry run mode
    options_demo.sh -n -f input.txt

EXIT CODES:
    0    Success
    1    General error
    2    Invalid option
    3    Missing required argument
    4    File not found

AUTHOR:
    Development Team

REPORTING BUGS:
    Report bugs to: bugs@example.com
```

```bash
./options_demo.sh -v -f test.txt -o output.txt
```
```
╔════════════════════════════════════════════════════════════════╗
║              OPTIONS DEMONSTRATION SCRIPT                      ║
╚════════════════════════════════════════════════════════════════╝

[VERBOSE] Parsing command-line options...

Options Parsed:
────────────────────────────────────────────────────────────────
Verbose mode:    Enabled
Input file:      test.txt
Output file:     output.txt
Quiet mode:      Disabled
Dry run:         Disabled

[VERBOSE] Validating options...

Validation:
────────────────────────────────────────────────────────────────
✓ Input file exists: test.txt
✓ Input file readable: test.txt
✓ Output directory writable: ./

[VERBOSE] Configuration complete

Processing Configuration:
────────────────────────────────────────────────────────────────
Input:           test.txt (2.3 KB, 47 lines)
Output:          output.txt
Mode:            Normal (verbose)

[VERBOSE] Starting processing...
[VERBOSE] Reading input file...
[VERBOSE] Processing line 1/47...
[VERBOSE] Processing line 2/47...
[... processing continues ...]
[VERBOSE] Processing line 47/47...
[VERBOSE] Writing output file...

╔════════════════════════════════════════════════════════════════╗
║              PROCESSING COMPLETE                               ║
╚════════════════════════════════════════════════════════════════╝

Summary:
────────────────────────────────────────────────────────────────
Input:           test.txt
Output:          output.txt (1.8 KB)
Lines processed: 47
Time elapsed:    0.234 seconds
Status:          ✓ Success

[VERBOSE] Cleanup completed
[VERBOSE] Exiting with code 0
```

```bash
./options_demo.sh -vf input.txt  # Combined options
```
```
╔════════════════════════════════════════════════════════════════╗
║              OPTIONS DEMONSTRATION SCRIPT                      ║
╚════════════════════════════════════════════════════════════════╝

[VERBOSE] Parsing command-line options...

Options Parsed:
────────────────────────────────────────────────────────────────
Verbose mode:    Enabled (combined with -f)
Input file:      input.txt
Output file:     output.txt (default)

[... processing continues ...]
```

```bash
./options_demo.sh -f nonexistent.txt
```
```
╔════════════════════════════════════════════════════════════════╗
║              OPTIONS DEMONSTRATION SCRIPT                      ║
╚════════════════════════════════════════════════════════════════╝

[ERROR] File not found: nonexistent.txt

Validation Failed:
────────────────────────────────────────────────────────────────
✗ Input file does not exist: nonexistent.txt

Please provide a valid input file using -f or --file option.

For help: ./options_demo.sh --help

Exit code: 4 (FILE_NOT_FOUND)
```

```bash
./options_demo.sh -f
```
```
[ERROR] Option -f requires an argument

Usage: options_demo.sh [OPTIONS]

For help: ./options_demo.sh --help

Exit code: 3 (MISSING_ARGUMENT)
```
### Bonus Challenge:
- Add config file support (`-c config.yml`)
- Implement option validation functions
- Support environment variable defaults
- Add interactive mode
- Create option dependency checking
- Support option conflicts detection
- Add bash completion script
- Create option documentation generator

***