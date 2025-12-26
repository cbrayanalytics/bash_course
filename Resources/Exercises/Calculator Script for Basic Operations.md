## Goal:
Create a script named `calc.sh` that performs basic arithmetic operations (+, -, \*, /) on two numbers.

***
## Requirements:
- Accept three arguments: number1, operator, number2
- Support these operators: `+`, `-`, `*`, `/`
- Perform the calculation using `$(())`
- Display the operation and result
- Handle division by zero

***
## Hints:
- Use `$1` for first number, `$2` for operator, `$3` for second number
- Use a case statement to handle different operators
- For division, check if `$3` equals 0 before calculating
- Remember that `*` might need escaping in some contexts

***
## Expected Output Example:
```bash
./calc.sh 10 + 5
```
```
10 + 5 = 15
```

```bash
./calc.sh 20 / 4
```
```
20 / 4 = 5
```

```bash
./calc.sh 10 / 0
```
```
Error: Division by zero is not allowed
```

***
## Bonus Challenge:
- Add support for multiple operations in sequence
- Validate that arguments are numeric
- Add parentheses support for complex expressions

***
## Pseudocode (with Bonus Challenges):

```bash
BEGIN calc.sh

  // ========================================
  // FUNCTIONS
  // ========================================

  FUNCTION display_usage()
    DISPLAY "Usage:"
    DISPLAY "  ./calc.sh <number1> <operator> <number2>"
    DISPLAY "  ./calc.sh <expression parts...>"
    DISPLAY ""
    DISPLAY "Examples:"
    DISPLAY "  ./calc.sh 10 + 5"
    DISPLAY "  ./calc.sh 20 / 4"
    DISPLAY "  ./calc.sh 10 / 0"
    DISPLAY "  ./calc.sh 10 + 5 - 3 * 2"
    DISPLAY "  ./calc.sh '(10 + 5) * 2'"
  END FUNCTION


  FUNCTION display_error(message)
    DISPLAY "Error: " + message
  END FUNCTION


  FUNCTION is_integer(value)
    // Return true if value matches optional '-' followed by digits only
    IF value matches pattern: optional "-" then one or more digits THEN
      RETURN true
    ELSE
      RETURN false
    END IF
  END FUNCTION


  FUNCTION validate_tokens(tokens_array)
    // tokens_array is all arguments as separate tokens
    // Allowed: integers, + - * / ( ) and possibly spaces between them
    FOR EACH token IN tokens_array DO
      IF token is one of "+", "-", "*", "/", "(", ")" THEN
        CONTINUE
      ELSE IF is_integer(token) is true THEN
        CONTINUE
      ELSE
        CALL display_error("Invalid token in expression: " + token)
        EXIT with status 1
      END IF
    END FOR
  END FUNCTION


  FUNCTION contains_division_by_zero(tokens_array)
    // Scan tokens for the pattern: "/" followed by "0"
    SET i = 1
    WHILE i < length of tokens_array DO
      SET current = tokens_array[i]
      SET next    = tokens_array[i + 1] (if exists)
      IF current == "/" AND next == "0" THEN
        RETURN true
      END IF
      INCREMENT i
    END WHILE
    RETURN false
  END FUNCTION


  FUNCTION build_expression_string(tokens_array)
    // Join all tokens with a single space (or no space) into one expression
    SET expr = empty string
    FOR EACH token IN tokens_array DO
      IF expr is empty THEN
        SET expr = token
      ELSE
        SET expr = expr + " " + token
      END IF
    END FOR
    RETURN expr
  END FUNCTION


  FUNCTION evaluate_expression(expr)
    // Use shell arithmetic evaluation
    // In real bash: result=$(( expr ))
    ATTEMPT to evaluate expr as arithmetic
    IF evaluation failed THEN
      CALL display_error("Invalid expression")
      EXIT 1
    END IF
    RETURN result
  END FUNCTION


  // ========================================
  // MAIN LOGIC
  // ========================================

  // Step 1: Require at least 3 arguments (e.g. num op num) OR a complex expression
  IF argument count ($#) < 3 THEN
    CALL display_error("Not enough arguments")
    CALL display_usage()
    EXIT 1
  END IF

  // Step 2: Gather all arguments as tokens (for complex expression support)
  SET tokens_array = all arguments as list

  // Step 3: Validate tokens (only integers and allowed operators/parentheses)
  CALL validate_tokens(tokens_array)

  // Step 4: Check for division by zero in simple pattern "/ 0"
  IF contains_division_by_zero(tokens_array) is true THEN
    DISPLAY "Error: Division by zero is not allowed"
    EXIT 1
  END IF

  // Step 5: Build expression string
  SET expr = build_expression_string(tokens_array)

  // Step 6: Evaluate expression with full precedence and parentheses
  SET result = evaluate_expression(expr)

  // Step 7: Display expression and result
  DISPLAY expr + " = " + result

  EXIT 0

END calc.sh
```
