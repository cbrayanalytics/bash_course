## Goal:
Create a script named `float_calc.sh` that performs calculations with decimal numbers using `bc`.
## Requirements:
- Accept three arguments: number1, operator, number2
- Support operations: `+`, `-`, `*`, `/`
- Handle floating-point numbers
- Set precision to 2 decimal places by default
- Allow user to optionally specify precision as 4th argument
- Compare result with integer arithmetic to show the difference
## Hints:
- Use `echo "scale=N; expression" | bc`
- Default scale to 2 if not provided: `${4:-2}`
- Show both integer and float results for comparison
- Format output nicely
## Expected Output Example:
```bash
./float_calc.sh 10 / 3
```
```
Operation: 10 / 3

Integer result:  3
Floating result: 3.33 (scale=2)

Note: Integer division truncates decimal places
```

```bash
./float_calc.sh 10 / 3 + 5
```
```
Invalid usage. This script accepts: num1 operator num2 [precision]
```

```bash
./float_calc.sh 22 / 7 4
```
```
Operation: 22 / 7

Integer result:  3
Floating result: 3.1429 (scale=4)

Approximation of π: 3.1429
```
## Bonus Challenge:
- Add scientific notation support
- Implement trigonometric functions (sin, cos, tan) using `bc -l`
- Create compound interest calculator
- Support complex expressions with parentheses

***
