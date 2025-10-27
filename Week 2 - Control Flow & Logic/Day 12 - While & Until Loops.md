### While Loop Basics
The `while` loop executes as long as a condition is true.

**Basic syntax:**
```bash
while [[ condition ]]; do
    # commands
done
```

**Simple counter example:**
```bash
count=1
while [[ $count -le 5 ]]; do
    echo "Count: $count"
    ((count++))
done
```

**Arithmetic condition:**
```bash
i=0
while ((i < 10)); do
    echo "Number: $i"
    ((i++))
done
```
### Reading Files Line-by-Line
The most common and important use of `while` loops is reading files:

**Standard pattern:**
```bash
while IFS= read -r line; do
    echo "Line: $line"
done < file.txt
```

**Why this pattern:**
- `IFS=` preserves leading/trailing whitespace
- `read -r` prevents backslash interpretation
- `< file.txt` redirects file as input

**Reading with line numbers:**
```bash
line_num=0
while IFS= read -r line; do
    ((line_num++))
    echo "$line_num: $line"
done < file.txt
```

**Reading from command output:**
```bash
ls -1 | while read -r filename; do
    echo "Processing: $filename"
done
```

**Reading CSV files:**
```bash
while IFS=',' read -r col1 col2 col3; do
    echo "Column 1: $col1"
    echo "Column 2: $col2"
    echo "Column 3: $col3"
done < data.csv
```

**Skip header line:**
```bash
# Read and discard first line
read -r header < file.txt

# Process remaining lines
tail -n +2 file.txt | while IFS= read -r line; do
    echo "Data: $line"
done
```

### Infinite Loops
Loops that run forever (until broken):
**Method 1: True condition:**
```bash
while true; do
    echo "This runs forever"
    sleep 1
done
```

**Method 2: Colon command:**
```bash
while :; do
    echo "Also runs forever"
    sleep 1
done
```

**Practical infinite loop with break:**
```bash
while true; do
    read -p "Enter command (quit to exit): " cmd
    
    if [[ "$cmd" == "quit" ]]; then
        break
    fi
    
    echo "You entered: $cmd"
done
```
### Until Loops
The `until` loop runs while condition is **false** (opposite of while):
**Basic syntax:**
```bash
until [[ condition ]]; do
    # commands
done
```

**Example:**
```bash
count=1
until [[ $count -gt 5 ]]; do
    echo "Count: $count"
    ((count++))
done
```

**Wait for file:**
```bash
until [[ -f "ready.txt" ]]; do
    echo "Waiting for ready.txt..."
    sleep 1
done
echo "File found!"
```

**Menu with until:**
```bash
choice=""
until [[ "$choice" == "0" ]]; do
    echo "Menu: [1] Option 1  [0] Exit"
    read -p "Select: " choice
    
    case $choice in
        1) echo "Option 1 selected" ;;
        2) echo "Goodbye" ;;
        *) echo "Invalid" ;;
    esac
done
```

### Loop Control
**Break - exit loop:**
```bash
count=0
while true; do
    ((count++))
    if ((count > 10)); then
        break
    fi
    echo $count
done
```

**Continue - skip to next iteration:**
```bash
count=0
while ((count < 10)); do
    ((count++))
    if ((count % 2 == 0)); then
        continue  # Skip even numbers
    fi
    echo $count  # Only prints odd numbers
done
```

### Reading User Input in Loops
**Interactive loop:**
```bash
while true; do
    read -p "Enter name (or 'done' to finish): " name
    
    if [[ "$name" == "done" ]]; then
        break
    fi
    
    echo "Hello, $name"
done
```

**Timeout in loop:**
```bash
while true; do
    if read -t 5 -p "Enter something (5 sec): " input; then
        echo "You entered: $input"
    else
        echo "Timeout! Exiting..."
        break
    fi
done
```
### Processing Command Output
**Parse ps output:**
```bash
ps aux | while read user pid cpu mem rest; do
    if ((cpu > 50)); then
        echo "High CPU: PID $pid using $cpu%"
    fi
done
```

**Process find results:**
```bash
find . -name "*.txt" | while read -r file; do
    echo "Processing: $file"
    wc -l "$file"
done
```
### While with Multiple Conditions
```bash
count=0
running=true

while [[ $count -lt 10 && $running == true ]]; do
    echo "Count: $count"
    ((count++))
    
    if ((count == 5)); then
        running=false
    fi
done
```
### Nested Loops
```bash
outer=1
while ((outer <= 3)); do
    echo "Outer loop: $outer"
    
    inner=1
    while ((inner <= 3)); do
        echo "  Inner loop: $inner"
        ((inner++))
    done
    
    ((outer++))
done
```
### Reading from Multiple Files
```bash
while IFS= read -r line1 <&3 && IFS= read -r line2 <&4; do
    echo "File1: $line1 | File2: $line2"
done 3<file1.txt 4<file2.txt
```
### Practical Examples
**Wait for service to start:**
```bash
echo "Starting service..."
./start_service.sh &

until curl -s http://localhost:8080/health > /dev/null; do
    echo "Waiting for service..."
    sleep 2
done

echo "Service is ready!"
```

**Monitor system resources:**
```bash
while true; do
    clear
    echo "=== System Monitor ==="
    echo "Time: $(date)"
    echo "CPU: $(top -bn1 | grep "Cpu(s)" | awk '{print $2}')"
    echo "Memory: $(free -h | awk 'NR==2{print $3}')"
    sleep 5
done
```

**Retry with exponential backoff:**
```bash
attempt=1
max_attempts=5

until command_that_might_fail; do
    if ((attempt >= max_attempts)); then
        echo "Failed after $max_attempts attempts"
        exit 1
    fi
    
    wait_time=$((2 ** attempt))
    echo "Attempt $attempt failed. Retrying in ${wait_time}s..."
    sleep $wait_time
    ((attempt++))
done
```

***

**Exercise 1:** [[Counter Script Using While Loop]]
**Exercise 2:** [[Read and Process File Contents Line-by-Line]]
**Exercise 3:** [[Menu System with Until Loop]]

**Daily Project:** [[Log File Monitor]]
