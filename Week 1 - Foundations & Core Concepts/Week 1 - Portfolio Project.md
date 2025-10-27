# System Information Dashboard

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