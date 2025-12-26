## Goal:
Create a script named `float_calc.sh` that performs calculations with decimal numbers using `bc`.

***
## Requirements:
- Accept three arguments: number1, operator, number2
- Support operations: `+`, `-`, `*`, `/`
- Handle floating-point numbers
- Set precision to 2 decimal places by default
- Allow user to optionally specify precision as 4th argument
- Compare result with integer arithmetic to show the difference

***
## Hints:
- Use `echo "scale=N; expression" | bc`
- Default scale to 2 if not provided: `${4:-2}`
- Show both integer and float results for comparison
- Format output nicely

***
## Key Points

1. **Functions are essential** for this script due to multiple features
2. **`bc` is used** for all floating-point math with configurable scale
3. **Integer comparison** shows the difference between truncation and proper decimal handling
4. **Bonus features** (trig, compound interest, sqrt) use `bc -l` for extended math library
5. **Input validation** ensures numbers, operators, and precision are valid
6. **Special handling** for notable values (like π approximation with 22/7)

***
## Pseudocode:

```bash
BEGIN float_calc.sh

  ## ========================================
  ## CONFIGURATION & GLOBALS
  ## ========================================
  
  SET DEFAULT_SCALE to 2
  
  ## ========================================
  ## HELPER FUNCTIONS ⚙️
  ## ========================================
  
  FUNCTION display_usage()
    DISPLAY "Usage: 📊"
    DISPLAY "  ./float_calc.sh <number1> <operator> <number2> [precision]"
    DISPLAY ""
    DISPLAY "Operators: + - * /"
    DISPLAY "Precision: Number of decimal places (default: 2)"
    DISPLAY ""
    DISPLAY "Examples:"
    DISPLAY "  ./float_calc.sh 10 / 3"
    DISPLAY "  ./float_calc.sh 10 / 3 4"
    DISPLAY "  ./float_calc.sh 22 / 7 4"
    DISPLAY "  ./float_calc.sh 3.14 '*' 2.5"
    DISPLAY ""
    DISPLAY "Bonus features:"
    DISPLAY "  ./float_calc.sh --sin 0.5       # Sine function"
    DISPLAY "  ./float_calc.sh --cos 0         # Cosine function"
    DISPLAY "  ./float_calc.sh --compound <principal> <rate> <years>"
  END FUNCTION
  
  FUNCTION display_error(message)
    DISPLAY "❌ Error: " + message
  END FUNCTION
  
  FUNCTION is_number(value)
    // Check if value is a valid number (integer or float)
    // Pattern: optional minus, digits, optional decimal point + digits
    SET pattern to '^-?[0-9]+\.?[0-9]*$'
    
    IF value matches pattern THEN
      RETURN true
    ELSE
      RETURN false
    END IF
  END FUNCTION
  
  FUNCTION validate_operator(op)
    IF op is one of ["+", "-", "*", "/"] THEN
      RETURN true
    ELSE
      RETURN false
    END IF
  END FUNCTION
  
  FUNCTION validate_precision(precision)
    // Must be non-negative integer
    SET pattern to '^[0-9]+$'
    
    IF precision matches pattern THEN
      RETURN true
    ELSE
      RETURN false
    END IF
  END FUNCTION
  
  ## ========================================
  ## CORE CALCULATION FUNCTIONS 🧮
  ## ========================================
  
  FUNCTION calculate_integer_result(num1, operator, num2)
    // Perform integer arithmetic (Bash\'s built-in)
    CASE operator OF
      "+": RETURN $((num1 + num2))
      "-": RETURN $((num1 - num2))
      "*": RETURN $((num1 * num2))
      "/": 
        IF num2 == 0 THEN
          DISPLAY "❌ Error: Division by zero"
          EXIT 1
        END IF
        RETURN $((num1 / num2))
    END CASE
  END FUNCTION
  
  FUNCTION calculate_float_result(num1, operator, num2, scale)
    // Use bc for floating-point arithmetic
    SET expression to num1 + " " + operator + " " + num2
    
    // Build bc command with scale
    SET bc_command to "scale=" + scale + "; " + expression
    
    // Execute bc and capture result
    SET result to output of: echo "$bc_command" | bc
    
    // Check if bc failed
    IF result is empty THEN
      CALL display_error("Failed to calculate expression")
      EXIT 1
    END IF
    
    RETURN result
  END FUNCTION
  
  FUNCTION perform_basic_operation(num1, operator, num2, scale)
    DISPLAY "Operation: " + num1 + " " + operator + " " + num2
    DISPLAY ""
    
    // Calculate integer result (for comparison)
    // Convert floats to integers for integer arithmetic
    SET int1 to integer part of num1
    SET int2 to integer part of num2
    SET int_result to calculate_integer_result(int1, operator, int2)
    
    // Calculate floating-point result
    SET float_result to calculate_float_result(num1, operator, num2, scale)
    
    // Display results
    DISPLAY "Integer result:  " + int_result
    DISPLAY "Floating result: " + float_result + " (scale=" + scale + ")"
    DISPLAY ""
    
    // Show note about truncation
    IF int_result != float_result THEN
      DISPLAY "Note: Integer division truncates decimal places"
    END IF
    
    // Special messages for common values
    IF num1 == 22 AND operator == "/" AND num2 == 7 THEN
      DISPLAY ""
      DISPLAY "Approximation of π: " + float_result
    END IF
  END FUNCTION
  
  ## ========================================
  ## BONUS FUNCTIONS 🎁
  ## ========================================
  
  FUNCTION calculate_sine(angle, scale)
    // 🎁 BONUS: Calculate sine using bc -l
    SET bc_command to "scale=" + scale + "; s(" + angle + ")"
    SET result to output of: echo "$bc_command" | bc -l
    
    DISPLAY "Sine Function: sin(" + angle + ")"
    DISPLAY "Result: " + result + " (scale=" + scale + ")"
    DISPLAY ""
    DISPLAY "Note: Angle is in radians. π ≈ 3.14159"
  END FUNCTION
  
  FUNCTION calculate_cosine(angle, scale)
    // 🎁 BONUS: Calculate cosine using bc -l
    SET bc_command to "scale=" + scale + "; c(" + angle + ")"
    SET result to output of: echo "$bc_command" | bc -l
    
    DISPLAY "Cosine Function: cos(" + angle + ")"
    DISPLAY "Result: " + result + " (scale=" + scale + ")"
  END FUNCTION
  
  FUNCTION calculate_tangent(angle, scale)
    // 🎁 BONUS: Calculate tangent as sin/cos
    SET bc_command to "scale=" + scale + "; s(" + angle + ") / c(" + angle + ")"
    SET result to output of: echo "$bc_command" | bc -l
    
    DISPLAY "Tangent Function: tan(" + angle + ")"
    DISPLAY "Result: " + result + " (scale=" + scale + ")"
  END FUNCTION
  
  FUNCTION calculate_compound_interest(principal, rate, years, scale)
    // 🎁 BONUS: Compound interest formula: A = P(1 + r)^t
    // Convert percentage rate to decimal: rate / 100
    SET decimal_rate to rate / 100
    SET bc_formula to principal + " * (1 + " + decimal_rate + ")^" + years
    SET bc_command to "scale=" + scale + "; " + bc_formula
    SET amount to output of: echo "$bc_command" | bc
    
    SET interest to amount - principal
    
    DISPLAY "💰 Compound Interest Calculator"
    DISPLAY "================================"
    DISPLAY "Principal:    $" + principal
    DISPLAY "Rate:         " + rate + "%"
    DISPLAY "Time:         " + years + " years"
    DISPLAY "Final Amount: $" + amount
    DISPLAY "Interest:     $" + interest
  END FUNCTION
  
  FUNCTION calculate_square_root(number, scale)
    // 🎁 BONUS: Square root using bc
    IF number < 0 THEN
      CALL display_error("Cannot calculate square root of negative number")
      EXIT 1
    END IF
    
    SET bc_command to "scale=" + scale + "; sqrt(" + number + ")"
    SET result to output of: echo "$bc_command" | bc
    
    DISPLAY "Square Root: √" + number
    DISPLAY "Result: " + result + " (scale=" + scale + ")"
  END FUNCTION
  
  ## ========================================
  ## MAIN LOGIC 🚀
  ## ========================================
  
  FUNCTION main(args)
    // Check for bonus feature flags
    IF first argument starts with "--" THEN
      SET feature to first argument
      
      CASE feature OF
        "--sin":
          IF number of args < 2 THEN
            CALL display_error("Sine requires an angle argument")
            CALL display_usage()
            EXIT 1
          END IF
          SET angle to second argument
          SET scale to third argument OR DEFAULT_SCALE
          CALL calculate_sine(angle, scale)
          EXIT 0
          
        "--cos":
          IF number of args < 2 THEN
            CALL display_error("Cosine requires an angle argument")
            EXIT 1
          END IF
          SET angle to second argument
          SET scale to third argument OR DEFAULT_SCALE
          CALL calculate_cosine(angle, scale)
          EXIT 0
          
        "--tan":
          SET angle to second argument
          SET scale to third argument OR DEFAULT_SCALE
          CALL calculate_tangent(angle, scale)
          EXIT 0
          
        "--compound":
          IF number of args < 4 THEN
            CALL display_error("Compound interest requires: principal rate years")
            EXIT 1
          END IF
          SET principal to args[1]
          SET rate to args[2]
          SET years to args[3]
          SET scale to args[4] OR DEFAULT_SCALE
          CALL calculate_compound_interest(principal, rate, years, scale)
          EXIT 0
          
        "--sqrt":
          SET number to second argument
          SET scale to third argument OR DEFAULT_SCALE
          CALL calculate_square_root(number, scale)
          EXIT 0
          
        DEFAULT:
          CALL display_error("Unknown feature: " + feature)
          CALL display_usage()
          EXIT 1
      END CASE
    END IF
    
    // Standard mode: num1 op num2 [precision]
    IF number of args < 3 THEN
      CALL display_error("Not enough arguments")
      CALL display_usage()
      EXIT 1
    END IF
    
    IF number of args > 4 THEN
      CALL display_error("Too many arguments")
      DISPLAY ""
      DISPLAY "Invalid usage. This script accepts: num1 operator num2 [precision]"
      CALL display_usage()
      EXIT 1
    END IF
    
    // Parse arguments
    SET num1 to first argument
    SET operator to second argument
    SET num2 to third argument
    SET scale to fourth argument OR DEFAULT_SCALE
    
    // Validate inputs
    IF NOT is_number(num1) THEN
      CALL display_error("First argument must be a number")
      EXIT 1
    END IF
    
    IF NOT validate_operator(operator) THEN
      CALL display_error("Operator must be one of: + - * /")
      EXIT 1
    END IF
    
    IF NOT is_number(num2) THEN
      CALL display_error("Third argument must be a number")
      EXIT 1
    END IF
    
    IF NOT validate_precision(scale) THEN
      CALL display_error("Precision must be a non-negative integer")
      EXIT 1
    END IF
    
    // Check for division by zero
    IF operator == "/" AND num2 == 0 THEN
      CALL display_error("Division by zero is not allowed")
      EXIT 1
    END IF
    
    // Perform calculation
    CALL perform_basic_operation(num1, operator, num2, scale)
    
    EXIT 0
  END FUNCTION
  
  // Entry point
  CALL main(all command-line arguments)
  
END float_calc.sh
```

***
## Expected Output Example:

```bash
./float_calc.sh 10 / 3
```
```
Operation: 10 / 3

Integer result:  3
Floating result: 3.33 (scale=2)

Note: Integer division truncates decimal places
```

```bash
./float_calc.sh 10 / 3 + 5
```
```
Invalid usage. This script accepts: num1 operator num2 [precision]
```

```bash
./float_calc.sh 22 / 7 4
```
```
Operation: 22 / 7

Integer result:  3
Floating result: 3.1429 (scale=4)

Approximation of π: 3.1429
```

***
## Bonus Challenge:
- Add scientific notation support
- Implement trigonometric functions (sin, cos, tan) using `bc -l`
- Create compound interest calculator
- Support complex expressions with parentheses

***
