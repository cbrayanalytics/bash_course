### Goal:
Create a script named `number_check.sh` that determines whether a given number is positive, negative, or zero.
### Requirements:
- Accept one argument: a number
- Use conditional statements to check:
  - If number equals 0
  - If number is greater than 0 (positive)
  - If number is less than 0 (negative)
- Display appropriate message for each case
- Validate that input is actually a number
### Hints:
- Use `$1` to get the first argument
- Use `-eq 0` to check for zero
- Use `-gt 0` for positive numbers
- Use `-lt 0` for negative numbers
- To validate numeric input: `[[ $1 =~ ^-?[0-9]+$ ]]`
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
### Bonus Challenge:
- Add support for floating-point numbers using `bc`
- Handle multiple numbers as arguments
- Show absolute value alongside the classification

***
