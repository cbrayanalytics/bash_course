### The Break Statement
The `break` statement immediately exits the current loop, regardless of the loop condition.

**Basic syntax:**
```bash
for i in {1..10}; do
    if [[ $i -eq 5 ]]; then
        break  # Exit loop when i equals 5
    fi
    echo $i
done
# Output: 1 2 3 4
```

**Break in while loop:**
```bash
count=0
while true; do
    ((count++))
    echo "Count: $count"
    
    if [[ $count -ge 5 ]]; then
        break  # Exit infinite loop
    fi
done
```

**Break with condition:**
```bash
while read -r line; do
    if [[ -z "$line" ]]; then
        echo "Empty line found, stopping"
        break
    fi
    echo "Processing: $line"
done < file.txt
```
### The Continue Statement
The `continue` statement skips the rest of the current iteration and moves to the next one.
**Basic syntax:**
```bash
for i in {1..10}; do
    if [[ $((i % 2)) -eq 0 ]]; then
        continue  # Skip even numbers
    fi
    echo $i  # Only prints odd numbers
done
# Output: 1 3 5 7 9
```

**Continue in while loop:**
```bash
count=0
while ((count < 10)); do
    ((count++))
    
    if [[ $count -eq 5 ]]; then
        continue  # Skip 5
    fi
    
    echo $count
done
# Output: 1 2 3 4 6 7 8 9 10
```

**Skip processing certain files:**
```bash
for file in *; do
    # Skip directories
    if [[ -d "$file" ]]; then
        continue
    fi
    
    # Skip hidden files
    if [[ "$file" == .* ]]; then
        continue
    fi
    
    echo "Processing: $file"
done
```

### Nested Loop Control
By default, `break` and `continue` only affect the innermost loop.
**Break inner loop only:**
```bash
for i in {1..3}; do
    echo "Outer: $i"
    for j in {1..5}; do
        if [[ $j -eq 3 ]]; then
            break  # Only breaks inner loop
        fi
        echo "  Inner: $j"
    done
done
```

**Continue in nested loop:**
```bash
for i in {1..3}; do
    for j in {1..3}; do
        if [[ $j -eq 2 ]]; then
            continue  # Skip to next j
        fi
        echo "i=$i, j=$j"
    done
done
```
### Breaking Multiple Loop Levels
Use numeric argument with `break` to exit multiple levels:
```bash
for i in {1..3}; do
    echo "Outer: $i"
    for j in {1..3}; do
        echo "  Middle: $j"
        for k in {1..3}; do
            echo "    Inner: $k"
            if [[ $k -eq 2 && $j -eq 2 ]]; then
                break 3  # Break all 3 loops
            fi
        done
    done
done
```

**Break 2 levels:**
```bash
for i in {1..5}; do
    for j in {1..5}; do
        if [[ $i -eq 3 && $j -eq 3 ]]; then
            break 2  # Exit both loops
        fi
        echo "i=$i, j=$j"
    done
done
```
### Loop Exit Codes
Loops have exit codes that can be used in conditionals.
**Exit code of last command in loop:**
```bash
for file in *.txt; do
    grep "pattern" "$file"
done

# Check if any grep succeeded
if [[ $? -eq 0 ]]; then
    echo "Pattern found in at least one file"
fi
```

**Break with exit code:**
```bash
found=false
for file in *.txt; do
    if grep -q "pattern" "$file"; then
        found=true
        break
    fi
done

if $found; then
    echo "Pattern found!"
fi
```

**Using loop as condition:**
```bash
# Loop succeeds if it completes naturally
if for i in {1..5}; do ((i < 10)); done; then
    echo "Loop completed successfully"
fi
```
### Practical Patterns
**Early exit on error:**
```bash
for file in *.txt; do
    if ! process_file "$file"; then
        echo "Error processing $file"
        break  # Stop on first error
    fi
done
```

**Skip invalid entries:**
```bash
while read -r line; do
    # Skip comments
    if [[ "$line" =~ ^# ]]; then
        continue
    fi
    
    # Skip empty lines
    if [[ -z "$line" ]]; then
        continue
    fi
    
    # Process valid line
    echo "Valid: $line"
done < config.txt
```

**Find first match:**
```bash
found=""
for item in "${array[@]}"; do
    if [[ "$item" == "target" ]]; then
        found="$item"
        break
    fi
done

if [[ -n "$found" ]]; then
    echo "Found: $found"
fi
```

**Limit iterations:**
```bash
count=0
max=100

while read -r line; do
    ((count++))
    
    if ((count > max)); then
        echo "Limit reached"
        break
    fi
    
    echo "$count: $line"
done < large_file.txt
```
### Error Handling with Break
```bash
success=false

for attempt in {1..5}; do
    echo "Attempt $attempt..."
    
    if command_that_might_fail; then
        success=true
        break  # Success, exit retry loop
    fi
    
    sleep 2
done

if ! $success; then
    echo "Failed after 5 attempts"
    exit 1
fi
```
### Continue with Logging
```bash
processed=0
skipped=0

for file in *; do
    if [[ ! -f "$file" ]]; then
        ((skipped++))
        echo "Skipping non-file: $file"
        continue
    fi
    
    if [[ ! -r "$file" ]]; then
        ((skipped++))
        echo "Skipping unreadable: $file"
        continue
    fi
    
    # Process file
    process_file "$file"
    ((processed++))
done

echo "Processed: $processed, Skipped: $skipped"
```

### Using Break/Continue with Functions

```bash
should_skip() {
    local file=$1
    [[ -d "$file" ]] && return 0
    [[ "$file" == .* ]] && return 0
    return 1
}

for file in *; do
    if should_skip "$file"; then
        continue
    fi
    
    echo "Processing: $file"
done
```

***

**Exercise 1:** [[Find First Even Number in Array and Exit Loop]]
**Exercise 2:** [[Skip Processing of Hidden Files Using Continue]]
**Exercise 3:** [[Nested Loop Control with Labeled Breaks]]

**Daily Project:  [[File Searcher with Configurable Stop Behavior]]
