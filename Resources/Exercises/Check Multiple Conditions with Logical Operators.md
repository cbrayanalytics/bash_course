### Goal:
Create a script named `login_validator.sh` that validates username and password with multiple conditions using logical operators.

***
### Requirements:
- Accept two arguments: username and password
- Validate username:
  - Not empty
  - Length between 3-20 characters
  - Contains only alphanumeric characters and underscores
- Validate password:
  - Not empty
  - Minimum 8 characters
  - Contains at least one number
  - Contains at least one letter
- Use `&&` and `||` operators to combine conditions
- Display which specific criteria failed
- Show success message only if all validations pass

***
### Hints:
- String length: `${#variable}`
- Pattern matching: `[[ $var =~ pattern ]]`
- Alphanumeric pattern: `^[a-zA-Z0-9_]+$`
- Contains number: `[0-9]`
- Contains letter: `[a-zA-Z]`
- Combine multiple checks with && and ||

***

### Pseudocode:

``` bash
# Login Validator Script Workflow
# File: login_validator.sh
# Purpose: Validate username and password with multiple security criteria
# Author: Senior Linux Admin
# Date: 2026-01-25

## SCRIPT INITIALIZATION
---
BEGIN SCRIPT

  # Declare global validation flags
  DECLARE username_valid AS boolean (default: true)
  DECLARE password_valid AS boolean (default: true)
  DECLARE all_checks_passed AS boolean (default: true)
  
  # Define validation criteria constants
  DECLARE MIN_USERNAME_LENGTH AS integer = 3
  DECLARE MAX_USERNAME_LENGTH AS integer = 20
  DECLARE MIN_PASSWORD_LENGTH AS integer = 8
  
  # Define regex patterns for validation
  DECLARE USERNAME_PATTERN AS string = "^[a-zA-Z0-9_]+$"
  DECLARE NUMBER_PATTERN AS string = "[0-9]"
  DECLARE LETTER_PATTERN AS string = "[a-zA-Z]"


## INPUT VALIDATION & ARGUMENT HANDLING
---
FUNCTION check_arguments():
  
  # Verify exactly 2 arguments provided
  IF argument_count != 2 THEN
    PRINT "✗ Error: Both username and password are required."
    PRINT "Usage: ./login_validator.sh <username> <password>"
    EXIT with status 1
  END IF
  
  # Assign arguments to named variables
  SET username = argument[1]
  SET password = argument[2]
  
  # Check for empty arguments (even if provided)
  IF username IS empty AND password IS empty THEN
    PRINT "✗ Error: Both username and password are required."
    PRINT "Usage: ./login_validator.sh <username> <password>"
    EXIT with status 1
  END IF
  
END FUNCTION


## USERNAME VALIDATION FUNCTIONS
---
FUNCTION validate_username(username):
  
  PRINT "Validating credentials..."
  PRINT ""
  
  # Initialize username validation tracking
  DECLARE username_errors AS integer = 0
  DECLARE username_length AS integer = LENGTH(username)
  
  # Test 1: Check if username is not empty
  DECLARE check_not_empty AS boolean
  IF username IS NOT empty THEN
    SET check_not_empty = true
    SET status_empty = "Pass"
  ELSE
    SET check_not_empty = false
    SET status_empty = "FAIL"
    INCREMENT username_errors
    SET username_valid = false
  END IF
  
  # Test 2: Check username length between 3-20 characters
  DECLARE check_length AS boolean
  IF username_length >= MIN_USERNAME_LENGTH AND username_length <= MAX_USERNAME_LENGTH THEN
    SET check_length = true
    SET status_length = "Pass (" + username_length + " characters)"
  ELSE IF username_length < MIN_USERNAME_LENGTH THEN
    SET check_length = false
    SET status_length = "FAIL (" + username_length + " characters - too short)"
    INCREMENT username_errors
    SET username_valid = false
  ELSE IF username_length > MAX_USERNAME_LENGTH THEN
    SET check_length = false
    SET status_length = "FAIL (" + username_length + " characters - too long)"
    INCREMENT username_errors
    SET username_valid = false
  END IF
  
  # Test 3: Check username contains only valid characters (alphanumeric + underscore)
  DECLARE check_valid_chars AS boolean
  IF username MATCHES USERNAME_PATTERN THEN
    SET check_valid_chars = true
    SET status_chars = "Pass"
  ELSE
    SET check_valid_chars = false
    SET status_chars = "FAIL (contains invalid characters)"
    INCREMENT username_errors
    SET username_valid = false
  END IF
  
  # Display username validation results
  IF username_errors == 0 THEN
    PRINT "✓ Username validation:"
  ELSE
    PRINT "✗ Username validation:"
  END IF
  
  PRINT "  - Not empty: " + status_empty
  PRINT "  - Length (3-20): " + status_length
  PRINT "  - Valid characters: " + status_chars
  PRINT ""
  
  # Return combined validation result using logical AND
  RETURN (check_not_empty AND check_length AND check_valid_chars)
  
END FUNCTION


## PASSWORD VALIDATION FUNCTIONS
---
FUNCTION validate_password(password):
  
  # Initialize password validation tracking
  DECLARE password_errors AS integer = 0
  DECLARE password_length AS integer = LENGTH(password)
  
  # Test 1: Check if password is not empty
  DECLARE check_not_empty AS boolean
  IF password IS NOT empty THEN
    SET check_not_empty = true
    SET status_empty = "Pass"
  ELSE
    SET check_not_empty = false
    SET status_empty = "FAIL"
    INCREMENT password_errors
    SET password_valid = false
  END IF
  
  # Test 2: Check minimum password length (8+ characters)
  DECLARE check_min_length AS boolean
  IF password_length >= MIN_PASSWORD_LENGTH THEN
    SET check_min_length = true
    SET status_length = "Pass (" + password_length + " characters)"
  ELSE
    SET check_min_length = false
    SET status_length = "FAIL (" + password_length + " characters)"
    INCREMENT password_errors
    SET password_valid = false
  END IF
  
  # Test 3: Check password contains at least one number
  DECLARE check_has_number AS boolean
  IF password MATCHES NUMBER_PATTERN THEN
    SET check_has_number = true
    SET status_number = "Pass"
  ELSE
    SET check_has_number = false
    SET status_number = "FAIL"
    INCREMENT password_errors
    SET password_valid = false
  END IF
  
  # Test 4: Check password contains at least one letter
  DECLARE check_has_letter AS boolean
  IF password MATCHES LETTER_PATTERN THEN
    SET check_has_letter = true
    SET status_letter = "Pass"
  ELSE
    SET check_has_letter = false
    SET status_letter = "FAIL"
    INCREMENT password_errors
    SET password_valid = false
  END IF
  
  # Display password validation results
  IF password_errors == 0 THEN
    PRINT "✓ Password validation:"
  ELSE
    PRINT "✗ Password validation:"
  END IF
  
  PRINT "  - Not empty: " + status_empty
  PRINT "  - Min length (8+): " + status_length
  PRINT "  - Contains number: " + status_number
  PRINT "  - Contains letter: " + status_letter
  PRINT ""
  
  # Return combined validation result using logical AND
  RETURN (check_not_empty AND check_min_length AND check_has_number AND check_has_letter)
  
END FUNCTION


## FINAL VALIDATION & OUTPUT
---
FUNCTION display_final_result(username_valid, password_valid):
  
  PRINT "════════════════════════════════════"
  
  # Use logical AND to check if all validations passed
  IF username_valid AND password_valid THEN
    PRINT "✓ All validations passed!"
    PRINT "Credentials are valid."
    PRINT "════════════════════════════════════"
    EXIT with status 0
  ELSE
    PRINT "✗ Validation failed!"
    PRINT "Please correct the errors above."
    PRINT "════════════════════════════════════"
    EXIT with status 1
  END IF
  
END FUNCTION


## MAIN EXECUTION FLOW
---
MAIN:
  
  # Step 1: Validate script arguments
  CALL check_arguments()
  
  # Step 2: Validate username with all criteria
  SET username_valid = validate_username(username)
  
  # Step 3: Validate password with all criteria
  SET password_valid = validate_password(password)
  
  # Step 4: Display final validation result
  CALL display_final_result(username_valid, password_valid)
  
END MAIN
```
### Expected Output Example:
```bash
./login_validator.sh john mypassword123
```
```
Validating credentials...

✓ Username validation:
  - Not empty: Pass
  - Length (3-20): Pass (4 characters)
  - Valid characters: Pass

✓ Password validation:
  - Not empty: Pass
  - Min length (8+): Pass (13 characters)
  - Contains number: Pass
  - Contains letter: Pass

════════════════════════════════════
✓ All validations passed!
Credentials are valid.
════════════════════════════════════
```

```bash
./login_validator.sh ab short
```
```
Validating credentials...

✗ Username validation:
  - Not empty: Pass
  - Length (3-20): FAIL (2 characters - too short)
  - Valid characters: Pass

✗ Password validation:
  - Not empty: Pass
  - Min length (8+): FAIL (5 characters)
  - Contains number: FAIL
  - Contains letter: Pass

════════════════════════════════════
✗ Validation failed!
Please correct the errors above.
════════════════════════════════════
```

```bash
./login_validator.sh "" ""
```
```
✗ Error: Both username and password are required.
Usage: ./login_validator.sh <username> <password>
```

***
### Bonus Challenge:
- Add password strength indicator (weak/medium/strong)
``` bash
FUNCTION calculate_password_strength(password):
  
  DECLARE strength_score AS integer = 0
  
  # Award points for meeting criteria
  IF LENGTH(password) >= 8 THEN INCREMENT strength_score
  IF LENGTH(password) >= 12 THEN INCREMENT strength_score
  IF password MATCHES NUMBER_PATTERN THEN INCREMENT strength_score
  IF password MATCHES LETTER_PATTERN THEN INCREMENT strength_score
  IF password MATCHES "[A-Z]" THEN INCREMENT strength_score
  IF password MATCHES "[a-z]" THEN INCREMENT strength_score
  IF password MATCHES "[!@#$%^&*()_+\-=\[\]{}|;:,.<>?]" THEN INCREMENT strength_score
  
  # Determine strength level
  IF strength_score <= 3 THEN
    RETURN "Weak"
  ELSE IF strength_score <= 5 THEN
    RETURN "Medium"
  ELSE
    RETURN "Strong"
  END IF
  
END FUNCTION
```

- Check for common weak passwords from a list
``` bash
FUNCTION check_weak_passwords(password):
  
  # Define array of common weak passwords
  DECLARE weak_passwords AS array = [
    "password", "12345678", "qwerty123", "admin123",
    "password123", "welcome1", "letmein1", "passw0rd"
  ]
  
  # Convert password to lowercase for comparison
  DECLARE password_lower = LOWERCASE(password)
  
  # Check against weak password list
  FOR EACH weak_pass IN weak_passwords DO
    IF password_lower == weak_pass THEN
      PRINT "  - Common password: FAIL (matches known weak password)"
      RETURN false
    END IF
  END FOR
  
  PRINT "  - Common password: Pass"
  RETURN true
  
END FUNCTION
```

- Require special characters in password
``` bash
FUNCTION check_special_characters(password):
  
  DECLARE SPECIAL_CHAR_PATTERN = "[!@#$%^&*()_+\-=\[\]{}|;:,.<>?]"
  
  IF password MATCHES SPECIAL_CHAR_PATTERN THEN
    PRINT "  - Contains special char: Pass"
    RETURN true
  ELSE
    PRINT "  - Contains special char: FAIL"
    RETURN false
  END IF
  
END FUNCTION
```

- Implement retry logic (3 attempts)
``` bash
FUNCTION main_with_retry():
  
  DECLARE MAX_ATTEMPTS AS integer = 3
  DECLARE current_attempt AS integer = 0
  
  WHILE current_attempt < MAX_ATTEMPTS DO
    INCREMENT current_attempt
    
    PRINT "Attempt " + current_attempt + " of " + MAX_ATTEMPTS
    
    # Read credentials from user input
    PROMPT "Enter username: " INTO username
    PROMPT "Enter password: " INTO password (hidden input)
    
    # Validate credentials
    SET username_valid = validate_username(username)
    SET password_valid = validate_password(password)
    
    # Check if validation successful
    IF username_valid AND password_valid THEN
      PRINT "✓ Login successful!"
      EXIT with status 0
    ELSE
      DECLARE remaining = MAX_ATTEMPTS - current_attempt
      IF remaining > 0 THEN
        PRINT "Attempts remaining: " + remaining
        PRINT ""
      END IF
    END IF
        
  END WHILE
  
  PRINT "✗ Maximum attempts exceeded. Access denied."
  EXIT with status 1
  
END FUNCTION
```

- Add option to generate secure password suggestion
``` bash
FUNCTION generate_secure_password():
  
  DECLARE password_length AS integer = 16
  DECLARE charset AS string = "A-Za-z0-9!@#$%^&*()_+-="
  
  # Generate random password using /dev/urandom and tr
  # Pseudocode representation:
  SET generated_password = RANDOM_CHARS_FROM(charset, password_length)
  
  PRINT "Suggested secure password: " + generated_password
  PRINT ""
  PRINT "Password characteristics:"
  PRINT "  - Length: " + password_length + " characters"
  PRINT "  - Contains uppercase letters: Yes"
  PRINT "  - Contains lowercase letters: Yes"
  PRINT "  - Contains numbers: Yes"
  PRINT "  - Contains special characters: Yes"
  
  RETURN generated_password
  
END FUNCTION
```

- Check against password history (simulate with array)
``` bash
FUNCTION check_password_history(username, new_password):
  
  # Simulate password history with associative array
  DECLARE password_history AS associative_array
  
  # Example history (in production, would read from secure storage)
  password_history["john"] = ["oldpass123", "john2024!", "previous99"]
  password_history["admin"] = ["admin2023!", "welcome2024"]
  
  # Check if user has password history
  IF username EXISTS IN password_history THEN
    
    # Get user's previous passwords
    DECLARE user_history = password_history[username]
    
    # Check against each historical password
    FOR EACH old_password IN user_history DO
      IF new_password == old_password THEN
        PRINT "  - Password history: FAIL (password previously used)"
        RETURN false
      END IF
    END FOR
    
  END IF
  
  PRINT "  - Password history: Pass"
  RETURN true
  
END FUNCTION
```

***

``` bash
FUNCTION enhanced_main():
  
  # Check arguments
  CALL check_arguments()
  
  # Validate username
  SET username_valid = validate_username(username)
  
  # Enhanced password validation
  PRINT "✓ Password validation (Enhanced):"
  
  # Run all password checks
  SET check1 = validate_password(password)
  SET check2 = check_weak_passwords(password)
  SET check3 = check_special_characters(password)
  SET check4 = check_password_history(username, password)
  
  # Calculate strength
  SET strength = calculate_password_strength(password)
  PRINT "  - Password strength: " + strength
  PRINT ""
  
  # Combine all checks with logical AND
  SET password_valid = (check1 AND check2 AND check3 AND check4)
  
  # Offer password generation if validation fails
  IF NOT password_valid THEN
    PRINT "Would you like a secure password suggestion? (y/n)"
    READ user_choice
    IF user_choice == "y" OR user_choice == "Y" THEN
      CALL generate_secure_password()
    END IF
  END IF
  
  # Display final result
  CALL display_final_result(username_valid, password_valid)
  
END FUNCTION
```