### Goal:
Create a comprehensive log monitoring tool named `log_monitor.sh` that continuously watches log files for new entries and alerts on specific keywords or patterns.
### Requirements:
**Core Monitoring Features:**
- Monitor one or more log files in real-time
- Detect new lines as they're added
- Search for configurable keywords/patterns
- Alert when keywords are found
- Support multiple alert levels (INFO, WARN, ERROR, CRITICAL)
- Color-code alerts by severity
- Track alert statistics
- Maintain state between runs

**Alert System:**
- Visual alerts (highlighted output)
- Sound alerts (system beep)
- Email notifications (simulate or real)
- Log alerts to separate file
- Desktop notifications (if available)
- Webhook support (send to external systems)

**Monitoring Modes:**
- Real-time tail mode (follow file as it grows)
- Full file scan mode
- Historical analysis mode
- Diff mode (compare with previous state)
- Pattern matching with regex
- Multi-file correlation

**Configuration:**
- Load keywords from config file
- Define alert rules
- Set monitoring intervals
- Configure alert destinations
- Whitelist/blacklist patterns

**Display:**
- Dashboard showing stats
- Recent alerts list
- Alert frequency graph (ASCII)
- File growth rate
- Match distribution
### Hints:
**Tail file in bash:**
```bash
# Method 1: Using tail -f in background
tail -f logfile.log | while read -r line; do
    echo "New line: $line"
done

# Method 2: Loop with file position tracking
position=0
while true; do
    # Read from last position
    tail -c +$position logfile.log | while read -r line; do
        # Process line
        echo "New: $line"
    done
    
    # Update position
    position=$(stat -f%z logfile.log)
    sleep 1
done
```

**Pattern matching:**
```bash
keywords=("ERROR" "FATAL" "CRITICAL")

for keyword in "${keywords[@]}"; do
    if [[ "$line" =~ $keyword ]]; then
        echo "ALERT: Found $keyword"
    fi
done
```

**Alert levels:**
```bash
case $severity in
    CRITICAL)
        color='\033[1;31m'  # Red
        ;;
    ERROR)
        color='\033[0;31m'   # Red
        ;;
    WARN)
        color='\033[1;33m'   # Yellow
        ;;
    INFO)
        color='\033[0;32m'   # Green
        ;;
esac
```
### Expected Output Example:
```bash
./log_monitor.sh /var/log/app.log
```

```
╔════════════════════════════════════════════════════════════════╗
║                    LOG FILE MONITOR                            ║
║                      v1.0.0                                    ║
╚════════════════════════════════════════════════════════════════╝

Initializing monitor...
✓ Configuration loaded from ~/.log_monitor.conf
✓ Monitoring: /var/log/app.log
✓ Keywords: ERROR, FATAL, WARNING, CRITICAL
✓ Alert destinations: console, email, log file

Press Ctrl+C to stop monitoring

────────────────────────────────────────────────────────────────
[01:15:30] Starting log monitor...
[01:15:30] File size: 2.3 MB | Last modified: 2025-10-19 01:15:28
────────────────────────────────────────────────────────────────

[01:15:32] INFO: Application started successfully
[01:15:33] INFO: Connected to database
[01:15:35] INFO: Server listening on port 8080

[01:15:40] ⚠ WARNING: High memory usage (85%)
           Line: [2025-10-19 01:15:40] WARNING: Memory at 85% capacity
           Action: Alert logged, notification sent

[01:15:45] INFO: Processing request from 192.168.1.100
[01:15:46] INFO: Request completed (0.023s)

[01:15:50] ✗ ERROR: Connection to cache failed
           Line: [2025-10-19 01:15:50] ERROR: Redis connection timeout
           Action: Alert logged, email sent, logged to /var/log/alerts.log

[01:15:51] INFO: Retrying cache connection...
[01:15:52] INFO: Cache connection restored

[01:16:00] ⚠ WARNING: Slow query detected (2.5s)
           Line: [2025-10-19 01:16:00] WARNING: Query exceeded threshold
           Action: Alert logged

────────────────────────────────────────────────────────────────
Statistics (45 seconds):
  Lines processed: 124
  Alerts triggered: 3
    - CRITICAL: 0
    - ERROR: 1
    - WARNING: 2
    - INFO: 0
  
  Alert frequency: 4.0 per minute
  File growth: 15 KB (20 KB/min)
────────────────────────────────────────────────────────────────

[01:16:15] INFO: Background job completed
...
```

**Dashboard mode:**
```bash
./log_monitor.sh --dashboard /var/log/app.log
```

```
╔════════════════════════════════════════════════════════════════╗
║              LOG MONITOR DASHBOARD                             ║
║              Monitoring: /var/log/app.log                      ║
║              Updates every 5 seconds | Press 'q' to quit       ║
╚════════════════════════════════════════════════════════════════╝

┌─────────────────────────── STATUS ────────────────────────────┐
│ File: /var/log/app.log                                        │
│ Size: 15.2 MB                                                 │
│ Lines: 45,283                                                 │
│ Monitoring since: 2025-10-19 01:00:00 (27 minutes)          │
│ Status: ✓ Active                                              │
└───────────────────────────────────────────────────────────────┘

┌────────────────────── RECENT ALERTS ──────────────────────────┐
│ Time     │ Level    │ Message                                 │
├──────────┼──────────┼─────────────────────────────────────────┤
│ 01:26:45 │ ERROR    │ Connection timeout                      │
│ 01:25:30 │ WARNING  │ High memory usage (87%)                │
│ 01:24:12 │ ERROR    │ Failed to process request              │
│ 01:23:00 │ WARNING  │ Slow query (3.2s)                      │
│ 01:22:45 │ WARNING  │ Cache miss rate high (45%)             │
└──────────┴──────────┴─────────────────────────────────────────┘

┌───────────────────── ALERT STATISTICS ────────────────────────┐
│ Last hour:                                                     │
│   CRITICAL: 0                                                  │
│   ERROR:    12 ████████░░░░░░░░░░░░                          │
│   WARNING:  35 ████████████████████████████░░░░              │
│   INFO:     0                                                  │
│                                                                │
│ Total alerts today: 287                                       │
│ Average per hour: 10.6                                        │
└───────────────────────────────────────────────────────────────┘

┌────────────────────── FILE ACTIVITY ──────────────────────────┐
│                                                                │
│ Growth rate: 45 KB/min                                        │
│ Lines per minute: 125                                          │
│                                                                │
│ Activity (last 60 minutes):                                   │
│ ████████████████████████████████████████████████████          │
│ High   │                   │                   │      Low      │
│                                                                │
└───────────────────────────────────────────────────────────────┘

┌──────────────────── MATCHED PATTERNS ─────────────────────────┐
│ Pattern      │ Count │ Last seen                              │
├──────────────┼───────┼────────────────────────────────────────┤
│ ERROR        │ 12    │ 01:26:45                              │
│ WARNING      │ 35    │ 01:26:30                              │
│ CRITICAL     │ 0     │ Never                                  │
│ Exception    │ 5     │ 01:25:15                              │
│ timeout      │ 8     │ 01:26:45                              │
└──────────────┴───────┴────────────────────────────────────────┘

[Updated: 01:27:15] Next update in 3 seconds...
```

**Multi-file mode:**
```bash
./log_monitor.sh /var/log/app.log /var/log/error.log /var/log/access.log
```

```
╔════════════════════════════════════════════════════════════════╗
║           LOG MONITOR - Multi-File Mode                        ║
╚════════════════════════════════════════════════════════════════╝

Monitoring 3 files:
  ✓ /var/log/app.log (15.2 MB)
  ✓ /var/log/error.log (3.8 MB)
  ✓ /var/log/access.log (125.5 MB)

────────────────────────────────────────────────────────────────

[app.log    01:28:00] INFO: Request processed
[access.log 01:28:00] 192.168.1.100 GET /index.html 200
[app.log    01:28:01] INFO: Cache hit
[error.log  01:28:02] ✗ ERROR: Database query failed
                      Alert: Email sent to admin@example.com
[access.log 01:28:02] 192.168.1.101 POST /api/users 500
[app.log    01:28:03] INFO: Retrying query...
[app.log    01:28:04] INFO: Query successful
[access.log 01:28:05] 192.168.1.100 GET /styles.css 200

────────────────────────────────────────────────────────────────
Statistics:
  app.log:    125 lines/min, 2 alerts
  error.log:  8 lines/min, 5 alerts
  access.log: 450 lines/min, 0 alerts
────────────────────────────────────────────────────────────────
```

**Alert configuration file example:**
```bash
# ~/.log_monitor.conf

# Keywords to monitor (case-insensitive)
KEYWORDS=(
    "ERROR"
    "FATAL"
    "CRITICAL"
    "Exception"
    "timeout"
)

# Alert levels (higher = more severe)
declare -A ALERT_LEVELS=(
    [CRITICAL]=4
    [FATAL]=4
    [ERROR]=3
    [WARNING]=2
    [INFO]=1
)

# Alert destinations
EMAIL_ALERTS=true
EMAIL_TO="admin@example.com"
SOUND_ALERTS=true
DESKTOP_NOTIFICATIONS=true
LOG_ALERTS=true
ALERT_LOG_FILE="/var/log/monitor_alerts.log"

# Monitoring settings
CHECK_INTERVAL=1  # seconds
MAX_LINES_DISPLAY=50
DASHBOARD_REFRESH=5  # seconds

# Thresholds
MAX_ALERTS_PER_MINUTE=10
FILE_SIZE_WARNING=100  # MB
```
### Bonus Challenges:
**Level 1 (Intermediate):**
- Add log rotation detection (handle file rollover)
- Support compressed logs (gzip)
- Implement alert throttling (don't spam)
- Add time-based filtering (only monitor during business hours)
- Create alert templates (customizable messages)
- Support log aggregation from multiple sources
- Add context lines around matches (show ±3 lines)
- Implement alert acknowledgment system

**Level 2 (Advanced):**
- Machine learning for anomaly detection
- Correlation engine (related events across files)
- Predictive alerting (warn before problems occur)
- Integration with monitoring systems (Prometheus, Grafana)
- Real-time log parsing and structuring
- Support for various log formats (JSON, syslog, custom)
- Distributed monitoring (multiple servers)
- Web interface for management
- API for external integrations
- Historical analysis and reporting
- Performance metrics and optimization

**Level 3 (Expert):**
- Stream processing with complex event processing
- AI-powered incident classification
- Auto-remediation triggers
- Integration with incident management (PagerDuty, Opsgenie)
- Log normalization across different formats
- Compliance monitoring and reporting
- Root cause analysis engine
- Capacity planning from log trends
- Security threat detection (SIEM functionality)
- Full-text search indexing
- Log retention and archival policies
- Multi-tenant support with isolation

***
