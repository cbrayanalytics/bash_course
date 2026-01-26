## Goal:
Create a script named `stack.sh` that implements stack data structure operations (Last-In-First-Out).
## Requirements:
- Implement these functions:
  - `push` - Add element to top of stack
  - `pop` - Remove and return top element
  - `peek` - View top element without removing
  - `size` - Return number of elements
  - `display` - Show all elements
- Demonstrate all operations with examples
- Handle empty stack errors (pop/peek on empty stack)
## Hints:
- Use regular array for the stack
- Push: `stack+=("value")`
- Pop: Get last element with `${stack[-1]}`, then `unset stack[-1]`
- Size: `${#stack[@]}`
- Check if empty: `[[ ${#stack[@]} -eq 0 ]]`

***
## Bonus Challenge:
- Implement queue operations (FIFO) as well
- Add `clear` operation to empty the stack
- Create interactive mode where user can perform operations
- Implement max size limit for the stack
- Add `contains` function to check if element exists

***
## Pseudocode for stack.sh

```sh
BEGIN stack.sh

  SET global IFS to newline + tab (for safer word splitting in most of script)

  DEFINE MAX_STACK_SIZE = 100
    # Max allowed elements in stack/queue
    # If MAX_STACK_SIZE <= 0, treat as “no limit”


## Helper Functions

### display_usage

FUNCTION display_usage()
  PRINT:
    "Usage: ./stack.sh [interactive|fifo|bonus|help]"
    ""
    "Run without arguments for demo mode"
    "Run with 'interactive / -i' for interactive mode"
    ""
    "Interactive Stack Operations:"
    "  push <value>   - Add element to top"
    "  pop            - Remove and return top element"
    "  peek           - View top element"
    "  size           - Show number of elements"
    "  display        - Show all elements"
    "  clear          - Empty the stack"
    "  contains <val> - Check if element exists"
    ""
    "Extra modes:"
    "  fifo / -f   - Demonstrate queue (FIFO) operations"
    "  bonus / -b  - Demonstrate bonus stack features"
    "  help / -h   - Show this help message"
END FUNCTION

### display_error

FUNCTION display_error(error_msg)
  PRINT "✗ Error: " + error_msg TO stderr
END FUNCTION

### display_header

FUNCTION display_header(title)
  SET inner_width = 40
  SET title_len   = length(title)

  SET padding_left  = (inner_width - title_len) / 2 (integer division)
  SET padding_right = inner_width - title_len - padding_left

  PRINT top border line using box characters
  PRINT line:
    "║" + (padding_left spaces) + title + (padding_right spaces) + "║"
  PRINT bottom border line
  PRINT blank line
END FUNCTION


## Core Stack Operations

### stack_is_empty

FUNCTION stack_is_empty(stack)
  IF length(stack) == 0 THEN
    RETURN true  (0)
  ELSE
    RETURN false (1)
  END IF
END FUNCTION

### stack_push

FUNCTION stack_push(stack, value)
  # If MAX_STACK_SIZE > 0, enforce capacity
  IF MAX_STACK_SIZE > 0 AND length(stack) >= MAX_STACK_SIZE THEN
    CALL display_error("Stack overflow - maximum size reached")
    RETURN failure
  END IF

  APPEND value to end of stack   # top of stack

  PRINT "Pushed: " + value
  RETURN success
END FUNCTION

### stack_pop

FUNCTION stack_pop(stack)
  IF stack_is_empty(stack) THEN
    CALL display_error("Cannot pop from an empty stack")
    RETURN failure
  END IF

  SET top_element = last element of stack
  REMOVE last element from stack

  # (Note: the Bash version also re-slices the array; conceptually,
  # removing the last element is enough as “pop”)
  # stack = stack[1..end] is redundant for LIFO, but present in code.

  PRINT "Popped: " + top_element
  RETURN success
END FUNCTION

### stack_peek

FUNCTION stack_peek(stack)
  IF stack_is_empty(stack) THEN
    CALL display_error("Cannot peek - stack is empty")
    RETURN failure
  END IF

  SET top_element = last element of stack
  PRINT "Top element: " + top_element
  RETURN success
END FUNCTION

### stack_size

FUNCTION stack_size(stack)
  SET count = length(stack)
  PRINT count
END FUNCTION

### stack_display

FUNCTION stack_display(stack)
  SET count = length(stack)

  IF count == 0 THEN
    PRINT "Stack: (empty)"
    RETURN
  END IF

  INITIALIZE display_string = "["

  FOR i FROM 0 TO count - 1 DO
    APPEND stack[i] to display_string
    IF i != count - 1 THEN
      APPEND ", " to display_string
    END IF
  END FOR

  APPEND "]" to display_string

  PRINT "Stack: " + display_string
END FUNCTION


## Bonus Stack Functions

### stack_clear

FUNCTION stack_clear(stack)
  SET stack to empty array
  PRINT "Stack cleared"
END FUNCTION

### stack_contains

FUNCTION stack_contains(stack, search_value)
  FOR EACH element IN stack DO
    IF element == search_value THEN
      PRINT "true"
      RETURN success
    END IF
  END FOR

  PRINT "false"
  RETURN failure
END FUNCTION

### stack_get_status

FUNCTION stack_get_status(stack)
  SET count = length(stack)

  IF count == 0 THEN
    PRINT "Empty"
  ELSE IF MAX_STACK_SIZE > 0 AND count == MAX_STACK_SIZE THEN
    PRINT "Full"
  ELSE
    PRINT "Active (" + count + " elements)"
  END IF
END FUNCTION


## Queue Operations (FIFO)

### queue_enqueue

FUNCTION queue_enqueue(queue, value)
  IF MAX_STACK_SIZE > 0 AND length(queue) >= MAX_STACK_SIZE THEN
    CALL display_error("Queue is full")
    RETURN failure
  END IF

  APPEND value to end of queue
  PRINT "Enqueued: " + value
  RETURN success
END FUNCTION

### queue_dequeue

FUNCTION queue_dequeue(queue, out_variable)
  IF length(queue) == 0 THEN
    CALL display_error("Cannot dequeue from empty queue")
    RETURN failure
  END IF

  SET front_element = queue[0]
  SET out_variable  = front_element

  # Remove first element and shift rest left:
  SET queue = elements of queue from index 1 onward

  RETURN success
END FUNCTION

### queue_peek_front

FUNCTION queue_peek_front(queue)
  IF length(queue) == 0 THEN
    CALL display_error("Cannot peek - queue is empty")
    RETURN failure
  END IF

  SET front_element = queue[0]
  PRINT front_element
  RETURN success
END FUNCTION

## Interactive Mode

FUNCTION interactive_mode(stack)
  SET local IFS to single space (so user input splits on spaces)

  CALL display_header("Interactive Stack Mode")
  PRINT "Type 'help' for available commands, 'quit' to exit"
  PRINT blank line

  LOOP forever:
    PROMPT "> " and READ line into array input[]
      # input[0] is command, input[1..] are arguments

    SET command   = input[0]
    SET arguments = all elements of input starting from index 1

    SWITCH command:
      CASE "push":
        IF arguments is empty THEN
          PRINT "Usage: push <value>"
        ELSE
          CALL stack_push(stack, arguments[0])
        END IF

      CASE "pop":
        CALL stack_pop(stack)

      CASE "peek":
        CALL stack_peek(stack)

      CASE "size":
        SET size_str = output of stack_size(stack)
        PRINT "Size: " + size_str

      CASE "display" OR "show":
        CALL stack_display(stack)

      CASE "status":
        CALL stack_get_status(stack)

      CASE "clear":
        CALL stack_clear(stack)

      CASE "contains":
        IF arguments is empty THEN
          PRINT "Usage: contains <value>"
        ELSE
          # stack_contains prints "true"/"false"; return code is also used
          IF stack_contains(stack, arguments[0]) succeeds THEN
            PRINT 'Element "<value>" exists in stack'
          ELSE
            PRINT 'Element "<value>" not found'
          END IF
        END IF

      CASE "help":
        CALL display_usage()

      CASE "quit" OR "exit":
        PRINT "Exiting interactive mode"
        RETURN

      CASE "" (empty line):
        # Do nothing

      DEFAULT:
        PRINT "Unknown command: " + command
        PRINT "Type 'help' for available commands"
    END SWITCH

    PRINT blank line
  END LOOP
END FUNCTION


## Demonstration Mode

### demo_stack_operations

FUNCTION demo_stack_operations(stack)
  CALL display_header("Stack Operations Demo")

  PRINT "Initial stack: (empty)"
  SET count = stack_size(stack)
  PRINT "Size: " + count
  PRINT blank line

  PRINT "--- Push Operations ---"
  CALL stack_push(stack, "apple")
  CALL stack_push(stack, "banana")
  CALL stack_push(stack, "cherry")
  PRINT blank line

  CALL stack_display(stack)
  SET count = stack_size(stack)
  PRINT "Size: " + count
  PRINT blank line

  PRINT "--- Peek Operations ---"
  CALL stack_peek(stack)
  PRINT "Stack unchanged"
  CALL stack_display(stack)
  PRINT blank line

  PRINT "--- Pop Operations ---"
  CALL stack_pop(stack)
  CALL stack_pop(stack)
  PRINT blank line

  CALL stack_display(stack)
  SET count = stack_size(stack)
  PRINT "Size: " + count
  PRINT blank line

  # Pop from single element
  CALL stack_pop(stack)
  CALL stack_display(stack)
  PRINT blank line

  PRINT "--- Pop from empty stack ---"
  CALL stack_pop(stack)  # triggers error
  PRINT blank line

  CALL display_header("Final Stack State")
  SET count = stack_size(stack)
  PRINT "Size: " + count
  SET status = stack_get_status(stack)
  PRINT "Status: " + status
  PRINT blank line
END FUNCTION

### demo_bonus_features

FUNCTION demo_bonus_features(stack)
  CALL display_header("Bonus Features Demo")

  CALL stack_clear(stack)
  CALL stack_push(stack, "one")
  CALL stack_push(stack, "two")
  CALL stack_push(stack, "three")
  PRINT blank line

  PRINT "--- Contains Operation ---"
  SET found_one = output of stack_contains(stack, "two")
  IF found_one == "true" THEN
    PRINT "✓ Stack contains 'two'"
  END IF

  SET found_two = output of stack_contains(stack, "four")
  IF found_two == "true" THEN
    PRINT "✓ Stack contains 'four'"
  END IF
  PRINT blank line

  PRINT "--- Status Check ---"
  SET status = stack_get_status(stack)
  PRINT "Current status: " + status
  PRINT blank line
END FUNCTION

### demo_queue_operations

FUNCTION demo_queue_operations(queue)
  DECLARE name_ref_one, name_ref_two

  CALL display_header("Queue Operations Demo (FIFO)")

  PRINT "--- Enqueue Operation ---"
  CALL queue_enqueue(queue, "first")
  CALL queue_enqueue(queue, "second")
  CALL queue_enqueue(queue, "third")
  PRINT blank line

  CALL stack_display(queue)        # reuse stack_display for array contents
  PRINT blank line

  PRINT "--- Dequeue Operation ---"
  CALL queue_dequeue(queue, name_ref_one)
  PRINT "Dequeued element: " + name_ref_one
  CALL queue_dequeue(queue, name_ref_two)
  PRINT "Dequeued element: " + name_ref_two
  PRINT blank line

  CALL stack_display(queue)
  PRINT blank line

  PRINT "--- Peek Operation ---"
  SET peeked_element = output of queue_peek_front(queue)
  PRINT "Peeked element: " + peeked_element
  PRINT blank line
END FUNCTION


## Main Logic

FUNCTION main(args)
  INITIALIZE stack as empty array

  SWITCH first argument (or empty string if none):
    CASE "interactive" OR "-i":
      CALL interactive_mode(stack)

    CASE "help" OR "-h":
      CALL display_usage()

    CASE "fifo" OR "-f":
      CALL demo_queue_operations(stack)

    CASE "bonus" OR "-b":
      CALL demo_bonus_features(stack)

    CASE "" (no arguments):
      CALL demo_stack_operations(stack)
      PRINT blank line
      CALL demo_bonus_features(stack)
      PRINT blank line
      CALL demo_queue_operations(stack)

    DEFAULT:
      CALL display_error("Unknown mode: " + first argument)
      CALL display_usage()
      RETURN failure
  END SWITCH

  RETURN success
END FUNCTION

CALL main(with command-line arguments)

END stack.sh
```

***
## Key Data Structure Concepts

### Stack (LIFO - Last In, First Out)
```
Stack operations on: [A, B, C]
                           ↑ top

Push D:  [A, B, C, D]  ← Add to end
Pop:     [A, B, C]     ← Remove from end
Peek:    Returns 'C' without removing
```

### Queue (FIFO - First In, First Out)
```
Queue operations on: [A, B, C]
                      ↑       ↑
                    front    rear

Enqueue D:  [A, B, C, D]   ← Add to rear
Dequeue:    [B, C, D]      ← Remove from front
```

***

## Implementation Patterns

### Pattern 1: Safe Access with Empty Check
```
FUNCTION operation(stack_ref)
  IF stack is empty THEN
    DISPLAY error
    RETURN failure
  END IF
  
  # Perform operation
  ...
ENDFUNCTION
```

### Pattern 2: Return Multiple Values
```
FUNCTION pop(stack_ref) RETURNS (success, value)
  IF valid THEN
    RETURN (true, element)
  ELSE
    RETURN (false, "")
  END IF
ENDFUNCTION
```

### Pattern 3: Reference Passing for Modification
```
FUNCTION push(stack_ref, value)
  # Modify the actual stack via reference
  APPEND value to stack_ref
ENDFUNCTION
```


***
## Expected Output Example:

```bash

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
