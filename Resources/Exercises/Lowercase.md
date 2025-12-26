## Goal:
Create a script named `case_converter.sh` that converts text between different cases.

***
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

***
## Hints:
- Use `${text^^}` for uppercase
- Use `${text,,}` for lowercase
- Use `${text^}` to capitalize first letter
- Combine operations for title case: `${text,,}` then `${text^}`
- Use case statement to handle different conversion types

***
## Pseudocode 

```
BEGIN case_converter.sh

  // ========================================
  // FUNCTION DEFINITIONS
  // ========================================

  FUNCTION display_usage()
    DISPLAY "Usage: ./case_converter.sh <conversion_type> <text>"
    DISPLAY "Conversion types:"
    DISPLAY "  upper    - Convert all to uppercase"
    DISPLAY "  lower    - Convert all to lowercase"
    DISPLAY "  title    - First letter uppercase, rest lowercase"
    DISPLAY "  toggle   - First letter lowercase, rest uppercase"
    DISPLAY "  proper   - Each word capitalized (BONUS)"
    DISPLAY "You may provide text directly or as a file with option: -f <filename>"
    DISPLAY ""
  ENDFUNCTION

  FUNCTION display_error(message)
    DISPLAY "✗ Error: " + message
  ENDFUNCTION

  FUNCTION validate_arguments(argc)
    IF argc < 2 THEN
      CALL display_error("At least 2 arguments required.")
      CALL display_usage()
      EXIT 1
    END IF
  ENDFUNCTION

  FUNCTION validate_conversion_type(type)
    SET valid_types to ["upper", "lower", "title", "toggle", "proper"]
    IF type NOT in valid_types THEN
      CALL display_error("Invalid conversion type: " + type)
      CALL display_usage()
      EXIT 1
    END IF
  ENDFUNCTION

  FUNCTION convert_to_upper(text)
    RETURN ${text^^}
  ENDFUNCTION

  FUNCTION convert_to_lower(text)
    RETURN ${text,,}
  ENDFUNCTION

  FUNCTION convert_to_title(text)
    SET lowered to ${text,,}
    RETURN ${lowered^}
  ENDFUNCTION

  FUNCTION convert_to_toggle(text)
    SET upped to ${text^^}
    RETURN ${upped,}
  ENDFUNCTION

  FUNCTION convert_to_proper(text)
    // BONUS: capitalize each word
    SPLIT text into words
    SET output to ""
    FOR EACH word in words DO
      SET lowered to ${word,,}
      SET proper_word to ${lowered^}
      APPEND proper_word and a space to output
    END FOR
    TRIM trailing space from output
    RETURN output
  ENDFUNCTION

  FUNCTION read_from_file(filename)
    IF filename does NOT exist OR is NOT readable THEN
      CALL display_error("File not found or unreadable: " + filename)
      EXIT 1
    END IF
    SET text to contents of filename
    RETURN text
  ENDFUNCTION

  FUNCTION perform_conversion(type, text)
    CASE type OF
      "upper":  RETURN convert_to_upper(text)
      "lower":  RETURN convert_to_lower(text)
      "title":  RETURN convert_to_title(text)
      "toggle": RETURN convert_to_toggle(text)
      "proper": RETURN convert_to_proper(text)
      DEFAULT:  CALL display_error("Unknown conversion type"); EXIT 1
    END CASE
  ENDFUNCTION

  // ========================================
  // MAIN EXECUTION
  // ========================================

  // Check for file input flag
  IF $2 equals "-f" AND $3 is specified THEN
    // BONUS: text is read from file
    SET text to read_from_file($3)
    SET type to $1
  ELSE
    SET type to $1
    SET text to $2
  END IF

  // Validate arguments and conversion type
  CALL validate_arguments($#)
  CALL validate_conversion_type(type)

  // Perform conversion
  SET converted to perform_conversion(type, text)

  // Display output
  DISPLAY "Original:  " + text
  DISPLAY "Converted: " + converted

  EXIT 0

END case_converter.sh
```

***
## Bonus Challenge:
- Implement "proper" title case where each word is capitalized
- Add validation for conversion type
- Support reading from file instead of argument

***
## Expected Output Example:
```bash
./case_converter.sh upper "hello world"
Original: hello world
Converted: HELLO WORLD
```

```bash
./case_converter.sh title "hello world"
Original: hello world
Converted: Hello world
```

```bash
./case_converter.sh lower "HELLO WORLD"
Original: HELLO WORLD
Converted: hello world
```

***
