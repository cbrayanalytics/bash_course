## Goal:
Create a script named `advanced_calc.sh` that performs modulo (%) and exponentiation (**) operations.
## Requirements:
- Accept operation type as first argument: `mod` or `exp`
- Accept two numbers as additional arguments
- For `mod`: calculate remainder of division
- For `exp`: calculate power (base^exponent)
- Display practical examples of what these operations mean
- Show step-by-step calculation for exponentiation
## Hints:
- Use `$((a % b))` for modulo
- Use `$((a ** b))` for exponentiation
- Modulo is useful for checking even/odd, divisibility
- Show the multiplication steps for exponentiation
## Expected Output Example:
```bash
./advanced_calc.sh mod 17 5
```
```
Modulo Operation: 17 % 5
Result: 2

Explanation: 17 ÷ 5 = 3 remainder 2
(5 × 3 = 15, and 17 - 15 = 2)

Use case: Check if 17 is divisible by 5? No (remainder is not 0)
```

```bash
./advanced_calc.sh exp 2 8
```
```
Exponentiation: 2^8
Result: 256

Calculation steps:
2^1 = 2
2^2 = 4
2^3 = 8
2^4 = 16
2^5 = 32
2^6 = 64
2^7 = 128
2^8 = 256
```
## Bonus Challenge:
- Add factorial operation
- Implement square root using `bc`
- Show practical use cases for each operation

***
