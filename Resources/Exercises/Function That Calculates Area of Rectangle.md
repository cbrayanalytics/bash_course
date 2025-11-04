### Goal:
Create a script named `rectangle_area.sh` that implements functions to calculate rectangle properties.
### Requirements:
- Create function `calculate_area(length, width)` that returns area
- Create function `calculate_perimeter(length, width)` that returns perimeter
- Validate inputs (must be positive numbers)
- Handle invalid inputs gracefully
- Return results via echo
- Set appropriate return codes (0=success, 1=error)
- Support floating-point numbers (using bc)
- Create additional functions:
  - `is_square(length, width)` - check if it's a square
  - `calculate_diagonal(length, width)` - calculate diagonal
  - `calculate_aspect_ratio(length, width)` - return ratio
- Provide interactive mode and command-line mode
### Hints:
- Area formula: `length * width`
- Perimeter formula: `2 * (length + width)`
- Diagonal formula: `sqrt(length² + width²)`
- Use `bc` for floating-point: `echo "scale=2; $expr" | bc`
- Validate numeric: `[[ $var =~ ^[0-9]+(\.[0-9]+)?$ ]]`
- Return value via echo, status via return
### Expected Output Example:
```bash
./rectangle_area.sh 5 10
```
```
╔════════════════════════════════════════╗
║    RECTANGLE CALCULATOR                ║
╚════════════════════════════════════════╝

Input:
  Length: 5
  Width: 10

Calculations:
─────────────────────────────────────────
  Area: 50
  Perimeter: 30
  Diagonal: 11.18
  Aspect Ratio: 1:2
  Is Square: No

All calculations completed successfully
```

```bash
./rectangle_area.sh 7 7
```
```
╔════════════════════════════════════════╗
║    RECTANGLE CALCULATOR                ║
╚════════════════════════════════════════╝

Input:
  Length: 7
  Width: 7

Calculations:
─────────────────────────────────────────
  Area: 49
  Perimeter: 28
  Diagonal: 9.90
  Aspect Ratio: 1:1
  Is Square: Yes ✓

All calculations completed successfully
```

```bash
./rectangle_area.sh 5.5 3.2
```
```
╔════════════════════════════════════════╗
║    RECTANGLE CALCULATOR                ║
╚════════════════════════════════════════╝

Input:
  Length: 5.5
  Width: 3.2

Calculations:
─────────────────────────────────────────
  Area: 17.60
  Perimeter: 17.40
  Diagonal: 6.37
  Aspect Ratio: 55:32
  Is Square: No

All calculations completed successfully
```

```bash
./rectangle_area.sh -5 10
```
```
╔════════════════════════════════════════╗
║    RECTANGLE CALCULATOR                ║
╚════════════════════════════════════════╝

Error: Invalid input

✗ Length must be a positive number
  Received: -5

Usage: ./rectangle_area.sh <length> <width>
  Both values must be positive numbers
  Supports decimal values (e.g., 5.5)

Examples:
  ./rectangle_area.sh 5 10
  ./rectangle_area.sh 7.5 3.2
  
Exit code: 1
```

```bash
./rectangle_area.sh abc 10
```
```
Error: Invalid input

✗ Length must be numeric
  Received: abc (not a number)

Please provide valid numeric values
Exit code: 1
```
### Bonus Challenge:
- Add volume calculation for rectangular prism (3D)
- Support different units (cm, m, inches, feet)
- Add unit conversion
- Calculate surface area for 3D shape
- Create comparison mode (compare two rectangles)
- Add golden ratio detection
- Support batch processing from file
- Generate ASCII art representation
- Add measurement uncertainty/tolerance
- Export results to JSON/CSV

***
