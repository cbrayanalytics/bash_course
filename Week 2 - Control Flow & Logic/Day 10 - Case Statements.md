### Case Statement Basics
The `case` statement provides an elegant way to handle multiple conditions, especially when comparing a single variable against multiple values. It's cleaner than multiple `if-elif` statements for pattern matching.

**Basic syntax:**
```bash
case $variable in
    pattern1)
        # commands for pattern1
        ;;
    pattern2)
        # commands for pattern2
        ;;
    *)
        # default case (like else)
        ;;
esac
```

**Simple example:**
```bash
fruit="apple"

case $fruit in
    apple)
        echo "This is an apple"
        ;;
    banana)
        echo "This is a banana"
        ;;
    orange)
        echo "This is an orange"
        ;;
    *)
        echo "Unknown fruit"
        ;;
esac
```

### Pattern Matching
Case statements support powerful pattern matching:
**Exact match:**
```bash
case $answer in
    yes)
        echo "You said yes"
        ;;
    no)
        echo "You said no"
        ;;
esac
```

**Wildcard patterns:**
```bash
case $filename in
    *.txt)
        echo "Text file"
        ;;
    *.jpg|*.png)
        echo "Image file"
        ;;
    *.sh)
        echo "Shell script"
        ;;
    *)
        echo "Unknown file type"
        ;;
esac
```

**Character ranges:**
```bash
case $grade in
    [Aa]*)
        echo "Excellent"
        ;;
    [Bb]*)
        echo "Good"
        ;;
    [Cc]*)
        echo "Average"
        ;;
    [Dd]*)
        echo "Poor"
        ;;
    [Ff]*)
        echo "Fail"
        ;;
esac
```

**Number ranges:**
```bash
case $number in
    [0-9])
        echo "Single digit"
        ;;
    [1-9][0-9])
        echo "Two digits"
        ;;
    [1-9][0-9][0-9])
        echo "Three digits"
        ;;
    *)
        echo "More than three digits or invalid"
        ;;
esac
```

### Multiple Patterns (OR Logic)
Use the pipe `|` to match multiple patterns in one case:
```bash
case $answer in
    yes|y|Y|YES)
        echo "Affirmative"
        ;;
    no|n|N|NO)
        echo "Negative"
        ;;
    *)
        echo "Invalid response"
        ;;
esac
```

**Another example:**
```bash
case $command in
    start|run|begin)
        echo "Starting service..."
        ;;
    stop|halt|end)
        echo "Stopping service..."
        ;;
    restart|reboot|reload)
        echo "Restarting service..."
        ;;
esac
```

### Case Terminators
**Double semicolon `;;` (default):**
```bash
case $option in
    1)
        echo "Option 1"
        ;;  # Exit case after this
    2)
        echo "Option 2"
        ;;
esac
```

**Fall-through `;&`:**
Continues to next pattern without testing (rare use):
```bash
case $num in
    1)
        echo "One"
        ;&  # Fall through to next case
    2)
        echo "Two or after one"
        ;;
esac
# Input of 1 prints both messages
```

**Test next pattern `;;&`:**
Continues testing remaining patterns:
```bash
case $num in
    [0-9])
        echo "Single digit"
        ;;&  # Continue testing
    [02468])
        echo "Even number"
        ;;
    [13579])
        echo "Odd number"
        ;;
esac
# Input of 2 prints "Single digit" and "Even number"
```

### Default Case
Always include a default case to handle unexpected input:
```bash
case $input in
    pattern1)
        # handle pattern1
        ;;
    pattern2)
        # handle pattern2
        ;;
    *)
        echo "Error: Invalid input '$input'"
        echo "Valid options: pattern1, pattern2"
        exit 1
        ;;
esac
```

### Case with Command-Line Options
Common pattern for handling script options:
```bash
case $1 in
    -h|--help)
        echo "Usage: $0 [options]"
        echo "Options:"
        echo "  -h, --help     Show this help"
        echo "  -v, --version  Show version"
        exit 0
        ;;
    -v|--version)
        echo "Version 1.0.0"
        exit 0
        ;;
    -*)
        echo "Error: Unknown option $1"
        exit 1
        ;;
    *)
        echo "Processing file: $1"
        ;;
esac
```
### Menu-Driven Interface Pattern
Classic pattern for interactive menus:
```bash
while true; do
    echo "Menu:"
    echo "1. Option 1"
    echo "2. Option 2"
    echo "3. Option 3"
    echo "0. Exit"
    read -p "Select: " choice
    
    case $choice in
        1)
            echo "You selected option 1"
            ;;
        2)
            echo "You selected option 2"
            ;;
        3)
            echo "You selected option 3"
            ;;
        0)
            echo "Goodbye!"
            break
            ;;
        *)
            echo "Invalid option"
            ;;
    esac
done
```
### Practical Examples
**File extension handler:**
```bash
case $filename in
    *.tar.gz|*.tgz)
        tar -xzf "$filename"
        ;;
    *.zip)
        unzip "$filename"
        ;;
    *.tar)
        tar -xf "$filename"
        ;;
    *)
        echo "Unknown archive format"
        ;;
esac
```

**Environment detection:**
```bash
case $(uname) in
    Linux)
        echo "Linux system"
        package_manager="apt"
        ;;
    Darwin)
        echo "macOS system"
        package_manager="brew"
        ;;
    CYGWIN*|MINGW*|MSYS*)
        echo "Windows system"
        package_manager="choco"
        ;;
    *)
        echo "Unknown system"
        ;;
esac
```

***

**Exercise 1:** [[Menu-Driven Script with 4 Options]]
**Exercise 2:** [[File Type Identifier Based on Extension]]
**Exercise 3:** [[Multi-Pattern Matching]]

**Daily Project:** [[Service Manager Script]]
