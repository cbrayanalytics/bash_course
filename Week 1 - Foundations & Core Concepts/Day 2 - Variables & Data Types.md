# Day 2: Variables & Data Types

### Variable Declaration

In Bash, variables are declared by simply assigning a value with **no spaces** around the equals sign:
```bash
name="John"
age=25
greeting="Hello, World"
```

**Key Rules:**
- No spaces around `=`
- No data type declaration needed
- Variable names are case-sensitive
- Access variables with `$variable_name` or `${variable_name}`

***
### Naming Conventions

**Valid variable names:**
- Start with letter or underscore
- Contain letters, numbers, underscores
- Examples: `user_name`, `count1`, `_temp`

**Conventions:**
- Use lowercase for local variables: `my_var`
- Use UPPERCASE for constants/environment variables: `MAX_SIZE`
- Use underscores for readability: `first_name` not `firstname`

***
### Local vs Global Scope

**Global variables** are accessible throughout the script[1][7]:
```bash
global_var="I'm global"

function my_function() {
    echo "$global_var"  # Can access global
}
```

**Local variables** only exist within functions[7]:
```bash
function my_function() {
    local local_var="I'm local"
    echo "$local_var"
}
# local_var not accessible here
```

**Export variables** to make them available to child processes[9]:
```bash
export MY_VAR="value"
./another_script.sh  # Can access MY_VAR
```

***
### Special Variables

Bash provides special built-in variables[2]:

- `$0` - Script name
- `$?` - Exit status of last command (0 = success)
- `$$` - Process ID (PID) of current script
- `$#` - Number of arguments passed
- `$@` - All arguments as separate words
- `$*` - All arguments as single string
- `$1, $2, $3...` - Individual positional arguments

**Example:**
```bash
#!/bin/bash
echo "Script name: $0"
echo "Process ID: $$"

ls /nonexistent
echo "Exit status: $?"  # Will be non-zero (error)

sleep 1
echo "Exit status: $?"  # Will be 0 (success)
```

***

- [x] **Exercise 1**:  [[Store and Display Variable Types]]
- [x] **Exercise 2:**  [[Calculate and Display Script Runtime Using Special Variables]]
- [x] **Exercise 3:** [[Export Variables and Demonstrate Scope Differences]]
- [x] **Daily Project:** [[Environment Info Script]]
