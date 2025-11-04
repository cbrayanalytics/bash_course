### Goal:
Create a script named `print_numbers.sh` that prints numbers 1-20 using different for loop styles.
### Requirements:
- Implement three different versions:
  1. Using brace expansion `{1..20}`
  2. Using C-style for loop
  3. Using sequence with custom formatting
- For each method:
  - Print numbers 1-20
  - Show loop type being used
  - Add formatting (e.g., "Number: X")
- Add these variations:
  - Print only even numbers (2, 4, 6... 20)
  - Print only odd numbers (1, 3, 5... 19)
  - Print in reverse (20 to 1)
  - Print every 5th number (5, 10, 15, 20)
### Hints:
- Brace expansion: `{1..20}`
- C-style: `for ((i=1; i<=20; i++))`
- Use modulo `%` to check even/odd: `((i % 2 == 0))`
- Reverse with: `{20..1}`
- Step with: `{1..20..5}` or `((i+=5))`
### Expected Output Example:
```bash
./print_numbers.sh
```

```
╔════════════════════════════════════════╗
║      NUMBER PRINTING DEMONSTRATION      ║
╚════════════════════════════════════════╝

[Method 1: Brace Expansion]
────────────────────────────────────────
1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20

[Method 2: C-Style Loop]
────────────────────────────────────────
Number 1
Number 2
Number 3
...
Number 20

[Method 3: Custom Formatting]
────────────────────────────────────────
[01] [02] [03] [04] [05] [06] [07] [08] [09] [10]
[11] [12] [13] [14] [15] [16] [17] [18] [19] [20]

════════════════════════════════════════
VARIATIONS
════════════════════════════════════════

Even Numbers (1-20):
2 4 6 8 10 12 14 16 18 20

Odd Numbers (1-20):
1 3 5 7 9 11 13 15 17 19

Countdown (20-1):
20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1

Every 5th Number:
5 10 15 20

════════════════════════════════════════
Summary: Printed 20 numbers using 3 methods
```
### Bonus Challenge:
- Add prime numbers (2, 3, 5, 7, 11, 13, 17, 19)
- Create visual progress bar as counting
- Print in multiple columns
- Add Fibonacci sequence
- Print perfect squares (1, 4, 9, 16)
- Allow user to specify range via arguments

***
