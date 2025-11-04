### Goal:
Create a script named `cron_lock.sh` that uses lockfiles to prevent multiple concurrent runs.
### Requirements:
- Create lockfile at start
- Check for existing lock, detect stale locks
- Clean up lock on exit (trap)
- Log lock actions
- Support stale lock timeout
- PID/hostname in lock
### Expected Output Example:
```bash
./cron_lock.sh
```
```
╔════════════════════════════════════════════════════════════════╗
║              LOCKFILE DEMONSTRATION                            ║
╚════════════════════════════════════════════════════════════════╝

[INFO] Attempting to acquire lock...
[INFO] Lock acquired (PID=12345 HOST=testhost)
Lockfile: /var/run/cron_lock.lock

[INFO] Running primary task...

[...]

[INFO] Cleaning up and releasing lock...
[INFO] Lock released successfully
[INFO] Script complete
```

**Lock already held:**
```
[WARN] Lockfile exists (PID=56789 HOST=prodhost)
[INFO] Lock held less than timeout (600s). Exiting (already running).
```

**Stale lockfile:**
```
[WARN] Lockfile exists (PID=21789 HOST=oldhost)
[WARN] No process with PID=21789 on host oldhost
[INFO] Stale lock detected (age: 2453s)
[INFO] Removing stale lock and acquiring new one...
[INFO] Lock acquired (PID=12345 HOST=testhost)
```

***
