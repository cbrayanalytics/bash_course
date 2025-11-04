### Goal:
Create a script named `parallel_executor.sh` that runs multiple processes in parallel, monitors them, and waits for completion.
### Requirements:
- Start multiple background processes
- Track all PIDs
- Monitor process status
- Wait for all to complete
- Handle individual failures
- Show progress for each process
- Calculate total execution time
- Support timeout for individual processes
- Collect results from each process
- Generate execution report
### Expected Output Example:
```bash
./parallel_executor.sh task1.sh task2.sh task3.sh
```
```
╔════════════════════════════════════════════════════════════════╗
║         PARALLEL PROCESS EXECUTOR                              ║
╚════════════════════════════════════════════════════════════════╝

Tasks to execute: 3
Mode: Parallel execution
Started: 2025-10-19 23:58:30

Launching tasks...
────────────────────────────────────────────────────────────────
[Task 1] Starting: task1.sh
  → PID: 12345
  → Started at: 23:58:30
  ✓ Running

[Task 2] Starting: task2.sh
  → PID: 12346
  → Started at: 23:58:30
  ✓ Running

[Task 3] Starting: task3.sh
  → PID: 12347
  → Started at: 23:58:30
  ✓ Running

All tasks launched successfully

Monitoring execution...
────────────────────────────────────────────────────────────────
Time: 00:05 | Task 1: █████████░░░░░░░░ 45% | Task 2: ███████░░░░░░░░░░ 35% | Task 3: ████████████░░░░ 60%
Time: 00:10 | Task 1: █████████████████ 85% | Task 2: ████████████░░░░ 60% | Task 3: ████████████████ 90%
Time: 00:12 | Task 1: ████████████████ 100% ✓ | Task 2: █████████████░░ 75% | Task 3: ████████████████ 100% ✓

[INFO] Task 3 completed (PID: 12347)
  Duration: 12.3 seconds
  Exit code: 0
  Status: ✓ Success

[INFO] Task 1 completed (PID: 12345)
  Duration: 12.8 seconds
  Exit code: 0
  Status: ✓ Success

Time: 00:15 | Task 2: ████████████████ 100%

[INFO] Task 2 completed (PID: 12346)
  Duration: 15.2 seconds
  Exit code: 0
  Status: ✓ Success

╔════════════════════════════════════════════════════════════════╗
║                    EXECUTION COMPLETE                          ║
╚════════════════════════════════════════════════════════════════╝

Summary:
────────────────────────────────────────────────────────────────
Total tasks: 3
Successful: 3 ✓
Failed: 0
Success rate: 100%

Timing:
────────────────────────────────────────────────────────────────
Total wall time: 15.2 seconds
Sequential time would be: 40.3 seconds
Time saved: 25.1 seconds (62.3% faster)

Task Results:
────────────────────────────────────────────────────────────────
Task 1 (task1.sh):
  Duration: 12.8s
  Exit code: 0
  Output: /tmp/parallel_task1_12345.out
  Status: ✓ Success

Task 2 (task2.sh):
  Duration: 15.2s
  Exit code: 0
  Output: /tmp/parallel_task2_12346.out
  Status: ✓ Success

Task 3 (task3.sh):
  Duration: 12.3s
  Exit code: 0
  Output: /tmp/parallel_task3_12347.out
  Status: ✓ Success

[INFO] All tasks completed successfully
```

**With failure:**
```bash
./parallel_executor.sh task1.sh failing_task.sh task3.sh
```
```
[... execution starts ...]

Monitoring execution...
────────────────────────────────────────────────────────────────
Time: 00:05 | Task 1: ██████████░░░░░░ 50% | Task 2: ███████░░░░░░░░░ 35% | Task 3: ████████████░░░ 60%

[ERROR] Task 2 failed (PID: 12346)
  Duration: 5.7 seconds
  Exit code: 1
  Status: ✗ Failed
  Error log: /tmp/parallel_task2_12346.err

Time: 00:10 | Task 1: ████████████████ 100% | Task 3: ████████████████ 100%

[INFO] Task 1 completed (PID: 12345) - ✓ Success
[INFO] Task 3 completed (PID: 12347) - ✓ Success

╔════════════════════════════════════════════════════════════════╗
║               EXECUTION COMPLETE (WITH ERRORS)                 ║
╚════════════════════════════════════════════════════════════════╝

Summary:
────────────────────────────────────────────────────────────────
Total tasks: 3
Successful: 2 ✓
Failed: 1 ✗
Success rate: 66.7%

Failed Tasks:
────────────────────────────────────────────────────────────────
Task 2 (failing_task.sh):
  Duration: 5.7s
  Exit code: 1
  Error: Database connection failed
  Log: /tmp/parallel_task2_12346.err
  
  Last 10 lines of error log:
  ──────────────────────────────────────
  Connecting to database...
  Error: Connection timeout after 5 seconds
  Failed to establish connection
  Retrying...
  Error: Connection timeout after 5 seconds
  Max retries exceeded
  Task failed
  ──────────────────────────────────────

[ERROR] Some tasks failed
[INFO] Exit code: 1 (partial failure)
```
### Bonus Challenge:
- Add resource limiting (CPU, memory)
- Implement job prioritization
- Support dependent tasks (task B waits for task A)
- Add retry logic for failures
- Create task queuing system
- Support dynamic task addition
- Implement load balancing
- Add distributed execution support

***