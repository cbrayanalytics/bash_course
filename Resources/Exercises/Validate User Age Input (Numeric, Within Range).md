### Goal:
Create a script named `age_validator.sh` that validates age input according to multiple criteria.

***
### Requirements:
- Prompt user for their age (or accept as argument)
- Validate that:
  - Input is not empty
  - Input is a number (integers only)
  - Number is within reasonable range (0-120)
  - Number is a positive integer
- Provide specific error messages for each validation failure
- If valid, categorize age:
  - 0-12: Child
  - 13-17: Teenager
  - 18-64: Adult
  - 65+: Senior
- Display category with appropriate message

***
### Hints:
- Check empty: `[[ -z "$age" ]]`
- Check numeric: `[[ $age =~ ^[0-9]+$ ]]`
- Use multiple if/elif statements for validation
- Use logical AND to combine conditions
- Exit with error code if validation fails

***

### Pseudocode:
``` bash
#!/bin/bash
################################################################################
# Script: age_validator.sh
# Description: Validates user age input with comprehensive error checking and
#              categorizes age into demographic groups with relevant information
# Usage: ./age_validator.sh [age]
#        If no argument provided, script will prompt for input
# Exit Codes:
#   0 - Success
#   1 - Empty input
#   2 - Non-numeric input
#   3 - Negative number
#   4 - Out of range (not 0-120)
################################################################################

# =============================================================================
# INITIALIZATION
# =============================================================================

# Enable strict error handling
SET shell_options TO: exit_on_error, exit_on_undefined_var, pipefail_enabled

# Define age range constants
DECLARE readonly MIN_AGE = 0
DECLARE readonly MAX_AGE = 120

# Define output formatting constants
DECLARE readonly SUCCESS_SYMBOL = "✓"
DECLARE readonly ERROR_SYMBOL = "✗"

# Store current year for calculations
DECLARE readonly CURRENT_YEAR = GET current_year_from_date_command


# =============================================================================
# INPUT ACQUISITION FUNCTION
# =============================================================================

FUNCTION get_age_input():
    """
    Retrieves age from command-line argument or user prompt
    Returns: age value as string
    """
    
    IF command_line_argument_1_exists THEN:
        age = command_line_argument_1
    ELSE:
        PROMPT user: "Enter your age: "
        READ user_input INTO age
    END IF
    
    # Return the age value (using echo for function return)
    ECHO age
END FUNCTION


# =============================================================================
# VALIDATION FUNCTIONS
# =============================================================================

FUNCTION validate_not_empty(input):
    """
    Validates that input is not empty or whitespace only
    Parameters: input - string to validate
    Returns: 0 if valid, exits with code 1 if invalid
    """
    
    IF input is_empty OR input matches_only_whitespace THEN:
        PRINT_ERROR "Age cannot be empty."
        EXIT with_code 1
    END IF
    
    RETURN 0
END FUNCTION


FUNCTION validate_is_numeric(input):
    """
    Validates that input contains only digits (positive integers)
    Parameters: input - string to validate
    Returns: 0 if valid, exits with code 2 if invalid
    """
    
    # Use regex pattern to match one or more digits: ^[0-9]+$
    IF input does_not_match regex_pattern "^[0-9]+$" THEN:
        PRINT_ERROR "Age must be a number."
        EXIT with_code 2
    END IF
    
    RETURN 0
END FUNCTION


FUNCTION validate_not_negative(input):
    """
    Validates that numeric input is not negative
    Parameters: input - numeric string to validate
    Returns: 0 if valid, exits with code 3 if invalid
    """
    
    # Check if first character is minus sign
    IF input starts_with "-" THEN:
        PRINT_ERROR "Age cannot be negative."
        EXIT with_code 3
    END IF
    
    RETURN 0
END FUNCTION


FUNCTION validate_in_range(input, min, max):
    """
    Validates that numeric input falls within acceptable range
    Parameters: input - number to check, min - minimum value, max - maximum value
    Returns: 0 if valid, exits with code 4 if invalid
    """
    
    IF input less_than min OR input greater_than max THEN:
        PRINT_ERROR "Age must be between ${min} and ${max}."
        EXIT with_code 4
    END IF
    
    RETURN 0
END FUNCTION


# =============================================================================
# CATEGORIZATION FUNCTION
# =============================================================================

FUNCTION categorize_age(age):
    """
    Categorizes age into demographic groups
    Parameters: age - validated numeric age
    Returns: category string
    """
    
    DECLARE category
    
    IF age >= 0 AND age <= 12 THEN:
        category = "Child"
    ELSE IF age >= 13 AND age <= 17 THEN:
        category = "Teenager"
    ELSE IF age >= 18 AND age <= 64 THEN:
        category = "Adult"
    ELSE IF age >= 65 THEN:
        category = "Senior"
    END IF
    
    ECHO category
END FUNCTION


# =============================================================================
# OUTPUT FUNCTIONS
# =============================================================================

FUNCTION print_error(message):
    """
    Prints formatted error message to stderr
    Parameters: message - error description
    """
    
    PRINT_TO_STDERR "${ERROR_SYMBOL} Error: ${message}"
END FUNCTION


FUNCTION display_age_information(age, category):
    """
    Displays validated age with demographic category and eligibility info
    Parameters: age - validated age, category - demographic category
    """
    
    # Display validation success
    PRINT ""
    PRINT "${SUCCESS_SYMBOL} Valid age: ${age}"
    PRINT "Category: ${category}"
    
    # Calculate and display voting eligibility
    IF age >= 18 THEN:
        PRINT "Voting eligible: Yes"
    ELSE:
        PRINT "Voting eligible: No"
    END IF
    
    # Calculate and display senior discount eligibility
    IF age >= 65 THEN:
        PRINT "Senior discount: Yes"
    ELSE:
        PRINT "Senior discount: No"
    END IF
    
    PRINT ""
END FUNCTION


# =============================================================================
# MAIN EXECUTION FLOW
# =============================================================================

FUNCTION main():
    """
    Main execution function - orchestrates validation and output
    """
    
    # Acquire age input from argument or prompt
    DECLARE age = CALL get_age_input()
    
    # Execute validation chain (each exits on failure)
    CALL validate_not_empty(age)
    CALL validate_is_numeric(age)
    CALL validate_not_negative(age)
    CALL validate_in_range(age, MIN_AGE, MAX_AGE)
    
    # If all validations pass, categorize the age
    DECLARE category = CALL categorize_age(age)
    
    # Display formatted results
    CALL display_age_information(age, category)
    
    # Exit successfully
    EXIT with_code 0
END FUNCTION


# Execute main function
CALL main()
```

***
### Expected Output Example:
```bash
./age_validator.sh
```
```
Enter your age: 25

✓ Valid age: 25
Category: Adult
Voting eligible: Yes
Senior discount: No
```

```bash
./age_validator.sh
```
```
Enter your age: 

✗ Error: Age cannot be empty.
```

```bash
./age_validator.sh
```
```
Enter your age: abc

✗ Error: Age must be a number.
```

```bash
./age_validator.sh
```
```
Enter your age: 150

✗ Error: Age must be between 0 and 120.
```

```bash
./age_validator.sh
```
```
Enter your age: -5

✗ Error: Age cannot be negative.
```

***
### Bonus Challenge:
- Calculate birth year based on current year
``` bash
### Feature 1: Birth Year Calculator

FUNCTION calculate_birth_year(age, current_year):
    """
    Calculates approximate birth year based on current age
    Note: Actual birth year depends on whether birthday has occurred this year
    """
    
    birth_year_approx = current_year - age
    birth_year_range_start = birth_year_approx - 1
    birth_year_range_end = birth_year_approx
    
    PRINT "Estimated birth year: ${birth_year_range_start}-${birth_year_range_end}"
END FUNCTION
```

- Add more age-specific information (legal drinking age, retirement age, etc.)
``` bash
### Feature 2: Additional Age-Specific Information

FUNCTION display_extended_information(age):
    """
    Displays comprehensive age-related eligibility and milestones
    """
    
    # Driving eligibility (varies by state, using common age 16)
    IF age >= 16 THEN:
        PRINT "Driving eligible: Yes"
    ELSE:
        years_until_driving = 16 - age
        PRINT "Driving eligible: No (${years_until_driving} years remaining)"
    END IF
    
    # Legal drinking age (US federal law)
    IF age >= 21 THEN:
        PRINT "Legal drinking age: Yes"
    ELSE:
        PRINT "Legal drinking age: No"
    END IF
    
    # Full retirement age (Social Security)
    IF age >= 67 THEN:
        PRINT "Full retirement age: Yes"
    ELSE:
        PRINT "Full retirement age: No"
    END IF
    
    # Medicare eligibility
    IF age >= 65 THEN:
        PRINT "Medicare eligible: Yes"
    ELSE:
        PRINT "Medicare eligible: No"
    END IF
END FUNCTION
```

- Support multiple users (loop until user quits)
``` bash
### Feature 3: Multiple User Loop

FUNCTION main_with_loop():
    """
    Continuous input mode - validate multiple ages until user quits
    """
    
    DECLARE continue_flag = "yes"
    
    WHILE continue_flag equals "yes" DO:
        
        # Run validation process
        PROMPT user: "Enter your age: "
        READ user_input INTO age
        
        # Perform all validations with error handling
        IF validate_all_criteria(age) equals SUCCESS THEN:
            category = CALL categorize_age(age)
            CALL display_age_information(age, category)
        END IF
        
        # Ask if user wants to continue
        PRINT ""
        PROMPT user: "Validate another age? (yes/no): "
        READ user_input INTO continue_flag
        
        # Normalize input to lowercase
        continue_flag = CONVERT_TO_LOWERCASE(continue_flag)
        
    END WHILE
    
    PRINT "Exiting age validator."
END FUNCTION
```

- Save validated ages to array and show statistics
``` bash
### Feature 4: Statistics Tracking with Arrays

FUNCTION main_with_statistics():
    """
    Tracks multiple validated ages and displays statistical summary
    """
    
    # Initialize array to store validated ages
    DECLARE ages_array = EMPTY_ARRAY
    DECLARE continue_flag = "yes"
    
    WHILE continue_flag equals "yes" DO:
        
        PROMPT user: "Enter your age: "
        READ user_input INTO age
        
        # Validate and store if valid
        IF validate_all_criteria(age) equals SUCCESS THEN:
            APPEND age TO ages_array
            PRINT "${SUCCESS_SYMBOL} Age ${age} recorded."
        END IF
        
        PROMPT user: "Add another age? (yes/no): "
        READ continue_flag
        continue_flag = CONVERT_TO_LOWERCASE(continue_flag)
        
    END WHILE
    
    # Calculate and display statistics
    IF array_length(ages_array) greater_than 0 THEN:
        CALL display_statistics(ages_array)
    ELSE:
        PRINT "No valid ages recorded."
    END IF
END FUNCTION


FUNCTION display_statistics(ages_array):
    """
    Calculates and displays statistical analysis of collected ages
    Parameters: ages_array - array of validated age integers
    """
    
    DECLARE total_count = LENGTH_OF(ages_array)
    DECLARE sum = 0
    DECLARE min_age = FIRST_ELEMENT(ages_array)
    DECLARE max_age = FIRST_ELEMENT(ages_array)
    
    # Iterate through array to calculate statistics
    FOR EACH age IN ages_array DO:
        sum = sum + age
        
        IF age less_than min_age THEN:
            min_age = age
        END IF
        
        IF age greater_than max_age THEN:
            max_age = age
        END IF
    END FOR
    
    # Calculate average (using bc for decimal precision)
    average = sum divided_by total_count (rounded to 2 decimal places)
    
    # Display statistical summary
    PRINT ""
    PRINT "=== Age Statistics ==="
    PRINT "Total entries: ${total_count}"
    PRINT "Minimum age: ${min_age}"
    PRINT "Maximum age: ${max_age}"
    PRINT "Average age: ${average}"
    
    # Display category distribution
    CALL display_category_distribution(ages_array)
END FUNCTION


FUNCTION display_category_distribution(ages_array):
    """
    Counts and displays distribution across age categories
    Parameters: ages_array - array of validated ages
    """
    
    DECLARE child_count = 0
    DECLARE teen_count = 0
    DECLARE adult_count = 0
    DECLARE senior_count = 0
    
    # Count entries in each category
    FOR EACH age IN ages_array DO:
        category = CALL categorize_age(age)
        
        CASE category OF:
            "Child": INCREMENT child_count
            "Teenager": INCREMENT teen_count
            "Adult": INCREMENT adult_count
            "Senior": INCREMENT senior_count
        END CASE
    END FOR
    
    # Display distribution
    PRINT ""
    PRINT "Category Distribution:"
    PRINT "  Child (0-12): ${child_count}"
    PRINT "  Teenager (13-17): ${teen_count}"
    PRINT "  Adult (18-64): ${adult_count}"
    PRINT "  Senior (65+): ${senior_count}"
END FUNCTION
```