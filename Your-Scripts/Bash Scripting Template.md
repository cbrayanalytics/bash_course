## Professional Script Setup & Documentation Standards

This template demonstrates proper Bash script structure, commenting conventions, and best practices for professional script development.

***

## 📝 Complete Template

```bash
#!/usr/bin/env bash

#================================================================
# HEADER
#================================================================
#% SYNOPSIS
#+    ${SCRIPT_NAME} [OPTIONS] [ARGUMENTS]
#%
#% DESCRIPTION
#%    Brief description of what this script does.
#%    Provide enough detail for users to understand the purpose
#%    and functionality without reading the entire code.
#%
#% OPTIONS
#%    -h, --help                    Print this help message
#%    -v, --version                 Print version information
#%    -d, --debug                   Enable debug mode (verbose output)
#%    -o [file], --output=[file]    Specify output file
#%    -i [file], --input=[file]     Specify input file
#%
#% EXAMPLES
#%    ${SCRIPT_NAME} --input data.txt --output result.txt
#%    ${SCRIPT_NAME} -d -o /tmp/output.log
#%
#================================================================
#- IMPLEMENTATION
#-    version         1.0.0
#-    author          Your Name
#-    copyright       Copyright (c) 2025
#-    license         MIT License
#-    script_id       001
#-
#================================================================
#  HISTORY
#     2025/11/05 : Your Name : Script creation
#     2025/11/06 : Your Name : Added error handling
#
#================================================================
#  DEBUG OPTIONS
#     set -n  # Uncomment to check syntax without execution
#     set -x  # Uncomment to debug this script
#
#================================================================
# END OF HEADER
#================================================================


#================================================================
# SCRIPT CONFIGURATION
#================================================================

# Bash strict mode - fail fast and fail loud
set -o errexit   # Exit on error (-e)
set -o nounset   # Exit on undefined variable (-u)
set -o pipefail  # Exit on pipe failure

# Optional: Enable debug mode if DEBUG environment variable is set
[[ "${DEBUG:-false}" == "true" ]] && set -o xtrace


#================================================================
# GLOBAL VARIABLES
#================================================================

# Script metadata
readonly SCRIPT_NAME="$(basename "${0}")"
readonly SCRIPT_DIR="$(cd "$(dirname "${0}")" && pwd)"
readonly SCRIPT_VERSION="1.0.0"
readonly SCRIPT_AUTHOR="Your Name"

# Default configuration values
DEFAULT_OUTPUT_FILE="/dev/null"
DEFAULT_LOG_LEVEL="INFO"

# User-configurable variables (can be modified by command-line options)
OUTPUT_FILE="${DEFAULT_OUTPUT_FILE}"
INPUT_FILE=""
DEBUG_MODE=false
VERBOSE=false

# Color codes for output formatting
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m' # No Color


#================================================================
# UTILITY FUNCTIONS
#================================================================

#----------------------------------------------------------------
# Print formatted message to stderr
#
# Arguments:
#   $1 - Message level (INFO, WARN, ERROR, SUCCESS, DEBUG)
#   $2 - Message text
# Returns:
#   None
#----------------------------------------------------------------
log() {
    local level="${1}"
    local message="${2}"
    local timestamp
    timestamp="$(date '+%Y-%m-%d %H:%M:%S')"
    
    case "${level}" in
        INFO)
            echo -e "${BLUE}[INFO]${NC} ${timestamp} - ${message}" >&2
            ;;
        WARN)
            echo -e "${YELLOW}[WARN]${NC} ${timestamp} - ${message}" >&2
            ;;
        ERROR)
            echo -e "${RED}[ERROR]${NC} ${timestamp} - ${message}" >&2
            ;;
        SUCCESS)
            echo -e "${GREEN}[SUCCESS]${NC} ${timestamp} - ${message}" >&2
            ;;
        DEBUG)
            if [[ "${DEBUG_MODE}" == true ]]; then
                echo -e "[DEBUG] ${timestamp} - ${message}" >&2
            fi
            ;;
        *)
            echo "${timestamp} - ${message}" >&2
            ;;
    esac
}


#----------------------------------------------------------------
# Display usage information
#
# Arguments:
#   None
# Returns:
#   None
#----------------------------------------------------------------
usage() {
    cat << EOF
Usage: ${SCRIPT_NAME} [OPTIONS] [ARGUMENTS]

DESCRIPTION:
    Brief description of what this script does.

OPTIONS:
    -h, --help              Show this help message and exit
    -v, --version           Show version information and exit
    -d, --debug             Enable debug mode (verbose output)
    -o, --output FILE       Specify output file (default: ${DEFAULT_OUTPUT_FILE})
    -i, --input FILE        Specify input file (required)

EXAMPLES:
    ${SCRIPT_NAME} --input data.txt --output result.txt
    ${SCRIPT_NAME} -d -i /path/to/input.txt

AUTHOR:
    ${SCRIPT_AUTHOR}

VERSION:
    ${SCRIPT_VERSION}
EOF
}


#----------------------------------------------------------------
# Display version information
#
# Arguments:
#   None
# Returns:
#   None
#----------------------------------------------------------------
version() {
    echo "${SCRIPT_NAME} version ${SCRIPT_VERSION}"
    echo "Author: ${SCRIPT_AUTHOR}"
}


#----------------------------------------------------------------
# Cleanup function (called on script exit)
#
# Arguments:
#   None
# Returns:
#   None
#----------------------------------------------------------------
cleanup() {
    local exit_code=$?
    
    log "DEBUG" "Cleanup function called with exit code: ${exit_code}"
    
    # Add cleanup tasks here (e.g., remove temporary files)
    # rm -f /tmp/tempfile.$$
    
    if [[ ${exit_code} -eq 0 ]]; then
        log "SUCCESS" "Script completed successfully"
    else
        log "ERROR" "Script exited with error code: ${exit_code}"
    fi
    
    exit "${exit_code}"
}


#----------------------------------------------------------------
# Error handler function
#
# Arguments:
#   $1 - Line number where error occurred
#   $2 - Error message
# Returns:
#   1 (error)
#----------------------------------------------------------------
error_handler() {
    local line_number="${1}"
    local error_message="${2:-Unknown error}"
    
    log "ERROR" "Error on line ${line_number}: ${error_message}"
    exit 1
}


#----------------------------------------------------------------
# Check if script is run as root
#
# Arguments:
#   None
# Returns:
#   0 if root, 1 if not root
#----------------------------------------------------------------
check_root() {
    if [[ "${EUID}" -ne 0 ]]; then
        log "ERROR" "This script must be run as root"
        return 1
    fi
    return 0
}


#----------------------------------------------------------------
# Check if required commands are available
#
# Arguments:
#   $@ - List of required commands
# Returns:
#   0 if all commands exist, 1 otherwise
#----------------------------------------------------------------
check_dependencies() {
    local missing_deps=()
    
    for cmd in "$@"; do
        if ! command -v "${cmd}" &> /dev/null; then
            missing_deps+=("${cmd}")
        fi
    done
    
    if [[ ${#missing_deps[@]} -gt 0 ]]; then
        log "ERROR" "Missing required dependencies: ${missing_deps[*]}"
        return 1
    fi
    
    return 0
}


#----------------------------------------------------------------
# Validate required file exists and is readable
#
# Arguments:
#   $1 - File path
# Returns:
#   0 if valid, 1 otherwise
#----------------------------------------------------------------
validate_file() {
    local file="${1}"
    
    if [[ -z "${file}" ]]; then
        log "ERROR" "File path is empty"
        return 1
    fi
    
    if [[ ! -f "${file}" ]]; then
        log "ERROR" "File does not exist: ${file}"
        return 1
    fi
    
    if [[ ! -r "${file}" ]]; then
        log "ERROR" "File is not readable: ${file}"
        return 1
    fi
    
    return 0
}


#================================================================
# BUSINESS LOGIC FUNCTIONS
#================================================================

#----------------------------------------------------------------
# Main processing function
#
# Arguments:
#   None (uses global variables)
# Returns:
#   0 on success, 1 on failure
#----------------------------------------------------------------
process_data() {
    log "INFO" "Starting data processing..."
    
    # Validate input file
    if ! validate_file "${INPUT_FILE}"; then
        return 1
    fi
    
    # Your main logic here
    log "DEBUG" "Processing file: ${INPUT_FILE}"
    
    # Example processing
    while IFS= read -r line; do
        log "DEBUG" "Processing line: ${line}"
        # Add your processing logic here
    done < "${INPUT_FILE}"
    
    log "SUCCESS" "Data processing completed"
    return 0
}


#================================================================
# COMMAND-LINE ARGUMENT PARSING
#================================================================

#----------------------------------------------------------------
# Parse command-line arguments
#
# Arguments:
#   $@ - All command-line arguments
# Returns:
#   None
#----------------------------------------------------------------
parse_arguments() {
    # If no arguments provided, show usage
    if [[ $# -eq 0 ]]; then
        usage
        exit 0
    fi
    
    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case "${1}" in
            -h|--help)
                usage
                exit 0
                ;;
            -v|--version)
                version
                exit 0
                ;;
            -d|--debug)
                DEBUG_MODE=true
                log "INFO" "Debug mode enabled"
                shift
                ;;
            -o|--output)
                OUTPUT_FILE="${2}"
                log "DEBUG" "Output file set to: ${OUTPUT_FILE}"
                shift 2
                ;;
            -i|--input)
                INPUT_FILE="${2}"
                log "DEBUG" "Input file set to: ${INPUT_FILE}"
                shift 2
                ;;
            --)
                shift
                break
                ;;
            -*)
                log "ERROR" "Unknown option: ${1}"
                usage
                exit 1
                ;;
            *)
                # Positional arguments
                log "DEBUG" "Positional argument: ${1}"
                shift
                ;;
        esac
    done
    
    # Validate required arguments
    if [[ -z "${INPUT_FILE}" ]]; then
        log "ERROR" "Input file is required"
        usage
        exit 1
    fi
}


#================================================================
# MAIN EXECUTION
#================================================================

#----------------------------------------------------------------
# Main function - entry point of the script
#
# Arguments:
#   $@ - All command-line arguments
# Returns:
#   0 on success, non-zero on failure
#----------------------------------------------------------------
main() {
    # Set up trap for cleanup
    trap cleanup EXIT
    trap 'error_handler ${LINENO} "${BASH_COMMAND}"' ERR
    
    log "INFO" "Starting ${SCRIPT_NAME} v${SCRIPT_VERSION}"
    
    # Parse command-line arguments
    parse_arguments "$@"
    
    # Check dependencies
    check_dependencies "awk" "sed" "grep"
    
    # Uncomment if root privileges are required
    # check_root || exit 1
    
    # Execute main business logic
    process_data
    
    log "SUCCESS" "Script execution completed"
    return 0
}


# Execute main function with all command-line arguments
main "$@"
```

***

## 📚 Template Sections Explained

### 1. Shebang Line
```bash
#!/usr/bin/env bash
```
- Always use `/usr/bin/env bash` for portability
- Never use `/bin/sh` unless writing POSIX-compliant scripts

### 2. Header Documentation
The header section provides complete documentation about the script, including synopsis, description, options, examples, implementation details, and version history.

### 3. Script Configuration
```bash
set -o errexit   # Exit immediately if a command fails
set -o nounset   # Exit if undefined variable is used
set -o pipefail  # Catch failures in pipes
```
These are **critical** for safe script execution.

### 4. Global Variables
- Use `readonly` for constants
- Use `UPPER_CASE` for global/environment variables
- Use `lower_case` for local variables

### 5. Utility Functions
Common helper functions that can be reused across scripts, including logging, error handling, and validation.

### 6. Business Logic Functions
Your script-specific functions should be well-documented with clear descriptions of arguments and return values.

### 7. Command-Line Parsing
Robust argument parsing with both short (`-h`) and long (`--help`) options.

### 8. Main Execution
All script logic should be in functions, with a `main()` function as the entry point.

***

## ✅ Best Practices Checklist

- [ ] Shebang line is first line of script
- [ ] `set -o errexit`, `set -o nounset`, `set -o pipefail` enabled
- [ ] All variables quoted: `"${variable}"`
- [ ] Functions documented with purpose, arguments, and returns
- [ ] Error handling and logging implemented
- [ ] Cleanup function with trap on EXIT
- [ ] Input validation for all user-provided data
- [ ] Dependency checking before execution
- [ ] Usage/help information available
- [ ] Script is executable: `chmod +x script.sh`

***

## 🎨 Commenting Conventions

### Single-line Comments
```bash
# This is a single-line comment explaining the next line
variable="value"
```

### Multi-line Comments
```bash
# This is a multi-line comment that explains
# a complex section of code or provides
# additional context for the following block
```

### Function Documentation
```bash
#----------------------------------------------------------------
# Brief description of function
#
# Arguments:
#   $1 - Description of first argument
#   $2 - Description of second argument
# Returns:
#   0 on success, 1 on failure
#----------------------------------------------------------------
```

### Inline Comments (Use Sparingly)
```bash
result=$((5 + 3))  # Calculate sum of 5 and 3
```

***

## 🚀 Usage Example

Save the template as `my-script.sh`, make it executable, and run:

```bash
# Make executable
chmod +x my-script.sh

# Show help
./my-script.sh --help

# Run with options
./my-script.sh --input data.txt --output result.txt --debug
```

***

## 📖 Additional Resources

- [ShellCheck](https://www.shellcheck.net/) - Online tool for validating scripts
- [Google Shell Style Guide](https://google.github.io/styleguide/shellguide.html)
- [Bash Hackers Wiki](https://wiki.bash-hackers.org/)

***

**Remember:** This template is a starting point. Adapt it to your specific needs, but always maintain clear documentation and error handling!