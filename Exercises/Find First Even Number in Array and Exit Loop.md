### Goal:
Create a script named `find_even.sh` that searches through an array of numbers and finds the first even number, then exits immediately.
### Requirements:
- Accept numbers as command-line arguments (or use predefined array)
- Loop through the array
- Check each number to see if it's even
- When first even number is found:
  - Display the number
  - Display its position in array
  - Exit the loop immediately
- If no even numbers found, display appropriate message
- Show how many numbers were checked before finding (or exhausting)
- Support multiple search modes:
  - Find first even
  - Find first odd
  - Find first number > threshold
  - Find first prime number
### Hints:
- Check even: `((num % 2 == 0))`
- Check odd: `((num % 2 != 0))`
- Use `break` to exit loop
- Track position with counter
- Array iteration: `for num in "${array[@]}"`
### Expected Output Example:
```bash
./find_even.sh 1 3 5 7 8 9 10 12
```
```
╔════════════════════════════════════════╗
║     FIND FIRST EVEN NUMBER             ║
╚════════════════════════════════════════╝

Array: [1, 3, 5, 7, 8, 9, 10, 12]
Total elements: 8

Searching for first even number...

Checking position 0: 1 (odd)
Checking position 1: 3 (odd)
Checking position 2: 5 (odd)
Checking position 3: 7 (odd)
Checking position 4: 8 (even) ✓

════════════════════════════════════════
✓ FOUND!
════════════════════════════════════════

First even number: 8
Position: 4 (5th element)
Numbers checked: 5 of 8
Remaining unchecked: [9, 10, 12]
```

```bash
./find_even.sh 1 3 5 7 9
```
```
╔════════════════════════════════════════╗
║     FIND FIRST EVEN NUMBER             ║
╚════════════════════════════════════════╝

Array: [1, 3, 5, 7, 9]
Total elements: 5

Searching for first even number...

Checking position 0: 1 (odd)
Checking position 1: 3 (odd)
Checking position 2: 5 (odd)
Checking position 3: 7 (odd)
Checking position 4: 9 (odd)

════════════════════════════════════════
✗ NOT FOUND
════════════════════════════════════════

No even numbers in array
All 5 elements checked
Array contains only odd numbers
```

```bash
./find_even.sh --mode prime 4 6 8 9 11 13 15
```
```
╔════════════════════════════════════════╗
║     FIND FIRST PRIME NUMBER            ║
╚════════════════════════════════════════╝

Array: [4, 6, 8, 9, 11, 13, 15]
Total elements: 7

Searching for first prime number...

Checking position 0: 4 (not prime - divisible by 2)
Checking position 1: 6 (not prime - divisible by 2)
Checking position 2: 8 (not prime - divisible by 2)
Checking position 3: 9 (not prime - divisible by 3)
Checking position 4: 11 (prime) ✓

════════════════════════════════════════
✓ FOUND!
════════════════════════════════════════

First prime number: 11
Position: 4 (5th element)
Numbers checked: 5 of 7
Search completed in 0.003 seconds
```

```bash
./find_even.sh --threshold 50 10 20 30 60 70
```
```
╔════════════════════════════════════════╗
║     FIND FIRST NUMBER > 50             ║
╚════════════════════════════════════════╝

Array: [10, 20, 30, 60, 70]
Threshold: 50

Searching...

[1] 10 ≤ 50
[2] 20 ≤ 50
[3] 30 ≤ 50
[4] 60 > 50 ✓

════════════════════════════════════════
✓ FOUND!
════════════════════════════════════════

First number > 50: 60
Position: 3 (4th element)
```
### Bonus Challenge:
- Find multiple matches (all even numbers) with option to stop after N matches
- Add performance timing
- Support searching for patterns (e.g., numbers ending in 5)
- Implement binary search for sorted arrays
- Find last occurrence instead of first
- Add verbose/quiet modes
- Support negative numbers
- Find duplicates

***
