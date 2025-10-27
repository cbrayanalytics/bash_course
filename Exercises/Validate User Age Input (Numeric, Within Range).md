### Goal:
Create a script named `age_validator.sh` that validates age input according to multiple criteria.
### Requirements:
- Prompt user for their age (or accept as argument)
- Validate that:
  - Input is not empty
  - Input is a number (integers only)
  - Number is within reasonable range (0-120)
  - Number is a positive integer
- Provide specific error messages for each validation failure
- If valid, categorize age:
  - 0-12: Child
  - 13-17: Teenager
  - 18-64: Adult
  - 65+: Senior
- Display category with appropriate message
### Hints:
- Check empty: `[[ -z "$age" ]]`
- Check numeric: `[[ $age =~ ^[0-9]+$ ]]`
- Use multiple if/elif statements for validation
- Use logical AND to combine conditions
- Exit with error code if validation fails
### Expected Output Example:
```bash
./age_validator.sh
```
```
Enter your age: 25

✓ Valid age: 25
Category: Adult
Voting eligible: Yes
Senior discount: No
```

```bash
./age_validator.sh
```
```
Enter your age: 

✗ Error: Age cannot be empty.
```

```bash
./age_validator.sh
```
```
Enter your age: abc

✗ Error: Age must be a number.
```

```bash
./age_validator.sh
```
```
Enter your age: 150

✗ Error: Age must be between 0 and 120.
```

```bash
./age_validator.sh
```
```
Enter your age: -5

✗ Error: Age cannot be negative.
```
### Bonus Challenge:
- Calculate birth year based on current year
- Add more age-specific information (legal drinking age, retirement age, etc.)
- Support multiple users (loop until user quits)
- Save validated ages to array and show statistics

***
