## Goal:
Create a script named `calc.sh` that performs basic arithmetic operations (+, -, \*, /) on two numbers.
## Requirements:
- Accept three arguments: number1, operator, number2
- Support these operators: `+`, `-`, `*`, `/`
- Perform the calculation using `$(())`
- Display the operation and result
- Handle division by zero
## Hints:
- Use `$1` for first number, `$2` for operator, `$3` for second number
- Use a case statement to handle different operators
- For division, check if `$3` equals 0 before calculating
- Remember that `*` might need escaping in some contexts

## Expected Output Example:
```bash
./calc.sh 10 + 5
```
```
10 + 5 = 15
```

```bash
./calc.sh 20 / 4
```
```
20 / 4 = 5
```

```bash
./calc.sh 10 / 0
```
```
Error: Division by zero is not allowed
```

## Bonus Challenge:
- Add support for multiple operations in sequence
- Validate that arguments are numeric
- Add parentheses support for complex expressions

***
