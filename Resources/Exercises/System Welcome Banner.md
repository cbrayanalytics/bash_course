## Goal:
Create a personalized welcome script named `welcome.sh` that displays an ASCII art banner along with basic system information using only Day 1 concepts (variables, command substitution, and echo statements).
## Requirements:
- [x] Display an ASCII art banner at the top
- [ ] Show at least 6 pieces of system information:
- [x] Username (using `whoami` or `$USER`)
- [x] Hostname (using `hostname`)
- [x] Home directory (using `$HOME`)
- [x] Current date (using `date`)
- [x] Current time (using `date`)
- [x] Operating system name
- [x] Use variables to store all information
- [x] Format output in a readable, organized way
- [x] Include a personalized greeting
- [x] Add proper header comments and shebang line
- [x] Make script executable with `chmod +x`

## Hints:
- Use `$(command)` for command substitution
- Store each piece of information in a variable first
- Use `echo` statements to build your output
- You can use box-drawing characters for borders: `═`, `║`, `╔`, `╗`, `╚`, `╝`
- For date formatting: `date +"%A, %B %d, %Y"` gives "Thursday, October 23, 2025"
- For time formatting: `date +"%I:%M %p"` gives "3:15 PM"
- To get OS name: `cat /etc/os-release | grep "PRETTY_NAME" | cut -d'"' -f2`
## Expected Output Example:
```bash
./welcome.sh
```

```
╔════════════════════════════════════════════════════════════════╗
║                         WELCOME!                               ║
╚════════════════════════════════════════════════════════════════╝

    ██╗    ██╗███████╗██╗      ██████╗ ██████╗ ███╗   ███╗███████╗
    ██║    ██║██╔════╝██║     ██╔════╝██╔═══██╗████╗ ████║██╔════╝
    ██║ █╗ ██║█████╗  ██║     ██║     ██║   ██║██╔████╔██║█████╗  
    ██║███╗██║██╔══╝  ██║     ██║     ██║   ██║██║╚██╔╝██║██╔══╝  
    ╚███╔███╔╝███████╗███████╗╚██████╗╚██████╔╝██║ ╚═╝ ██║███████╗
     ╚══╝╚══╝ ╚══════╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝

══════════════════════════════════════════════════════════════════
                    Hello, john!
              Thursday, October 23, 2025 at 3:15 PM
══════════════════════════════════════════════════════════════════

--- System Information ---
Computer Name  : mycomputer
Username       : john
Home Directory : /home/john
Shell          : /bin/bash
OS Version     : Ubuntu 22.04.3 LTS

Have a great day!

══════════════════════════════════════════════════════════════════
```
## Bonus Challenges:
- Add more system information (kernel version, uptime, current directory)
- Create your own custom ASCII art design
- Use different box-drawing characters for variety
- Add color using ANSI codes: `echo -e "\033[1;34mBlue Text\033[0m"`
- Include the current weather or a motivational quote
- Make the greeting time-aware (Good morning/afternoon/evening based on time)
## Starter Code Template:
```bash
#!/bin/bash

#######################################
# Welcome Banner Script
# Week 1 Portfolio Project
# 
# Author: [Your Name]
# Date: [Today's Date]
#######################################

# TODO: Collect system information using variables
# Hint: username=$(whoami)

# TODO: Display top border

# TODO: Display ASCII art banner

# TODO: Display personalized greeting

# TODO: Display system information section

# TODO: Display closing message
```
## Submission Checklist:
- [x] Script has proper shebang line (`#!/bin/bash`)
- [x] Header comments with author and date included
- [x] At least 6 variables storing system information
- [x] Command substitution used correctly (e.g., `$(whoami)`)
- [x] ASCII banner displays without errors
- [x] Personalized greeting includes username
- [x] Output is well-formatted and readable
- [x] Script is executable (`chmod +x welcome.sh`)
- [x] No syntax errors when running script
- [x] Works on your system without modifications
## Testing Your Script:
```bash
# Make executable
chmod +x welcome.sh

# Run the script
./welcome.sh

# Verify output displays correctly
# Check that all information is accurate
# Ensure ASCII art renders properly
```
## Common Mistakes to Avoid:
- Forgetting the shebang line at the top
- Using spaces around `=` in variable assignment (should be `var=value` not `var = value`)
- Forgetting `$` when referencing variables (should be `$username` not `username`)
- Not making the script executable before running it
- Breaking ASCII art by incorrect escaping or line breaks

***

