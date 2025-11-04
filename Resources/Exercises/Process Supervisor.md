### Goal:
Build a comprehensive process supervision system named `supervisor.sh` that manages multiple services with monitoring, automatic restart, health checks, and advanced features.
### Requirements:
**Core Features:**
1. **Service Management:**
   - Start/stop/restart services
   - Status checking
   - Configuration per service
   - Multiple service support
   - Service groups
   - Dependency management

2. **Monitoring:**
   - Process health checks
   - Resource usage monitoring
   - Crash detection
   - Response time tracking
   - Log monitoring
   - Metric collection

3. **Auto-Restart:**
   - Configurable restart policies
   - Exponential backoff
   - Maximum restart attempts
   - Restart windows
   - Failure threshold
   - Recovery strategies

4. **Health Checks:**
   - HTTP/TCP health endpoints
   - Custom health scripts
   - Periodic health validation
   - Graceful degradation
   - Health history tracking

5. **Alerting:**
   - Failure notifications
   - Performance alerts
   - Escalation policies
   - Multiple alert channels
   - Alert throttling

**Advanced Features:**
- Web dashboard
- API interface
- Log aggregation
- Metrics export (Prometheus)
- Rolling updates
- Blue-green deployment
- Service discovery
- Load balancing
### Expected Output Example:
```bash
sudo ./supervisor.sh start
```

```
╔════════════════════════════════════════════════════════════════╗
║            PROCESS SUPERVISOR v1.0                             ║
║            Professional Service Management                     ║
╚════════════════════════════════════════════════════════════════╝

[INFO] Supervisor starting...
[INFO] Supervisor PID: 10000
[INFO] Configuration: /etc/supervisor/supervisor.conf
[INFO] Log file: /var/log/supervisor/supervisor.log

Loading configuration...
────────────────────────────────────────────────────────────────
✓ Configuration loaded
✓ Service definitions: 4 found
✓ Alert rules: 3 configured
✓ Health check interval: 30 seconds

Services to manage:
────────────────────────────────────────────────────────────────
1. webapp     - Web Application Server (python3 app.py)
2. worker     - Background Worker (worker.sh)
3. cache      - Redis Cache Server (redis-server)
4. database   - PostgreSQL Database (postgres)

Dependencies detected:
────────────────────────────────────────────────────────────────
database → cache → webapp
database → worker

Start order: database, cache, webapp, worker

Starting services...
════════════════════════════════════════════════════════════════

[1/4] Starting service: database
────────────────────────────────────────────────────────────────
Command: postgres -D /var/lib/postgresql/data
User: postgres
Working directory: /var/lib/postgresql

→ Starting process...
  PID: 10001
  Started at: 23:58:50
  
→ Waiting for health check...
  Health endpoint: tcp://localhost:5432
  Attempt 1/10... ✓ Healthy
  
✓ Service 'database' started successfully
  PID: 10001
  Status: Running
  Health: ✓ Healthy

[2/4] Starting service: cache
────────────────────────────────────────────────────────────────
Command: redis-server /etc/redis/redis.conf
User: redis
Working directory: /var/lib/redis

→ Starting process...
  PID: 10002
  Started at: 23:58:52
  
→ Waiting for health check...
  Health endpoint: tcp://localhost:6379
  Attempt 1/10... ✓ Healthy
  
✓ Service 'cache' started successfully
  PID: 10002
  Status: Running
  Health: ✓ Healthy

[3/4] Starting service: webapp
────────────────────────────────────────────────────────────────
Command: python3 app.py
User: www-data
Working directory: /var/www/app

→ Starting process...
  PID: 10003
  Started at: 23:58:54
  
→ Waiting for health check...
  Health endpoint: http://localhost:8080/health
  Attempt 1/10... ✓ Healthy (200 OK)
  Response time: 45ms
  
✓ Service 'webapp' started successfully
  PID: 10003
  Status: Running
  Health: ✓ Healthy

[4/4] Starting service: worker
────────────────────────────────────────────────────────────────
Command: worker.sh
User: worker
Working directory: /var/lib/worker

→ Starting process...
  PID: 10004
  Started at: 23:58:56
  
→ Waiting for health check...
  Health script: /usr/local/bin/worker_health.sh
  Attempt 1/10... ✓ Healthy
  
✓ Service 'worker' started successfully
  PID: 10004
  Status: Running
  Health: ✓ Healthy

╔════════════════════════════════════════════════════════════════╗
║                ALL SERVICES STARTED                            ║
╚════════════════════════════════════════════════════════════════╝

Service Status Summary:
────────────────────────────────────────────────────────────────
Total services: 4
Running: 4 ✓
Stopped: 0
Failed: 0

Services:
────────────────────────────────────────────────────────────────
✓ database  (PID: 10001) - Running - Healthy
✓ cache     (PID: 10002) - Running - Healthy
✓ webapp    (PID: 10003) - Running - Healthy
✓ worker    (PID: 10004) - Running - Healthy

[INFO] Entering monitoring mode...
[INFO] Health checks every 30 seconds
[INFO] Auto-restart enabled for all services

Supervisor is now running in the background
────────────────────────────────────────────────────────────────
PID file: /var/run/supervisor.pid
Log file: /var/log/supervisor/supervisor.log
Status: ./supervisor.sh status
Stop: ./supervisor.sh stop
```

**Monitoring output:**
```bash
./supervisor.sh status
```
```
╔════════════════════════════════════════════════════════════════╗
║            SUPERVISOR STATUS                                   ║
║            Updated: 2025-10-20 00:05:00                        ║
╚════════════════════════════════════════════════════════════════╝

Supervisor: Running (PID: 10000)
Uptime: 6 minutes 10 seconds
Monitored services: 4

Service Status:
════════════════════════════════════════════════════════════════

[1] database (postgres)
────────────────────────────────────────────────────────────────
Status:        ✓ Running
PID:           10001
Uptime:        6m 10s
Restarts:      0
Health:        ✓ Healthy (last check: 15s ago)
CPU:           2.3%
Memory:        234 MB (4.5% of available)
Connections:   23
Last restart:  Never

[2] cache (redis-server)
────────────────────────────────────────────────────────────────
Status:        ✓ Running
PID:           10002
Uptime:        6m 8s
Restarts:      0
Health:        ✓ Healthy (last check: 15s ago)
CPU:           1.2%
Memory:        89 MB (1.7% of available)
Hit rate:      94.5%
Last restart:  Never

[3] webapp (python3 app.py)
────────────────────────────────────────────────────────────────
Status:        ✓ Running
PID:           10003
Uptime:        6m 6s
Restarts:      0
Health:        ✓ Healthy (last check: 10s ago)
  Response:    http://localhost:8080/health
  Status code: 200 OK
  Latency:     42ms
CPU:           5.7%
Memory:        512 MB (9.8% of available)
Requests/s:    145
Last restart:  Never

[4] worker (worker.sh)
────────────────────────────────────────────────────────────────
Status:        ✓ Running
PID:           10004
Uptime:        6m 4s
Restarts:      0
Health:        ✓ Healthy (last check: 12s ago)
CPU:           3.4%
Memory:        156 MB (3.0% of available)
Jobs processed: 234
Last restart:  Never

Overall Health: ✓ ALL SERVICES HEALTHY
Alerts: None
```

**With automatic restart:**

```bash
# Monitoring logs showing auto-restart
tail -f /var/log/supervisor/supervisor.log
```
```
2025-10-20 00:10:15 [INFO] Performing health check: webapp
2025-10-20 00:10:15 [INFO] Health check passed: webapp (200 OK, 45ms)
2025-10-20 00:10:45 [INFO] Performing health check: webapp
2025-10-20 00:10:45 [ERROR] Health check failed: webapp (Connection refused)
2025-10-20 00:10:45 [WARN] Service 'webapp' appears to be down
2025-10-20 00:10:45 [INFO] Verifying process status...
2025-10-20 00:10:45 [ERROR] Process 10003 not found
2025-10-20 00:10:45 [ALERT] Service crashed: webapp (PID: 10003)

2025-10-20 00:10:45 [INFO] Auto-restart triggered for: webapp
2025-10-20 00:10:45 [INFO] Restart attempt: 1/5
2025-10-20 00:10:45 [INFO] Restart delay: 5 seconds

2025-10-20 00:10:50 [INFO] Restarting service: webapp
2025-10-20 00:10:50 [INFO] Command: python3 app.py
2025-10-20 00:10:50 [INFO] Working directory: /var/www/app
2025-10-20 00:10:50 [INFO] User: www-data

2025-10-20 00:10:51 [INFO] Process started: PID 10015
2025-10-20 00:10:51 [INFO] Waiting for service to become healthy...

2025-10-20 00:10:56 [INFO] Health check attempt 1/10...
2025-10-20 00:10:56 [INFO] Health endpoint: http://localhost:8080/health
2025-10-20 00:10:56 [INFO] Response: 200 OK (48ms)
2025-10-20 00:10:56 [INFO] Service 'webapp' is healthy

2025-10-20 00:10:56 [INFO] Service 'webapp' restarted successfully
2025-10-20 00:10:56 [INFO] New PID: 10015
2025-10-20 00:10:56 [INFO] Restart #1 completed

2025-10-20 00:10:56 [ALERT] Service recovered: webapp
2025-10-20 00:10:56 [INFO] Downtime: 11 seconds
2025-10-20 00:10:56 [INFO] Alert sent to: admin@example.com, slack://ops-channel
```

**Full dashboard output:**
```bash
./supervisor.sh dashboard
```
```
╔════════════════════════════════════════════════════════════════╗
║               SUPERVISOR DASHBOARD                             ║
║               Press 'q' to quit, 'r' to refresh                ║
╚════════════════════════════════════════════════════════════════╝

Supervisor Status [Last updated: 00:15:30]
────────────────────────────────────────────────────────────────
● Supervisor Running (PID: 10000)
● Uptime: 16m 40s
● Managed Services: 4
● Overall Health: ✓ HEALTHY

Services Overview
════════════════════════════════════════════════════════════════

┌──────────┬────────┬─────────┬─────────┬────────┬────────┬─────┐
│ Service  │ Status │   PID   │ Uptime  │  CPU   │  Mem   │ Restarts│
├──────────┼────────┼─────────┼─────────┼────────┼────────┼─────┤
│ database │  ✓ UP  │  10001  │ 16m 40s │  2.1%  │  234MB │   0 │
│ cache    │  ✓ UP  │  10002  │ 16m 38s │  1.3%  │   89MB │   0 │
│ webapp   │  ✓ UP  │  10015  │  5m 34s │  5.2%  │  512MB │   1 │
│ worker   │  ✓ UP  │  10004  │ 16m 34s │  3.8%  │  156MB │   0 │
└──────────┴────────┴─────────┴─────────┴────────┴────────┴─────┘

Resource Usage
────────────────────────────────────────────────────────────────
Total CPU: 12.4% of 8 cores
Total Memory: 991 MB of 16 GB (6.2%)

CPU Usage (per service):
database ██░░░░░░░░  2.1%
cache    █░░░░░░░░░  1.3%
webapp   █████░░░░░  5.2%
worker   ████░░░░░░  3.8%

Memory Usage (per service):
database ████████░░  234 MB
cache    ███░░░░░░░   89 MB
webapp   ████████████ 512 MB
worker   █████░░░░░  156 MB

Health Checks (Last 1 hour)
────────────────────────────────────────────────────────────────
database: ████████████████████████████████ 100% (120/120 passed)
cache:    ████████████████████████████████ 100% (120/120 passed)
webapp:   ███████████████████████████████░  98% (118/120 passed)
worker:   ████████████████████████████████ 100% (120/120 passed)

Recent Events
────────────────────────────────────────────────────────────────
00:10:45 ⚠ Service crashed: webapp
00:10:56 ✓ Service recovered: webapp (downtime: 11s)
00:05:30 ℹ Health check passed: all services
00:00:00 ✓ Supervisor started

Alerts (Last 24 hours)
────────────────────────────────────────────────────────────────
🔴 Critical: 0
⚠  Warning:  1 (webapp crash at 00:10:45)
ℹ  Info:     4

Quick Actions
────────────────────────────────────────────────────────────────
[s] Start service    [r] Restart service
[t] Stop service     [l] View logs
[h] Health check     [c] Configuration
[q] Quit dashboard
```
