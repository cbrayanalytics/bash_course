---
id: Day 7 - Arrays & Associative Arrays
aliases: []
tags: []
---

# Array Basics

Arrays in Bash allow you to store multiple values in a single variable.

**Declaration methods:**

```bash
# Method 1: Declare and assign
files=("file1.txt" "file2.txt" "file3.txt")

# Method 2: Declare then assign
declare -a numbers
numbers[0]=10
numbers[1]=20
numbers[2]=30

# Method 3: Assign multiple values
colors=(red green blue yellow)

# Method 4: Create from command output
files=($(ls *.txt))
```

## Accessing Array Elements

```bash
fruits=("apple" "banana" "cherry" "date")

echo ${fruits[0]}   # apple (first element)
echo ${fruits[1]}   # banana (second element)
echo ${fruits[-1]}  # date (last element)
echo ${fruits[-2]}  # cherry (second to last)
```

**All elements:**

```bash
echo ${fruits[@]}   # All elements as separate words
echo ${fruits[*]}   # All elements as single string
```

## Array Length

```bash
fruits=("apple" "banana" "cherry")

echo ${#fruits[@]}   # 3 (number of elements)
echo ${#fruits[0]}   # 5 (length of first element: "apple")
```

## Array Iteration

**Loop through all elements:**

```bash
for fruit in "${fruits[@]}"; do
    echo "Fruit: $fruit"
done
```

**Loop with index:**

```bash
for i in "${!fruits[@]}"; do
    echo "Index $i: ${fruits[$i]}"
done
```

**Traditional for loop:**

```bash
for ((i=0; i<${#fruits[@]}; i++)); do
    echo "Element $i: ${fruits[$i]}"
done
```

## Adding and Removing Elements

**Append elements:**

```bash
fruits+=("elderberry")
fruits[${#fruits[@]}]="fig"
```

**Remove elements:**

```bash
unset fruits[1]  # Remove element at index 1
unset fruits     # Remove entire array
```

**Note:** Removing an element doesn't shift indices; it creates a gap.

## Array Slicing

```bash
numbers=(0 1 2 3 4 5 6 7 8 9)

echo ${numbers[@]:2:4}   # 2 3 4 5 (start at index 2, length 4)
echo ${numbers[@]:5}     # 5 6 7 8 9 (from index 5 to end)
echo ${numbers[@]: -3}   # 7 8 9 (last 3 elements)
```

## Associative Arrays (Hash Maps/Dictionaries)

Associative arrays use strings as keys instead of numeric indices.

**Declaration:**

```bash
declare -A person
person[name]="John"
person[age]=30
person[city]="Denver"
```

**Alternative declaration:**

```bash
declare -A config=(
    [host]="localhost"
    [port]=8080
    [debug]="true"
)
```

## Accessing Associative Arrays

```bash
echo ${person[name]}    # John
echo ${person[age]}     # 30

# All keys
echo ${!person[@]}      # name age city

# All values
echo ${person[@]}       # John 30 Denver

# Number of key-value pairs
echo ${#person[@]}      # 3
```

## Iterating Associative Arrays

```bash
# Loop through keys and values
for key in "${!person[@]}"; do
    echo "$key: ${person[$key]}"
done
```

**Output:**

```
name: John
age: 30
city: Denver
```

### Checking if Key Exists

```bash
if [[ -v person[name] ]]; then
    echo "Key 'name' exists"
fi

# Or check if value is set
if [[ -n "${person[email]}" ]]; then
    echo "Email is set"
else
    echo "Email is not set"
fi
```

### Practical Examples

**Array of command results:**

```bash
# Store list of users
users=($(cut -d: -f1 /etc/passwd))
echo "Total users: ${#users[@]}"
```

**Configuration storage:**

```bash
declare -A database
database[host]="db.example.com"
database[port]=5432
database[name]="production"
database[user]="admin"

# Build connection string
conn_string="${database[user]}@${database[host]}:${database[port]}/${database[name]}"
```

---

- [ ] **Exercise 1:** [[Store and Loop Through a List of Filenames]]
- [ ] **Exercise 2:** [[Implement Stack Operations (pushpop) Using Arrays]]
- [ ] **Exercise 3:** [[Create Associative Array for Key-Value Configuration]]
- [ ] **Daily Project:** [[Student Grade Tracker with Associative Arrays]]
