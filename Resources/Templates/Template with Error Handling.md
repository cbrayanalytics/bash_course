## 🛠️ Template with Error Handling

For production scripts:

```bash
#!/usr/bin/env bash
set -euo pipefail

#================================================================
# Script: script-name.sh
# Description: What this script does
# Author: Your Name
#================================================================

readonly SCRIPT_NAME="$(basename "${0}")"

#----------------------------------------------------------------
# Cleanup on exit
#----------------------------------------------------------------
cleanup() {
    local exit_code=$?
    # Add cleanup tasks here
    exit "${exit_code}"
}

trap cleanup EXIT

#----------------------------------------------------------------
# Error handler
#----------------------------------------------------------------
error_exit() {
    echo "ERROR: ${1}" >&2
    exit 1
}

#----------------------------------------------------------------
# Main function
#----------------------------------------------------------------
main() {
    # Check dependencies
    command -v awk >/dev/null 2>&1 || error_exit "awk is required"
    
    # Your code here
    echo "Script running..."
    
}

main "$@"
```

