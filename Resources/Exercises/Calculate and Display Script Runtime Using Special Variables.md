### Goal:
Create a script named `runtime.sh` that calculates and displays how long it takes to execute.
### Requirements:
- [x] Capture the start time (use `date +%s` for seconds since epoch)
- [x] Perform some operation (like a sleep or loop)
- [x] Capture the end time
- [x] Calculate and display the runtime in seconds
- [x] Use `$$` to display the script's process ID
- [x] Use `$0` to display the script name
### Hints:
- `date +%s` returns current timestamp in seconds
- Store start time in a variable, do work, then get end time
- Subtract start from end to get runtime
- Arithmetic: `$((end - start))`
### Expected Output Example:
```
Script: ./runtime.sh
Process ID: 12345
Starting execution...
[work happens here]
Execution completed
Runtime: 3 seconds
```

***