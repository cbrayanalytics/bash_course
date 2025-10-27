## Goal:
Create a script named `process_all.sh` that accepts any number of arguments and processes them using `shift`.
## Requirements:
- Accept any number of arguments (1 or more)
- Use a loop with `shift` to process each argument
- Display each argument with its original position number
- Calculate and display the sum if all arguments are numbers (bonus)
- Count how many arguments were processed
## Hints:
- Use `while [[ $# -gt 0 ]]` loop
- Use a counter variable to track position
- Call `shift` at the end of each loop iteration
- Check if all arguments are numeric before attempting sum
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
## Bonus Challenge:
- Add option to skip certain arguments (e.g., if they start with `-`)
- Implement `shift 2` to process arguments in pairs

***
