### Goal:
Create a script named `login_validator.sh` that validates username and password with multiple conditions using logical operators.
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
### Hints:
- String length: `${#variable}`
- Pattern matching: `[[ $var =~ pattern ]]`
- Alphanumeric pattern: `^[a-zA-Z0-9_]+$`
- Contains number: `[0-9]`
- Contains letter: `[a-zA-Z]`
- Combine multiple checks with && and ||
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
### Bonus Challenge:
- Add password strength indicator (weak/medium/strong)
- Check for common weak passwords from a list
- Require special characters in password
- Implement retry logic (3 attempts)
- Add option to generate secure password suggestion
- Check against password history (simulate with array)

***
