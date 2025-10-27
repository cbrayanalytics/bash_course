### What is getopts?
`getopts` is a built-in Bash command for parsing command-line options (flags).

**Basic syntax:**
```bash
getopts optstring name [args...]
```

**Components:**
- `optstring` - String defining valid options
- `name` - Variable to store current option
- Options are prefixed with `-` (e.g., `-h`, `-v`)
### Simple Example
```bash
#!/bin/bash

while getopts "hvf:" opt; do
    case $opt in
        h)
            echo "Help message"
            ;;
        v)
            echo "Verbose mode"
            ;;
        f)
            echo "File: $OPTARG"
            ;;
        \?)
            echo "Invalid option: -$OPTARG"
            exit 1
            ;;
    esac
done
```

**Usage:**
```bash
./script.sh -h          # Help message
./script.sh -v          # Verbose mode
./script.sh -f test.txt # File: test.txt
```
### Option String Syntax
**Options without arguments:**
```bash
getopts "abc" opt
# Valid: -a, -b, -c
# No arguments required
```

**Options with required arguments:**
```bash
getopts "f:d:o:" opt
# -f requires argument
# -d requires argument
# -o requires argument
```

**Mixed options:**
```bash
getopts "hvf:o:" opt
# -h (no argument)
# -v (no argument)
# -f (requires argument)
# -o (requires argument)
```
### Special Variables
**`OPTARG`** - Contains the argument value:
```bash
while getopts "f:" opt; do
    case $opt in
        f)
            echo "File: $OPTARG"
            ;;
    esac
done
```

**`OPTIND`** - Index of next argument to process:
```bash
echo "OPTIND: $OPTIND"
```

**Shift after processing options:**
```bash
shift $((OPTIND - 1))
# Now $1, $2, etc. are non-option arguments
```
### Combining Short Options
Options can be combined:
```bash
# These are equivalent:
./script.sh -a -b -c
./script.sh -abc
```

**Example:**
```bash
#!/bin/bash

while getopts "abc" opt; do
    case $opt in
        a) echo "Option A" ;;
        b) echo "Option B" ;;
        c) echo "Option C" ;;
    esac
done

# ./script.sh -abc
# Output:
# Option A
# Option B
# Option C
```
### Error Handling
**Two error handling modes:**

1. **Verbose mode (default):**
```bash
getopts "abc" opt
# Prints error message for invalid options
```

2. **Silent mode (prefix with `:`):**
```bash
getopts ":abc" opt
# Suppresses error messages
# You handle errors manually
```

**Silent mode error handling:**
```bash
while getopts ":f:o:" opt; do
    case $opt in
        f)
            file=$OPTARG
            ;;
        o)
            output=$OPTARG
            ;;
        :)
            echo "Error: -$OPTARG requires an argument"
            exit 1
            ;;
        \?)
            echo "Error: Invalid option -$OPTARG"
            exit 1
            ;;
    esac
done
```
### Complete Pattern
```bash
#!/bin/bash

# Default values
verbose=false
file=""
output="output.txt"

# Parse options
while getopts ":hvf:o:" opt; do
    case $opt in
        h)
            echo "Usage: $0 [-h] [-v] [-f file] [-o output]"
            exit 0
            ;;
        v)
            verbose=true
            ;;
        f)
            file=$OPTARG
            ;;
        o)
            output=$OPTARG
            ;;
        :)
            echo "Error: -$OPTARG requires an argument" >&2
            exit 1
            ;;
        \?)
            echo "Error: Invalid option -$OPTARG" >&2
            exit 1
            ;;
    esac
done

# Shift to access non-option arguments
shift $((OPTIND - 1))

# Now $1, $2, etc. are non-option arguments
echo "Remaining args: $@"
```
### Long Options (Manual Implementation)
`getopts` doesn't support long options (`--help`), but you can implement them:
```bash
#!/bin/bash

while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            echo "Help message"
            exit 0
            ;;
        -v|--verbose)
            verbose=true
            shift
            ;;
        -f|--file)
            file="$2"
            shift 2
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done
```
### Optional Arguments (Advanced)
`getopts` doesn't directly support optional arguments, but you can implement them:
```bash
#!/bin/bash

while getopts ":f:" opt; do
    case $opt in
        f)
            # Check if OPTARG starts with -
            if [[ $OPTARG == -* ]]; then
                # It's actually another option, not an argument
                ((OPTIND--))
                file="default.txt"
            else
                file=$OPTARG
            fi
            ;;
    esac
done
```
### Practical Examples
**Script with help:**
```bash
#!/bin/bash

show_help() {
    cat << EOF
Usage: ${0##*/} [-h] [-v] [-f FILE] [-o OUTPUT]
    
Process files with various options.

Options:
    -h          Display this help message
    -v          Enable verbose output
    -f FILE     Input file to process
    -o OUTPUT   Output file (default: output.txt)
EOF
}

while getopts ":hvf:o:" opt; do
    case $opt in
        h)
            show_help
            exit 0
            ;;
        v)
            verbose=true
            ;;
        f)
            input=$OPTARG
            ;;
        o)
            output=$OPTARG
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            show_help
            exit 1
            ;;
    esac
done
```

***

**Exercise 1:** [[Script with -h, -v , -f]]
**Exercise 2:** [[Handle Required vs Optional Arguments]]
**Exercise 3:** [[Implement Long Option Equivalents Manually]]

**Daily Project:** [[Backup Utility with Comprehensive Option Parsing]]