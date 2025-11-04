### Goal:
Create a script named `greet.sh` that implements various greeting functions with parameters.
### Requirements:
- Create multiple greeting functions:
  - `greet_simple(name)` - Basic greeting
  - `greet_formal(title, name)` - Formal greeting with title
  - `greet_time(name)` - Time-based greeting (morning/afternoon/evening)
  - `greet_custom(name, message)` - Custom message greeting
- Accept command-line arguments or use interactive input
- Validate that name parameter is provided
- Handle empty/invalid names gracefully
- Support multiple names (greet each one)
- Add greeting styles (casual, formal, enthusiastic)
### Hints:
- Parameters accessed with `$1`, `$2`, etc.
- Check if parameter exists: `[[ -z "$1" ]]`
- Get current hour: `date +%H`
- Use local variables within functions
- Call functions with: `function_name "argument"`
### Expected Output Example:
```bash
./greet.sh Alice
```
```
╔════════════════════════════════════════╗
║         GREETING FUNCTIONS             ║
╚════════════════════════════════════════╝

Testing various greeting styles for: Alice

[1] Simple Greeting:
────────────────────────────────────────
Hello, Alice!

[2] Formal Greeting:
────────────────────────────────────────
Good day, Ms. Alice.

[3] Time-based Greeting (18:45):
────────────────────────────────────────
Good evening, Alice!

[4] Enthusiastic Greeting:
────────────────────────────────────────
HEY ALICE! 🎉 Great to see you!

[5] Custom Greeting:
────────────────────────────────────────
Welcome back, Alice! Hope you're having a wonderful day!

═══════════════════════════════════════
All greetings completed successfully!
```

```bash
./greet.sh Bob Charlie Diana
```
```
╔════════════════════════════════════════╗
║    GREETING MULTIPLE PEOPLE            ║
╚════════════════════════════════════════╗

Processing 3 names...

Person 1: Bob
  → Hello, Bob!
  → Welcome to the team!

Person 2: Charlie
  → Hello, Charlie!
  → Welcome to the team!

Person 3: Diana
  → Hello, Diana!
  → Welcome to the team!

═══════════════════════════════════════
Greeted 3 people successfully!
```

```bash
./greet.sh
```
```
Error: No name provided

Usage: ./greet.sh <name> [name2] [name3] ...

Examples:
  ./greet.sh Alice
  ./greet.sh Bob Charlie Diana
  
Try again with a name!
```

```bash
./greet.sh ""
```
```
Error: Empty name not allowed

Please provide a valid name (non-empty string)
```
### Bonus Challenge:
- Add greeting in multiple languages
- Support nickname/preferred name
- Add greeting history (track who was greeted)
- Create greeting templates
- Add random greeting generator
- Support greeting groups/teams
- Add personalized greetings based on time of day and name
- Create greeting statistics (most common names)

***
