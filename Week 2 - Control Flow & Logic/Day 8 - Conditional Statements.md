### Understanding Test Commands
In Bash, conditional testing is done using the `test` command or its bracket equivalents. There are three forms:
``` bash
test expression          # Original test command
[ expression ]          # Single bracket (same as test)
[[ expression ]]        # Double bracket (modern, recommended)
```

**Important spacing rules:**
- Space required after `[` and before `]`
- Correct: `[ 5 -eq 5 ]`
- Wrong: `[5 -eq 5]`

**Recommended:** Use `[[ ]]` (double brackets) for modern Bash scripting because it's more powerful and handles edge cases better.
### Integer Comparison Operators
For comparing numbers, use these operators:
``` bash
-eq    # Equal to
-ne    # Not equal to
-gt    # Greater than
-lt    # Less than
-ge    # Greater than or equal to
-le    # Less than or equal to
```

**Examples:**
``` bash
num=10

if [[ $num -eq 10 ]]; then
    echo "Number is 10"
fi

if [[ $num -gt 5 ]]; then
    echo "Number is greater than 5"
fi

if [[ $num -le 20 ]]; then
    echo "Number is less than or equal to 20"
fi
```

**Common mistake:** Don't use `<` or `>` for integer comparison inside `[ ]` - they're for string comparison. Use `-lt` and `-gt` instead.
### String Comparison Operators
For comparing strings:
``` bash
=  or ==    # Equal to
!=          # Not equal to
<           # Less than (alphabetically)
>           # Greater than (alphabetically)
-z          # String is empty (zero length)
-n          # String is not empty (non-zero length)
```

**Examples:**
``` bash
name="John"

if [[ $name == "John" ]]; then
    echo "Name is John"
fi

if [[ $name != "Jane" ]]; then
    echo "Name is not Jane"
fi

if [[ -z $empty_var ]]; then
    echo "Variable is empty"
fi

if [[ -n $name ]]; then
    echo "Name variable is not empty"
fi
```

### Logical Operators (Combining Conditions)
Combine multiple conditions using logical operators:
```bash
&&    # AND - both conditions must be true
||    # OR - at least one condition must be true
!     # NOT - negates the condition
```

**Examples:**
``` bash
age=25
name="John"

# AND operator
if [[ $age -gt 18 && $name == "John" ]]; then
    echo "Adult named John"
fi

# OR operator
if [[ $age -lt 18 || $age -gt 65 ]]; then
    echo "Either minor or senior"
fi

# NOT operator
if [[ ! $name == "Jane" ]]; then
    echo "Name is not Jane"
fi
```

**Alternative syntax for multiple conditions:**
``` bash
# Separate test commands
if [[ $age -gt 18 ]] && [[ $name == "John" ]]; then
    echo "Adult named John"
fi
```

### if/elif/else Structure
Complete conditional structure:
``` bash
if [[ condition1 ]]; then
    # Execute if condition1 is true
elif [[ condition2 ]]; then
    # Execute if condition1 is false and condition2 is true
elif [[ condition3 ]]; then
    # Execute if previous conditions are false and condition3 is true
else
    # Execute if all conditions are false
fi
```

**Example:**
``` bash
score=85

if [[ $score -ge 90 ]]; then
    echo "Grade: A"
elif [[ $score -ge 80 ]]; then
    echo "Grade: B"
elif [[ $score -ge 70 ]]; then
    echo "Grade: C"
elif [[ $score -ge 60 ]]; then
    echo "Grade: D"
else
    echo "Grade: F"
fi
```

### Nested Conditions
You can nest if statements inside each other:
``` bash
if [[ $age -ge 18 ]]; then
    echo "You are an adult"
    
    if [[ $age -ge 65 ]]; then
        echo "You are a senior citizen"
    fi
else
    echo "You are a minor"
fi
```

### Exit Status and Conditions
Every command returns an exit status (stored in `$?`):
- `0` = Success (true)
- Non-zero = Failure (false)
```bash
# Using command success as condition
if grep "error" logfile.txt; then
    echo "Errors found in log"
fi

# Check exit status explicitly
ls /nonexistent
if [[ $? -ne 0 ]]; then
    echo "Command failed"
fi
```
### Practical Examples
**Check if variable is set:**
``` bash
if [[ -z "$var" ]]; then
    echo "Variable is not set or empty"
    exit 1
fi
```

**Range checking:**
```bash
if [[ $num -ge 1 && $num -le 100 ]]; then
    echo "Number is between 1 and 100"
fi
```

**Multiple OR conditions:**
```bash
if [[ $input == "yes" || $input == "y" || $input == "Y" ]]; then
    echo "User confirmed"
fi
```

***

- [ ] **Exercise 1:** [[Script That Checks if Number is Positive, Negative, or Zero]]
- [ ] **Exercise 2:** [[Validate User Age Input (Numeric, Within Range)]]
- [ ] **Exercise 3:** [[Check Multiple Conditions with Logical Operators]]
- [ ] **Daily Project:** [[File Permission Checker]]
