### Goal:
Create a script named `math_lib.sh` that implements a complete math functions library.
### Requirements:
- Implement these basic operations:
  - `add(a, b)` - Addition
  - `subtract(a, b)` - Subtraction
  - `multiply(a, b)` - Multiplication
  - `divide(a, b)` - Division with error handling
  - `modulo(a, b)` - Remainder
  - `power(base, exponent)` - Exponentiation
- All functions should:
  - Validate input (check if numeric)
  - Handle edge cases (division by zero, etc.)
  - Return results via echo
  - Set appropriate return codes (0=success, 1=error)
- Create a calculator interface that uses these functions
- Support chaining operations
- Show step-by-step calculations
### Hints:
- Arithmetic: `$(( expression ))`
- Check numeric: `[[ $var =~ ^-?[0-9]+$ ]]`
- Return value: `echo $result`
- Return code: `return 0` or `return 1`
- Use `local` for all function variables
### Expected Output Example:
```bash
./math_lib.sh
```
```
╔════════════════════════════════════════════════════════════════╗
║              MATH FUNCTIONS LIBRARY                            ║
╚════════════════════════════════════════════════════════════════╝

Welcome to the Math Calculator!

Available Operations:
  [1] Add
  [2] Subtract
  [3] Multiply
  [4] Divide
  [5] Modulo (Remainder)
  [6] Power (Exponentiation)
  [7] Run Test Suite
  [Q] Quit

Select operation: 1

═══════════════════════════════════════
Addition
═══════════════════════════════════════

Enter first number: 15
Enter second number: 27

Calculating: 15 + 27

Result: 42

Operation completed successfully ✓

Press Enter to continue...
```

```bash
./math_lib.sh --test
```
```
╔════════════════════════════════════════════════════════════════╗
║           MATH LIBRARY TEST SUITE                              ║
╚════════════════════════════════════════════════════════════════╝

Running comprehensive tests...

[1/6] Testing Addition Function
────────────────────────────────────────────────────────────────
  Test 1: add 5 3
    Expected: 8
    Got: 8
    ✓ PASS

  Test 2: add -10 5
    Expected: -5
    Got: -5
    ✓ PASS

  Test 3: add 0 0
    Expected: 0
    Got: 0
    ✓ PASS

  Addition: 3/3 tests passed

[2/6] Testing Subtraction Function
────────────────────────────────────────────────────────────────
  Test 1: subtract 10 3
    Expected: 7
    Got: 7
    ✓ PASS

  Test 2: subtract 5 10
    Expected: -5
    Got: -5
    ✓ PASS

  Subtraction: 2/2 tests passed

[3/6] Testing Multiplication Function
────────────────────────────────────────────────────────────────
  Test 1: multiply 6 7
    Expected: 42
    Got: 42
    ✓ PASS

  Test 2: multiply -3 4
    Expected: -12
    Got: -12
    ✓ PASS

  Multiplication: 2/2 tests passed

[4/6] Testing Division Function
────────────────────────────────────────────────────────────────
  Test 1: divide 20 4
    Expected: 5
    Got: 5
    ✓ PASS

  Test 2: divide 10 3
    Expected: 3 (integer division)
    Got: 3
    ✓ PASS

  Test 3: divide 10 0
    Expected: ERROR
    Got: ERROR (Cannot divide by zero)
    ✓ PASS

  Division: 3/3 tests passed

[5/6] Testing Modulo Function
────────────────────────────────────────────────────────────────
  Test 1: modulo 10 3
    Expected: 1
    Got: 1
    ✓ PASS

  Test 2: modulo 17 5
    Expected: 2
    Got: 2
    ✓ PASS

  Modulo: 2/2 tests passed

[6/6] Testing Power Function
────────────────────────────────────────────────────────────────
  Test 1: power 2 8
    Expected: 256
    Got: 256
    ✓ PASS

  Test 2: power 3 3
    Expected: 27
    Got: 27
    ✓ PASS

  Test 3: power 10 0
    Expected: 1
    Got: 1
    ✓ PASS

  Power: 3/3 tests passed

╔════════════════════════════════════════════════════════════════╗
║                    TEST SUMMARY                                ║
╚════════════════════════════════════════════════════════════════╝

Total Tests: 15
Passed: 15 ✓
Failed: 0 ✗
Success Rate: 100%

All math functions working correctly!
```

```bash
./math_lib.sh --calc "5 + 3 * 2"
```
```
╔════════════════════════════════════════╗
║      EXPRESSION CALCULATOR             ║
╚════════════════════════════════════════╝

Expression: 5 + 3 * 2

Parsing expression...
Step 1: multiply(3, 2) = 6
Step 2: add(5, 6) = 11

Final Result: 11

Calculation completed in 0.003 seconds
```

```bash
./math_lib.sh --interactive
```
```
╔════════════════════════════════════════╗
║    INTERACTIVE CALCULATOR              ║
╚════════════════════════════════════════╝

Enter calculations (or 'quit' to exit)
Format: number operation number
Example: 5 + 3

> 10 + 5
Result: 15

> 15 * 2
Result: 30

> 30 / 6
Result: 5

> 5 ^ 3
Result: 125

> 125 / 0
Error: Cannot divide by zero

> quit
Goodbye!
```
### Bonus Challenge:
- Add square root function (using bc)
- Implement factorial function
- Add trigonometric functions (sin, cos, tan)
- Support floating-point operations
- Create expression parser
- Add memory storage (store/recall)
- Implement statistical functions (average, median)
- Add complex number support
- Create function graphing
- Support unit conversions

***
