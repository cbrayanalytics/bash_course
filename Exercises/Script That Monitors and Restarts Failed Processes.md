### Goal:
Create a script named `process_monitor.sh` that monitors a process and automatically restarts it if it fails.
### Requirements:
- Monitor process by PID or name
- Detect when process dies
- Automatically restart process
- Configurable restart delay
- Maximum restart attempts
- Exponential backoff
- Health checks before restart
- Log all restarts and failures
- Alert on repeated failures
- Support graceful shutdown
### Expected Output Example:
```bash
./process_monitor.sh --command "python3 app.py" --max-restarts 5
```
```
╔════════════════════════════════════════════════════════════════╗
║              PROCESS MONITOR                                   ║
╚════════════════════════════════════════════════════════════════╝

Configuration:
────────────────────────────────────────────────────────────────
Command: python3 app.py
Max restarts: 5
Restart delay: 5 seconds
Backoff: Exponential (2x)
Health check: Enabled
Alert threshold: 3 consecutive failures

[INFO] Starting process monitor...
[INFO] Monitor PID: 12340

[INFO] Starting application...
Command: python3 app.py
Working directory: /home/user/app

Application started:
────────────────────────────────────────────────────────────────
PID: 12345
Started at: 2025-10-19 23:58:45
Status: Running ✓

[INFO] Monitoring process 12345...
[INFO] Press Ctrl+C to stop monitoring

Monitoring:
────────────────────────────────────────────────────────────────
23:58:50 | Status: Running | Uptime: 5s   | Restarts: 0
23:58:55 | Status: Running | Uptime: 10s  | Restarts: 0
23:59:00 | Status: Running | Uptime: 15s  | Restarts: 0
23:59:05 | Status: Running | Uptime: 20s  | Restarts: 0

[WARN] Process 12345 has exited unexpectedly!

Process Exit Details:
────────────────────────────────────────────────────────────────
Exit code: 1
Exit time: 23:59:07
Uptime: 22 seconds
Reason: Application error

[INFO] Restart attempt 1/5
[INFO] Waiting 5 seconds before restart...

[INFO] Restarting application...
Application restarted:
────────────────────────────────────────────────────────────────
PID: 12346
Started at: 23:59:12
Status: Running ✓

[INFO] Monitoring process 12346...

Monitoring:
────────────────────────────────────────────────────────────────
23:59:15 | Status: Running | Uptime: 3s   | Restarts: 1
23:59:20 | Status: Running | Uptime: 8s   | Restarts: 1
23:59:25 | Status: Running | Uptime: 13s  | Restarts: 1
[... continues monitoring ...]

00:05:30 | Status: Running | Uptime: 6m18s | Restarts: 1

[INFO] Application stable (running for > 5 minutes)
[INFO] Reset restart counter to 0

Monitoring:
────────────────────────────────────────────────────────────────
00:10:00 | Status: Running | Uptime: 10m48s | Restarts: 0

^C
[INFO] Interrupt received
[INFO] Stopping monitor gracefully...

[INFO] Stopping monitored application (PID: 12346)...
  → Sending SIGTERM
  → Waiting for graceful shutdown...
  ✓ Application stopped

Monitor Summary:
────────────────────────────────────────────────────────────────
Total runtime: 11m15s
Total restarts: 1
Current status: Stopped (manual)
Final PID: 12346

Restart History:
────────────────────────────────────────────────────────────────
1. 23:59:07 - Exit code 1 (restarted after 5s)

[INFO] Monitor stopped
Log file: /var/log/process_monitor_12345.log
```

**With repeated failures:**
```bash
./process_monitor.sh --command "failing_app" --max-restarts 3
```
```
[INFO] Starting application...
PID: 12350

[WARN] Process 12350 exited (code: 1)
[INFO] Restart attempt 1/3 (delay: 5s)
[INFO] Application restarted (PID: 12351)

[WARN] Process 12351 exited (code: 1)
[INFO] Restart attempt 2/3 (delay: 10s - exponential backoff)
[INFO] Application restarted (PID: 12352)

[WARN] Process 12352 exited (code: 1)
[INFO] Restart attempt 3/3 (delay: 20s - exponential backoff)
[INFO] Application restarted (PID: 12353)

[ERROR] Process 12353 exited (code: 1)
[ERROR] Maximum restart attempts reached (3/3)

╔════════════════════════════════════════════════════════════════╗
║               MONITORING FAILED                                ║
╚════════════════════════════════════════════════════════════════╝

Failure Summary:
────────────────────────────────────────────────────────────────
Total attempts: 4 (initial + 3 restarts)
All attempts failed with exit code: 1
Total runtime: 35 seconds (cumulative)

Failure Pattern:
────────────────────────────────────────────────────────────────
All processes crashed within 5 seconds of starting
Likely cause: Configuration error or missing dependency

Recommendations:
────────────────────────────────────────────────────────────────
1. Check application logs:
   tail -50 /var/log/failing_app.log

2. Verify dependencies:
   ldd /usr/bin/failing_app

3. Test manually:
   failing_app --verbose

4. Check configuration:
   cat /etc/failing_app/config.conf

🚨 Alert sent to: admin@example.com

[ERROR] Monitor giving up
[ERROR] Exit code: 1 (maximum restarts exceeded)
```
### Bonus Challenge:
- Add custom health check scripts
- Implement circuit breaker pattern
- Support process groups
- Add resource monitoring (CPU/memory)
- Create alert escalation
- Support scheduled restarts
- Implement rolling restarts
- Add process metrics collection

***