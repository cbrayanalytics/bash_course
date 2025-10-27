### Goal:
Create a script named `quiz.sh` that asks a question with a time limit.
### Requirements:
- Ask the user a question (like "What is 5 + 7?")
- Use `read -t` to set a timeout (e.g., 5 seconds)
- If user answers in time, check if answer is correct
- If timeout occurs, inform user they ran out of time
- Display appropriate messages for both scenarios
### Hints:
- The `-t` option sets timeout in seconds
- When timeout occurs, `read` returns a non-zero exit status
- Check `$?` immediately after read to detect timeout
- Use conditional statements to handle timeout vs. answer scenarios
- Combine `-t` with `-p` for timed prompts
### Expected Output Example:
```
Quick! What is 5 + 7? (5 seconds): 12
Correct! You answered in time.

--- OR ---

Quick! What is 5 + 7? (5 seconds): 
Time's up! You didn't answer in time.

--- OR ---

Quick! What is 5 + 7? (5 seconds): 10
Wrong answer! The correct answer is 12.
```
### Bonus Challenge:
- Create a multi-question quiz with score tracking
- Display remaining time as user types (advanced)
- Allow different time limits for different difficulty questions

***
