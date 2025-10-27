### Goal:
Create a script named `menu_system.sh` that implements a robust menu-driven interface using an until loop.
### Requirements:
- Use `until` loop to keep showing menu until user quits
- Implement at least 6 menu options plus exit
- Each option performs a useful function:
  1. System information
  2. File operations
  3. Process management
  4. Network tools
  5. User management
  6. Utilities
  7. Exit
- Validate user input
- Handle invalid selections gracefully
- Add sub-menus for complex operations
- Show "Press Enter to continue" after each action
- Clear screen between menu displays
- Track user's menu history
### Hints:
- Structure: `until [[ "$choice" == "0" ]]; do ... done`
- Read input: `read -p "Select option: " choice`
- Case statement for options
- Clear screen: `clear` or `printf '\033[2J\033[H'`
- Pause: `read -p "Press Enter to continue..." -r`
### Expected Output Example:
```bash
./menu_system.sh
```

```
╔════════════════════════════════════════╗
║       SYSTEM MANAGEMENT MENU           ║
║            v1.0.0                      ║
╚════════════════════════════════════════╝

[1] System Information
[2] File Operations
[3] Process Management
[4] Network Tools
[5] User Management
[6] Utilities
[0] Exit

Select option (0-6): 1

═══════════════════════════════════════════
System Information
═══════════════════════════════════════════

Hostname: myserver
OS: Linux (Ubuntu 22.04)
Kernel: 5.15.0-91-generic
Uptime: 3 days, 16 hours
CPU: 8 cores
Memory: 16 GB (8.5 GB used)
Disk: 500 GB (350 GB free)

Press Enter to continue...

╔════════════════════════════════════════╗
║       SYSTEM MANAGEMENT MENU           ║
╚════════════════════════════════════════╝

[1] System Information
[2] File Operations
[3] Process Management
[4] Network Tools
[5] User Management
[6] Utilities
[0] Exit

Select option (0-6): 2

═══════════════════════════════════════════
File Operations
═══════════════════════════════════════════

  [a] List files in directory
  [b] Search for files
  [c] Copy files
  [d] Move files
  [e] Delete files
  [f] File permissions
  [0] Back to main menu

Select operation: a

Enter directory path [current: .]: /home/user

Listing files in /home/user...

  document.txt (2.3 KB)
  script.sh (1.5 KB)
  photo.jpg (3.2 MB)
  ...

Total: 15 files, 45.8 MB

Press Enter to continue...

╔════════════════════════════════════════╗
║       SYSTEM MANAGEMENT MENU           ║
╚════════════════════════════════════════╝

[1] System Information
[2] File Operations
[3] Process Management
[4] Network Tools
[5] User Management
[6] Utilities
[0] Exit

Select option (0-6): 9

✗ Invalid option '9'
Valid options: 0-6

Press Enter to continue...

╔════════════════════════════════════════╗
║       SYSTEM MANAGEMENT MENU           ║
╚════════════════════════════════════════╝

[1] System Information
[2] File Operations
[3] Process Management
[4] Network Tools
[5] User Management
[6] Utilities
[0] Exit

Select option (0-6): 0

═══════════════════════════════════════════
Exiting System Management Menu
═══════════════════════════════════════════

Session summary:
  Actions performed: 2
  Time spent: 2 minutes, 34 seconds

Thank you for using System Management Menu!
Goodbye!
```
### Bonus Challenge:
- Add command history (show recent selections)
- Implement favorites/bookmarks
- Add help system with command descriptions
- Support keyboard shortcuts (Ctrl+C handling)
- Add breadcrumb navigation for sub-menus
- Implement user preferences/settings
- Add theme/color customization
- Create command search functionality
- Add undo/redo for actions
- Support scriptable mode (non-interactive)

***
