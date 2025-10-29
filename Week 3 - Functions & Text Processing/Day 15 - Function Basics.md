### Function Declaration
Functions in Bash allow you to group commands into reusable blocks. There are two main syntax styles for declaring functions:

**Style 1: Function name with parentheses (most common):**
```bash
function_name() {
    commands
}
```

**Style 2: Using `function` keyword:**
```bash
function function_name {
    commands
}
```

**Style 3: Combining both (also valid):**
```bash
function function_name() {
    commands
}
```

**Single-line syntax:**
```bash
function_name() { commands; }
```

**Important rules:**
- Curly braces must be separated from commands by spaces or semicolons
- Function must be declared **before** it's called
- No parameters are declared in the parentheses (unlike other languages)
### Basic Function Example
```bash
#!/bin/bash

# Define function
greet() {
    echo "Hello, World!"
}

# Call function
greet
```

Output:
```
Hello, World!
```
### Calling Functions
To execute a function, simply use its name:
```bash
my_function() {
    echo "Function is running"
}

# Call it
my_function

# Call multiple times
my_function
my_function
```

**Functions must be defined before they're called:**
```bash
# This will FAIL
greet  # Error: greet: command not found

greet() {
    echo "Hello"
}
```

```bash
# This WORKS
greet() {
    echo "Hello"
}

greet  # Successfully calls function
```

### Function Parameters/Arguments
Functions accept arguments through positional parameters `$1`, `$2`, `$3`, etc.
```bash
greet() {
    echo "Hello, $1!"
}

greet "Alice"    # Output: Hello, Alice!
greet "Bob"      # Output: Hello, Bob!
```

**Multiple parameters:**
```bash
full_name() {
    echo "First name: $1"
    echo "Last name: $2"
}

full_name "John" "Doe"
```

Output:
```
First name: John
Last name: Doe
```

**Special parameter variables in functions:**
- `$1, $2, $3...` - Individual arguments
- `$#` - Number of arguments passed
- `$@` - All arguments as separate strings
- `$*` - All arguments as single string
- `$0` - Script name (not function name)

```bash
show_args() {
    echo "Number of arguments: $#"
    echo "All arguments: $@"
    echo "First argument: $1"
}

show_args apple banana cherry
```
### Variable Scope
Variables in Bash can be **global** or **local**.
**Global variables** are accessible throughout the entire script:
```bash
#!/bin/bash

# Global variable
name="Alice"

greet() {
    echo "Hello, $name"  # Can access global variable
}

greet  # Output: Hello, Alice
echo "Name is still: $name"  # Output: Name is still: Alice
```

**Without `local` keyword, variables in functions are global:**
```bash
#!/bin/bash

counter=0

modify_global() {
    counter=10  # Modifies the global variable
}

echo "Before: $counter"  # 0
modify_global
echo "After: $counter"   # 10 (changed!)
```
### Local Variables
Use the `local` keyword to create variables that only exist within the function:
```bash
#!/bin/bash

global_var="I'm global"

test_scope() {
    local local_var="I'm local"
    
    echo "Inside function:"
    echo "  Global: $global_var"
    echo "  Local: $local_var"
}

test_scope

echo "Outside function:"
echo "  Global: $global_var"  # Accessible
echo "  Local: $local_var"    # Empty! Not accessible
```

Output:
```
Inside function:
  Global: I'm global
  Local: I'm local
Outside function:
  Global: I'm global
  Local: 
```

**Important behavior - functions modify global variables:**
```bash
#!/bin/bash

var1='A'
var2='B'

my_function() {
    local var1='C'  # Local - doesn't affect global
    var2='D'        # NO local keyword - modifies global!
    
    echo "Inside function: var1=$var1, var2=$var2"
}

echo "Before: var1=$var1, var2=$var2"
my_function
echo "After: var1=$var1, var2=$var2"
```

Output:
```
Before: var1=A, var2=B
Inside function: var1=C, var2=D
After: var1=A, var2=D
```

**Best practice:** Always use `local` for function variables to avoid unintended side effects.

### Return Values
Bash functions have two ways to return 
**1. Return exit code (0-255) using `return`:**
```bash
is_even() {
    local num=$1
    if (( num % 2 == 0 )); then
        return 0  # Success (even)
    else
        return 1  # Failure (odd)
    fi
}

if is_even 4; then
    echo "Number is even"
fi
```

**2. Output data using `echo` (recommended for returning values):**
```bash
add() {
    local sum=$(( $1 + $2 ))
    echo $sum  # Output the result
}

result=$(add 5 3)  # Capture output
echo "Result: $result"  # Output: Result: 8
```

**Check return code with `$?`:**
```bash
check_file() {
    if [[ -f "$1" ]]; then
        return 0
    else
        return 1
    fi
}

check_file "/etc/passwd"
if [[ $? -eq 0 ]]; then
    echo "File exists"
fi
```
### Function Best Practices
**1. Descriptive names:**
```bash
# Good
calculate_total() { }
validate_email() { }

# Avoid
func1() { }
do_stuff() { }
```

**2. Use local variables:**
```bash
calculate() {
    local result=$(( $1 + $2 ))  # Always use local
    echo $result
}
```

**3. Validate inputs:**
```bash
divide() {
    if [[ $# -lt 2 ]]; then
        echo "Error: Need 2 arguments" >&2
        return 1
    fi
    
    if [[ $2 -eq 0 ]]; then
        echo "Error: Cannot divide by zero" >&2
        return 1
    fi
    
    echo $(( $1 / $2 ))
}
```

**4. Document functions:**
```bash
# Calculate the sum of two numbers
# Arguments:
#   $1 - First number
#   $2 - Second number
# Returns:
#   Sum of the two numbers
add() {
    echo $(( $1 + $2 ))
}
```
### Practical Example
```bash
#!/bin/bash

# Function library for user management

# Print error message to stderr
error() {
    echo "ERROR: $*" >&2
}

# Check if user exists
user_exists() {
    local username=$1
    if id "$username" &>/dev/null; then
        return 0
    else
        return 1
    fi
}

# Main program
username="john"

if user_exists "$username"; then
    echo "User $username exists"
else
    error "User $username not found"
fi
```

***

- [ ] **Exercise 1:** [[Create Greeting Function That Accepts Name Parameter]]
- [ ] **Exercise 2:** [[Math Functions Library (Add, Subtract, Multiply, Divide)]]
- [ ] **Exercise 3:** [[Demonstrate Global vs Local Variable Scope]]
- [ ] **Daily Project:** [[Logging Utility with Different Log Levels]]

