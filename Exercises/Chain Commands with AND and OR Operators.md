### Goal:
Create a script named `command_chain.sh` that demonstrates effective use of command chaining with `&&` and `||` operators.
### Requirements:
- Implement various command chain patterns
- Show short-circuit evaluation in action
- Demonstrate these patterns:
  - Success chains (all commands must succeed)
  - Fallback chains (try alternatives)
  - Conditional chains (based on previous results)
  - Complex mixed chains
  - Error recovery chains
- Provide visual feedback showing which commands executed
- Log chain execution flow
- Support chain debugging mode
- Handle chain failures gracefully
### Hints:
- `cmd1 && cmd2` - cmd2 only if cmd1 succeeds
- `cmd1 || cmd2` - cmd2 only if cmd1 fails - Combine: `cmd1 && cmd2 || cmd3`
- Use `true` and `false` commands for testing
### Expected Output Example:
```bash
./command_chain.sh
```
```
╔════════════════════════════════════════════════════════════════╗
║           COMMAND CHAINING DEMONSTRATION                       ║
╚════════════════════════════════════════════════════════════════╝

Pattern 1: Success Chain (AND operator)
────────────────────────────────────────────────────────────────
Chain: mkdir temp && cd temp && touch file.txt

  [1] mkdir temp
      ✓ Succeeded (exit 0)
      → Continuing to next command
      
  [2] cd temp
      ✓ Succeeded (exit 0)
      → Continuing to next command
      
  [3] touch file.txt
      ✓ Succeeded (exit 0)
      → Chain completed

Result: ✓ ALL COMMANDS SUCCEEDED
────────────────────────────────────────────────────────────────

Pattern 2: Fallback Chain (OR operator)
────────────────────────────────────────────────────────────────
Chain: cat cached.txt || wget http://example.com/file.txt

  [1] cat cached.txt
      ✗ Failed (exit 1) - file not found
      → Trying fallback command
      
  [2] wget http://example.com/file.txt
      ✓ Succeeded (exit 0)
      → Chain completed

Result: ✓ FALLBACK SUCCEEDED
────────────────────────────────────────────────────────────────

Pattern 3: Success with Notification
────────────────────────────────────────────────────────────────
Chain: backup_data && echo "Backup successful" || echo "Backup failed"

  [1] backup_data
      ✓ Succeeded (exit 0)
      → Executing success action
      
  [2] echo "Backup successful"
      Output: Backup successful
      ✓ Succeeded (exit 0)
      → Skipping failure action (previous command succeeded)

Result: ✓ SUCCESS ACTION EXECUTED
────────────────────────────────────────────────────────────────

Pattern 4: Complex Chain with Multiple Fallbacks
────────────────────────────────────────────────────────────────
Chain: primary || secondary || tertiary || echo "All failed"

  [1] primary
      ✗ Failed (exit 1)
      → Trying next alternative
      
  [2] secondary
      ✗ Failed (exit 1)
      → Trying next alternative
      
  [3] tertiary
      ✓ Succeeded (exit 0)
      → Chain completed (alternative 3 succeeded)

Result: ✓ TERTIARY ALTERNATIVE SUCCEEDED
────────────────────────────────────────────────────────────────

Pattern 5: Conditional Execution
────────────────────────────────────────────────────────────────
Chain: test -f config.yaml && load_config || use_defaults

  [1] test -f config.yaml
      ✓ Succeeded (exit 0) - file exists
      → Executing primary action
      
  [2] load_config
      ✓ Succeeded (exit 0)
      → Skipping default action

Result: ✓ CONFIG LOADED FROM FILE
────────────────────────────────────────────────────────────────

╔════════════════════════════════════════════════════════════════╗
║                        SUMMARY                                 ║
╚════════════════════════════════════════════════════════════════╝

Patterns demonstrated: 5
Successful chains: 5
Failed chains: 0
Commands executed: 14
Short-circuits avoided: 6
```

```bash
./command_chain.sh --debug
```
```
╔════════════════════════════════════════════════════════════════╗
║        COMMAND CHAINING - DEBUG MODE                           ║
╚════════════════════════════════════════════════════════════════╝

Chain: mkdir test && cd test && ls -la || echo "Failed"

[DEBUG] Starting chain execution
[DEBUG] Operator precedence: && has higher priority than ||

Step 1: mkdir test
  [DEBUG] Executing: mkdir test
  [DEBUG] Working directory: /home/user
  [DEBUG] Exit code: 0
  [DEBUG] Evaluation: 0 == 0 (success)
  [DEBUG] Next operator: && (AND)
  [DEBUG] Decision: Execute next command (previous succeeded)
  ✓ Success

Step 2: cd test
  [DEBUG] Executing: cd test
  [DEBUG] Working directory before: /home/user
  [DEBUG] Working directory after: /home/user/test
  [DEBUG] Exit code: 0
  [DEBUG] Evaluation: 0 == 0 (success)
  [DEBUG] Next operator: && (AND)
  [DEBUG] Decision: Execute next command (previous succeeded)
  ✓ Success

Step 3: ls -la
  [DEBUG] Executing: ls -la
  [DEBUG] Output captured (3 lines)
  [DEBUG] Exit code: 0
  [DEBUG] Evaluation: 0 == 0 (success)
  [DEBUG] Next operator: || (OR)
  [DEBUG] Decision: Skip next command (previous succeeded)
  ✓ Success

Step 4: echo "Failed"
  [DEBUG] Skipped (previous command in OR chain succeeded)
  ⊘ Skipped

[DEBUG] Chain execution complete
[DEBUG] Final exit code: 0
[DEBUG] Total execution time: 0.043s

Result: ✓ CHAIN SUCCEEDED (3/4 commands executed)
```
### Bonus Challenge:
- Add timeout for long-running chains
- Implement chain branching (if-then-else with chains)
- Create chain templates library
- Add chain profiling (timing each command)
- Support parallel chain execution
- Implement chain transactions (rollback on failure)
- Add chain visualization (flowchart)
- Create chain optimizer

***