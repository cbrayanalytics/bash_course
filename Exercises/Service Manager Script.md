### Goal:
Create a comprehensive service management script named `service_manager.sh` that can start, stop, restart, and check status of custom services or applications.
### Requirements:
**Core Commands:**
- `start` - Start a service
- `stop` - Stop a service
- `restart` - Restart a service (stop then start)
- `status` - Check if service is running
- `reload` - Reload configuration without stopping
- `enable` - Enable service to start on boot (simulate)
- `disable` - Disable service from starting on boot
- `logs` - Display service logs

**Service Management:**
- Manage multiple services (accept service name as argument)
- Track process IDs (PID)
- Store PIDs in `/tmp` or configurable directory
- Handle services that are already running/stopped
- Provide detailed status information
- Support wildcards to manage multiple services
- Validate service name before operations

**Error Handling:**
- Check if service exists
- Handle missing PID files
- Detect stale PID files (process not running)
- Provide meaningful error messages
- Suggest corrective actions

**Display:**
- Color-coded output (green=running, red=stopped, yellow=warning)
- Show uptime for running services
- Display resource usage (CPU, memory)
- Show service dependencies (optional)
### Hints:
**PID file management:**
```bash
PID_DIR="/tmp/service_manager"
PID_FILE="$PID_DIR/$service_name.pid"

# Store PID
echo $$ > "$PID_FILE"

# Read PID
if [[ -f "$PID_FILE" ]]; then
    pid=$(cat "$PID_FILE")
fi

# Check if process is running
if kill -0 "$pid" 2>/dev/null; then
    echo "Process is running"
fi
```

**Service simulation:**
```bash
# Start service (background process)
start_service() {
    sleep 999999 &
    echo $! > "$PID_FILE"
}

# Or run actual service commands
start_apache() {
    sudo systemctl start apache2
}
```

**For real system services:**
- Use `systemctl` on systems with systemd
- Use `service` command for init.d services
- Parse `ps` output for process information
### Expected Output Example:
```bash
./service_manager.sh
```
```
Usage: ./service_manager.sh <command> <service>

Commands:
  start <service>     Start a service
  stop <service>      Stop a service
  restart <service>   Restart a service
  status <service>    Check service status
  reload <service>    Reload service configuration
  enable <service>    Enable service at boot
  disable <service>   Disable service at boot
  logs <service>      View service logs
  list                List all managed services

Examples:
  ./service_manager.sh start webserver
  ./service_manager.sh status database
  ./service_manager.sh restart all
```

```bash
./service_manager.sh start webserver
```
```
╔════════════════════════════════════════╗
║      SERVICE MANAGER - START           ║
╚════════════════════════════════════════╝

Service: webserver
Action: Starting...

[1/3] Checking prerequisites...
  ✓ Service configuration found
  ✓ Required ports available (80, 443)
  ✓ Sufficient memory available

[2/3] Starting service...
  • Initializing webserver
  • Loading configuration
  • Binding to ports
  • Starting worker processes

[3/3] Verifying startup...
  ✓ Process started (PID: 12345)
  ✓ Service responding
  ✓ Health check passed

════════════════════════════════════════
✓ webserver started successfully
════════════════════════════════════════

Service Details:
  Status: Running
  PID: 12345
  Uptime: 2 seconds
  Port: 80, 443
  Started: 2025-10-19 01:10:15

Logs: /var/log/webserver/access.log
      /var/log/webserver/error.log
```

```bash
./service_manager.sh status webserver
```
```
╔════════════════════════════════════════╗
║      SERVICE STATUS - webserver        ║
╚════════════════════════════════════════╝

● webserver
  Status: ✓ Active (running)
  PID: 12345
  Uptime: 5 minutes, 32 seconds
  Started: 2025-10-19 01:10:15

Resource Usage:
  CPU: 2.3%
  Memory: 145 MB (1.2%)
  Threads: 8

Network:
  Listening on: 0.0.0.0:80, 0.0.0.0:443
  Connections: 23 active

Recent Activity:
  [01:15:20] Request from 192.168.1.100
  [01:15:18] Configuration reloaded
  [01:15:10] New worker process spawned
  [01:10:15] Service started

Health Status: ✓ Healthy
  ✓ Process responding
  ✓ Ports accessible
  ✓ No errors in last 5 minutes

To view logs: ./service_manager.sh logs webserver
```

```bash
./service_manager.sh stop webserver
```
```
╔════════════════════════════════════════╗
║      SERVICE MANAGER - STOP            ║
╚════════════════════════════════════════╝

Service: webserver
Action: Stopping...

[1/3] Checking service status...
  ✓ Service is running (PID: 12345)
  ✓ No active connections

[2/3] Stopping service...
  • Sending termination signal (SIGTERM)
  • Waiting for graceful shutdown (max 30s)
  • Closing open connections
  • Releasing resources

[3/3] Verifying shutdown...
  ✓ Process terminated
  ✓ PID file removed
  ✓ Ports released

════════════════════════════════════════
✓ webserver stopped successfully
════════════════════════════════════════

Service was running for: 5 minutes, 47 seconds
Final status: Stopped cleanly
```

```bash
./service_manager.sh restart webserver
```
```
╔════════════════════════════════════════╗
║     SERVICE MANAGER - RESTART          ║
╚════════════════════════════════════════╝

Service: webserver
Action: Restarting...

[1/2] Stopping service...
  • webserver is running (PID: 12345)
  • Sending stop signal
  • Waiting for shutdown...
  ✓ Service stopped

[2/2] Starting service...
  • Initializing webserver
  • Loading configuration
  • Starting processes
  ✓ Service started (PID: 12389)

════════════════════════════════════════
✓ webserver restarted successfully
════════════════════════════════════════

Restart completed in: 3.2 seconds
New PID: 12389
Status: Running
```

```bash
./service_manager.sh status database
```
```
╔════════════════════════════════════════╗
║      SERVICE STATUS - database         ║
╚════════════════════════════════════════╝

● database
  Status: ✗ Inactive (stopped)
  Last seen: 2025-10-19 00:45:30
  Last status: Stopped manually

⚠ Service is not running

To start: ./service_manager.sh start database
```

```bash
./service_manager.sh list
```
```
╔════════════════════════════════════════╗
║     MANAGED SERVICES LIST              ║
╚════════════════════════════════════════╝

┌────────────────────────────────────────────────────────────┐
│ Service      │ Status  │ PID   │ Uptime     │ Auto-start  │
├────────────────────────────────────────────────────────────┤
│ webserver    │ Running │ 12389 │ 2m 15s     │ Enabled     │
│ database     │ Stopped │   -   │ -          │ Enabled     │
│ cache        │ Running │ 11234 │ 1h 23m     │ Disabled    │
│ worker       │ Stopped │   -   │ -          │ Disabled    │
└────────────────────────────────────────────────────────────┘

Summary:
  Total services: 4
  Running: 2
  Stopped: 2
  Enabled on boot: 2
```

```bash
./service_manager.sh logs webserver
```
```
╔════════════════════════════════════════╗
║     SERVICE LOGS - webserver           ║
╚════════════════════════════════════════╝

Showing last 20 lines from /var/log/webserver/access.log

[2025-10-19 01:15:30] INFO: Request received from 192.168.1.100
[2025-10-19 01:15:31] INFO: Processing GET /index.html
[2025-10-19 01:15:31] INFO: Response: 200 OK (0.023s)
[2025-10-19 01:15:35] INFO: Request received from 192.168.1.102
[2025-10-19 01:15:35] INFO: Processing GET /api/users
[2025-10-19 01:15:35] INFO: Response: 200 OK (0.156s)
[2025-10-19 01:15:40] WARN: Slow query detected (0.523s)
[2025-10-19 01:15:42] INFO: Cache hit rate: 87%
[2025-10-19 01:15:45] INFO: Worker process #3 idle

Errors: 0 | Warnings: 1 | Info: 8

To follow live logs: tail -f /var/log/webserver/access.log
To view errors only: ./service_manager.sh logs webserver --errors
```

```bash
./service_manager.sh start nonexistent
```
```
✗ Error: Service 'nonexistent' not found

Available services:
  • webserver
  • database
  • cache
  • worker

To create a new service configuration:
  ./service_manager.sh create nonexistent
```
### Bonus Challenges:
**Level 1 (Intermediate):**
- Add dependency management (start dependencies first)
- Implement service groups (start/stop multiple together)
- Add configuration validation before start
- Support environment variable injection
- Add health check endpoints
- Implement automatic restart on failure
- Add resource limits (max memory, CPU)
- Create service templates

**Level 2 (Advanced):**
- Integration with systemd/init.d
- Manage Docker containers as services
- Implement rolling restarts (zero downtime)
- Add monitoring and alerting
- Create service dashboard (real-time status)
- Support remote service management (SSH)
- Implement service orchestration
- Add backup/restore for service data
- Create audit log of all operations
- Email/webhook notifications

**Level 3 (Expert):**
- Multi-node service management (clustering)
- Load balancer integration
- Automated failover
- Service discovery and registration
- Metrics collection and graphing
- Log aggregation and analysis
- Configuration management integration
- Container orchestration (Kubernetes-like)
- Blue-green deployment support
- Canary releases
- Service mesh integration
- Performance profiling
- Automated capacity planning

***
