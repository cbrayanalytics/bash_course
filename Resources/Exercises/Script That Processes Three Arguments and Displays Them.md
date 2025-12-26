## Goal:
Create a script named `args.sh` that accepts exactly three arguments and displays them in different formats.

***
## Requirements:
- Accept exactly 3 command-line arguments
- Display each argument individually with labels
- Display all arguments together
- Display them in reverse order
- Show the total count of arguments

***
## Pseudocode:
```bash
BEGIN args.sh

  // Step 1: Validate argument count (bonus)
  IF argument count ($#) is not equal to 3 THEN
    DISPLAY "✗ Error: Exactly 3 arguments are required"
    DISPLAY "Usage: ./args.sh <arg1> <arg2> <arg3>"
    EXIT with status 1
  END IF

  // Step 2: Assign arguments to variables for clarity
  SET arg1 to $1
  SET arg2 to $2
  SET arg3 to $3

  // Step 3: Display each argument individually
  DISPLAY "Argument 1: " + arg1
  DISPLAY "Argument 2: " + arg2
  DISPLAY "Argument 3: " + arg3
  DISPLAY empty line

  // Step 4: Display all arguments together
  DISPLAY "All arguments: " + arg1 + " " + arg2 + " " + arg3

  // Step 5: Display arguments in reverse order
  DISPLAY "Reverse order: " + arg3 + " " + arg2 + " " + arg1

  // Step 6: Show total count of arguments
  DISPLAY "Total arguments: " + argument count ($#)

  EXIT with status 0

END args.sh
```

***
## Hints:
- Use `$1`, `$2`, `$3` for individual arguments
- Use `$#` to count arguments
- You can display them in any order by choosing which variable to echo when

***
## Expected Output Example:
```bash
./args.sh apple banana cherry
```
```
Argument 1: apple
Argument 2: banana
Argument 3: cherry

All arguments: apple banana cherry
Reverse order: cherry banana apple
Total arguments: 3
```

***
## Bonus Challenge:
Add validation to ensure exactly 3 arguments are provided, exit with error message and usage instructions if not.

***

## Bonus Pseudocode:
```bash
BEGIN args.sh

  // BONUS: Step 1 - Validate number of arguments
  IF argument count ($#) is NOT equal to 3 THEN
    DISPLAY "✗ Error: Exactly 3 arguments are required"
    DISPLAY "Usage: ./args.sh <arg1> <arg2> <arg3>"
    EXIT with status 1
  END IF

  // Step 2 - Assign each argument to a variable (optional for clarity)
  SET arg1 to $1
  SET arg2 to $2
  SET arg3 to $3

  // Step 3 - Display each argument individually with label
  DISPLAY "Argument 1: " + arg1
  DISPLAY "Argument 2: " + arg2
  DISPLAY "Argument 3: " + arg3
  DISPLAY empty line

  // Step 4 - Display all arguments together in order
  DISPLAY "All arguments: " + arg1 + " " + arg2 + " " + arg3

  // Step 5 - Display all arguments in reverse order
  DISPLAY "Reverse order: " + arg3 + " " + arg2 + " " + arg1

  // Step 6 - Show the total count of arguments
  DISPLAY "Total arguments: " + argument count ($#)

  EXIT with status 0

END args.sh
```
