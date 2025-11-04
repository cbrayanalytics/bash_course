### Goal:
Create a script named `scope_demo.sh` that clearly demonstrates the difference between global and local variables.
### Requirements:
- Create functions that demonstrate:
  - Global variable access and modification
  - Local variable isolation
  - Variable shadowing (local with same name as global)
  - Parameter passing vs global access
  - Return values vs global modification
- Provide visual representation showing scope
- Include before/after comparisons
- Show practical examples of when to use each
- Demonstrate common pitfalls and solutions
### Hints:
- Without `local`, variables are global
- Use `local` keyword for function-local variables
- Show variable values before/after function calls
- Use descriptive variable names
- Add visual separators for clarity
### Expected Output Example:
```bash
./scope_demo.sh
```
```
╔════════════════════════════════════════════════════════════════╗
║          VARIABLE SCOPE DEMONSTRATION                          ║
╚════════════════════════════════════════════════════════════════╝

This script demonstrates how variable scope works in Bash functions.

══════════════════════════════════════════════════════════════
DEMO 1: Global Variables
══════════════════════════════════════════════════════════════

Setting up global variable:
  global_var = "I am global"

Before calling function:
  global_var = "I am global"

Calling function that accesses global variable...

Inside function:
  Accessing global_var: "I am global"
  ✓ Global variable is accessible inside function

After calling function:
  global_var = "I am global"

═══════════════════════════════════════════════════════════════
DEMO 2: Modifying Global Variables
═══════════════════════════════════════════════════════════════

Setting up:
  counter = 0

Before function:
  counter = 0

Calling function that modifies global variable...

Inside function:
  Setting counter to 10
  counter = 10

After function:
  counter = 10
  
⚠ WARNING: Function changed the global variable!

═══════════════════════════════════════════════════════════════
DEMO 3: Local Variables
═══════════════════════════════════════════════════════════════

Before function:
  outside_var = "undefined" (empty)

Calling function with local variable...

Inside function:
  Creating local variable: local_var = "I am local"
  local_var = "I am local"

After function:
  local_var = "undefined" (empty)
  
✓ Local variable only exists inside function

═══════════════════════════════════════════════════════════════
DEMO 4: Variable Shadowing
═══════════════════════════════════════════════════════════════

Setting up global:
  color = "red"

Before function:
  color = "red"

Calling function with LOCAL variable of same name...

Inside function:
  local color = "blue"
  color inside function = "blue"

After function:
  color = "red"
  
✓ Local variable shadowed the global one
✓ Global variable unchanged

═══════════════════════════════════════════════════════════════
DEMO 5: The Danger of Forgetting 'local'
═══════════════════════════════════════════════════════════════

Setting up:
  important_value = "original"

Before function:
  important_value = "original"

Calling function WITHOUT 'local' keyword...

Inside function:
  important_value = "accidentally changed"
  (Oops! Forgot 'local' keyword)

After function:
  important_value = "accidentally changed"
  
✗ DANGER: Global variable was unintentionally modified!
✗ Always use 'local' for function variables!

═══════════════════════════════════════════════════════════════
DEMO 6: Best Practice Comparison
═══════════════════════════════════════════════════════════════

BAD PRACTICE:
────────────────────────────────────────────────────────────────
calculate() {
    result=$(($ 1 + $2))  # NO local keyword!
}

calculate 5 3
echo "Result: $result"  # Works, but 'result' is now global

GOOD PRACTICE:
────────────────────────────────────────────────────────────────
calculate() {
    local result=$(($1 + $2))  # Uses local!
    echo $result               # Return via echo
}

result=$(calculate 5 3)
echo "Result: $result"

✓ Function doesn't pollute global namespace
✓ Clear intent to return value via echo
✓ Global variables remain unaffected

╔════════════════════════════════════════════════════════════════╗
║                        SUMMARY                                 ║
╚════════════════════════════════════════════════════════════════╝

Key Takeaways:
  1. Variables in functions are GLOBAL by default
  2. Use 'local' keyword to create function-local variables
  3. Local variables shadow global ones with the same name
  4. Always use 'local' unless you specifically need global access
  5. Return values via echo, not global variables

Visual Representation:
────────────────────────────────────────────────────────────────

Global Scope (entire script):
┌──────────────────────────────────────────────┐
│ global_var = "accessible everywhere"         │
│                                              │
│ Function Scope:                              │
│ ┌──────────────────────────────────────┐   │
│ │ local_var = "only here"             │   │
│ │ Can access: global_var              │   │
│ └──────────────────────────────────────┘   │
│                                              │
│ Outside function: local_var doesn't exist    │
└──────────────────────────────────────────────┘

Recommendations:
  ✓ Use local variables inside functions
  ✓ Pass data via parameters, not globals
  ✓ Return data via echo, not globals
  ✓ Only modify globals when necessary
  ✓ Document when functions modify globals

End of scope demonstration.
```
### Bonus Challenge:
- Add nested function scope demonstration
- Show exported variables behavior
- Demonstrate readonly variables
- Add interactive scope tester
- Create scope visualization tool
- Show array scope behavior
- Demonstrate associative array scope
- Add performance comparison (local vs global)
- Create scope debugging tool
- Show subshell scope behavior

***