## Arithmetic Expansion $(())
The most common and efficient way to perform integer arithmetic in Bash is using `$(())`:

```bash
result=$((5 + 3))
echo $result  # Output: 8
```

**Basic operations:**
```bash
a=10
b=3

echo $((a + b))   # Addition: 13
echo $((a - b))   # Subtraction: 7
echo $((a * b))   # Multiplication: 30
echo $((a / b))   # Division (integer): 3
echo $((a % b))   # Modulo (remainder): 1
echo $((a ** b))  # Exponentiation: 1000
```

**Important:** `$(())` only handles integers. Division truncates to integer result.

**Compound operations:**
```bash
result=$((5 + 3 * 2))      # 11 (follows order of operations)
result=$(((5 + 3) * 2))    # 16 (use parentheses for grouping)
```

**Increment/decrement:**
```bash
count=5
((count++))    # count is now 6
((count--))    # count is now 5
((count += 3)) # count is now 8
((count *= 2)) # count is now 16
```

**Comparison in arithmetic context:**
```bash
if ((a > b)); then
    echo "a is greater"
fi

# Returns 1 (true) or 0 (false)
result=$((5 > 3))  # result=1
```
## The expr Command
`expr` is an older external command for arithmetic (less commonly used now):

```bash
result=$(expr 5 + 3)
echo $result  # Output: 8

# Note: operators must be separated by spaces and * must be escaped
result=$(expr 5 \* 3)
```

**Limitations:** Slower (external command), requires careful escaping of special characters.
## The let Command
`let` is a built-in command for arithmetic evaluation:

```bash
let result=5+3
echo $result  # Output: 8

let "result = 5 + 3"  # With spaces (use quotes)
let result+=5         # result is now 13
let result++          # result is now 14
```

## Floating-Point Arithmetic with bc
Bash doesn't support floating-point natively. Use `bc` (basic calculator) for decimals:

```bash
result=$(echo "scale=2; 10 / 3" | bc)
echo $result  # Output: 3.33
```

**Scale sets decimal places:**
```bash
# No scale (integer division)
echo "10 / 3" | bc          # Output: 3

# With scale
echo "scale=4; 10 / 3" | bc # Output: 3.3333
```

**Complex calculations:**
```bash
# Multiple operations
result=$(echo "scale=2; (5.5 + 3.2) * 2 / 1.5" | bc)

# Using variables
a=10.5
b=3.2
result=$(echo "scale=2; $a + $b" | bc)
echo $result  # Output: 13.70
```

**bc functions:**
```bash
# Square root
echo "sqrt(16)" | bc                    # Output: 4

# Power
echo "2^10" | bc                        # Output: 1024

# Pi (load math library with -l)
echo "scale=10; 4*a(1)" | bc -l        # Output: 3.1415926532
```

## Practical Examples

**Calculate percentage:**
```bash
total=200
part=45
percentage=$(echo "scale=2; ($part * 100) / $total" | bc)
echo "$percentage%"  # Output: 22.50%
```

**Convert units:**
```bash
bytes=1048576
mb=$(echo "scale=2; $bytes / 1024 / 1024" | bc)
echo "${mb}MB"  # Output: 1.00MB
```

***

**Exercise 1:** [[Calculator Script for Basic Operations]]
**Exercise 2:** [[Perform Modulo and Exponentiation Operations]]
**Exercise 3:** [[Floating-Point Calculations Using bc]]

**Daily Project:** [[Disk Space Calculator with Unit Conversion]]

