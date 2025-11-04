### Goal:
Create a script named `output_capture.sh` that demonstrates various techniques for capturing function output.
### Requirements:
- Create functions that return data via echo
- Demonstrate different capture techniques:
  - Simple capture with `$()`
  - Capturing into arrays
  - Capturing multiple return values
  - Capturing stdout vs stderr
  - Capturing while preserving exit code
- Show practical examples:
  - Math calculations
  - Data processing
  - File operations
  - String manipulation
- Compare capture methods (performance, readability)
- Handle functions that output to both stdout and stderr
### Hints:
- Capture with: `result=$(function_name args)`
- Capture into array: `mapfile -t array < <(function_name)`
- Multiple values: use space-separated or newline-separated
- Preserve whitespace: quote the substitution
- Check exit code after capture: Store `$?` immediately
### Expected Output Example:
```bash
./output_capture.sh
```
```
╔════════════════════════════════════════════════════════════════╗
║           FUNCTION OUTPUT CAPTURE DEMONSTRATION                ║
╚════════════════════════════════════════════════════════════════╝

This script demonstrates various techniques for capturing function
output and using it in variables.

══════════════════════════════════════════════════════════════
TECHNIQUE 1: Simple Output Capture
══════════════════════════════════════════════════════════════

Function that returns current date:
────────────────────────────────────────────────────────────────
get_current_date() {
    date +%Y-%m-%d
}

Capturing output:
────────────────────────────────────────────────────────────────
today=$(get_current_date)
echo "Today is: $today"

Result:
────────────────────────────────────────────────────────────────
Today is: 2025-10-19

✓ Simple capture successful

══════════════════════════════════════════════════════════════
TECHNIQUE 2: Capturing Multiple Values
══════════════════════════════════════════════════════════════

Function that returns width and height:
────────────────────────────────────────────────────────────────
get_dimensions() {
    echo "1920 1080"
}

Method A: Read into separate variables
────────────────────────────────────────────────────────────────
read -r width height <<< "$(get_dimensions)"
echo "Width: $width, Height: $height"

Result:
Width: 1920, Height: 1080

Method B: Capture into array
────────────────────────────────────────────────────────────────
IFS=' ' read -ra dims <<< "$(get_dimensions)"
echo "Width: ${dims[0]}, Height: ${dims[1]}"

Result:
Width: 1920, Height: 1080

✓ Multiple value capture successful

══════════════════════════════════════════════════════════════
TECHNIQUE 3: Capturing Line-by-Line Output
══════════════════════════════════════════════════════════════

Function that returns multiple lines:
────────────────────────────────────────────────────────────────
get_system_info() {
    echo "Hostname: $(hostname)"
    echo "User: $(whoami)"
    echo "Date: $(date +%Y-%m-%d)"
}

Capturing into array:
────────────────────────────────────────────────────────────────
mapfile -t info < <(get_system_info)

echo "Line 1: ${info[0]}"
echo "Line 2: ${info[1]}"
echo "Line 3: ${info[2]}"

Result:
────────────────────────────────────────────────────────────────
Line 1: Hostname: myserver
Line 2: User: john
Line 3: Date: 2025-10-19

✓ Line-by-line capture successful

══════════════════════════════════════════════════════════════
TECHNIQUE 4: Capturing with Exit Code Preservation
══════════════════════════════════════════════════════════════

Function that returns data and exit code:
────────────────────────────────────────────────────────────────
calculate_with_validation() {
    local a=$1
    local b=$2
    
    if [[ $b -eq 0 ]]; then
        echo "Error: Division by zero" >&2
        return 1
    fi
    
    echo $((a / b))
    return 0
}

Method: Capture output and check status
────────────────────────────────────────────────────────────────
if result=$(calculate_with_validation 10 2); then
    echo "Success: Result = $result"
else
    echo "Failed: Check returned error"
fi

Result:
Success: Result = 5

Testing with invalid input (division by zero):
if result=$(calculate_with_validation 10 0); then
    echo "Success: Result = $result"
else
    echo "Failed: Check returned error"
fi

Result:
Error: Division by zero
Failed: Check returned error

✓ Exit code preservation successful

══════════════════════════════════════════════════════════════
TECHNIQUE 5: Capturing STDOUT and STDERR Separately
══════════════════════════════════════════════════════════════

Function with both stdout and stderr:
────────────────────────────────────────────────────────────────
mixed_output() {
    echo "This goes to stdout"
    echo "This goes to stderr" >&2
    echo "More stdout"
}

Capture stdout only:
────────────────────────────────────────────────────────────────
stdout=$(mixed_output 2>/dev/null)
echo "STDOUT: $stdout"

Result:
STDOUT: This goes to stdout
More stdout

Capture stderr only:
────────────────────────────────────────────────────────────────
stderr=$(mixed_output 2>&1 1>/dev/null)
echo "STDERR: $stderr"

Result:
STDERR: This goes to stderr

✓ Separate stream capture successful

══════════════════════════════════════════════════════════════
PRACTICAL EXAMPLE: System Information Gatherer
══════════════════════════════════════════════════════════════

gather_all_info() {
    local hostname=$(get_hostname)
    local uptime=$(get_uptime)
    local memory=$(get_memory_usage)
    local disk=$(get_disk_usage)
    
    echo "System Report"
    echo "-------------"
    echo "Hostname: $hostname"
    echo "Uptime: $uptime"
    echo "Memory: $memory"
    echo "Disk: $disk"
}

Result:
────────────────────────────────────────────────────────────────
System Report
-------------
Hostname: myserver
Uptime: 3 days, 18 hours
Memory: 8.5 GB / 16 GB (53%)
Disk: 350 GB / 500 GB (70%)

══════════════════════════════════════════════════════════════
PERFORMANCE COMPARISON
══════════════════════════════════════════════════════════════

Testing 1000 iterations of different capture methods:

Method 1: Simple $() capture
Time: 0.234 seconds

Method 2: Backtick `` capture (deprecated)
Time: 0.289 seconds

Method 3: Read with process substitution
Time: 0.312 seconds

Recommendation: Use $() for best performance and readability

╔════════════════════════════════════════════════════════════════╗
║                        SUMMARY                                 ║
╚════════════════════════════════════════════════════════════════╝

Techniques demonstrated: 5
All captures successful: ✓

Key Takeaways:
  • Use $() for simple captures
  • Use read or mapfile for multiple values
  • Check exit codes with if statement or $?
  • Redirect stderr with 2> for clean output
  • Always quote captures to preserve whitespace
  • Use local variables to capture in functions

Best Practices:
  ✓ Always check for command substitution failures
  ✓ Quote variable captures
  ✓ Use appropriate capture method for data type
  ✓ Handle both stdout and stderr appropriately
  ✓ Consider performance for repeated calls
```
### Bonus Challenge:
- Add timeout for function captures
- Capture and parse JSON output
- Implement streaming capture (process as data arrives)
- Add capture buffering control
- Create capture debugging mode
- Support capture to multiple destinations
- Add capture filtering/transformation
- Implement capture caching
- Create capture replay functionality
- Support asynchronous capture

***