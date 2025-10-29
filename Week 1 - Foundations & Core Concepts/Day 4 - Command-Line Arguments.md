## Positional Parameters
Positional parameters allow your script to accept arguments from the command line[1]. When you run a script like `./script.sh arg1 arg2 arg3`, these arguments are automatically stored in special variables.

**Basic positional parameters:**
```bash
$0  # Script name itself
$1  # First argument
$2  # Second argument
$3  # Third argument
# ... up to $9
${10}  # Tenth argument (use braces for 10+)
${11}  # Eleventh argument
```

**Example script:**
```bash
#!/bin/bash
echo "Script name: $0"
echo "First argument: $1"
echo "Second argument: $2"
echo "Third argument: $3"
```

**Running it:**
```bash
./script.sh apple banana cherry
# Output:
# Script name: ./script.sh
# First argument: apple
# Second argument: banana
# Third argument: cherry
```

### Special Parameter Variables

**`$#` - Number of arguments:**
```bash
echo "You passed $# arguments"
```

**`$@` - All arguments as separate words:**
```bash
# Each argument remains separate (proper for iteration)
for arg in "$@"; do
    echo "Argument: $arg"
done
```

**`$*` - All arguments as single string:**
```bash
# All arguments merged into one string
echo "All args: $*"
```

**Key difference between `$@` and `$*`:**
- `"$@"` expands to: `"arg1" "arg2" "arg3"` (separate strings)
- `"$*"` expands to: `"arg1 arg2 arg3"` (single string)

Use `"$@"` when you want to preserve individual arguments, especially with spaces[2].

### The shift Command

The `shift` command shifts positional parameters to the left, removing `$1` and moving everything down:

```bash
#!/bin/bash
echo "First arg: $1"
shift
echo "After shift, first arg is now: $1"
shift
echo "After another shift: $1"
```

**Running it:**
```bash
./script.sh one two three
# Output:
# First arg: one
# After shift, first arg is now: two
# After another shift: three
```

**Shift with count:**
```bash
shift 2  # Shift twice (remove first two arguments)
```

**Common use case - processing unlimited arguments:**
```bash
while [[ $# -gt 0 ]]; do
    echo "Processing: $1"
    shift
done
```

### Argument Validation Patterns

**Check if enough arguments provided:**
```bash
if [[ $# -lt 2 ]]; then
    echo "Error: Need at least 2 arguments"
    echo "Usage: $0 <source> <destination>"
    exit 1
fi
```

**Check if specific argument is empty:**
```bash
if [[ -z "$1" ]]; then
    echo "Error: First argument is required"
    exit 1
fi
```

***

- [ ] **Exercise 1:** [[Script That Processes Three Arguments and Displays Them]]
- [ ] **Exercise 2:** [[Implement Argument Counting and Validation]]
- [ ] **Exercise 3:** [[Use shift to Process Unlimited Arguments]]
- [ ] **Daily Project:** [[File Backup Script with Arguments and Validation]]

