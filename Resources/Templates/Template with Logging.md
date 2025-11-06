## 📝 Template with Logging

For scripts that need better output tracking:

```bash
#!/usr/bin/env bash
set -euo pipefail

#================================================================
# Script: script-name.sh
# Description: What this script does
# Author: Your Name
#================================================================

readonly SCRIPT_NAME="$(basename "${0}")"

# Colors for output
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly NC='\033[0m'

#----------------------------------------------------------------
# Logging function
#----------------------------------------------------------------
log() {
    local level="${1}"
    local message="${2}"
    case "${level}" in
        ERROR)   echo -e "${RED}[ERROR]${NC} ${message}" >&2 ;;
        SUCCESS) echo -e "${GREEN}[SUCCESS]${NC} ${message}" ;;
        WARN)    echo -e "${YELLOW}[WARN]${NC} ${message}" ;;
        *)       echo "[INFO] ${message}" ;;
    esac
}

#----------------------------------------------------------------
# Main function
#----------------------------------------------------------------
main() {
    log "INFO" "Script starting..."
    
    # Your code here
    
    log "SUCCESS" "Script completed"
}

main "$@"
```

