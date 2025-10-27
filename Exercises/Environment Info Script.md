### Goal:
Create a comprehensive script named `envinfo.sh` that displays key environment variables and system information in a well-formatted output.
### Requirements:
- [x] Display at least 8-10 environment variables including:
- [x] `USER` or `LOGNAME` - current username
- [x] `HOME` - home directory path
- [x] `SHELL` - current shell
- [x] `PATH` - command search path
- [x] `PWD` - present working directory
- [x] `HOSTNAME` or use `hostname` command
- [x] `LANG` - system language
- [x] `TERM` - terminal type
- [x] Use special variables `$0` and `$$`
- [x] Format output in a readable way (aligned, sectioned)
- [x] Use variables to store and format the output
- [x] Add color or formatting for better readability (optional bonus)
### Hints:
- Access environment variables with `$VARIABLE_NAME`
- You can use `printf` for better formatting alignment
- Section your output with headers
- Consider truncating long values like PATH for readability

### Expected Output Example:
```
========================================
    SYSTEM ENVIRONMENT INFORMATION
========================================
Script Name    : ./envinfo.sh
Process ID     : 54321

--- User Information ---
Username       : john
Home Directory : /home/john
Shell          : /bin/bash

--- System Information ---
Hostname       : mycomputer
Working Dir    : /home/john/scripts
Terminal Type  : xterm-256color
Language       : en_US.UTF-8

--- Path Information ---
PATH           : /usr/local/bin:/usr/bin:/bin:...
(showing first 50 chars)

========================================
```

### Bonus Challenges:
- [ ] Add color to section headers using ANSI color codes
- [ ] Format the output in a table-like structure
- [ ] Include additional calculated info (like PATH entry count)
- [ ] Make the script accept an optional argument to show verbose or condensed output

***