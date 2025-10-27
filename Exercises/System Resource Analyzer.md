### Goal:
Build a comprehensive system resource analysis tool named `resource_analyzer.sh` that processes `ps`, `df`, and other system command outputs using awk to generate formatted reports.
### Requirements:

**Data Sources:**
1. **Process Analysis (ps):**
   - CPU usage by process
   - Memory usage by process
   - Top consumers (CPU/Memory)
   - Process count by user
   - Process hierarchy
   - Zombie/defunct processes
   - Long-running processes

2. **Disk Usage (df):**
   - Filesystem usage
   - Available space
   - Percentage used
   - Inodes usage
   - Mount points
   - Disk growth trends

3. **Memory Analysis (free):**
   - Total/Used/Free memory
   - Swap usage
   - Cache/Buffer usage
   - Memory pressure indicators

4. **Network (netstat/ss):**
   - Connection counts
   - Listening ports
   - Established connections
   - Network traffic by port

5. **System Load (uptime):**
   - Load averages
   - Uptime
   - User count

**Analysis Features:**
- Threshold alerts (>80% usage, etc.)
- Historical comparison
- Trend analysis
- Resource predictions
- Anomaly detection
- Recommendations
- Executive summary
- Detailed drill-down

**Output Formats:**
- Terminal (colored, formatted)
- HTML report
- JSON for APIs
- Email report
- Dashboard view
### Expected Output Example:
```bash
./resource_analyzer.sh
```
```
╔════════════════════════════════════════════════════════════════╗
║           SYSTEM RESOURCE ANALYZER                             ║
║           Generated: 2025-10-19 23:31:00 MDT                   ║
╚════════════════════════════════════════════════════════════════╝

System: myserver
Uptime: 15 days, 8 hours, 23 minutes
Load Average: 1.25, 1.45, 1.67 (1/5/15 min)

══════════════════════════════════════════════════════════════
CPU USAGE ANALYSIS
══════════════════════════════════════════════════════════════

Overall CPU: 35.2% utilized

Top 10 CPU Consumers:
────────────────────────────────────────────────────────────────
PID    Process              User    CPU%   Mem%   Time
────────────────────────────────────────────────────────────────
1234   mysql                mysql   12.5%  8.3%   145:23
2345   java                 app     8.7%   15.2%  89:45
3456   python               app     5.3%   3.1%   45:12
4567   nginx                www     3.2%   1.5%   234:56
5678   postgres             db      2.8%   6.7%   178:34
6789   redis                cache   1.9%   2.3%   198:23
7890   node                 app     0.8%   4.5%   23:45
8901   apache               www     0.5%   1.2%   167:89
9012   mongod               db      0.3%   5.8%   98:76
1023   python3              app     0.2%   1.1%   12:34
────────────────────────────────────────────────────────────────

Process Statistics:
────────────────────────────────────────────────────────────────
Total processes: 347
Running: 3
Sleeping: 342
Zombie: 0
Stopped: 2

Processes by user:
────────────────────────────────────────────────────────────────
root:      89 processes (25.6%)
app:       125 processes (36.0%)
mysql:     45 processes (13.0%)
www:       34 processes (9.8%)
db:        28 processes (8.1%)
Other:     26 processes (7.5%)

⚠ Alerts:
  • mysql using high CPU (12.5%) - consider optimization
  • java memory usage at 15.2% - monitor for leaks

══════════════════════════════════════════════════════════════
MEMORY ANALYSIS
══════════════════════════════════════════════════════════════

Physical Memory:
────────────────────────────────────────────────────────────────
Total:     16.0 GB
Used:      11.2 GB (70%)  ███████████████████████████░░░
Free:       1.8 GB (11%)  ████░░░░░░░░░░░░░░░░░░░░░░░░
Cache:      3.0 GB (19%)  ██████░░░░░░░░░░░░░░░░░░░░░░

Swap:
────────────────────────────────────────────────────────────────
Total:     4.0 GB
Used:      0.5 GB (12%)  ████░░░░░░░░░░░░░░░░░░░░░░░░
Free:      3.5 GB (88%)  ████████████████████████████

Top 10 Memory Consumers:
────────────────────────────────────────────────────────────────
Process              Memory      % of RAM  RSS      VSZ
────────────────────────────────────────────────────────────────
java                 2.4 GB      15.2%     2.4 GB   4.2 GB
mysql                1.3 GB      8.3%      1.3 GB   2.1 GB
postgres             1.1 GB      6.7%      1.1 GB   1.8 GB
mongod               930 MB      5.8%      930 MB   1.5 GB
node                 720 MB      4.5%      720 MB   1.2 GB
python               500 MB      3.1%      500 MB   850 MB
redis                370 MB      2.3%      370 MB   420 MB
apache               190 MB      1.2%      190 MB   280 MB
nginx                240 MB      1.5%      240 MB   310 MB
python3              180 MB      1.1%      180 MB   250 MB
────────────────────────────────────────────────────────────────
Total (Top 10):      7.9 GB      49.7%

Memory Status: ⚠ WARNING (70% used)
Recommendation: Consider adding RAM or optimizing applications

══════════════════════════════════════════════════════════════
DISK USAGE ANALYSIS
══════════════════════════════════════════════════════════════

Filesystem Usage:
────────────────────────────────────────────────────────────────
Mount         Size   Used   Avail  Use%  Status
────────────────────────────────────────────────────────────────
/             50GB   35GB   13GB   73%   ⚠ High
/home         200GB  145GB  47GB   76%   ⚠ High
/var          100GB  82GB   15GB   85%   🔴 Critical
/tmp          20GB   2GB    18GB   10%   ✓ OK
/opt          50GB   15GB   33GB   31%   ✓ OK
────────────────────────────────────────────────────────────────

Visual representation:
────────────────────────────────────────────────────────────────
/        ████████████████████████████░░░ 73%
/home    ████████████████████████████████ 76%
/var     █████████████████████████████████ 85% ⚠
/tmp     ████░░░░░░░░░░░░░░░░░░░░░░░░░░ 10%
/opt     ████████████░░░░░░░░░░░░░░░░░░ 31%

🔴 Critical Alerts:
  • /var at 85% capacity - immediate cleanup required
  • /home at 76% - approaching threshold

Top 10 Largest Directories in /var:
────────────────────────────────────────────────────────────────
Directory                          Size
────────────────────────────────────────────────────────────────
/var/log/                         25.3 GB
/var/lib/mysql/                   18.7 GB
/var/lib/postgresql/              12.4 GB
/var/cache/                       8.9 GB
/var/spool/                       6.2 GB
/var/lib/docker/                  5.8 GB
/var/tmp/                         2.3 GB
/var/backups/                     1.8 GB
/var/lib/mongodb/                 0.9 GB
/var/lib/redis/                   0.4 GB
────────────────────────────────────────────────────────────────

Recommendations:
  1. Clean old log files in /var/log
  2. Review database sizes in /var/lib/mysql
  3. Clear cache in /var/cache
  4. Archive or delete old backups

══════════════════════════════════════════════════════════════
NETWORK ANALYSIS
══════════════════════════════════════════════════════════════

Network Connections:
────────────────────────────────────────────────────────────────
State            Count
────────────────────────────────────────────────────────────────
ESTABLISHED      234
LISTEN           45
TIME_WAIT        89
CLOSE_WAIT       12
FIN_WAIT         5
────────────────────────────────────────────────────────────────
Total:           385

Top 5 Listening Ports:
────────────────────────────────────────────────────────────────
Port   Service        Process      Connections
────────────────────────────────────────────────────────────────
80     HTTP           nginx        89
443    HTTPS          nginx        67
3306   MySQL          mysqld       45
5432   PostgreSQL     postgres     23
6379   Redis          redis        10

Active Connections by Service:
────────────────────────────────────────────────────────────────
nginx:           156 connections
mysql:           45 connections
postgresql:      23 connections
redis:           10 connections

══════════════════════════════════════════════════════════════
SYSTEM HEALTH SUMMARY
══════════════════════════════════════════════════════════════

Overall Status: ⚠ WARNING

Issues Detected: 3
────────────────────────────────────────────────────────────────
🔴 CRITICAL (1):
   • Disk /var at 85% capacity

⚠ WARNING (2):
   • Memory at 70% - approaching threshold
   • Disk /home at 76% - monitor closely

✓ OK (3):
   • CPU usage within normal range
   • Swap usage minimal
   • No zombie processes

Recommendations:
────────────────────────────────────────────────────────────────
Immediate actions:
  1. Clean /var filesystem (Priority: HIGH)
  2. Archive old log files
  3. Review and optimize database storage

Short-term:
  4. Monitor memory usage trends
  5. Plan for storage expansion
  6. Optimize high-CPU processes

Long-term:
  7. Consider upgrading RAM (current: 16GB)
  8. Implement log rotation policies
  9. Set up monitoring alerts

╔════════════════════════════════════════════════════════════════╗
║                    REPORT COMPLETE                             ║
╚════════════════════════════════════════════════════════════════╝

Full report saved to: resource_report_20251019_233100.txt
HTML report: resource_report_20251019_233100.html
JSON  resource_data_20251019_233100.json

Next scan scheduled: 2025-10-20 00:00:00
To run again: ./resource_analyzer.sh
For continuous monitoring: ./resource_analyzer.sh --watch
```
### Bonus Challenges:
**Level 1 (Intermediate):**
- Add historical trend analysis
- Create comparison reports (vs yesterday/last week)
- Add predictive analytics (when will disk fill)
- Support custom thresholds
- Add email alerts
- Create scheduled reporting
- Support multiple servers
- Add performance baselines

**Level 2 (Advanced):**
- Build real-time dashboard
- Add capacity planning
- Create anomaly detection
- Support log correlation
- Add root cause analysis
- Build cost optimization suggestions
- Create SLA monitoring
- Add integration with monitoring tools

**Level 3 (Expert):**
- Full observability platform
- AI-powered insights
- Automated remediation
- Predictive failure analysis
- Multi-cloud resource tracking
- Container/K8s resource analysis
- Full infrastructure as code integration
- Enterprise-grade reporting suite

