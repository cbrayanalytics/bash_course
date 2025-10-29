## The read Command Basics
The `read` command is a built-in Bash utility that captures user input from standard input and stores it in variables[1][3]. 

**Basic syntax:**
```bash
read variable_name
```

**Example:**
```bash
echo "Enter your name:"
read name
echo "Hello, $name"
```

When executed, the script pauses and waits for user input. After the user types and presses Enter, the input is stored in the variable[3].

***
## Multiple Variables
You can read multiple inputs into separate variables:
```bash
read first_name last_name
echo "Hello, $first_name $last_name"
```

If the user enters more words than variables, the extra words go into the last variable. If fewer words are entered, remaining variables are empty[1].

## read Command Options
The `read` command supports several options to control input behavior[1][6]:

**`-p` (Prompt)** - Display a prompt before reading:
```bash
read -p "Enter your name: " name
```

**`-s` (Silent)** - Hide input (useful for passwords):
```bash
read -sp "Enter password: " password
echo  # New line after hidden input
```

**`-t` (Timeout)** - Set a timeout in seconds:
```bash
read -t 5 -p "You have 5 seconds: " response
```

**`-n` (Number of characters)** - Read only N characters:
```bash
read -n 1 -p "Press any key to continue..."
```

**`-a` (Array)** - Store input into an array:
```bash
read -a numbers -p "Enter numbers: "
echo "First: ${numbers[0]}, Second: ${numbers[1]}"
```

**`-r` (Raw)** - Prevent backslash interpretation:
```bash
read -r path  # Backslashes in paths won't be escaped
```

### Input Validation Basics

Always validate user input to ensure your script behaves correctly[1][5]:

**Check if variable is empty:**
```bash
read -p "Enter your name: " name
if [[ -z "$name" ]]; then
    echo "Error: Name cannot be empty"
    exit 1
fi
```

**Validate numeric input:**
```bash
read -p "Enter your age: " age
if ! [[ "$age" =~ ^[0-9]+$ ]]; then
    echo "Error: Age must be a number"
    exit 1
fi
```

**Validate against options:**
```bash
read -p "Continue? (y/n): " answer
if [[ ! "$answer" =~ ^[yn]$ ]]; then
    echo "Error: Please enter y or n"
    exit 1
fi
```

### Combining Options

You can combine multiple options:
```bash
# Prompt with timeout and silent mode
read -t 10 -sp "Enter password (10 sec timeout): " passwd
echo

# Prompt with character limit
read -n 1 -p "Press Y to continue: " confirm
echo
```

### Default Values with REPLY

If you don't specify a variable name, `read` uses the special variable `$REPLY`:
```bash
read -p "Enter something: "
echo "You entered: $REPLY"
```

***

- [ ] **Exercise 1:** [[Interactive Script That Asks for User Details]]
- [ ] **Exercise 2:** [[Password Input Script Using Silent Read]]
- [ ] **Exercise 3:** [[Timed Input with Timeout Handling]]
- [ ] **Daily Project:** [[Interactive System Configuration Wizard]]

