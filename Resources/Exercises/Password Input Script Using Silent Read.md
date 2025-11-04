### Goal:
Create a script named `password.sh` that securely collects a password without displaying it on screen.
### Requirements:
- Use `read -s` to hide password input
- Prompt user to enter password
- Prompt user to confirm password (enter again)
- Compare both entries
- Display success message if they match, error if they don't
- Show password length (but not the actual password)
### Hints:
- The `-s` option hides input characters
- Combine `-s` with `-p` for a silent prompt
- Add `echo` after silent read to move to new line
- Use `${#variable}` to get string length
- Use `[[ "$var1" == "$var2" ]]` to compare strings
### Expected Output Example:
```
Enter password: 
Confirm password: 
✓ Passwords match!
Password length: 12 characters

--- OR ---

Enter password: 
Confirm password: 
✗ Error: Passwords do not match!
```
### Bonus Challenge:
Add password strength validation (minimum length, requires numbers, etc.).

***
