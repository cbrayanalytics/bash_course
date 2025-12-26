## Goal:
Create a script named `advanced_calc.sh` that performs modulo (%) and exponentiation (**) operations.

***
## Requirements:
- Accept operation type as first argument: `mod` or `exp`
- Accept two numbers as additional arguments
- For `mod`: calculate remainder of division
- For `exp`: calculate power (base^exponent)
- Display practical examples of what these operations mean
- Show step-by-step calculation for exponentiation

***
## Hints:
- Use `$((a % b))` for modulo
- Use `$((a ** b))` for exponentiation
- Modulo is useful for checking even/odd, divisibility
- Show the multiplication steps for exponentiation

***
## Expected Output Example:
```bash
./advanced_calc.sh mod 17 5
```
```
Modulo Operation: 17 % 5
Result: 2

Explanation: 17 ÷ 5 = 3 remainder 2
(5 × 3 = 15, and 17 - 15 = 2)

Use case: Check if 17 is divisible by 5? No (remainder is not 0)
```

```bash
./advanced_calc.sh exp 2 8
```
```
Exponentiation: 2^8
Result: 256

Calculation steps:
2^1 = 2
2^2 = 4
2^3 = 8
2^4 = 16
2^5 = 32
2^6 = 64
2^7 = 128
2^8 = 256
```

***
## Bonus Challenge:
- Add factorial operation
- Implement square root using `bc`
- Show practical use cases for each operation

***
## Pseudocode (with Bonus Challenges):
```bash
BEGIN advanced_calc.sh

  // ========================================
  // FUNCTION DEFINITIONS
  // ========================================

  FUNCTION display_usage()
    DISPLAY "Usage:"
    DISPLAY "  ./advanced_calc.sh mod <number1> <number2>"
    DISPLAY "  ./advanced_calc.sh exp <base> <exponent>"
    DISPLAY "  ./advanced_calc.sh fact <number>        (bonus)"
    DISPLAY "  ./advanced_calc.sh sqrt <number>        (bonus)"
    DISPLAY ""
    DISPLAY "Examples:"
    DISPLAY "  ./advanced_calc.sh mod 17 5"
    DISPLAY "  ./advanced_calc.sh exp 2 8"
    DISPLAY "  ./advanced_calc.sh fact 5"
    DISPLAY "  ./advanced_calc.sh sqrt 9"
  END FUNCTION

  FUNCTION display_error(message)
    DISPLAY "✗ Error: " + message
  END FUNCTION

  FUNCTION is_integer(value)
    // Return true if value is an integer (optional leading minus)
    IF value matches pattern: optional "-" then digits only THEN
      RETURN true
    ELSE
      RETURN false
    END IF
  END FUNCTION

  FUNCTION validate_basic_args(argc)
    // Need at least operation + 2 numbers for mod/exp
    IF argc < 3 THEN
      CALL display_error("Not enough arguments")
      CALL display_usage()
      EXIT 1
    END IF
  END FUNCTION

  FUNCTION validate_numbers(num1, num2)
    IF NOT is_integer(num1) THEN
      CALL display_error("First number must be an integer")
      EXIT 1
    END IF
    IF NOT is_integer(num2) THEN
      CALL display_error("Second number must be an integer")
      EXIT 1
    END IF
  END FUNCTION

  FUNCTION perform_modulo(a, b)
    // Check division by zero
    IF b equals 0 THEN
      CALL display_error("Modulo by zero is not allowed")
      EXIT 1
    END IF

    SET result to $(( a % b ))

    DISPLAY "Modulo Operation: " + a + " % " + b
    DISPLAY "Result: " + result
    DISPLAY ""
    DISPLAY "Explanation: " + a + " ÷ " + b + " = " + (a / b) + " remainder " + result
    DISPLAY "(" + b + " × " + (a / b) + " = " + (b * (a / b)) + ", and " +
              a + " - " + (b * (a / b)) + " = " + result + ")"
    DISPLAY ""
    IF result equals 0 THEN
      DISPLAY "Use case: " + a + " is divisible by " + b + " (remainder is 0)"
    ELSE
      DISPLAY "Use case: Check if " + a + " is divisible by " + b + "? No (remainder is not 0)"
    END IF
  END FUNCTION

  FUNCTION perform_exponentiation(base, exponent)
    // validate exponent as non‑negative integer for step display
    IF exponent < 0 THEN
      CALL display_error("Negative exponents not supported in this simple script")
      EXIT 1
    END IF

    SET result to $(( base ** exponent ))

    DISPLAY "Exponentiation: " + base + "^" + exponent
    DISPLAY "Result: " + result
    DISPLAY ""
    DISPLAY "Calculation steps:"

    // Show step-by-step multiplication
    // running_value = base^current_power
    SET running_value to 1
    SET current_power to 0

    WHILE current_power < exponent DO
      INCREMENT current_power by 1
      SET running_value to $(( running_value * base ))
      DISPLAY base + "^" + current_power + " = " + running_value
    END WHILE

    DISPLAY ""
    DISPLAY "Use case: Exponentiation models repeated multiplication."
    DISPLAY "For example, compound growth, powers of 2, or combinations of bits."
  END FUNCTION

  // BONUS: factorial
  FUNCTION perform_factorial(n)
    IF n < 0 THEN
      CALL display_error("Factorial is not defined for negative numbers")
      EXIT 1
    END IF

    SET result to 1
    SET i to 1

    DISPLAY "Factorial: " + n + "!"
    DISPLAY ""

    WHILE i <= n DO
      SET result to $(( result * i ))
      DISPLAY "Step " + i + ": " + "partial result = " + result
      INCREMENT i
    END WHILE

    DISPLAY ""
    DISPLAY "Result: " + n + "! = " + result
    DISPLAY "Use case: Factorial is used in permutations, combinations, and probability."
  END FUNCTION

  // BONUS: square root via bc
  FUNCTION perform_sqrt(n)
    IF n < 0 THEN
      CALL display_error("Square root of negative numbers not supported (no complex numbers)")
      EXIT 1
    END IF

    // Use bc for non‑integer result with some scale
    SET sqrt_value to output of: echo "scale=4; sqrt(${n})" | bc

    DISPLAY "Square root operation: √" + n
    DISPLAY "Result (approx): " + sqrt_value
    DISPLAY ""
    DISPLAY "Use case: Distances, geometry, and standard deviation often use square roots."
  END FUNCTION

  // ========================================
  // MAIN EXECUTION
  // ========================================

  // Step 1: Ensure at least operation + 2 args (for mod/exp).
  // Note: factorial and sqrt can later relax this.
  IF argument count == 0 THEN
    CALL display_error("No operation provided")
    CALL display_usage()
    EXIT 1
  END IF

  SET operation to $1

  // Handle factorial and sqrt separately (bonus)
  IF operation equals "fact" THEN
    IF argument count != 2 THEN
      CALL display_error("Usage: ./advanced_calc.sh fact <number>")
            EXIT 1
          END IF
          SET number to $2
          IF NOT is_integer(number) THEN
            CALL display_error("Argument must be an integer")
            EXIT 1
          END IF
          CALL perform_factorial(number)
          EXIT 0
        END IF
      
        // Handle square root separately (only needs 1 number - bonus)
        IF operation equals "sqrt" THEN
          IF argument count != 2 THEN
            CALL display_error("Usage: ./advanced_calc.sh sqrt <number>")
            EXIT 1
          END IF
          SET number to $2
          IF NOT is_integer(number) THEN
            CALL display_error("Argument must be an integer")
            EXIT 1
          END IF
          CALL perform_sqrt(number)
          EXIT 0
        END IF
      
        // For mod and exp, need 3 arguments total
        CALL validate_basic_args($#)
      
        SET num1 to $2
        SET num2 to $3
      
        // Validate both numbers are integers
        CALL validate_numbers(num1, num2)
      
        // Perform the requested operation
        CASE operation OF
          "mod":
            CALL perform_modulo(num1, num2)
            
          "exp":
            CALL perform_exponentiation(num1, num2)
            
          DEFAULT:
            CALL display_error("Unknown operation: " + operation)
            CALL display_usage()
            EXIT 1
        END CASE
      
        EXIT 0
      
      END advanced_calc.sh

```

***
