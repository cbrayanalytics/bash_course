## Professional Bash Script Template 

```bash
#!/usr/bin/env bash

################################################################################
# Script Name:    [CHANGE_ME].sh
# Description:    [DESCRIBE WHAT THIS SCRIPT DOES]
# Author:         [YOUR_NAME]
# Created:        [DATE]
# Version:        1.0.0
################################################################################

# Strict mode - exit on errors
set -euo pipefail
IFS=$'\n\t'

# Script metadata
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly SCRIPT_NAME="$(basename "${BASH_SOURCE[0]}")"
readonly LOG_FILE="${SCRIPT_DIR}/${SCRIPT_NAME%.sh}.log"

# Default configuration
VERBOSE=false
DRY_RUN=false

# Colors for output
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly RESET='\033[0m'

################################################################################
# LOGGING FUNCTIONS
################################################################################

log_info() {
    echo -e "${GREEN}[INFO]${RESET} $*" | tee -a "${LOG_FILE}"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${RESET} $*" | tee -a "${LOG_FILE}" >&2
}

log_error() {
    echo -e "${RED}[ERROR]${RESET} $*" | tee -a "${LOG_FILE}" >&2
}

################################################################################
# CLEANUP & ERROR HANDLING
################################################################################

cleanup() {
    local exit_code=$?
    
    # Add cleanup tasks here
    
    if [[ ${exit_code} -eq 0 ]]; then
        log_info "Script completed successfully"
    else
        log_error "Script failed with exit code: ${exit_code}"
    fi
    
    exit "${exit_code}"
}

trap cleanup EXIT SIGINT SIGTERM

################################################################################
# UTILITY FUNCTIONS
################################################################################

usage() {
    cat << EOF
Usage: ${SCRIPT_NAME} [OPTIONS]

Description of your script

OPTIONS:
    -h, --help          Show this help message
    -v, --verbose       Enable verbose output
    -n, --dry-run       Perform dry run (no changes)

EXAMPLES:
    ${SCRIPT_NAME} --verbose
    ${SCRIPT_NAME} --dry-run

EOF
}

check_dependencies() {
    local missing_deps=()
    
    for cmd in "$@"; do
        if ! command -v "${cmd}" &>/dev/null; then
            missing_deps+=("${cmd}")
        fi
    done
    
    if [[ ${#missing_deps[@]} -gt 0 ]]; then
        log_error "Missing dependencies: ${missing_deps[*]}"
        exit 1
    fi
}

################################################################################
# ARGUMENT PARSING
################################################################################

parse_arguments() {
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -h|--help)
                usage
                exit 0
                ;;
            -v|--verbose)
                VERBOSE=true
                shift
                ;;
            -n|--dry-run)
                DRY_RUN=true
                log_info "DRY RUN MODE - No changes will be made"
                shift
                ;;
            *)
                log_error "Unknown option: $1"
                usage
                exit 1
                ;;
        esac
    done
}

################################################################################
# MAIN LOGIC
################################################################################

main() {
    log_info "Starting ${SCRIPT_NAME}"
    
    # Check for required dependencies
    check_dependencies "grep" "sed" "awk"
    
    # ──────────────────────────────────────────────────
    # ADD YOUR CUSTOM LOGIC HERE
    # ──────────────────────────────────────────────────
    
    if [[ "${DRY_RUN}" == true ]]; then
        log_info "DRY RUN: Would perform operations here"
    else
        log_info "Performing operations..."
        
        # Your actual script logic goes here
        
    fi
    
    # ──────────────────────────────────────────────────
    
    log_info "Script execution complete"
}

################################################################################
# SCRIPT ENTRY POINT
################################################################################

parse_arguments "$@"
main
```

***

## Quick Start Guide

### Step 1: Copy & Create Your Script
```bash
# Copy template to new script
cat > my_script.sh << 'EOF'
[PASTE TEMPLATE HERE]
EOF

# Make executable
chmod +x my_script.sh
```

### Step 2: Customize (Only 4 Things to Change)

1. **Header section** - Update script name, description, author
2. **Dependencies** - Change the dependencies in `check_dependencies`
3. **Arguments** - Add custom options in `parse_arguments` section
4. **Main logic** - Replace placeholder in `main()` function

### Step 3: Test
```bash
# Show help
./my_script.sh --help

# Dry run
./my_script.sh --dry-run

# Verbose mode
./my_script.sh --verbose
```

***

## Example: Custom Script

Here's how to customize it for a simple backup script:

```bash
#!/usr/bin/env bash

################################################################################
# Script Name:    backup_files.sh
# Description:    Backs up specified directory to archive location
# Author:         John Admin
# Created:        2025-11-06
# Version:        1.0.0
################################################################################

# Strict mode - exit on errors
set -euo pipefail
IFS=$'\n\t'

# Script metadata
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly SCRIPT_NAME="$(basename "${BASH_SOURCE[0]}")"
readonly LOG_FILE="${SCRIPT_DIR}/${SCRIPT_NAME%.sh}.log"

# Default configuration
VERBOSE=false
DRY_RUN=false
SOURCE_DIR=""
BACKUP_DIR="/backup"

# Colors for output
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly RESET='\033[0m'

################################################################################
# LOGGING FUNCTIONS
################################################################################

log_info() {
    echo -e "${GREEN}[INFO]${RESET} $*" | tee -a "${LOG_FILE}"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${RESET} $*" | tee -a "${LOG_FILE}" >&2
}

log_error() {
    echo -e "${RED}[ERROR]${RESET} $*" | tee -a "${LOG_FILE}" >&2
}

################################################################################
# CLEANUP & ERROR HANDLING
################################################################################

cleanup() {
    local exit_code=$?
    
    if [[ ${exit_code} -eq 0 ]]; then
        log_info "Script completed successfully"
    else
        log_error "Script failed with exit code: ${exit_code}"
    fi
    
    exit "${exit_code}"
}

trap cleanup EXIT SIGINT SIGTERM

################################################################################
# UTILITY FUNCTIONS
################################################################################

usage() {
    cat << EOF
Usage: ${SCRIPT_NAME} [OPTIONS] -s SOURCE_DIR

Backs up specified directory to archive location

OPTIONS:
    -h, --help          Show this help message
    -v, --verbose       Enable verbose output
    -n, --dry-run       Perform dry run (no changes)
    -s, --source DIR    Source directory to backup (required)
    -b, --backup DIR    Backup destination (default: /backup)

EXAMPLES:
    ${SCRIPT_NAME} -s /home/user/documents
    ${SCRIPT_NAME} --source /var/www --backup /mnt/backups --verbose

EOF
}

check_dependencies() {
    local missing_deps=()
    
    for cmd in "$@"; do
        if ! command -v "${cmd}" &>/dev/null; then
            missing_deps+=("${cmd}")
        fi
    done
    
    if [[ ${#missing_deps[@]} -gt 0 ]]; then
        log_error "Missing dependencies: ${missing_deps[*]}"
        exit 1
    fi
}

################################################################################
# ARGUMENT PARSING
################################################################################

parse_arguments() {
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -h|--help)
                usage
                exit 0
                ;;
            -v|--verbose)
                VERBOSE=true
                shift
                ;;
            -n|--dry-run)
                DRY_RUN=true
                log_info "DRY RUN MODE - No changes will be made"
                shift
                ;;
            -s|--source)
                SOURCE_DIR="$2"
                shift 2
                ;;
            -b|--backup)
                BACKUP_DIR="$2"
                shift 2
                ;;
            *)
                log_error "Unknown option: $1"
                usage
                exit 1
                ;;
        esac
    done
    
    # Validate required arguments
    if [[ -z "${SOURCE_DIR}" ]]; then
        log_error "Source directory is required"
        usage
        exit 1
    fi
}

################################################################################
# MAIN LOGIC
################################################################################

main() {
    log_info "Starting ${SCRIPT_NAME}"
    
    # Check for required dependencies
    check_dependencies "tar" "gzip"
    
    # Validate source directory exists
    if [[ ! -d "${SOURCE_DIR}" ]]; then
        log_error "Source directory does not exist: ${SOURCE_DIR}"
        exit 1
    fi
    
    # Create backup directory if needed
    if [[ ! -d "${BACKUP_DIR}" ]]; then
        log_info "Creating backup directory: ${BACKUP_DIR}"
        mkdir -p "${BACKUP_DIR}"
    fi
    
    # Create backup filename with timestamp
    local timestamp
    timestamp=$(date +%Y%m%d_%H%M%S)
    local backup_file="${BACKUP_DIR}/backup_${timestamp}.tar.gz"
    
    if [[ "${DRY_RUN}" == true ]]; then
        log_info "DRY RUN: Would create backup: ${backup_file}"
        log_info "DRY RUN: Would archive: ${SOURCE_DIR}"
    else
        log_info "Creating backup: ${backup_file}"
        log_info "Archiving: ${SOURCE_DIR}"
        
        tar -czf "${backup_file}" -C "$(dirname "${SOURCE_DIR}")" "$(basename "${SOURCE_DIR}")" 2>&1 | tee -a "${LOG_FILE}"
        
        log_info "Backup created successfully: ${backup_file}"
        log_info "Backup size: $(du -h "${backup_file}" | cut -f1)"
    fi
    
    log_info "Script execution complete"
}

################################################################################
# SCRIPT ENTRY POINT
################################################################################

parse_arguments "$@"
main
```
