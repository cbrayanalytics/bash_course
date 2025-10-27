### Goal:
Create a script named `long_options.sh` that supports both short (`-h`) and long (`--help`) options.
### Requirements:
- Support both short and long options
- Handle long options with arguments (`--file=input.txt`)
- Handle long options with space-separated arguments (`--file input.txt`)
- Combine short and long in same script
- Support abbreviations (partial matching)
- Case-insensitive long options
- Validate long option format
- Show both in help
### Expected Output Example:
```bash
./long_options.sh --help
```
```
╔════════════════════════════════════════════════════════════════╗
║              LONG OPTIONS DEMONSTRATION                        ║
╚════════════════════════════════════════════════════════════════╝

USAGE:
    long_options.sh [OPTIONS]

SHORT AND LONG OPTIONS:
    -h, --help              Display this help message
    -v, --verbose           Enable verbose mode
    -q, --quiet             Quiet mode (suppress output)
    -f, --file FILE         Input file
    -o, --output FILE       Output file
    -m, --mode MODE         Operation mode
    -n, --number NUM        Numeric value
    -V, --version           Show version

OPTIONS WITH ARGUMENTS:
    Both forms are supported:
        --file=input.txt
        --file input.txt
    
    Short options:
        -f input.txt
    
    Combined short options:
        -vf input.txt

EXAMPLES:
    # Using long options
    long_options.sh --verbose --file input.txt --output result.txt
    
    # Using short options
    long_options.sh -v -f input.txt -o result.txt
    
    # Mixed short and long
    long_options.sh -v --file input.txt -o result.txt
    
    # Long option with = syntax
    long_options.sh --file=input.txt --output=result.txt
    
    # Combined short options
    long_options.sh -vqf input.txt
```

```bash
./long_options.sh --verbose --file=test.txt
```
```
╔════════════════════════════════════════════════════════════════╗
║              LONG OPTIONS DEMONSTRATION                        ║
╚════════════════════════════════════════════════════════════════╝

[VERBOSE] Parsing command-line options...
[VERBOSE] Found long option: --verbose
[VERBOSE] Found long option: --file with argument: test.txt

Options Parsed:
────────────────────────────────────────────────────────────────
Verbose:    Enabled (via --verbose)
File:       test.txt (via --file=test.txt)

[VERBOSE] Processing with file: test.txt
✓ Processing complete
```

```bash
./long_options.sh -v --file test.txt  # Space-separated
```
```
[VERBOSE] Parsing command-line options...
[VERBOSE] Found short option: -v
[VERBOSE] Found long option: --file with argument: test.txt

Options Parsed:
────────────────────────────────────────────────────────────────
Verbose:    Enabled (via -v)
File:       test.txt (via --file test.txt)

✓ Processing complete
```

```bash
./long_options.sh -vf test.txt  # Combined short options
```
```
[VERBOSE] Parsing command-line options...
[VERBOSE] Found combined short options: -vf
[VERBOSE] Processing: -v
[VERBOSE] Processing: -f with argument: test.txt

Options Parsed:
────────────────────────────────────────────────────────────────
Verbose:    Enabled (via -v in -vf)
File:       test.txt (via -f in -vf)

✓ Processing complete
```
### Bonus Challenge:
- Add partial long option matching (--verb matches --verbose)
- Implement option value validation
- Support negation (--no-verbose)
- Add option chaining
- Create option parser library
- Support custom option formats
- Add getopt-style parsing
- Implement option serialization

***