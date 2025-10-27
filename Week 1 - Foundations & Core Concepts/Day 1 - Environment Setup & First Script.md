## What is a Shebang?
The **shebang** (`#!`) is the first line of your Bash script that tells the system which interpreter to use. It must be the very first line of your script.

**Standard shebang:**
```bash
#!/bin/bash
```

**Portable shebang (recommended):**
```bash
#!/usr/bin/env bash
```

This finds bash in your PATH, making scripts more portable.

***
## Making Scripts Executable
Use `chmod` to give execute permission:
```bash
chmod +x myscript.sh
```

***
## Running Your Script
**Method 1: Direct execution** (needs shebang + execute permission)
```bash
./myscript.sh
```

**Method 2: Call interpreter explicitly** (no permissions needed)
```bash
bash myscript.sh
```

**Method 3: From anywhere** (script must be in PATH)
```bash
myscript.sh
```

***
## PATH Basics
PATH is an environment variable containing directories where the system looks for executables.
**View your PATH:**
```bash
echo $PATH
```

**Add your script directory to PATH** (add to ~/.bashrc):
```bash
export PATH="$HOME/bin:$PATH"
```
## Quick Example
```bash
# Create script
nano hello.sh

# Add content:
#!/bin/bash
echo "Hello, $USER!"

# Make executable and run
chmod +x hello.sh
./hello.sh
```

***

- [x] **Exercise 1:**  [[hello world]]
- [x] **Exercise 2:**  [[system information]]
- [x] **Exercise 3:**  [[add to path]]
- [x] **Daily Project:** [[System Welcome Banner]]