### Goal:
Create a script named `cleanup_demo.sh` that properly manages temporary resources and ensures cleanup in all exit scenarios.
### Requirements:
- Create multiple temporary resources (files, directories, processes)
- Use trap to ensure cleanup
- Handle normal exit
- Handle error exit
- Handle interruption (Ctrl+C)
- Handle kill signals
- Show cleanup progress
- Verify cleanup completed
- Support nested cleanup functions
- Handle cleanup failures gracefully
### Expected Output Example:
```bash
./cleanup_demo.sh
```
```
╔════════════════════════════════════════════════════════════════╗
║           CLEANUP DEMONSTRATION                                ║
╚════════════════════════════════════════════════════════════════╝

[INFO] Setting up trap handlers...
✓ EXIT trap registered
✓ INT trap registered (Ctrl+C)
✓ TERM trap registered
✓ ERR trap registered

[INFO] Creating temporary resources...

Temporary Resources Created:
────────────────────────────────────────────────────────────────
📁 Temp directory: /tmp/cleanup_demo.12345/
📄 Temp file 1: /tmp/cleanup_demo.12345/data.txt
📄 Temp file 2: /tmp/cleanup_demo.12345/config.conf
📄 Lock file: /var/lock/cleanup_demo.lock
⚙️  Background process: PID 67890
🔗 Symlink: /tmp/cleanup_link -> /tmp/cleanup_demo.12345/

[INFO] Processing data (this takes 10 seconds)...
Progress: ████████████████████████████████████████ 100%

[INFO] Work completed successfully

[INFO] Cleanup initiated (EXIT trap)

Cleanup Progress:
────────────────────────────────────────────────────────────────
[1/6] Terminating background processes...
  → Sending SIGTERM to PID 67890... ✓
  → Waiting for graceful shutdown... ✓
  → Process terminated

[2/6] Removing lock file...
  → Deleting /var/lock/cleanup_demo.lock... ✓

[3/6] Removing symlinks...
  → Deleting /tmp/cleanup_link... ✓

[4/6] Removing temporary files...
  → Deleting /tmp/cleanup_demo.12345/data.txt... ✓
  → Deleting /tmp/cleanup_demo.12345/config.conf... ✓

[5/6] Removing temporary directory...
  → Deleting /tmp/cleanup_demo.12345/... ✓

[6/6] Verifying cleanup...
  → No temporary resources remaining ✓

[INFO] Cleanup completed successfully
[INFO] Script exiting with code: 0
```

```bash
./cleanup_demo.sh
# Press Ctrl+C during processing
```
```
╔════════════════════════════════════════════════════════════════╗
║           CLEANUP DEMONSTRATION                                ║
╚════════════════════════════════════════════════════════════════╝

[INFO] Setting up trap handlers...
✓ All traps registered

[INFO] Creating temporary resources...
✓ 6 resources created

[INFO] Processing data (this takes 10 seconds)...
Progress: ████████░░░░░░░░░░░░░░░░░░░░░░░░░░░░ 25%

^C
[WARN] Interrupt signal received (SIGINT)

[INFO] Cleanup initiated (INT trap)

Cleanup Progress:
────────────────────────────────────────────────────────────────
[1/6] Terminating background processes...
  → Sending SIGTERM to PID 67890... ✓
  → Force killing if necessary... (not needed)

[2/6] Removing lock file...
  → Deleting /var/lock/cleanup_demo.lock... ✓

[3/6] Cleaning partial work...
  → Removing incomplete output files... ✓

[4/6] Removing temporary files...
  → Deleting all temp files... ✓ (2 files)

[5/6] Removing temporary directory...
  → Deleting /tmp/cleanup_demo.12345/... ✓

[6/6] Verifying cleanup...
  → No temporary resources remaining ✓

[INFO] Cleanup completed successfully
[WARN] Script interrupted by user
[INFO] Exiting with code: 130 (SIGINT)
```

```bash
./cleanup_demo.sh --simulate-error
```
```
╔════════════════════════════════════════════════════════════════╗
║           CLEANUP DEMONSTRATION (Error Simulation)             ║
╚════════════════════════════════════════════════════════════════╝

[INFO] Setting up trap handlers...
✓ All traps registered (including ERR trap)

[INFO] Creating temporary resources...
✓ 6 resources created

[INFO] Processing data...
Progress: ████████████████████░░░░░░░░░░░░░░░░ 50%

[ERROR] Simulated error occurred!
Error: Database connection failed
Line: 123
Function: process_data

[INFO] Cleanup initiated (ERR trap)

Error Cleanup:
────────────────────────────────────────────────────────────────
[!] Error occurred - performing emergency cleanup

[1/6] Terminating background processes...
  → Sending SIGTERM to PID 67890... ✓

[2/6] Rolling back partial changes...
  → Restoring previous state... ✓

[3/6] Removing corrupted files...
  → Deleting incomplete output... ✓

[4/6] Removing temporary files...
  → Deleting all temp files... ✓ (2 files)

[5/6] Removing temporary directory...
  → Deleting /tmp/cleanup_demo.12345/... ✓

[6/6] Verifying cleanup...
  → No temporary resources remaining ✓

[INFO] Emergency cleanup completed
[ERROR] Script failed with exit code: 1

Troubleshooting:
────────────────────────────────────────────────────────────────
Error log: /var/log/cleanup_demo_error.log
To retry: ./cleanup_demo.sh
For help: ./cleanup_demo.sh --help
```
### Bonus Challenge:
- Add timeout for cleanup operations
- Implement cleanup priority levels
- Add cleanup verification tests
- Create cleanup audit trail
- Support cleanup rollback
- Add resource tracking
- Implement cleanup hooks for plugins
- Support distributed cleanup (remote resources)

***