### Passing Arguments to Functions
Functions in Bash receive arguments through positional parameters, just like scripts receive command-line arguments.

**Basic argument passing:**
```bash
greet() {
    echo "Hello, $1!"
}

greet "Alice"  # Output: Hello, Alice!
greet "Bob"    # Output: Hello, Bob!
```

**Multiple arguments:**
```bash
full_name() {
    local first=$1
    local last=$2
    echo "Full name: $first $last"
}

full_name "John" "Doe"  # Output: Full name: John Doe
```

**Arguments are local to the function:**
```bash
#!/bin/bash

arg="global"

test_args() {
    echo "Inside function: $1"  # Uses function's $1
}

test_args "function_arg"
echo "Outside function: $arg"   # Uses global variable
```
### Special Parameter Variables in Functions
**`$#` - Number of arguments:**
```bash
show_count() {
    echo "Received $# arguments"
}

show_count one two three  # Output: Received 3 arguments
```

**`$@` - All arguments as separate words (recommended):**
```bash
show_all() {
    echo "Arguments: $@"
    for arg in "$@"; do
        echo "  - $arg"
    done
}

show_all apple banana cherry
```

Output:
```
Arguments: apple banana cherry
  - apple
  - banana
  - cherry
```

**`$*` - All arguments as single string:**
```bash
show_all_merged() {
    echo "Arguments as one: $*"
}

show_all_merged apple banana cherry
# Output: Arguments as one: apple banana cherry
```

**Key difference between `$@` and `$*`:**
```bash
test_difference() {
    echo "With @:"
    for arg in "$@"; do
        echo "  [$arg]"
    done
    
    echo "With *:"
    for arg in "$*"; do
        echo "  [$arg]"
    done
}

test_difference "one two" "three"
```

Output:
```
With @:
  [one two]
  [three]
With *:
  [one two three]
```

**Always use `"$@"` when you want to preserve individual arguments!**
### Default Values for Arguments
```bash
greet() {
    local name=${1:-"Guest"}  # Default to "Guest" if $1 is empty
    echo "Hello, $name!"
}

greet          # Output: Hello, Guest!
greet "Alice"  # Output: Hello, Alice!
```

### Return vs Echo
Functions in Bash have two ways to provide output:

**1. Return (for exit codes/status):**
- Returns a numeric value (0-255)
- 0 typically means success, non-zero means failure
- Retrieved with `$?`
- Cannot return strings or large numbers
```bash
is_even() {
    local num=$1
    if (( num % 2 == 0 )); then
        return 0  # Success/True
    else
        return 1  # Failure/False
    fi
}

if is_even 4; then
    echo "Number is even"
fi

# Or check explicitly
is_even 5
if [[ $? -eq 0 ]]; then
    echo "Even"
else
    echo "Odd"
fi
```

**2. Echo (for returning data):**
- Outputs data to stdout
- Can return strings, numbers, multiple values
- Captured using command substitution `$()`
- More flexible than return

```bash
get_square() {
    local num=$1
    local result=$((num * num))
    echo $result  # Output the result
}

result=$(get_square 5)
echo "Square of 5 is: $result"
```

**Combining return and echo:**
```bash
divide() {
    local a=$1
    local b=$2
    
    # Check for division by zero
    if [[ $b -eq 0 ]]; then
        echo "Error: Division by zero" >&2
        return 1
    fi
    
    # Return result via echo
    echo $((a / b))
    return 0
}

# Use it
if result=$(divide 10 2); then
    echo "Result: $result"
else
    echo "Division failed"
fi
```
### Capturing Function Output

**Method 1: Command substitution with `$()`:**
```bash
get_date() {
    date +%Y-%m-%d
}

today=$(get_date)
echo "Today is: $today"
```

**Method 2: Backticks (older style, avoid):**
```bash
today=`get_date`
echo "Today is: $today"
```

**Capture stdout and stderr separately:**
```bash
run_command() {
    echo "This is stdout"
    echo "This is stderr" >&2
}

# Capture only stdout
output=$(run_command)
echo "Captured: $output"

# Capture stdout and stderr separately
{
    IFS= read -r stdout
    IFS= read -r stderr <&2
} < <(run_command 2>&1 1>&3 3>&-)

echo "STDOUT: $stdout"
echo "STDERR: $stderr"
```

**Capture and check return code:**
```bash
process_file() {
    local file=$1
    
    if [[ ! -f "$file" ]]; then
        echo "Error: File not found" >&2
        return 1
    fi
    
    # Process and return result
    wc -l < "$file"
    return 0
}

# Capture output and check status
if lines=$(process_file "data.txt"); then
    echo "File has $lines lines"
else
    echo "Failed to process file"
fi
```
### Multiple Return Values
Since bash functions can only return one exit code, use echo to return multiple values:

**Method 1: Space-separated values:**
```bash
get_dimensions() {
    local width=1920
    local height=1080
    echo "$width $height"
}

# Capture into array or separate variables
read -r width height <<< "$(get_dimensions)"
echo "Width: $width, Height: $height"
```

**Method 2: One value per line:**
```bash
get_user_info() {
    echo "John Doe"
    echo "john@example.com"
    echo "30"
}

# Read into array
mapfile -t user_info < <(get_user_info)
echo "Name: ${user_info[0]}"
echo "Email: ${user_info[1]}"
echo "Age: ${user_info[2]}"
```

**Method 3: Using global variables (less preferred):**
```bash
get_stats() {
    # Modify global variables
    total=100
    average=50
    max=75
}

get_stats
echo "Total: $total, Average: $average, Max: $max"
```
### Practical Patterns
**Validation function:**
```bash
validate_email() {
    local email=$1
    
    if [[ $email =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
        return 0  # Valid
    else
        return 1  # Invalid
    fi
}

if validate_email "user@example.com"; then
    echo "Valid email"
fi
```

**Function with multiple outputs and status:**
```bash
fetch_data() {
    local url=$1
    
    # Simulate data fetching
    if curl -s "$url" > /tmp/data.txt 2>/dev/null; then
        cat /tmp/data.txt  # Output data
        return 0           # Success
    else
        echo "Failed to fetch from $url" >&2
        return 1           # Failure
    fi
}

if data=$(fetch_data "http://example.com/api"); then
    echo "Got  $data"
else
    echo "Fetch failed"
fi
```

***

**Exercise 1:** [[Function That Calculates Area of Rectangle]]
**Exercise 2:** [[Return Success Failure Codes from Functions]]
**Exercise 3:** [[Capture and Use Function Output in Variables]]

**Daily Projects:** [[Validation Library]]

