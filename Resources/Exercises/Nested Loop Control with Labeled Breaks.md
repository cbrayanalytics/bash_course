### Goal:
Create a script named `matrix_search.sh` that searches a 2D matrix (nested arrays) for a value and demonstrates breaking out of multiple loop levels.
### Requirements:
- Create a 2D matrix (array of arrays or simulated)
- Implement nested loop to search matrix
- When target value is found:
  - Report row and column
  - Break out of both loops
  - Show how many elements were checked
- Support these search modes:
  - Find first occurrence
  - Find all occurrences
  - Find and replace
  - Find in specific row/column
- Display matrix visually
- Show search path (which cells were checked)
- Track performance (comparisons made)
### Hints:
- Simulate 2D with formula: `index = row * width + col`
- Or use array of row  `rows=("1 2 3" "4 5 6" "7 8 9")`
- Use `break 2` to exit both loops
- Track position with row/column counters
### Expected Output Example:
```bash
./matrix_search.sh
```
```
╔════════════════════════════════════════════════════════════════╗
║              MATRIX SEARCH DEMONSTRATION                       ║
╚════════════════════════════════════════════════════════════════╝

Creating 5x5 matrix with random values (1-25)...

Matrix:
┌─────────────────────────────────────┐
│  12   3  18   7  21                 │
│   5  15   9  23   2                 │
│  19   8  11  16   4                 │
│  14   1  20   6  17                 │
│  10  22  13  25  24                 │
└─────────────────────────────────────┘

Search target: 11
Mode: Find first occurrence

Searching...

[Row 0, Col 0] Checking 12... ✗
[Row 0, Col 1] Checking 3... ✗
[Row 0, Col 2] Checking 18... ✗
[Row 0, Col 3] Checking 7... ✗
[Row 0, Col 4] Checking 21... ✗
[Row 1, Col 0] Checking 5... ✗
[Row 1, Col 1] Checking 15... ✗
[Row 1, Col 2] Checking 9... ✗
[Row 1, Col 3] Checking 23... ✗
[Row 1, Col 4] Checking 2... ✗
[Row 2, Col 0] Checking 19... ✗
[Row 2, Col 1] Checking 8... ✗
[Row 2, Col 2] Checking 11... ✓ FOUND!

Breaking out of nested loops...

════════════════════════════════════════
✓ TARGET FOUND!
════════════════════════════════════════

Value: 11
Location: Row 2, Column 2 (3rd row, 3rd column)
Position in linear array: 12

Search Statistics:
  Comparisons made: 13
  Elements checked: 13 of 25 (52%)
  Remaining unchecked: 12
  Search efficiency: Early termination saved 12 comparisons

Visual representation:
┌─────────────────────────────────────┐
│  ✓    ✓   ✓   ✓   ✓                 │
│  ✓    ✓   ✓   ✓   ✓                 │
│  ✓    ✓  [11]  -   -                │
│  -    -   -   -   -                 │
│  -    -   -   -   -                 │
└─────────────────────────────────────┘

Legend: ✓ = Checked, [X] = Found, - = Not checked
```

```bash
./matrix_search.sh --all 5
```
```
╔════════════════════════════════════════════════════════════════╗
║           MATRIX SEARCH - Find All Occurrences                 ║
╚════════════════════════════════════════════════════════════════╝

Matrix (4x4):
┌───────────────────────────┐
│   5   3   8   5           │
│   2   5   1   7           │
│   5   9   4   6           │
│   3   5   2   5           │
└───────────────────────────┘

Search target: 5
Mode: Find all occurrences

Searching entire matrix...

[Row 0, Col 0] Found 5 ✓ (occurrence #1)
[Row 0, Col 3] Found 5 ✓ (occurrence #2)
[Row 1, Col 1] Found 5 ✓ (occurrence #3)
[Row 2, Col 0] Found 5 ✓ (occurrence #4)
[Row 3, Col 1] Found 5 ✓ (occurrence #5)
[Row 3, Col 3] Found 5 ✓ (occurrence #6)

════════════════════════════════════════
✓ SEARCH COMPLETE
════════════════════════════════════════

Found 6 occurrences of value 5

Locations:
  1. Row 0, Col 0
  2. Row 0, Col 3
  3. Row 1, Col 1
  4. Row 2, Col 0
  5. Row 3, Col 1
  6. Row 3, Col 3

Statistics:
  Matrix size: 4x4 (16 elements)
  All elements checked: 16
  Occurrences found: 6
  Frequency: 37.5%

Visual map:
┌───────────────────────────┐
│  [5]  3   8  [5]          │
│   2  [5]  1   7           │
│  [5]  9   4   6           │
│   3  [5]  2  [5]          │
└───────────────────────────┘
```

```bash
./matrix_search.sh --path 15
```
```
╔════════════════════════════════════════════════════════════════╗
║         MATRIX SEARCH - Show Search Path                       ║
╚════════════════════════════════════════════════════════════════╝

Matrix (6x6):
┌────────────────────────────────────────┐
│   2   8  12   5  18  22                │
│   9   4  15   1  19   7                │
│  14  11   6  20  13  25                │
│   3  17  23  16  10  24                │
│  21   8  15   9  27  30                │
│  26  28   4  15  29  31                │
└────────────────────────────────────────┘

Search target: 15
Mode: Find first with path visualization

Animated search path:

Step 1:  [■]  ░   ░   ░   ░   ░
         ░    ░   ░   ░   ░   ░
         ░    ░   ░   ░   ░   ░

Step 2:  ✓   [■]  ░   ░   ░   ░
         ░    ░   ░   ░   ░   ░
         ░    ░   ░   ░   ░   ░

Step 3:  ✓    ✓  [■]  ░   ░   ░
         ░    ░   ░   ░   ░   ░
         ░    ░   ░   ░   ░   ░

...

Step 9:  ✓    ✓   ✓   ✓   ✓   ✓
         ✓    ✓  [15] ░   ░   ░
         ░    ░   ░   ░   ░   ░

FOUND at Row 1, Col 2!

════════════════════════════════════════
Search Path:
════════════════════════════════════════

(0,0) → (0,1) → (0,2) → (0,3) → (0,4) → (0,5) →
(1,0) → (1,1) → (1,2) ✓

Comparisons: 9
Search pattern: Row-major order
Time: 0.009 seconds
```
### Bonus Challenge:
- Implement different search algorithms (breadth-first, depth-first)
- Add diagonal search
- Support sparse matrices
- Implement matrix operations (transpose, rotate)
- Add shortest path finder
- Support 3D matrices
- Add pattern matching (find submatrix)
- Implement flood fill algorithm
- Add maze solving
- Support different traversal orders

***
