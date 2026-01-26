- [ ] # System Information Dashboard

## Goal:
Create a comprehensive system information dashboard script named `sysinfo_dashboard.sh` that displays detailed system metrics in an attractive, formatted layout.

***
## Requirements:

### System Information to Display:
**1. System Overview:**
- Operating system name and version
- Kernel version
- Hostname
- System uptime
- Current date and time
- System architecture (32-bit/64-bit)
- Number of CPU cores

**2. Memory Information:**
- Total RAM
- Used RAM
- Free RAM
- Memory usage percentage
- Swap total and used

**3. Disk Space:**
- All mounted filesystems
- Total, used, and available space for each
- Usage percentage
- Highlight filesystems above 80% usage

**4. CPU Information:**
- CPU model/name
- Number of cores
- Current CPU usage percentage
- Load averages (1, 5, 15 minutes)

**5. User Information:**
- Currently logged-in users
- Number of active sessions
- Current user and shell

**6. Network Information:**
- Active network interfaces
- IP addresses (internal)
- Network status (up/down)

**7. Process Information:**
- Top 5 processes by CPU usage
- Top 5 processes by memory usage
- Total number of running processes

***
### Technical Requirements:
**Must use concepts from Week 1:**
- Variables for storing all data
- Arrays for lists (filesystems, users, processes)
- Arithmetic operations for:
  - Percentage calculations
  - Unit conversions (bytes to GB/MB)
  - Average calculations
- String operations for:
  - Formatting output
  - Extracting information from command output
  - Creating visual elements (boxes, bars)

**Code quality:**
- Proper shebang line
- Well-organized sections with comments
- Functions for repeated operations (optional but recommended)
- Clear variable names
- Efficient command usage

**Output formatting:**
- Use box-drawing characters or ASCII art for visual appeal
- Align data in columns
- Color-coding for different sections (optional bonus)
- Progress bars or visual indicators for percentages
- Clear section headers
- Consistent spacing and indentation

***
### Hints:

**System information commands:**
- `uname -a` - System information
- `hostname` - Hostname
- `uptime` - System uptime and load
- `free -h` - Memory information (Linux) or `vm_stat` (macOS)
- `df -h` - Disk space
- `who` - Logged-in users
- `ps aux` - Process information
- `top -bn1` or `ps` - CPU/memory usage
- `ifconfig` or `ip addr` - Network interfaces
- `nproc` - Number of CPU cores (Linux)
- `sysctl -n hw.ncpu` - Number of cores (macOS)

**Useful techniques:**
- Use command substitution: `variable=$(command)`
- Parse command output with `awk`, `grep`, `cut`, `sed`
- Calculate percentages: `$((used * 100 / total))`
- Create visual bars: Use repeated characters based on percentage
- Format numbers: Use `printf` for aligned columns

**Cross-platform considerations:**
- Detect OS with `uname` and adjust commands accordingly
- Linux uses different commands than macOS for some metrics
- Test which commands are available before using them

***

### Pseudocode:
``` bash
#!/bin/bash
#
# Script: sysinfo_dashboard.sh
# Author: [Student Name]
# Date: January 19, 2026
# Description: Comprehensive system information dashboard
# Usage: ./sysinfo_dashboard.sh [--simple|--export|--help]
#

# ============================================================================
# SECTION 1: INITIALIZATION AND SETUP
# ============================================================================

# Set script options for error handling
SET errexit option (exit on error)
SET nounset option (exit on undefined variable)
SET pipefail option (catch errors in pipes)

# Define global variables for formatting
DECLARE script_start_time = current timestamp
DECLARE box_width = 64
DECLARE bar_length = 20

# Box drawing characters (UTF-8)
DECLARE top_left = "┌"
DECLARE top_right = "┐"
DECLARE bottom_left = "└"
DECLARE bottom_right = "┘"
DECLARE horizontal = "─"
DECLARE vertical = "│"
DECLARE left_tee = "├"
DECLARE right_tee = "┤"

# Progress bar characters
DECLARE filled_char = "█"
DECLARE empty_char = "░"

# ============================================================================
# SECTION 2: HELPER FUNCTIONS
# ============================================================================

FUNCTION print_header():
    # Prints top border with title
    PRINT double-line box top border
    PRINT "║" + centered text "SYSTEM INFORMATION DASHBOARD" + "║"
    PRINT centered timestamp
    PRINT double-line box bottom border
    PRINT empty line
END FUNCTION

FUNCTION print_box_top():
    # Creates top border of section box
    PRINT top_left + (horizontal × box_width-2) + top_right
END FUNCTION

FUNCTION print_box_divider():
    # Creates middle divider line
    PRINT left_tee + (horizontal × box_width-2) + right_tee
END FUNCTION

FUNCTION print_box_bottom():
    # Creates bottom border
    PRINT bottom_left + (horizontal × box_width-2) + bottom_right
END FUNCTION

FUNCTION print_box_line(label, value):
    # Prints formatted line inside box with proper padding
    CALCULATE padding_needed = box_width - length(label) - length(value) - 4
    PRINT vertical + " " + label + ":" + (spaces × padding) + value + " " + vertical
END FUNCTION

FUNCTION create_progress_bar(percentage):
    # Creates visual progress bar based on percentage
    # INPUT: percentage (0-100)
    # OUTPUT: string with filled/empty characters
    
    CALCULATE filled_blocks = (percentage × bar_length) / 100
    CALCULATE empty_blocks = bar_length - filled_blocks
    
    DECLARE bar_string = ""
    FOR i FROM 1 TO filled_blocks:
        bar_string = bar_string + filled_char
    END FOR
    
    FOR i FROM 1 TO empty_blocks:
        bar_string = bar_string + empty_char
    END FOR
    
    RETURN "[" + bar_string + "]"
END FUNCTION

FUNCTION bytes_to_gb(bytes):
    # Converts bytes to gigabytes with 2 decimal places
    # INPUT: bytes as integer
    # OUTPUT: formatted string "X.XX GB"
    
    DECLARE gb_value = bytes / (1024 × 1024 × 1024)
    RETURN printf format "%.2f GB" with gb_value
END FUNCTION

FUNCTION calculate_percentage(used, total):
    # Calculates percentage and returns as integer
    # INPUT: used amount, total amount
    # OUTPUT: percentage (0-100)
    
    IF total equals 0:
        RETURN 0
    END IF
    
    DECLARE percentage = (used × 100) / total
    RETURN percentage
END FUNCTION

FUNCTION format_uptime(uptime_seconds):
    # Converts uptime seconds to human-readable format
    # INPUT: uptime in seconds
    # OUTPUT: "X days, Y hours, Z minutes"
    
    DECLARE days = uptime_seconds / 86400
    DECLARE remaining = uptime_seconds % 86400
    DECLARE hours = remaining / 3600
    DECLARE remaining = remaining % 3600
    DECLARE minutes = remaining / 60
    
    RETURN formatted string "days days, hours hours, minutes minutes"
END FUNCTION

# ============================================================================
# SECTION 3: DATA COLLECTION FUNCTIONS
# ============================================================================

FUNCTION gather_system_info():
    # Collects operating system and kernel information
    
    # Detect OS type for platform-specific commands
    DECLARE os_type = EXECUTE(uname -s)
    
    # Get OS information
    IF os_type contains "Linux":
        IF file /etc/os-release exists:
            DECLARE os_name = EXTRACT from /etc/os-release (NAME field)
            DECLARE os_version = EXTRACT from /etc/os-release (VERSION field)
        ELSE:
            DECLARE os_name = "Linux"
            DECLARE os_version = "Unknown"
        END IF
    ELSE IF os_type contains "Darwin":
        DECLARE os_name = "macOS"
        DECLARE os_version = EXECUTE(sw_vers -productVersion)
    END IF
    
    # Get kernel version
    DECLARE kernel_version = EXECUTE(uname -r)
    
    # Get hostname
    DECLARE hostname = EXECUTE(hostname)
    
    # Get architecture
    DECLARE architecture = EXECUTE(uname -m)
    
    # Get CPU cores count
    IF os_type contains "Linux":
        DECLARE cpu_cores = EXECUTE(nproc)
    ELSE IF os_type contains "Darwin":
        DECLARE cpu_cores = EXECUTE(sysctl -n hw.ncpu)
    END IF
    
    # Get uptime
    DECLARE uptime_raw = EXECUTE(uptime)
    EXTRACT uptime_seconds from uptime_raw using string operations
    DECLARE formatted_uptime = CALL format_uptime(uptime_seconds)
    
    # Get current date/time
    DECLARE current_datetime = EXECUTE(date "+%Y-%m-%d %H:%M:%S")
    
    # Store in associative array or individual variables
    DECLARE system_os = os_name + " " + os_version
    DECLARE system_kernel = kernel_version
    DECLARE system_hostname = hostname
    DECLARE system_uptime = formatted_uptime
    DECLARE system_arch = architecture
    DECLARE system_cores = cpu_cores
END FUNCTION

FUNCTION gather_memory_info():
    # Collects memory and swap information
    
    DECLARE os_type = EXECUTE(uname -s)
    
    IF os_type contains "Linux":
        # Use free command for Linux
        DECLARE mem_output = EXECUTE(free -b)
        
        # Parse total, used, free RAM from output
        # Using awk/grep/cut to extract values
        DECLARE mem_total = EXTRACT total memory from mem_output (line 2, column 2)
        DECLARE mem_used = EXTRACT used memory from mem_output (line 2, column 3)
        DECLARE mem_free = EXTRACT free memory from mem_output (line 2, column 4)
        
        # Parse swap information
        DECLARE swap_total = EXTRACT swap total from mem_output (line 3, column 2)
        DECLARE swap_used = EXTRACT swap used from mem_output (line 3, column 3)
        DECLARE swap_free = EXTRACT swap free from mem_output (line 3, column 4)
        
    ELSE IF os_type contains "Darwin":
        # Use vm_stat for macOS
        DECLARE vm_output = EXECUTE(vm_stat)
        
        # Extract page size and counts, convert to bytes
        EXTRACT page_size, free_pages, active_pages, etc.
        CALCULATE memory values in bytes
    END IF
    
    # Convert to human-readable format
    DECLARE mem_total_gb = CALL bytes_to_gb(mem_total)
    DECLARE mem_used_gb = CALL bytes_to_gb(mem_used)
    DECLARE mem_free_gb = CALL bytes_to_gb(mem_free)
    
    # Calculate percentage
    DECLARE mem_percentage = CALL calculate_percentage(mem_used, mem_total)
    
    # Convert swap to GB
    DECLARE swap_total_gb = CALL bytes_to_gb(swap_total)
    DECLARE swap_used_gb = CALL bytes_to_gb(swap_used)
    DECLARE swap_free_gb = CALL bytes_to_gb(swap_free)
END FUNCTION

FUNCTION gather_disk_info():
    # Collects disk/filesystem information
    
    # Get disk information (df -h for human-readable, but parse df -k for calculations)
    DECLARE disk_output = EXECUTE(df -k)
    
    # Initialize arrays for disk data
    DECLARE filesystem_array = empty array
    DECLARE size_array = empty array
    DECLARE used_array = empty array
    DECLARE avail_array = empty array
    DECLARE percent_array = empty array
    
    # Initialize alert array for disks over 80%
    DECLARE disk_alerts = empty array
    
    # Parse df output line by line (skip header)
    FOR each line in disk_output (starting from line 2):
        # Extract fields using awk or read
        EXTRACT filesystem, size_kb, used_kb, avail_kb, use_percent, mountpoint
        
        # Filter out unwanted filesystems (tmpfs, devtmpfs, etc.)
        IF filesystem starts with "/dev/":
            # Convert kilobytes to human-readable
            DECLARE size_gb = size_kb / (1024 × 1024)
            DECLARE used_gb = used_kb / (1024 × 1024)
            DECLARE avail_gb = avail_kb / (1024 × 1024)
            
            # Store in arrays
            ADD filesystem to filesystem_array
            ADD size_gb to size_array
            ADD used_gb to used_array
            ADD avail_gb to avail_array
            
            # Extract percentage (remove % sign)
            DECLARE percent_value = REMOVE "%" from use_percent
            ADD percent_value to percent_array
            
            # Check if over 80% usage
            IF percent_value > 80:
                ADD "WARNING: " + filesystem + " is " + percent_value + "% full" to disk_alerts
            END IF
        END IF
    END FOR
END FUNCTION

FUNCTION gather_cpu_info():
    # Collects CPU model and usage information
    
    DECLARE os_type = EXECUTE(uname -s)
    
    IF os_type contains "Linux":
        # Get CPU model from /proc/cpuinfo
        DECLARE cpu_model = EXECUTE(grep "model name" /proc/cpuinfo | head -n1)
        # Extract just the model string (remove "model name :")
        cpu_model = EXTRACT text after ":" using cut/sed/awk
        
        # Get CPU usage
        # Method 1: Use top command
        DECLARE cpu_usage = EXECUTE(top -bn1 | grep "Cpu(s)")
        # Extract idle percentage and calculate usage = 100 - idle
        EXTRACT idle_percent from cpu_usage
        DECLARE cpu_percent = 100 - idle_percent
        
        # Get load averages
        DECLARE load_output = EXECUTE(uptime)
        EXTRACT load_1min, load_5min, load_15min from load_output
        
    ELSE IF os_type contains "Darwin":
        # macOS CPU information
        DECLARE cpu_model = EXECUTE(sysctl -n machdep.cpu.brand_string)
        
        # CPU usage calculation for macOS
        DECLARE top_output = EXECUTE(top -l 1 | grep "CPU usage")
        EXTRACT cpu_percent from top_output
        
        # Load averages
        DECLARE load_output = EXECUTE(sysctl -n vm.loadavg)
        EXTRACT load values
    END IF
    
    # Number of cores (already got this in system info, reuse)
    DECLARE cpu_cores = system_cores
END FUNCTION

FUNCTION gather_user_info():
    # Collects logged-in user information
    
    # Get current user
    DECLARE current_user = EXECUTE(whoami)
    
    # Get current shell
    DECLARE current_shell = READ from environment variable $SHELL
    
    # Get all logged-in users
    DECLARE who_output = EXECUTE(who)
    
    # Initialize arrays for user data
    DECLARE user_names = empty array
    DECLARE user_terminals = empty array
    DECLARE user_times = empty array
    
    # Count total sessions
    DECLARE session_count = 0
    
    # Parse who output
    FOR each line in who_output:
        EXTRACT username, terminal, login_time from line
        
        ADD username to user_names
        ADD terminal to user_terminals
        ADD login_time to user_times
        
        INCREMENT session_count
    END FOR
END FUNCTION

FUNCTION gather_network_info():
    # Collects network interface information
    
    DECLARE os_type = EXECUTE(uname -s)
    
    # Initialize arrays
    DECLARE interface_names = empty array
    DECLARE interface_ips = empty array
    DECLARE interface_status = empty array
    
    IF os_type contains "Linux":
        # Option 1: Use ip command (modern)
        IF command "ip" exists:
            DECLARE ip_output = EXECUTE(ip -brief addr)
            
            FOR each line in ip_output:
                EXTRACT interface, status, ip_address
                
                ADD interface to interface_names
                ADD status to interface_status
                ADD ip_address to interface_ips
            END FOR
            
        # Option 2: Use ifconfig (fallback)
        ELSE IF command "ifconfig" exists:
            DECLARE ifconfig_output = EXECUTE(ifconfig)
            
            # Parse ifconfig output (more complex)
            FOR each interface block:
                EXTRACT interface name
                EXTRACT IP address from "inet" line
                DETERMINE status from flags (UP/DOWN)
                
                ADD to respective arrays
            END FOR
        END IF
        
    ELSE IF os_type contains "Darwin":
        # macOS uses ifconfig
        DECLARE ifconfig_output = EXECUTE(ifconfig)
        # Similar parsing as above
    END IF
END FUNCTION

FUNCTION gather_process_info():
    # Collects top processes by CPU and memory
    
    # Initialize arrays for top CPU processes
    DECLARE top_cpu_pids = empty array
    DECLARE top_cpu_percentages = empty array
    DECLARE top_cpu_commands = empty array
    
    # Initialize arrays for top memory processes
    DECLARE top_mem_pids = empty array
    DECLARE top_mem_percentages = empty array
    DECLARE top_mem_commands = empty array
    
    # Get top 5 processes by CPU
    DECLARE cpu_procs = EXECUTE(ps aux --sort=-%cpu | head -n 6)
    # Skip header, take next 5 lines
    
    FOR each line in cpu_procs (skip first line):
        EXTRACT pid, cpu_percent, command using awk
        
        # Truncate long commands
        IF length(command) > 40:
            command = first 40 characters + "..."
        END IF
        
        ADD pid to top_cpu_pids
        ADD cpu_percent to top_cpu_percentages
        ADD command to top_cpu_commands
    END FOR
    
    # Get top 5 processes by memory
    DECLARE mem_procs = EXECUTE(ps aux --sort=-%mem | head -n 6)
    
    FOR each line in mem_procs (skip first line):
        EXTRACT pid, mem_percent, command using awk
        
        # Truncate long commands
        IF length(command) > 40:
            command = first 40 characters + "..."
        END IF
        
        ADD pid to top_mem_pids
        ADD mem_percent to top_mem_percentages
        ADD command to top_mem_commands
    END FOR
    
    # Get total process count
    DECLARE total_processes = EXECUTE(ps aux | wc -l) - 1  # Subtract header
END FUNCTION

# ============================================================================
# SECTION 4: DISPLAY FUNCTIONS
# ============================================================================

FUNCTION display_system_overview():
    # Displays system information section
    
    CALL print_box_top()
    PRINT vertical + " SYSTEM OVERVIEW" + (padding) + vertical
    CALL print_box_divider()
    
    CALL print_box_line("OS", system_os)
    CALL print_box_line("Kernel", system_kernel)
    CALL print_box_line("Architecture", system_arch)
    CALL print_box_line("Hostname", system_hostname)
    CALL print_box_line("Uptime", system_uptime)
    CALL print_box_line("CPU Cores", system_cores)
    
    CALL print_box_bottom()
    PRINT empty line
END FUNCTION

FUNCTION display_memory_usage():
    # Displays memory information with progress bar
    
    CALL print_box_top()
    PRINT vertical + " MEMORY USAGE" + (padding) + vertical
    CALL print_box_divider()
    
    CALL print_box_line("Total RAM", mem_total_gb)
    CALL print_box_line("Used RAM", mem_used_gb)
    CALL print_box_line("Free RAM", mem_free_gb)
    
    # Create progress bar for memory usage
    DECLARE mem_bar = CALL create_progress_bar(mem_percentage)
    DECLARE usage_line = printf format "%5.2f%%" with mem_percentage
    CALL print_box_line("Usage", usage_line + " " + mem_bar)
    
    PRINT vertical + (spaces × box_width-2) + vertical
    CALL print_box_line("Swap Total", swap_total_gb)
    CALL print_box_line("Swap Used", swap_used_gb)
    CALL print_box_line("Swap Free", swap_free_gb)
    
    CALL print_box_bottom()
    PRINT empty line
END FUNCTION

FUNCTION display_disk_space():
    # Displays disk space with visual bars
    
    CALL print_box_top()
    PRINT vertical + " DISK SPACE" + (padding) + vertical
    CALL print_box_divider()
    
    # Print table header
    DECLARE header = printf format "%-15s %6s %6s %6s %5s" with "Filesystem", "Size", "Used", "Avail", "Use%"
    PRINT vertical + " " + header + (padding) + vertical
    
    # Loop through filesystem arrays
    FOR i FROM 0 TO length(filesystem_array) - 1:
        DECLARE fs = filesystem_array[i]
        DECLARE size = printf format "%.0fGB" with size_array[i]
        DECLARE used = printf format "%.0fGB" with used_array[i]
        DECLARE avail = printf format "%.0fGB" with avail_array[i]
        DECLARE percent = percent_array[i]
        
        # Create progress bar
        DECLARE disk_bar = CALL create_progress_bar(percent)
        
        # Format line
        DECLARE disk_line = printf format "%-15s %6s %6s %6s %4d%%" 
                           with fs, size, used, avail, percent
        PRINT vertical + " " + disk_line + " " + disk_bar + " " + vertical
    END
```

***
### Expected Output Example:

```bash
./sysinfo_dashboard.sh
```

```
╔════════════════════════════════════════════════════════════════╗
║              SYSTEM INFORMATION DASHBOARD                      ║
║                  Generated: 2025-10-18 13:50:22                ║
╚════════════════════════════════════════════════════════════════╝

┌────────────────────────────────────────────────────────────────┐
│ SYSTEM OVERVIEW                                                │
├────────────────────────────────────────────────────────────────┤
│ OS:           Linux (Ubuntu 22.04.3 LTS)                       │
│ Kernel:       5.15.0-91-generic                                │
│ Architecture: x86_64                                           │
│ Hostname:     myserver                                         │
│ Uptime:       3 days, 14 hours, 23 minutes                     │
│ CPU Cores:    8                                                │
└────────────────────────────────────────────────────────────────┘

┌────────────────────────────────────────────────────────────────┐
│ MEMORY USAGE                                                   │
├────────────────────────────────────────────────────────────────┤
│ Total RAM:    16.00 GB                                         │
│ Used RAM:     8.45 GB                                          │
│ Free RAM:     7.55 GB                                          │
│ Usage:        52.81% [██████████░░░░░░░░░░]                    │
│                                                                │
│ Swap Total:   4.00 GB                                          │
│ Swap Used:    0.23 GB                                          │
│ Swap Free:    3.77 GB                                          │
└────────────────────────────────────────────────────────────────┘

┌────────────────────────────────────────────────────────────────┐
│ DISK SPACE                                                     │
├────────────────────────────────────────────────────────────────┤
│ Filesystem      Size    Used   Avail   Use%                    │
│ /dev/sda1       50GB    35GB   13GB    73% [██████████████░░░] │
│ /dev/sda2       100GB   82GB   15GB    85% [█████████████████] │
│ /dev/sdb1       500GB   125GB  350GB   25% [█████░░░░░░░░░░░░] │
│                                                                │
│ WARNING: /dev/sda2 is 85% full                                 │
└────────────────────────────────────────────────────────────────┘

┌────────────────────────────────────────────────────────────────┐
│ CPU INFORMATION                                                │
├────────────────────────────────────────────────────────────────┤
│ Model:        Intel(R) Core(TM) i7-9700K @ 3.60GHz             │
│ Cores:        8                                                │
│ Usage:        23.5% [████░░░░░░░░░░░░░░░░]                     │
│                                                                │
│ Load Averages:                                                 │
│   1 min:      1.45                                             │
│   5 min:      1.23                                             │
│   15 min:     0.98                                             │
└────────────────────────────────────────────────────────────────┘

┌────────────────────────────────────────────────────────────────┐
│ USER SESSIONS                                                  │
├────────────────────────────────────────────────────────────────┤
│ Current User: john                                             │
│ Shell:        /bin/bash                                        │
│                                                                │
│ Logged in users (3):                                           │
│   • john     (tty1)     - since 10:30                          │
│   • admin    (pts/0)    - since 12:15                          │
│   • john     (pts/1)    - since 13:00                          │
└────────────────────────────────────────────────────────────────┘

┌────────────────────────────────────────────────────────────────┐
│ NETWORK INTERFACES                                             │
├────────────────────────────────────────────────────────────────┤
│ Interface    Status    IP Address                              │
│ eth0         UP        192.168.1.100                           │
│ wlan0        DOWN      N/A                                     │
│ lo           UP        127.0.0.1                               │
└────────────────────────────────────────────────────────────────┘

┌────────────────────────────────────────────────────────────────┐
│ TOP PROCESSES BY CPU                                           │
├────────────────────────────────────────────────────────────────┤
│ PID     CPU%   Command                                         │
│ 1234    12.5   /usr/bin/python3 script.py                      │
│ 5678    8.3    /usr/lib/firefox/firefox                        │
│ 9012    5.1    /usr/bin/node server.js                         │
│ 3456    3.2    /usr/sbin/apache2                               │
│ 7890    2.8    /usr/bin/docker                                 │
└────────────────────────────────────────────────────────────────┘

┌────────────────────────────────────────────────────────────────┐
│ TOP PROCESSES BY MEMORY                                        │
├────────────────────────────────────────────────────────────────┤
│ PID     MEM%   Command                                         │
│ 5678    15.3   /usr/lib/firefox/firefox                        │
│ 1234    8.7    /usr/bin/python3 script.py                      │
│ 9012    6.2    /usr/bin/node server.js                         │
│ 2345    4.5    /usr/bin/mysql                                  │
│ 6789    3.8    /usr/lib/chrome/chrome                          │
└────────────────────────────────────────────────────────────────┘

┌────────────────────────────────────────────────────────────────┐
│ SUMMARY                                                        │
├────────────────────────────────────────────────────────────────┤
│ Total Processes:     287                                       │
│ System Health:       GOOD                                      │
│ Alerts:              1 (Disk /dev/sda2 at 85%)                 │
│                                                                │
│ Dashboard generated in: 0.234 seconds                          │
└────────────────────────────────────────────────────────────────┘

╔════════════════════════════════════════════════════════════════╗
║  Use './sysinfo_dashboard.sh --help' for options               ║
╚════════════════════════════════════════════════════════════════╝
```

***
## Bonus Challenges:

### Level 1 (Intermediate):
- Add command-line options:
  - `--simple` - Show simplified output
  - `--export` - Save output to file
  - `--refresh N` - Auto-refresh every N seconds
  - `--section NAME` - Show only specific section
- Color-code warnings (yellow) and critical alerts (red)
- Add temperature monitoring (CPU, GPU if available)
- Show battery status on laptops
- Add timestamp to each section
- Create compact one-line mode for quick checks
### Level 2 (Advanced):
- Add historical tracking:
  - Compare with previous run
  - Show trends (▲ increased, ▼ decreased, ─ stable)
  - Store metrics in file for comparison
- Create alerts for:
  - Disk space above threshold
  - Memory usage above threshold
  - High CPU load
  - Failed services
- Add system health score (0-100)
- Generate HTML output version
- Email report capability
- Create comparison mode (side-by-side with previous report)
### Level 3 (Expert):
- Add interactive mode with keyboard navigation
- Real-time updating dashboard (like `htop`)
- Graph generation (ASCII charts for trends)
- Integration with system monitoring tools
- Remote system monitoring (SSH into other machines)
- Docker container monitoring
- Service status checking (systemd services)
- Log analysis integration (check for errors)
- Customizable layouts via config file
- Export to JSON/CSV for external processing
- Web interface (serve via simple HTTP server)

***
## Validation Checklist:
Before submitting, ensure your script:
- [ ] Runs without errors on your system
- [ ] Uses variables for all data storage
- [ ] Uses arrays for list data (filesystems, users, processes)
- [ ] Performs arithmetic operations (percentages, conversions)
- [ ] Uses string operations (formatting, extraction)
- [ ] Has proper error handling (commands that might fail)
- [ ] Works with limited permissions (no root required)
- [ ] Has clean, readable output
- [ ] Includes comments explaining complex sections
- [ ] Uses meaningful variable names
- [ ] Has consistent formatting throughout
- [ ] Includes script name and purpose at top
- [ ] Handles edge cases (no users logged in, no swap, etc.)

***
## Submission Format:
Your script should:
1. Start with proper shebang and header comment block
2. Include author name and date
3. Include brief description of functionality
4. Have clear section markers in code
5. Include usage instructions if options are supported

**Example header:**
```bash
#!/bin/bash
#
# Script: sysinfo_dashboard.sh
# Author: Your Name
# Date: October 18, 2025
#
# Description: Comprehensive system information dashboard that displays
#              OS details, memory usage, disk space, CPU info, users,
#              network interfaces, and top processes in a formatted layout.
#
# Usage: ./sysinfo_dashboard.sh [options]
#        Options:
#          --simple    Show simplified output
#          --export    Save to file
#          --help      Show this help message
#
```

***