### Understanding Signals
Signals are notifications sent to processes to trigger specific actions.

**Common signals:**
- `SIGINT` (2) - Interrupt (Ctrl+C)
- `SIGTERM` (15) - Terminate (graceful shutdown)
- `SIGKILL` (9) - Kill (immediate, cannot be caught)
- `SIGHUP` (1) - Hangup (terminal closed)
- `SIGQUIT` (3) - Quit (Ctrl+\$$)
- `SIGUSR1` (10) - User-defined signal 1
- `SIGUSR2` (12) - User-defined signal 2

**View all signals:**
```bash
kill -l
# Or
trap -l
```
### Trapping Signals
**Basic trap syntax:**
```bash
trap 'commands' SIGNAL [SIGNAL...]
```

**Trap Ctrl+C (SIGINT):**
```bash
#!/bin/bash

trap 'echo "Interrupted! Cleaning up..."; exit 130' INT

echo "Press Ctrl+C to interrupt"
sleep 100
```

**Trap multiple signals:**
```bash
#!/bin/bash

cleanup() {
    echo "Cleaning up..."
    rm -f /tmp/myfile
    exit
}

trap cleanup INT TERM HUP

# Script continues...
```

**Ignore signals:**
```bash
trap '' INT  # Ignore Ctrl+C
trap '' TERM # Ignore SIGTERM

# Critical section that shouldn't be interrupted
important_work

trap - INT   # Restore default behavior
trap - TERM
```
### Background Processes (&)
Run commands in the background:

**Simple background process:**
```bash
#!/bin/bash

# Start in background
sleep 30 &

echo "Sleep started in background"
echo "Script continues..."
```

**Capture background PID:**
```bash
#!/bin/bash

sleep 30 &
bg_pid=$!

echo "Background process PID: $bg_pid"
```

**Multiple background processes:**
```bash
#!/bin/bash

command1 &
pid1=$!

command2 &
pid2=$!

command3 &
pid3=$!

echo "Started processes: $pid1, $pid2, $pid3"
```
### The Wait Command
Wait for background processes to complete:

**Wait for all background jobs:**
```bash
#!/bin/bash

sleep 5 &
sleep 10 &
sleep 3 &

echo "Waiting for all background jobs..."
wait
echo "All jobs completed"
```

**Wait for specific process:**
```bash
#!/bin/bash

sleep 10 &
pid=$!

echo "Waiting for PID $pid..."
wait $pid
echo "Process $pid completed with exit code: $?"
```

**Wait with timeout (bash 4.3+):**
```bash
#!/bin/bash

sleep 100 &
pid=$!

# Wait up to 5 seconds
timeout 5 bash -c "wait $pid" 2>/dev/null
if [[ $? -eq 124 ]]; then
    echo "Timeout! Killing process..."
    kill $pid
fi
```
### Jobs Control
Manage background jobs:

**List jobs:**
```bash
jobs
# Output:
# [1]   Running                 sleep 100 &
# [2]-  Running                 sleep 200 &
# [3]+  Running                 sleep 300 &
```

**Bring job to foreground:**
```bash
fg %1  # Bring job 1 to foreground
```

**Send to background:**
```bash
bg %2  # Resume job 2 in background
```

**Job states:**
- `Running` - Currently executing
- `Stopped` - Suspended (Ctrl+Z)
- `Done` - Completed
- `Terminated` - Killed
### The Kill Command
Send signals to processes:

**Kill by PID:**
```bash
kill 12345         # SIGTERM (graceful)
kill -9 12345      # SIGKILL (force)
kill -KILL 12345   # Same as -9
```

**Kill by job number:**
```bash
kill %1            # Kill job 1
kill -9 %2         # Force kill job 2
```

**Send specific signal:**
```bash
kill -HUP 12345    # Hangup signal
kill -USR1 12345   # User signal 1
kill -TERM 12345   # Terminate signal
```

**Check if process exists:**
```bash
if kill -0 $pid 2>/dev/null; then
    echo "Process $pid is running"
else
    echo "Process $pid not found"
fi
```
### Practical Patterns
**Start process with timeout:**
```bash
#!/bin/bash

# Start long-running process
long_process &
pid=$!

# Wait with timeout
sleep 60 &
timeout_pid=$!

while kill -0 $pid 2>/dev/null && kill -0 $timeout_pid 2>/dev/null; do
    sleep 1
done

# Check which finished first
if kill -0 $pid 2>/dev/null; then
    echo "Timeout! Killing process..."
    kill $pid
else
    echo "Process completed"
    kill $timeout_pid 2>/dev/null
fi
```

**Graceful shutdown with timeout:**
```bash
#!/bin/bash

graceful_kill() {
    local pid=$1
    local timeout=${2:-30}
    
    # Try graceful shutdown
    kill -TERM $pid 2>/dev/null
    
    # Wait for process to exit
    local count=0
    while kill -0 $pid 2>/dev/null && [[ $count -lt $timeout ]]; do
        sleep 1
        ((count++))
    done
    
    # Force kill if still running
    if kill -0 $pid 2>/dev/null; then
        echo "Graceful shutdown failed, forcing..."
        kill -9 $pid 2>/dev/null
    fi
}

# Usage
graceful_kill 12345 30
```

**Process monitoring:**
```bash
#!/bin/bash

monitor_process() {
    local pid=$1
    
    while kill -0 $pid 2>/dev/null; do
        echo "Process $pid is running..."
        sleep 5
    done
    
    echo "Process $pid has exited"
}

# Start process
my_command &
pid=$!

# Monitor it
monitor_process $pid
```

***

**Exercise 1:** [[Handle Ctrl+C Gracefully with Cleanup]]
**Exercise 2:** [[Run Background Processes and Wait for Completion]]
**Exercise 3:** [[Script That Monitors and Restarts Failed Processes]]

**Daily Project:** [[Process Supervisor]]


