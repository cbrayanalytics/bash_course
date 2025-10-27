## Goal:
Create a script named `validate_args.sh` that accepts between 2-5 arguments and validates the count.
## Requirements:
- Check that at least 2 arguments are provided
- Check that no more than 5 arguments are provided
- If validation fails, display an error and usage message
- If validation passes, display:
  - Number of arguments received
  - First argument
  - Last argument (hint: use parameter expansion or array indexing)
  - All arguments
## Hints:
- Use `$#` to count arguments
- Use `[[ $# -lt 2 ]]` and `[[ $# -gt 5 ]]` for range checking
- For last argument, you can use: `"${!#}"` or `"${@: -1}"`
- Exit with non-zero status on validation failure
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
## Bonus Challenge:
Add different handling for even vs odd number of arguments (e.g., pair them up if even).

***
