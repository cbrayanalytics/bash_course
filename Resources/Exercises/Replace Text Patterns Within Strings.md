## Goal:
Create a script named `text_replacer.sh` that performs various text replacement operations.

***
## Requirements:
- Accept input text as an argument
- Perform and display these replacements:
  - Replace first occurrence of a word
  - Replace all occurrences of a word
  - Remove all spaces
  - Replace multiple spaces with single space
  - Remove all numbers
  - Replace underscores with hyphens

***
## Hints:
- Use `${text/pattern/replacement}` for first occurrence
- Use `${text//pattern/replacement}` for all occurrences
- Use `${text// /}` to remove spaces (replace with nothing)
- For multiple replacements, chain them or store intermediate results
- Patterns can be literal text or character classes

***
## Pseudocode:

```bash
BEGIN text_replacer.sh

  // ========================================
  // FUNCTION DEFINITIONS
  // ========================================

  FUNCTION display_usage()
    DISPLAY "Usage: ./text_replacer.sh <text>"
    DISPLAY "Bonus: ./text_replacer.sh -c <pattern> <replacement> <text>"
    DISPLAY "Flags:  -i (case-insensitive, bonus)"
    DISPLAY ""
    DISPLAY "Examples:"
    DISPLAY '  ./text_replacer.sh "hello world hello universe"'
    DISPLAY '  ./text_replacer.sh -c "foo" "bar" "foo foo bar"'
  ENDFUNCTION

  FUNCTION display_error(message)
    DISPLAY "✗ Error: " + message
  ENDFUNCTION

  FUNCTION validate_arguments(argc)
    IF argc < 1 THEN
      CALL display_error("At least one argument required.")
      CALL display_usage()
      EXIT 1
    END IF
  ENDFUNCTION

  // Standard replacements
  FUNCTION replace_first_occurrence(text, pattern, replacement)
    RETURN ${text/pattern/replacement}
  ENDFUNCTION

  FUNCTION replace_all_occurrences(text, pattern, replacement)
    RETURN ${text//pattern/replacement}
  ENDFUNCTION

  FUNCTION remove_all_spaces(text)
    RETURN ${text// /}
  ENDFUNCTION

  FUNCTION replace_spaces_with_dash(text)
    RETURN ${text// /-}
  ENDFUNCTION

  FUNCTION collapse_multiple_spaces(text)
    // Loop until no double space remains
    SET result to text
    WHILE result contains "  " DO
      SET result to ${result//  / }
    END WHILE
    RETURN result
  ENDFUNCTION

  FUNCTION remove_all_numbers(text)
    // Remove each digit from 0 to 9
    SET result to text
    FOR digit FROM "0" TO "9" DO
      SET result to ${result//$digit/}
    END FOR
    RETURN result
  ENDFUNCTION

  FUNCTION replace_underscores_with_hyphens(text)
    RETURN ${text//_/-}
  ENDFUNCTION

  FUNCTION remove_extension(text)
    IF text contains "." THEN
      RETURN ${text%.*}
    ELSE
      RETURN text
    END IF
  ENDFUNCTION

  // BONUS: Custom replacements
  FUNCTION custom_replace(text, pattern, replacement, case_insensitive)
    IF case_insensitive THEN
      // Advanced: use sed for regex and case insensitive matching
      RETURN output of: echo "$text" | sed "s/$pattern/$replacement/gi"
    ELSE
      RETURN ${text//pattern/replacement}
    END IF
  ENDFUNCTION

  // ========================================
  // MAIN EXECUTION
  // ========================================

  // Initialize flags
  SET custom_mode to false
  SET case_insensitive to false

  // Parse flags and switch to custom mode if necessary
  WHILE first argument starts with "-" DO
    IF $1 equals "-c" THEN
      SET custom_mode to true
      CALL shift
    ELSE IF $1 equals "-i" THEN
      SET case_insensitive to true
      CALL shift
    ELSE
      CALL display_error("Unknown flag: " + $1)
      CALL display_usage()
      EXIT 1
    END IF
  END WHILE

  // Custom replacement mode (BONUS)
  IF custom_mode THEN
    IF number of remaining args < 3 THEN
      CALL display_error("Custom mode requires <pattern> <replacement> <text>")
      CALL display_usage()
      EXIT 1
    END IF
    SET pattern to $1
    SET replacement to $2
    SET text to $3
    DISPLAY "Original text:   " + text
    SET result to custom_replace(text, pattern, replacement, case_insensitive)
    DISPLAY "Result:          " + result
    EXIT 0
  END IF

  // Standard mode (PRESET OPERATIONS)
  SET text to $1
  DISPLAY "Original text:           " + text

  // Replace first occurrence of 'hello' with 'hi'
  SET res1 to replace_first_occurrence(text, "hello", "hi")
  DISPLAY "Replace first 'hello':   " + res1

  // Replace all occurrences of 'hello' with 'hi'
  SET res2 to replace_all_occurrences(text, "hello", "hi")
  DISPLAY "Replace all 'hello':     " + res2

  // Remove all spaces
  SET res3 to remove_all_spaces(text)
  DISPLAY "Remove spaces:           " + res3

  // Replace spaces with dash
  SET res4 to replace_spaces_with_dash(text)
  DISPLAY "Replace spaces w/dash:   " + res4

  // Collapse multiple spaces to a single space
  SET res5 to collapse_multiple_spaces(text)
  DISPLAY "Collapse multi-spaces:   " + res5

  // Remove all numbers
  SET res6 to remove_all_numbers(text)
  DISPLAY "Remove numbers:          " + res6

  // Replace underscores with hyphens
  SET res7 to replace_underscores_with_hyphens(text)
  DISPLAY "Underscores to hyphens:  " + res7

  // Remove extension
  IF text contains "." THEN
    SET res8 to remove_extension(text)
    DISPLAY "Remove extension:        " + res8
  END IF

  EXIT 0

END text_replacer.sh
```

***
## Expected Output Example:
```bash
./text_replacer.sh "hello world hello universe"
```
```
Original text:           hello world hello universe

Replace first 'hello':   hi world hello universe
Replace all 'hello':     hi world hi universe
Remove spaces:           helloworldhellouniverse
Replace spaces w/dash:   hello-world-hello-universe
```

```bash
./text_replacer.sh "test_file_123.txt"
```
```
Original text:           test_file_123.txt

Remove numbers:          test_file_.txt
Underscores to hyphens:  test-file-123.txt
Remove extension:        test_file_123
```

***
## Bonus Challenge:
- Accept pattern and replacement as arguments (custom find/replace)
- Support regex-like patterns
- Case-insensitive replacement option

***
## Bonus Challenge Pseudocode:

### Bonus 1: Custom Pattern and Replacement
```
IF custom_mode THEN
  CALL custom_replace() with pattern / replacement / text
  DISPLAY result
END IF
```

### Bonus 2: Regex-Like Patterns
```
IF case_insensitive or advanced pattern THEN
  // Use sed for regex replacement
  SET result = echo "$text" | sed "s/$pattern/$replacement/gi"
END IF
```

### Bonus 3: Case-Insensitive Replacement
```
IF -i flag used:
  Use sed "s/$pattern/$replacement/gi" for global, case-insensitive replacement.
END IF
```

***
