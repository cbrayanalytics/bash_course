## Goal:
Create a script named `process_all.sh` that accepts any number of arguments and processes them using `shift`.

***
## Requirements:
- Accept any number of arguments (1 or more)
- Use a loop with `shift` to process each argument
- Display each argument with its original position number
- Calculate and display the sum if all arguments are numbers (bonus)
- Count how many arguments were processed

***

## Pseudocode:
```bash
BEGIN process_all.sh

  // Check minimum arguments
  IF argument count ($#) is less than 1 THEN
    DISPLAY "Error: At least one argument is required"
    DISPLAY "Usage: ./process_all.sh <arg1> [arg2] [arg3] ..."
    EXIT with status 1
  END IF
  
  // Initialize variables
  SET position_counter to 1
  SET total_processed to 0
  SET all_numeric to true
  SET sum to 0
  
  // Process all arguments using shift
  WHILE argument count ($#) is greater than 0 DO
    // Display current argument with position
    DISPLAY "Processing argument " + position_counter + ": " + $1
    
    // Check if current argument is numeric
    IF $1 matches numeric pattern (digits only) THEN
      SET sum to sum + $1
    ELSE
      SET all_numeric to false
    END IF
    
    // Increment counters
    INCREMENT position_counter by 1
    INCREMENT total_processed by 1
    
    // Shift to next argument
    CALL shift command to move arguments left by 1
  END WHILE
  
  // Display summary
  DISPLAY empty line
  DISPLAY "Total arguments processed: " + total_processed
  
  // Display sum if all arguments were numeric
  IF all_numeric is true THEN
    DISPLAY "Sum of all arguments: " + sum
  END IF
  
  EXIT with status 0

END process_all.sh

```

***
## Hints:
- Use `while [[ $# -gt 0 ]]` loop
- Use a counter variable to track position
- Call `shift` at the end of each loop iteration
- Check if all arguments are numeric before attempting sum

***
## Expected Output Example:
```bash
./process_all.sh red green blue yellow
```
```
Processing argument 1: red
Processing argument 2: green
Processing argument 3: blue
Processing argument 4: yellow

Total arguments processed: 4
```

```bash
./process_all.sh 10 20 30 40
```
```
Processing argument 1: 10
Processing argument 2: 20
Processing argument 3: 30
Processing argument 4: 40

Total arguments processed: 4
Sum of all arguments: 100
```

***
## Bonus Challenge:
- Add option to skip certain arguments (e.g., if they start with `-`)
- Implement `shift 2` to process arguments in pairs

***

## Bonus Pseudocode:
```bash
BEGIN process_all.sh with skip feature

  // Check minimum arguments
  IF argument count ($#) is less than 1 THEN
    DISPLAY "Error: At least one argument is required"
    DISPLAY "Usage: ./process_all.sh <arg1> [arg2] [arg3] ..."
    EXIT with status 1
  END IF
  
  // Initialize variables
  SET position_counter to 1
  SET total_processed to 0
  SET skipped_count to 0
  SET all_numeric to true
  SET sum to 0
  
  // Process all arguments using shift
  WHILE argument count ($#) is greater than 0 DO
    
    // Check if argument starts with dash (-)
    IF $1 starts with "-" THEN
      DISPLAY "Skipping flag: " + $1
      INCREMENT skipped_count by 1
      CALL shift command
      CONTINUE to next iteration
    END IF
    
    // Display current argument with position
    DISPLAY "Processing argument " + position_counter + ": " + $1
    
    // Check if current argument is numeric
    IF $1 matches numeric pattern THEN
      SET sum to sum + $1
    ELSE
      SET all_numeric to false
    END IF
    
    // Increment counters
    INCREMENT position_counter by 1
    INCREMENT total_processed by 1
    
    // Shift to next argument
    CALL shift command
  END WHILE
  
  // Display summary
  DISPLAY empty line
  DISPLAY "Total arguments processed: " + total_processed
  DISPLAY "Arguments skipped: " + skipped_count
  
  // Display sum if all processed arguments were numeric
  IF all_numeric is true AND total_processed is greater than 0 THEN
    DISPLAY "Sum of all arguments: " + sum
  END IF
  
  EXIT with status 0

END process_all.sh with skip feature
```

```bash
BEGIN process_all.sh with pair processing

  // Check minimum arguments
  IF argument count ($#) is less than 2 THEN
    DISPLAY "Error: At least two arguments required for pair processing"
    DISPLAY "Usage: ./process_all.sh <arg1> <arg2> [arg3] [arg4] ..."
    EXIT with status 1
  END IF
  
  // Initialize variables
  SET pair_counter to 1
  SET total_processed to 0
  
  // Process arguments in pairs using shift 2
  WHILE argument count ($#) is greater than or equal to 2 DO
    
    // Display current pair
    DISPLAY "Processing pair " + pair_counter + ":"
    DISPLAY "  First: " + $1
    DISPLAY "  Second: " + $2
    
    // Increment counters
    INCREMENT pair_counter by 1
    INCREMENT total_processed by 2
    
    // Shift by 2 to move to next pair
    CALL shift 2 command to move arguments left by 2
    
    DISPLAY empty line
  END WHILE
  
  // Check for remaining single argument
  IF argument count ($#) equals 1 THEN
    DISPLAY "Remaining unpaired argument: " + $1
    INCREMENT total_processed by 1
  END IF
  
  // Display summary
  DISPLAY "Total arguments processed: " + total_processed
  DISPLAY "Total pairs processed: " + (pair_counter - 1)
  
  EXIT with status 0

END process_all.sh with pair processing
```

***
