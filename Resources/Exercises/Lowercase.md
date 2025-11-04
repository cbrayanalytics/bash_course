## Goal:
Create a script named `case_converter.sh` that converts text between different cases.
## Requirements:
- Accept two arguments:
  - `$1` - Conversion type: `upper`, `lower`, `title`, or `toggle`
  - `$2` - The text to convert
- Support these conversions:
  - `upper` - Convert all to uppercase
  - `lower` - Convert all to lowercase
  - `title` - First letter uppercase, rest lowercase
  - `toggle` - First letter lowercase, rest uppercase (reverse title)
- Display both original and converted text
## Hints:
- Use `${text^^}` for uppercase
- Use `${text,,}` for lowercase
- Use `${text^}` to capitalize first letter
- Combine operations for title case: `${text,,}` then `${text^}`
- Use case statement to handle different conversion types
## Expected Output Example:
```bash
./case_converter.sh upper "hello world"
```
```
Original: hello world
Converted: HELLO WORLD
```

```bash
./case_converter.sh title "hello world"
```
```
Original: hello world
Converted: Hello world
```

```bash
./case_converter.sh lower "HELLO WORLD"
```
```
Original: HELLO WORLD
Converted: hello world
```
## Bonus Challenge:
- Implement "proper" title case where each word is capitalized
- Add validation for conversion type
- Support reading from file instead of argument

***
