### Goal:
Create a script named `menu.sh` that displays an interactive menu with four functional options.
### Requirements:
- Display a clear menu with 4 numbered options plus exit option
- Use case statement to handle user selection
- Each option should perform a meaningful action:
  1. Display system information
  2. Show disk usage
  3. List running processes (top 10 by memory)
  4. Show current date and time
  5. Exit
- Loop menu until user chooses to exit
- Handle invalid input with error message
- Clear screen between menu displays (optional)
### Hints:
- Use `while true` for infinite loop
- Use `read -p` to get user input
- Use `case` statement for option handling
- Use `break` to exit loop
- Common commands: `uname`, `df -h`, `ps aux`, `date`
- Consider using `read -p "Press Enter to continue..."` after each action
### Expected Output Example:
```bash
./menu.sh
```

```
╔════════════════════════════════════════╗
║         SYSTEM UTILITIES MENU          ║
╚════════════════════════════════════════╝

[1] System Information
[2] Disk Usage
[3] Top Processes (by memory)
[4] Current Date/Time
[0] Exit

Select option: 1

═══════════════════════════════════════════
System Information:
═══════════════════════════════════════════
OS: Linux
Kernel: 5.15.0-91-generic
Hostname: myserver
Uptime: 3 days, 15 hours
CPU Cores: 8
Architecture: x86_64

Press Enter to continue...

╔════════════════════════════════════════╗
║         SYSTEM UTILITIES MENU          ║
╚════════════════════════════════════════╝

[1] System Information
[2] Disk Usage
[3] Top Processes (by memory)
[4] Current Date/Time
[0] Exit

Select option: 2

═══════════════════════════════════════════
Disk Usage:
═══════════════════════════════════════════
Filesystem      Size  Used Avail Use%
/dev/sda1        50G   35G   13G  73%
/dev/sda2       100G   82G   15G  85%

Press Enter to continue...

╔════════════════════════════════════════╗
║         SYSTEM UTILITIES MENU          ║
╚════════════════════════════════════════╝

[1] System Information
[2] Disk Usage
[3] Top Processes (by memory)
[4] Current Date/Time
[0] Exit

Select option: 9

✗ Invalid option. Please select 0-4.

Press Enter to continue...

╔════════════════════════════════════════╗
║         SYSTEM UTILITIES MENU          ║
╚════════════════════════════════════════╝

[1] System Information
[2] Disk Usage
[3] Top Processes (by memory)
[4] Current Date/Time
[0] Exit

Select option: 0

Exiting... Goodbye!
```
### Bonus Challenge:
- Add sub-menus for more options
- Add color coding to menu
- Save output to log file option
- Add more utility functions (network info, memory usage, etc.)
- Implement keyboard shortcuts (press number without Enter)
- Add command history (show last executed option)

***
