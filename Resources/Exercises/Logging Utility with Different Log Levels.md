### Goal:
Build a comprehensive logging utility named `logger.sh` that provides professional logging functions for bash scripts.
### Requirements:
**Core Logging Functions:**
1. `log_debug(message)` - Debug-level messages (verbose output)
2. `log_info(message)` - Informational messages
3. `log_warn(message)` - Warning messages
4. `log_error(message)` - Error messages
5. `log_fatal(message)` - Fatal errors (exits script)

**Logging Features:**
- Timestamp for each log entry
- Log level indicator with color coding
- Write to file and/or console
- Configurable log level filtering
- Structured log format
- Log rotation support
- Caller information (function name, line number)
- Session tracking
- Log statistics

**Configuration:**
- Set minimum log level (DEBUG, INFO, WARN, ERROR)
- Enable/disable console output
- Enable/disable file output
- Set log file path
- Configure timestamp format
- Set maximum log file size
- Configure log retention period

**Advanced Features:**
- JSON output format option
- Multiple output destinations
- Log context (add metadata)
- Log filtering by pattern
- Log searching and querying
- Log analysis and statistics
- Alert integration (email/webhook)
### Expected Output Example:
```bash
source logger.sh

log_info "Application starting"
log_debug "Loading configuration"
log_warn "Configuration file not found, using defaults"
log_error "Failed to connect to database"
log_fatal "Critical component failure"
```

```
╔════════════════════════════════════════════════════════════════╗
║                    APPLICATION LOG                             ║
╚════════════════════════════════════════════════════════════════╝

[2025-10-19 21:19:05] [INFO ] Application starting
[2025-10-19 21:19:05] [DEBUG] Loading configuration
[2025-10-19 21:19:05] [WARN ] Configuration file not found, using defaults
[2025-10-19 21:19:06] [ERROR] Failed to connect to database
  ↳ Location: main() at line 45
  ↳ Attempt: 1 of 3
[2025-10-19 21:19:06] [FATAL] Critical component failure
  ↳ Location: initialize() at line 23
  ↳ Stack: main() → initialize() → connect_db()

FATAL ERROR - Application terminated
Exit code: 1
```

**Complete example script:**
```bash
#!/bin/bash

# Source the logger
source ./logger.sh

# Configure logging
log_init
log_set_level "DEBUG"
log_set_file "/var/log/myapp.log"
log_enable_colors true

# Use logging in your script
main() {
    log_info "Application started"
    log_debug "Debugging information"
    
    if ! check_prerequisites; then
        log_error "Prerequisites check failed"
        return 1
    fi
    
    log_info "All checks passed"
    
    if ! perform_critical_operation; then
        log_fatal "Critical operation failed - cannot continue"
    fi
    
    log_info "Application completed successfully"
}

check_prerequisites() {
    log_debug "Checking prerequisites..."
    
    if [[ ! -f "config.yaml" ]]; then
        log_warn "Config file missing, using defaults"
    fi
    
    if ! command -v required_tool &>/dev/null; then
        log_error "Required tool 'required_tool' not found"
        return 1
    fi
    
    return 0
}

perform_critical_operation() {
    log_info "Performing critical operation..."
    
    local result
    result=$(some_command 2>&1)
    
    if [[ $? -ne 0 ]]; then
        log_error "Command failed: $result"
        return 1
    fi
    
    log_info "Operation completed successfully"
    return 0
}

main "$@"
```

**Output:**
```
╔════════════════════════════════════════════════════════════════╗
║              APPLICATION LOG - Session 20251019_211905         ║
╚════════════════════════════════════════════════════════════════╝

[2025-10-19 21:19:05.123] [INFO ] Application started
  └─ Function: main
  └─ PID: 12345

[2025-10-19 21:19:05.145] [DEBUG] Debugging information
  └─ Function: main
  └─ Line: 15

[2025-10-19 21:19:05.167] [DEBUG] Checking prerequisites...
  └─ Function: check_prerequisites
  └─ Called from: main

[2025-10-19 21:19:05.189] [WARN ] Config file missing, using defaults
  └─ Function: check_prerequisites
  └─ File: config.yaml
  └─ Action: Using default configuration

[2025-10-19 21:19:05.211] [INFO ] All checks passed
  └─ Function: main

[2025-10-19 21:19:05.233] [INFO ] Performing critical operation...
  └─ Function: perform_critical_operation
  └─ Operation: some_command

[2025-10-19 21:19:05.456] [INFO ] Operation completed successfully
  └─ Function: perform_critical_operation
  └─ Duration: 0.223s

[2025-10-19 21:19:05.478] [INFO ] Application completed successfully
  └─ Function: main
  └─ Total runtime: 0.355s

╔════════════════════════════════════════════════════════════════╗
║                     SESSION SUMMARY                            ║
╚════════════════════════════════════════════════════════════════╝

Log Statistics:
  Total entries: 9
  DEBUG: 2
  INFO: 5
  WARN: 1
  ERROR: 0
  FATAL: 0

Session duration: 0.355 seconds
Exit code: 0 (success)

Log file: /var/log/myapp.log
Session ID: 20251019_211905
```

**Logger implementation structure:**
```bash
#!/bin/bash
#
# logger.sh - Professional logging library for Bash
#

# Configuration
LOG_LEVEL="${LOG_LEVEL:-INFO}"
LOG_FILE="${LOG_FILE:-}"
LOG_TO_CONSOLE="${LOG_TO_CONSOLE:-true}"
LOG_TO_FILE="${LOG_TO_FILE:-false}"
LOG_COLORS="${LOG_COLORS:-true}"
LOG_TIMESTAMP_FORMAT="${LOG_TIMESTAMP_FORMAT:-%Y-%m-%d %H:%M:%S}"
LOG_SESSION_ID="$(date +%Y%m%d_%H%M%S)"

# Log levels
declare -A LOG_LEVELS=(
    [DEBUG]=0
    [INFO]=1
    [WARN]=2
    [ERROR]=3
    [FATAL]=4
)

# Colors
if [[ "$LOG_COLORS" == "true" ]]; then
    readonly COLOR_DEBUG='\033[0;36m'   # Cyan
    readonly COLOR_INFO='\033[0;32m'    # Green
    readonly COLOR_WARN='\033[1;33m'    # Yellow
    readonly COLOR_ERROR='\033[0;31m'   # Red
    readonly COLOR_FATAL='\033[1;31m'   # Bold Red
    readonly COLOR_RESET='\033[0m'
else
    readonly COLOR_DEBUG=''
    readonly COLOR_INFO=''
    readonly COLOR_WARN=''
    readonly COLOR_ERROR=''
    readonly COLOR_FATAL=''
    readonly COLOR_RESET=''
fi

# Initialize logging system
log_init() {
    if [[ -n "$LOG_FILE" && "$LOG_TO_FILE" == "true" ]]; then
        # Create log directory if needed
        local log_dir
        log_dir=$(dirname "$LOG_FILE")
        mkdir -p "$log_dir"
        
        # Initialize log file with header
        {
            echo "========================================="
            echo "Log Session Started: $(date)"
            echo "Session ID: $LOG_SESSION_ID"
            echo "========================================="
        } >> "$LOG_FILE"
    fi
}

# Set log level
log_set_level() {
    LOG_LEVEL="$1"
}

# Set log file
log_set_file() {
    LOG_FILE="$1"
    LOG_TO_FILE=true
}

# Enable/disable colors
log_enable_colors() {
    LOG_COLORS="$1"
}

# Core logging function
_log() {
    local level=$1
    shift
    local message="$*"
    
    # Check if this level should be logged
    if [[ ${LOG_LEVELS[$level]} -lt ${LOG_LEVELS[$LOG_LEVEL]} ]]; then
        return 0
    fi
    
    # Get caller information
    local caller_func="${FUNCNAME[2]}"
    local caller_line="${BASH_LINENO[1]}"
    
    # Format timestamp
    local timestamp
    timestamp=$(date +"$LOG_TIMESTAMP_FORMAT")
    
    # Select color
    local color
    case $level in
        DEBUG) color=$COLOR_DEBUG ;;
        INFO)  color=$COLOR_INFO ;;
        WARN)  color=$COLOR_WARN ;;
        ERROR) color=$COLOR_ERROR ;;
        FATAL) color=$COLOR_FATAL ;;
    esac
    
    # Format log entry
    local log_entry
    log_entry=$(printf "[%s] [%-5s] %s" "$timestamp" "$level" "$message")
    
    # Console output
    if [[ "$LOG_TO_CONSOLE" == "true" ]]; then
        if [[ "$LOG_COLORS" == "true" ]]; then
            echo -e "${color}${log_entry}${COLOR_RESET}"
        else
            echo "$log_entry"
        fi
        
        # Add caller info for errors
        if [[ "$level" == "ERROR" || "$level" == "FATAL" ]]; then
            echo "  ↳ Location: $caller_func() at line $caller_line"
        fi
    fi
    
    # File output
    if [[ "$LOG_TO_FILE" == "true" && -n "$LOG_FILE" ]]; then
        echo "$log_entry" >> "$LOG_FILE"
        if [[ "$level" == "ERROR" || "$level" == "FATAL" ]]; then
            echo "  ↳ Location: $caller_func() at line $caller_line" >> "$LOG_FILE"
        fi
    fi
    
    # Handle FATAL level
    if [[ "$level" == "FATAL" ]]; then
        echo ""
        echo "FATAL ERROR - Application terminated"
        log_cleanup
        exit 1
    fi
}

# Public logging functions
log_debug() { _log "DEBUG" "$@"; }
log_info()  { _log "INFO" "$@"; }
log_warn()  { _log "WARN" "$@"; }
log_error() { _log "ERROR" "$@"; }
log_fatal() { _log "FATAL" "$@"; }

# Cleanup function
log_cleanup() {
    if [[ "$LOG_TO_FILE" == "true" && -n "$LOG_FILE" ]]; then
        {
            echo "========================================="
            echo "Log Session Ended: $(date)"
            echo "========================================="
        } >> "$LOG_FILE"
    fi
}

# Export functions
export -f log_init
export -f log_set_level
export -f log_set_file
export -f log_enable_colors
export -f log_debug
export -f log_info
export -f log_warn
export -f log_error
export -f log_fatal
```
### Bonus Challenges:
**Level 1 (Intermediate):**
- Add log rotation by size/date
- Implement log compression
- Add context managers (start/end blocks)
- Support structured logging (key-value pairs)
- Add performance metrics logging
- Create log viewer utility
- Add remote logging (syslog)
- Support multiple log files simultaneously

**Level 2 (Advanced):**
- Implement log aggregation
- Add log streaming (tail -f like)
- Create log analysis tools
- Add alerting thresholds
- Implement log sampling (for high-volume)
- Add correlation IDs for request tracking
- Create log dashboard
- Support log encryption

**Level 3 (Expert):**
- Distributed logging system
- ELK stack integration
- Machine learning for anomaly detection
- Real-time log analysis
- Log-based metrics
- Full observability suite
- APM integration
- Compliance logging (GDPR, HIPAA)
