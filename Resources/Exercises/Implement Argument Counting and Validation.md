## Goal:
Create a script named `validate_args.sh` that accepts between 2-5 arguments and validates the count.

***
## Requirements:
- Check that at least 2 arguments are provided
- Check that no more than 5 arguments are provided
- If validation fails, display an error and usage message
- If validation passes, display:
  - Number of arguments received
  - First argument
  - Last argument (hint: use parameter expansion or array indexing)
  - All arguments

***
## Pseudocode:
```bash
BEGIN validate_args.sh

  // Get the count of arguments
  SET argument_count to $#
  
  // Validate minimum arguments (at least 2)
  IF argument_count is less than 2 THEN
    DISPLAY "✗ Error: Not enough arguments"
    DISPLAY "Usage: ./validate_args.sh <arg1> <arg2> [arg3] [arg4] [arg5]"
    DISPLAY "Requires: 2-5 arguments"
    DISPLAY "Received: " + argument_count + " arguments"
    EXIT with status 1
  END IF
  
  // Validate maximum arguments (no more than 5)
  IF argument_count is greater than 5 THEN
    DISPLAY "✗ Error: Too many arguments"
    DISPLAY "Usage: ./validate_args.sh <arg1> <arg2> [arg3] [arg4] [arg5]"
    DISPLAY "Requires: 2-5 arguments"
    DISPLAY "Received: " + argument_count + " arguments"
    EXIT with status 1
  END IF
  
  // Validation passed - display success message
  DISPLAY "✓ Valid number of arguments"
  DISPLAY empty line
  
  // Display argument count
  DISPLAY "Arguments received: " + argument_count
  
  // Display first argument
  SET first_arg to $1
  DISPLAY "First argument: " + first_arg
  
  // Display last argument (using parameter expansion ${!#})
  SET last_arg to ${!#} or ${@: -1}
  DISPLAY "Last argument: " + last_arg
  
  // Display all arguments
  SET all_args to "$@"
  DISPLAY "All arguments: " + all_args

END validate_args.sh
```

***
## Hints:
- Use `$#` to count arguments
- Use `[[ $# -lt 2 ]]` and `[[ $# -gt 5 ]]` for range checking
- For last argument, you can use: `"${!#}"` or `"${@: -1}"`
- Exit with non-zero status on validation failure

***
## Expected Output Example:
```bash
./validate_args.sh one two three
```
```
✓ Valid number of arguments

Arguments received: 3
First argument: one
Last argument: three
All arguments: one two three
```

```bash
./validate_args.sh one
```
```
✗ Error: Not enough arguments
Usage: ./validate_args.sh <arg1> <arg2> [arg3] [arg4] [arg5]
Requires: 2-5 arguments
Received: 1 arguments
```

***
## Bonus Challenge:
Add different handling for even vs odd number of arguments (e.g., pair them up if even).

## Bonus Pseudocode:
```bash
BEGIN validate_args.sh with bonus

  // ... (same validation logic as above) ...
  
  // After displaying basic argument information
  DISPLAY empty line
  
  // Check if argument count is even or odd
  SET remainder to argument_count modulo 2
  
  IF remainder equals 0 THEN
    // Even number of arguments - pair them up
    DISPLAY "Even number of arguments detected - pairing them:"
    
    SET index to 1
    SET pair_number to 1
    
    WHILE index is less than or equal to argument_count DO
      SET arg1 to argument at position index
      SET arg2 to argument at position (index + 1)
      DISPLAY "Pair " + pair_number + ": " + arg1 + " <-> " + arg2
      INCREMENT index by 2
      INCREMENT pair_number by 1
    END WHILE
    
  ELSE
    // Odd number of arguments
    DISPLAY "Odd number of arguments detected"
    DISPLAY "Middle argument: " + argument at position ((argument_count + 1) / 2)
  END IF

END validate_args.sh with bonus
```

***
