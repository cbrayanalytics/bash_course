### Goal:
Create a script named `graceful_interrupt.sh` that handles interruption signals properly, performs cleanup, and exits cleanly.
### Requirements:
- Trap SIGINT (Ctrl+C), SIGTERM, and SIGHUP
- Perform cleanup on interruption
- Save work in progress
- Display meaningful messages
- Support nested interrupt handling
- Prevent double cleanup
- Log interruption events
- Return appropriate exit codes
- Handle interruption during critical sections
- Support forced exit (double Ctrl+C)
### Expected Output Example:
```bash
./graceful_interrupt.sh
```
```
╔════════════════════════════════════════════════════════════════╗
║         GRACEFUL INTERRUPT HANDLER DEMO                        ║
╚════════════════════════════════════════════════════════════════╝

[INFO] Script started (PID: 12345)
[INFO] Press Ctrl+C to interrupt gracefully
[INFO] Press Ctrl+C twice to force exit

Setting up signal handlers...
✓ SIGINT handler installed (Ctrl+C)
✓ SIGTERM handler installed
✓ SIGHUP handler installed

Starting long-running operation...
────────────────────────────────────────────────────────────────

Working on task 1/10... [████░░░░░░░░░░░░░░░░░░░░░░░░░░░░] 10%
Working on task 2/10... [████████░░░░░░░░░░░░░░░░░░░░░░░░] 20%
Working on task 3/10... [████████████░░░░░░░░░░░░░░░░░░░░] 30%

^C
[WARN] Interrupt signal received (SIGINT)
[INFO] Handling interrupt gracefully...

Interruption Handler:
────────────────────────────────────────────────────────────────
Signal: SIGINT (2)
Received at: 2025-10-19 23:58:15
Current task: 3/10 (30% complete)
PID: 12345

[INFO] Saving work in progress...
  → Saving state to /tmp/graceful_interrupt_state.tmp
  ✓ State saved (3/10 tasks completed)
  → Creating checkpoint
  ✓ Checkpoint created

[INFO] Cleaning up resources...
  → Closing file handles (2 open)
  ✓ File handles closed
  → Removing temporary files (5 files)
  ✓ Temporary files removed: /tmp/graceful_*.tmp
  → Terminating background processes (1 running)
  ✓ Background process terminated (PID: 12346)

[INFO] Work saved successfully
[INFO] You can resume with: ./graceful_interrupt.sh --resume

Cleanup Summary:
────────────────────────────────────────────────────────────────
✓ State saved: 3/10 tasks completed
✓ Resources cleaned up
✓ No data loss
✓ Safe to exit

[INFO] Exiting gracefully...
[INFO] Exit code: 130 (interrupted by user)

Log file: /var/log/graceful_interrupt.log
```

**With double Ctrl+C (forced exit):**
```bash
./graceful_interrupt.sh
```
```
[... normal operation ...]

Working on task 5/10... [████████████████████░░░░░░░░░░░░] 50%

^C
[WARN] Interrupt signal received (SIGINT)
[INFO] Handling interrupt gracefully...
[INFO] Saving work in progress...
  → Saving state to /tmp/graceful_interrupt_state.tmp

^C
[WARN] Second interrupt received!
[WARN] Forcing immediate exit...

[ERROR] FORCED EXIT - Cleanup may be incomplete

Forced Exit Status:
────────────────────────────────────────────────────────────────
⚠ Partial state saved (may be corrupted)
⚠ Some resources may not be cleaned
⚠ Background processes may still be running

To clean up manually:
  1. Check for running processes: ps aux | grep graceful_interrupt
  2. Remove temp files: rm /tmp/graceful_interrupt_*.tmp
  3. Check state: cat /tmp/graceful_interrupt_state.tmp

[ERROR] Exit code: 131 (forced termination)
```

**Interruption during critical section:**
```bash
./graceful_interrupt.sh --critical
```
```
[INFO] Starting critical operation...
[WARN] Critical section - interruption will be delayed

Working on critical task... [████████████████░░░░░░░░░░░░░░] 40%

^C
[WARN] Interrupt signal received during critical section
[INFO] Interrupt deferred until critical section completes
[INFO] Press Ctrl+C again to force (NOT RECOMMENDED)

Continuing critical operation...
Working on critical task... [████████████████████████░░░░░░] 60%
Working on critical task... [████████████████████████████░░] 80%
Working on critical task... [████████████████████████████████] 100%

✓ Critical section completed

[INFO] Now processing deferred interrupt...
[INFO] Saving work...
✓ State saved
[INFO] Cleaning up...
✓ Cleanup complete

[INFO] Exiting gracefully after critical section
[INFO] Exit code: 130
```
### Bonus Challenge:
- Add progress bar for cleanup operations
- Implement checkpoint/restore functionality
- Support custom cleanup handlers
- Add signal history logging
- Create signal debugger
- Support signal forwarding to child processes
- Implement graceful degradation
- Add interrupt analytics

***