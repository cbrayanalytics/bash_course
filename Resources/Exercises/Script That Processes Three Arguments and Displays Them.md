## Goal:
Create a script named `args.sh` that accepts exactly three arguments and displays them in different formats.
## Requirements:
- Accept exactly 3 command-line arguments
- Display each argument individually with labels
- Display all arguments together
- Display them in reverse order
- Show the total count of arguments
## Hints:
- Use `$1`, `$2`, `$3` for individual arguments
- Use `$#` to count arguments
- You can display them in any order by choosing which variable to echo when
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
## Bonus Challenge:
Add validation to ensure exactly 3 arguments are provided, exit with error message and usage instructions if not.

***
