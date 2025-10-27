### Avoiding Unnecessary Subshells
**Subshells are expensive** - each one creates a new process.

**Bad (spawns subshell):**
```bash
result=$(echo "hello")  # Spawns echo command
```

**Good (built-in):**
```bash
result="hello"  # No subshell needed
```

**Bad (unnecessary cat):**
```bash
data=$(cat file.txt)
```

**Good (use redirection):**
```bash
data=$(< file.txt)
# Or
data=$(<file.txt)  # Even faster
```

**Bad (useless use of cat):**
```bash
cat file.txt | grep "pattern"
```

**Good (direct input):**
```bash
grep "pattern" file.txt
```
### Command Substitution Optimization
**Old style (backticks) - avoid:**
```bash
date=`date +%Y-%m-%d`
```

**Modern style ($()):**
```bash
date=$(date +%Y-%m-%d)
```

**Avoid command substitution when possible:**
```bash
# Bad
count=$(wc -l < file.txt)

# Better (but still spawns wc)
count=$(<file.txt wc -l)

# Best for small files
mapfile -t lines < file.txt
count=${#lines[@]}
```
### Parameter Expansion Tricks
Parameter expansion is faster than external commands.

**String length:**
```bash
# Bad
length=$(echo -n "$string" | wc -c)

# Good
length=${#string}
```

**Substring extraction:**
```bash
string="Hello World"

# Bad
first=$(echo "$string" | cut -c1-5)

# Good
first=${string:0:5}  # Hello
```

**Default values:**
```bash
# Bad
if [[ -z "$var" ]]; then
    var="default"
fi

# Good
var=${var:-default}

# Set and export default
: ${var:=default}
```

**Remove prefix/suffix:**
```bash
filename="example.tar.gz"

# Remove shortest match from end
${filename%.*}      # example.tar

# Remove longest match from end
${filename%%.*}     # example

# Remove shortest match from start
${filename#*.}      # tar.gz

# Remove longest match from start
${filename##*.}     # gz
```

**Search and replace:**
```bash
string="hello world hello"

# Replace first occurrence
${string/hello/hi}        # hi world hello

# Replace all occurrences
${string//hello/hi}       # hi world hi

# Remove pattern
${string//hello/}         # world

# Replace at beginning
${string/#hello/hi}       # hi world hello

# Replace at end
${string/%hello/hi}       # hello world hi
```

**Case conversion (Bash 4+):**
```bash
string="Hello World"

# Uppercase
${string^^}         # HELLO WORLD

# Lowercase
${string,,}         # hello world

# Capitalize first letter
${string^}          # Hello World

# Lowercase first letter
${string,}          # hello World
```
### Readonly Variables
Prevent accidental modification of constants:

**Basic readonly:**
```bash
readonly PI=3.14159
PI=3.14  # Error: PI: readonly variable
```

**Readonly arrays:**
```bash
readonly -a COLORS=("red" "green" "blue")
COLORS[0]="yellow"  # Error
```

**Readonly functions:**
```bash
my_function() {
    echo "Hello"
}
readonly -f my_function
```

**List readonly variables:**
```bash
readonly      # List all
readonly -p   # Same, but with 'declare -r' format
```

**Best practice for constants:**
```bash
#!/bin/bash

# Define constants at the top
readonly APP_NAME="MyApp"
readonly APP_VERSION="1.0.0"
readonly CONFIG_DIR="/etc/myapp"
readonly LOG_FILE="/var/log/myapp.log"

# Constants are uppercase by convention
readonly MAX_RETRIES=3
readonly TIMEOUT_SECONDS=30
```
### Efficient Loop Patterns
**Bad (spawns process per iteration):**
```bash
for i in $(seq 1 1000); do
    echo $i
done
```

**Good (bash arithmetic):**
```bash
for ((i=1; i<=1000; i++)); do
    echo $i
done
```

**Reading files efficiently:**
```bash
# Bad (spawns cat)
for line in $(cat file.txt); do
    process "$line"
done

# Good (built-in)
while IFS= read -r line; do
    process "$line"
done < file.txt
```
### Built-in String Operations
**Bad (spawns sed):**
```bash
result=$(echo "$string" | sed 's/old/new/g')
```

**Good (parameter expansion):**
```bash
result=${string//old/new}
```

**Bad (spawns tr):**
```bash
upper=$(echo "$string" | tr '[:lower:]' '[:upper:]')
```

**Good (parameter expansion, Bash 4+):**
```bash
upper=${string^^}
```
### Arithmetic Operations
**Bad (spawns bc):**
```bash
result=$(echo "5 + 3" | bc)
```

**Good (bash arithmetic):**
```bash
result=$((5 + 3))

# Or
((result = 5 + 3))
```

**Floating point (need bc):**
```bash
# Can't avoid bc for floating point
result=$(bc <<< "scale=2; 10 / 3")  # 3.33
```
### Array Operations
**Efficient array handling:**
```bash
# Get array length
${#array[@]}

# Get all elements
"${array[@]}"

# Get indices
"${!array[@]}"

# Slice array
"${array[@]:2:3}"  # 3 elements starting at index 2

# Append to array
array+=("new_element")
```
### Avoid Pipes When Possible
**Bad (multiple processes):**
```bash
cat file.txt | grep "pattern" | wc -l
```

**Better (fewer processes):**
```bash
grep "pattern" file.txt | wc -l
```

**Best (single process when possible):**
```bash
grep -c "pattern" file.txt
```

***

**Exercise 1:** [[Optimize Slow Script by Reducing Command Spawning]]
**Exercise 2:** [[Use Parameter Expansion Instead of External Commands]]
**Exercise 3:** [[Implement Readonly Constants for Configuration]]

**Daily Project:** [[Refactor Previous Projects with Optimization]]


