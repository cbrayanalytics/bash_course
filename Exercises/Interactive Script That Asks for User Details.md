### Goal:
Create a script named `userinfo.sh` that prompts for and collects user details: name, age, and location.
### Requirements:
- Use `read -p` to prompt for three pieces of information
- Store each in a separate variable
- Display all collected information in a formatted summary
- Handle the case where the user enters multiple words for name/location
### Hints:
- Use descriptive prompts with `-p` option
- Remember that spaces in input can split across variables
- Consider using quotes when displaying variables with spaces
- Think about the order of prompts for a natural conversation flow
### Expected Output Example:
```
Enter your full name: John Doe
Enter your age: 30
Enter your location: Denver, Colorado

=== User Profile ===
Name: John Doe
Age: 30
Location: Denver, Colorado
```
### Bonus Challenge:
Add basic validation to ensure age is a number and name/location are not empty.

***
