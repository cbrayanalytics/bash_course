### Goal:
Create a script named `stack.sh` that implements stack data structure operations (Last-In-First-Out).
### Requirements:
- Implement these functions:
  - `push` - Add element to top of stack
  - `pop` - Remove and return top element
  - `peek` - View top element without removing
  - `size` - Return number of elements
  - `display` - Show all elements
- Demonstrate all operations with examples
- Handle empty stack errors (pop/peek on empty stack)
### Hints:
- Use regular array for the stack
- Push: `stack+=("value")`
- Pop: Get last element with `${stack[-1]}`, then `unset stack[-1]`
- Size: `${#stack[@]}`
- Check if empty: `[[ ${#stack[@]} -eq 0 ]]`
### Expected Output Example:
```bash
./stack.sh
```
```
╔════════════════════════════════════════╗
║     Stack Operations Demo              ║
╚════════════════════════════════════════╝

Initial stack: (empty)
Size: 0

--- Push Operations ---
Pushing: apple
Pushing: banana
Pushing: cherry

Stack: [apple, banana, cherry]
Size: 3

--- Peek Operation ---
Top element: cherry
Stack unchanged: [apple, banana, cherry]

--- Pop Operations ---
Popped: cherry
Popped: banana

Stack: [apple]
Size: 1

--- Pop from single element ---
Popped: apple
Stack: (empty)

--- Pop from empty stack ---
Error: Cannot pop from empty stack

╔════════════════════════════════════════╗
║     Final Stack State                  ║
╚════════════════════════════════════════╝
Size: 0
Status: Empty
```
### Bonus Challenge:
- Implement queue operations (FIFO) as well
- Add `clear` operation to empty the stack
- Create interactive mode where user can perform operations
- Implement max size limit for the stack
- Add `contains` function to check if element exists

***
