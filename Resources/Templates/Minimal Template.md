## 📋 Minimal Template (Copy & Paste Ready)

```bash
#!/usr/bin/env bash

#================================================================
# Script: script-name.sh
# Description: Brief description of what this script does
# Author: Your Name
# Date: 2025-11-06
#================================================================

# Bash strict mode - exit on error
set -euo pipefail

# Script variables
readonly SCRIPT_DIR="$(cd "$(dirname "${0}")" && pwd)"
readonly SCRIPT_NAME="$(basename "${0}")"

#----------------------------------------------------------------
# Display usage information
#----------------------------------------------------------------
usage() {
    cat << EOF
Usage: ${SCRIPT_NAME} [OPTIONS]

Description of your script

OPTIONS:
    -h, --help      Show this help message
    -v, --verbose   Enable verbose output

EXAMPLES:
    ${SCRIPT_NAME} --help
EOF
}

#----------------------------------------------------------------
# Main function
#----------------------------------------------------------------
main() {
    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case "${1}" in
            -h|--help)
                usage
                exit 0
                ;;
            -v|--verbose)
                set -x
                shift
                ;;
            *)
                echo "Unknown option: ${1}"
                usage
                exit 1
                ;;
        esac
    done
    
    # Your script logic here
    echo "Script starting..."
    
    # Add your code below
    
}

# Execute main function
main "$@"
```

