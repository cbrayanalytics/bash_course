### Basic For Loop Syntax
Bash supports multiple for loop styles for different use cases.

**List-based for loop (most common):**
```bash
for item in list of items; do
    # commands using $item
done
```

**Example:**
```bash
for fruit in apple banana cherry; do
    echo "Fruit: $fruit"
done
```

Output:
```
Fruit: apple
Fruit: banana
Fruit: cherry
```
### Range Iteration with Brace Expansion
Use brace expansion `{start..end}` for numeric ranges:
```bash
# Numbers 1 to 10
for i in {1..10}; do
    echo "Number: $i"
done

# Numbers 5 to 15
for i in {5..15}; do
    echo $i
done

# With step/increment
for i in {0..100..10}; do
    echo $i  # Prints: 0, 10, 20, ... 100
done

# Countdown
for i in {10..1}; do
    echo "T-minus $i"
done
```

**Letters:**
```bash
for letter in {a..z}; do
    echo "Letter: $letter"
done

# Uppercase
for letter in {A..Z}; do
    echo $letter
done
```

**Zero-padded numbers:**
```bash
for i in {01..10}; do
    echo "Number: $i"  # 01, 02, 03, ... 10
done
```

### C-Style For Loop
Similar to C, Java, or JavaScript:
```bash
for ((initialization; condition; increment)); do
    # commands
done
```

**Examples:**
```bash
# Count 1 to 10
for ((i=1; i<=10; i++)); do
    echo "Count: $i"
done

# Count by 2s
for ((i=0; i<=20; i+=2)); do
    echo $i  # 0, 2, 4, 6, ... 20
done

# Countdown
for ((i=10; i>=1; i--)); do
    echo "T-minus $i"
done

# Multiple variables
for ((i=0, j=10; i<=5; i++, j--)); do
    echo "i=$i, j=$j"
done
```
### Array Iteration
Loop through array elements:
```bash
# Declare array
fruits=("apple" "banana" "cherry" "date")

# Iterate over values
for fruit in "${fruits[@]}"; do
    echo "Fruit: $fruit"
done

# Iterate over indices
for i in "${!fruits[@]}"; do
    echo "Index $i: ${fruits[$i]}"
done

# C-style with array length
for ((i=0; i<${#fruits[@]}; i++)); do
    echo "Position $i: ${fruits[$i]}"
done
```

**Associative array iteration:**
```bash
declare -A person=(
    [name]="John"
    [age]="30"
    [city]="Denver"
)

# Loop through keys
for key in "${!person[@]}"; do
    echo "$key: ${person[$key]}"
done
```

### File Globbing
Loop through files matching patterns:
**All files in current directory:**
```bash
for file in *; do
    echo "File: $file"
done
```

**Specific extension:**
```bash
# All .txt files
for file in *.txt; do
    echo "Text file: $file"
done

# All .sh scripts
for script in *.sh; do
    echo "Script: $script"
    chmod +x "$script"
done
```

**Multiple patterns:**
```bash
# All images
for file in *.jpg *.png *.gif; do
    echo "Image: $file"
done
```

**Files in subdirectories:**
```bash
# All .txt files in subdirectories
for file in */*.txt; do
    echo "File: $file"
done

# Recursive (with globstar enabled)
shopt -s globstar
for file in **/*.txt; do
    echo "Found: $file"
done
```

**Handle no matches gracefully:**
```bash
shopt -s nullglob  # Empty list if no matches
for file in *.txt; do
    echo "Processing: $file"
done
```

### Nested Loops
Loops within loops:
```bash
# Nested loop example
for i in {1..3}; do
    for j in {1..3}; do
        echo "i=$i, j=$j"
    done
done
```

**Multiplication table:**
```bash
for i in {1..10}; do
    for j in {1..10}; do
        product=$((i * j))
        printf "%4d" $product
    done
    echo  # New line after each row
done
```

**File processing with nested loop:**
```bash
for dir in */; do
    echo "Processing directory: $dir"
    for file in "$dir"*.txt; do
        echo "  - File: $file"
    done
done
```
### Loop Control
**Continue - skip to next iteration:**
```bash
for i in {1..10}; do
    if ((i % 2 == 0)); then
        continue  # Skip even numbers
    fi
    echo $i  # Only prints odd numbers
done
```

**Break - exit loop:**
```bash
for i in {1..100}; do
    if ((i > 10)); then
        break  # Stop at 10
    fi
    echo $i
done
```

### Command Substitution in Loops
Loop through command output:
```bash
# Loop through lines of output
for user in $(cut -d: -f1 /etc/passwd); do
    echo "User: $user"
done

# Better: use while read for lines with spaces
while IFS= read -r line; do
    echo "Line: $line"
done < file.txt

# Loop through files from find
for file in $(find . -name "*.txt"); do
    echo "Found: $file"
done
```
### Practical Examples
**Create multiple directories:**
```bash
for i in {1..5}; do
    mkdir -p "project_$i"
done
```

**Backup multiple files:**
```bash
for file in *.conf; do
    cp "$file" "$file.backup"
done
```

**Process files with progress:**
```bash
files=(*.txt)
total=${#files[@]}
count=0

for file in "${files[@]}"; do
    ((count++))
    echo "Processing $count/$total: $file"
    # Process file here
done
```

**Rename files:**
```bash
for file in *.JPG; do
    mv "$file" "${file%.JPG}.jpg"
done
```

***

- [ ] **Exercise 1:** [[Print Numbers 1-20 with Loop]]
- [ ] **Exercise 2:** [[Iterate Through Files in Directory with Specific Extension]]
- [ ] **Exercise 3:** [[Nested Loops to Create Multiplication Table]]
- [ ] **Daily Project:** [[Batch File Renamer]]
