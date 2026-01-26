### Goal:

Create a script named `number_check.sh` that determines whether a given number is positive, negative, or zero.

***
### Requirements:

- Accept one argument: a number
- Use conditional statements to check:
  - If number equals 0
  - If number is greater than 0 (positive)
  - If number is less than 0 (negative)
- Display appropriate message for each case
- Validate that input is actually a number

***
### Hints:

- Use `$1` to get the first argument
- Use `-eq 0` to check for zero
- Use `-gt 0` for positive numbers
- Use `-lt 0` for negative numbers
- To validate numeric input: `[[ $1 =~ ^-?[0-9]+$ ]]`

***

### Workflow:

START
* Check if argument count is correct
	* If no arguments: Display error and usage, EXIT
* Validate input is a number
	* If not valid: Display error and usage, EXIT
* Perform number classification
	* If number equals 0: Display "zero" message
	* Else if number > 0: Display "positive" message
	* Else: Display "negative" message
END

***
### Pseudocode:

``` bash
FUNCTION main:
    // Step 1: Argument Validation
    IF argument_count != 1 THEN
        PRINT "Error: Please provide exactly one argument."
        PRINT "Usage: ./number_check.sh <number>"
        EXIT with code 1
    END IF
    
    // Step 2: Store the input
    SET input = $1
    
    // Step 3: Numeric Validation
    // Pattern ^-?[0-9]+$ means:
    //   ^ = start of string
    //   -? = optional minus sign
    //   [0-9]+ = one or more digits
    //   $ = end of string
    
    IF input does NOT match pattern "^-?[0-9]+$" THEN
        PRINT "Error: '" + input + "' is not a valid number."
        PRINT "Usage: ./number_check.sh <number>"
        EXIT with code 1
    END IF
    
    // Step 4: Number Classification
    IF input -eq 0 THEN
        PRINT "The number " + input + " is zero."
    ELSE IF input -gt 0 THEN
        PRINT "The number " + input + " is positive."
    ELSE  // input -lt 0
        PRINT "The number " + input + " is negative."
    END IF
    
    EXIT with code 0
END FUNCTION
```

***
### Expected Output Example:
```bash
./number_check.sh 42
```
```
The number 42 is positive.
```

```bash
./number_check.sh -15
```
```
The number -15 is negative.
```

```bash
./number_check.sh 0
```
```
The number 0 is zero.
```

```bash
./number_check.sh abc
```
```
Error: 'abc' is not a valid number.
Usage: ./number_check.sh <number>
```

***
### Bonus Challenge:

- Add support for floating-point numbers using `bc`
``` bash
FUNCTION validate_floating_point:
    // Pattern ^-?[0-9]+\.?[0-9]*$ means:
    //   ^ = start
    //   -? = optional minus
    //   [0-9]+ = one or more digits
    //   \.? = optional decimal point
    //   [0-9]* = zero or more digits after decimal
    //   $ = end
    
    IF input matches "^-?[0-9]+\.?[0-9]*$" THEN
        RETURN valid
    ELSE
        RETURN invalid
    END IF
END FUNCTION

FUNCTION classify_floating_point:
    // Use bc for floating-point comparison
    SET result = echo "input == 0" | bc
    
    IF result == 1 THEN
        PRINT "zero"
    ELSE
        SET result = echo "input > 0" | bc
        IF result == 1 THEN
            PRINT "positive"
        ELSE
            PRINT "negative"
        END IF
    END IF
END FUNCTION
```

- Handle multiple numbers as arguments
``` bash
FUNCTION process_multiple_numbers:
    IF argument_count == 0 THEN
        PRINT error and usage
        EXIT
    END IF
    
    FOR each argument in $@ DO
        VALIDATE argument
        IF valid THEN
            CLASSIFY argument
            PRINT result
        ELSE
            PRINT error for this argument
        END IF
    END FOR
END FUNCTION
```

- Show absolute value alongside the classification
``` bash
FUNCTION calculate_absolute_value:
    IF number -lt 0 THEN
        SET abs_value = number * -1
        // Or using bc: abs_value = echo "input * -1" | bc
    ELSE
        SET abs_value = number
    END IF
    
    PRINT "The number " + number + " is " + classification + 
          " (absolute value: " + abs_value + ")."
END FUNCTION
```

***
