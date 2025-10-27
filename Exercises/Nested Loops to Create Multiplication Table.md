### Goal:
Create a script named `multiplication_table.sh` that generates formatted multiplication tables using nested loops.
### Requirements:
- Accept table size as argument (default: 10)
- Generate multiplication table from 1 to N
- Use nested for loops
- Format output in aligned columns
- Highlight specific values:
  - Perfect squares (1, 4, 9, 16, 25...)
  - Multiples of 5
  - Diagonal (where row == column)
- Add row and column headers
- Display multiple formatting options:
  - Compact table
  - Spaced table
  - Grid with borders
- Calculate and display statistics
### Hints:
- Use `printf` for aligned columns: `printf "%4d" $product`
- Nested loop structure:
  ```bash
  for ((i=1; i<=n; i++)); do
      for ((j=1; j<=n; j++)); do
          product=$((i * j))
      done
  done
  ```
- Check perfect square: `sqrt=$((product)); ((sqrt * sqrt == product))`
- Add color codes for highlighting (optional)
### Expected Output Example:
```bash
./multiplication_table.sh 10
```

```
╔════════════════════════════════════════════════════════════════╗
║           MULTIPLICATION TABLE (1-10)                          ║
╚════════════════════════════════════════════════════════════════╝

[Format: Standard Table]

     |   1   2   3   4   5   6   7   8   9  10
─────┼────────────────────────────────────────────
  1  |   1   2   3   4   5   6   7   8   9  10
  2  |   2   4   6   8  10  12  14  16  18  20
  3  |   3   6   9  12  15  18  21  24  27  30
  4  |   4   8  12  16  20  24  28  32  36  40
  5  |   5  10  15  20  25  30  35  40  45  50
  6  |   6  12  18  24  30  36  42  48  54  60
  7  |   7  14  21  28  35  42  49  56  63  70
  8  |   8  16  24  32  40  48  56  64  72  80
  9  |   9  18  27  36  45  54  63  72  81  90
 10  |  10  20  30  40  50  60  70  80  90 100

════════════════════════════════════════════════════════════════

[Format: Highlighted Table]
Legend: [■] Perfect Square  [*] Multiple of 5

     |   1   2   3   4   5   6   7   8   9  10
─────┼────────────────────────────────────────────
  1  |  [■]  2   3  [■] [*]  6   7   8  [■][*]
  2  |   2  [■]  6   8 [*]  12  14 [■]  18 [*]
  3  |   3   6  [■] 12 [*]  18  21  24  27 [*]
  4  |  [■]  8  12 [■][*]  24  28  32 [■][*]
  5  | [*] [*] [*][*][■] [*] [*][*] [*][*]
  6  |   6  12  18  24 [*] [■]  42  48  54 [*]
  7  |   7  14  21  28 [*]  42 [■]  56  63 [*]
  8  |   8 [■]  24  32 [*]  48  56 [■]  72 [*]
  9  |  [■] 18  27 [■][*]  54  63  72 [■][*]
 10  | [*] [*] [*][*][*] [*] [*][*] [*][■]

════════════════════════════════════════════════════════════════

Statistics:
  Table size:        10 x 10
  Total products:    100
  Perfect squares:   10 (1, 4, 9, 16, 25, 36, 49, 64, 81, 100)
  Multiples of 5:    37
  Largest product:   100
  Smallest product:  1
  Sum of all:        3,025
  Average:           30.25
```

```bash
./multiplication_table.sh 5
```

```
╔════════════════════════════════════════╗
║    MULTIPLICATION TABLE (1-5)          ║
╚════════════════════════════════════════╝

    |   1   2   3   4   5
────┼───────────────────────
 1  |   1   2   3   4   5
 2  |   2   4   6   8  10
 3  |   3   6   9  12  15
 4  |   4   8  12  16  20
 5  |   5  10  15  20  25

Perfect Squares: 1, 4, 9, 16, 25
Multiples of 5: 5, 10, 15, 20, 25
```

```bash
./multiplication_table.sh 12 --compact
```

```
MULTIPLICATION TABLE (1-12) - Compact Format

  1  2  3  4  5  6  7  8  9 10 11 12
  2  4  6  8 10 12 14 16 18 20 22 24
  3  6  9 12 15 18 21 24 27 30 33 36
  4  8 12 16 20 24 28 32 36 40 44 48
  5 10 15 20 25 30 35 40 45 50 55 60
  6 12 18 24 30 36 42 48 54 60 66 72
  7 14 21 28 35 42 49 56 63 70 77 84
  8 16 24 32 40 48 56 64 72 80 88 96
  9 18 27 36 45 54 63 72 81 90 99108
 10 20 30 40 50 60 70 80 90100110120
 11 22 33 44 55 66 77 88 99110121132
 12 24 36 48 60 72 84 96108120132144
```
### Bonus Challenge:
- Add division table
- Add addition/subtraction tables
- Support custom ranges (e.g., 5-15)
- Export to CSV or HTML
- Add color coding
- Create times tables quiz mode
- Generate printable PDF
- Support different bases (binary, hex)
- Add ASCII art borders
- Create interactive mode (ask for products)

***
