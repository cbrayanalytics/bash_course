### Goal:
Build a comprehensive log parsing tool named `log_parser.sh` that extracts and analyzes patterns from log files using regex.
### Requirements:

**Core Extraction Patterns:**
1. **IP Addresses:**
   - IPv4: `192.168.1.1`
   - IPv6: `2001:0db8:85a3::8a2e:0370:7334`
   - Extract all unique IPs
   - Count occurrences per IP
   - Identify top IPs by frequency
   - Detect private vs public IPs

2. **Timestamps:**
   - Multiple formats:
     - ISO 8601: `2025-10-19T21:30:00Z`
     - Apache: `[19/Oct/2025:21:30:00 +0000]`
     - Syslog: `Oct 19 21:30:00`
   - Parse date and time components
   - Group by time periods (hour, day)
   - Calculate time ranges
   - Detect time gaps

3. **Log Levels:**
   - ERROR, WARN, INFO, DEBUG, FATAL
   - Case-insensitive matching
   - Count by level
   - Filter by level
   - Severity distribution

4. **Error Codes:**
   - HTTP status codes (200, 404, 500, etc.)
   - Application error codes
   - Count and categorize
   - Success vs failure rates

5. **Patterns:**
   - URLs from logs
   - File paths
   - User agents
   - Session IDs
   - Email addresses
   - Database queries
   - Stack traces

**Analysis Features:**
- Statistics per pattern type
- Timeline analysis
- Anomaly detection (unusual patterns)
- Correlation between patterns
- Pattern frequency over time
- Generate summary report
- Export to CSV/JSON
- Create visualizations (ASCII graphs)
### Expected Output Example:
```bash
./log_parser.sh /var/log/apache/access.log
```
```
╔════════════════════════════════════════════════════════════════╗
║                   LOG PARSER & ANALYZER                        ║
║                   File: /var/log/apache/access.log            ║
╚════════════════════════════════════════════════════════════════╝

Analyzing log file...
File size: 245 MB
Lines: 1,234,567
Time range: 2025-10-01 00:00:00 to 2025-10-19 23:59:59

██████████████████████████████████████ 100% Complete

══════════════════════════════════════════════════════════════
IP ADDRESS ANALYSIS
══════════════════════════════════════════════════════════════

Total unique IPs: 15,432

Top 10 IPs by request count:
────────────────────────────────────────────────────────────────
1. 192.168.1.100    45,678 requests (3.7%)
2. 203.0.113.42     32,456 requests (2.6%)
3. 198.51.100.23    28,901 requests (2.3%)
4. 192.168.1.101    25,432 requests (2.1%)
5. 10.0.0.15        22,789 requests (1.8%)
6. 172.16.0.50      19,234 requests (1.6%)
7. 203.0.113.78     18,567 requests (1.5%)
8. 198.51.100.89    17,234 requests (1.4%)
9. 192.168.2.30     15,890 requests (1.3%)
10. 10.0.1.20       14,567 requests (1.2%)

IP Classification:
────────────────────────────────────────────────────────────────
Private IPs:     8,234 (53%)
Public IPs:      7,198 (47%)

Geographic distribution (top 5):
────────────────────────────────────────────────────────────────
United States:   5,678 IPs (36.8%)
United Kingdom:  2,345 IPs (15.2%)
Germany:         1,890 IPs (12.2%)
France:          1,456 IPs (9.4%)
Canada:          1,234 IPs (8.0%)

Suspicious IPs (multiple failed attempts):
────────────────────────────────────────────────────────────────
⚠ 203.0.113.99    234 failed login attempts
⚠ 198.51.100.55   189 404 errors
⚠ 192.0.2.123     156 500 errors

══════════════════════════════════════════════════════════════
TIMESTAMP ANALYSIS
══════════════════════════════════════════════════════════════

Time range: 19 days, 23 hours, 59 minutes
First entry: 2025-10-01 00:00:03
Last entry:  2025-10-19 23:59:58

Requests by hour (average):
────────────────────────────────────────────────────────────────
00:00 - 01:00  ████░░░░░░░░░░░░░░░░  2,345 (1.9%)
01:00 - 02:00  ███░░░░░░░░░░░░░░░░░  1,890 (1.5%)
02:00 - 03:00  ██░░░░░░░░░░░░░░░░░░  1,456 (1.2%)
...
09:00 - 10:00  ████████████████████  12,890 (10.4%) ← Peak
10:00 - 11:00  ███████████████████░  11,234 (9.1%)
11:00 - 12:00  ██████████████████░░  10,567 (8.6%)
...
22:00 - 23:00  █████░░░░░░░░░░░░░░░  3,456 (2.8%)
23:00 - 00:00  ████░░░░░░░░░░░░░░░░  2,789 (2.3%)

Peak hour: 09:00 - 10:00 (12,890 requests/hour average)
Quiet hour: 02:00 - 03:00 (1,456 requests/hour average)

Requests by day of week:
────────────────────────────────────────────────────────────────
Monday:    ████████████████░░░░  23,456 (18.9%)
Tuesday:   ███████████████████░  24,567 (19.8%) ← Peak
Wednesday: ██████████████████░░  23,890 (19.3%)
Thursday:  █████████████████░░░  22,345 (18.0%)
Friday:    ███████████████░░░░░  19,234 (15.5%)
Saturday:  ████████░░░░░░░░░░░░  5,678 (4.6%)
Sunday:    ████████░░░░░░░░░░░░  4,567 (3.7%)

Time gaps detected:
────────────────────────────────────────────────────────────────
⚠ 2025-10-05 03:15:00 - 03:47:00 (32 min gap)
⚠ 2025-10-12 14:30:00 - 15:22:00 (52 min gap)

══════════════════════════════════════════════════════════════
HTTP STATUS CODE ANALYSIS
══════════════════════════════════════════════════════════════

Total requests: 1,234,567

Status code distribution:
────────────────────────────────────────────────────────────────
2xx (Success):
  200 OK              1,089,234 (88.2%) ████████████████████
  201 Created             5,678 (0.5%)  █
  204 No Content          2,345 (0.2%)  ░

3xx (Redirection):
  301 Moved               12,345 (1.0%) ██
  302 Found                8,901 (0.7%) █
  304 Not Modified        15,678 (1.3%) ██

4xx (Client Error):
  400 Bad Request          3,456 (0.3%) █
  401 Unauthorized         5,678 (0.5%) █
  403 Forbidden            4,567 (0.4%) █
  404 Not Found           45,678 (3.7%) ███████
  429 Too Many Req         2,345 (0.2%) ░

5xx (Server Error):
  500 Internal Error      23,456 (1.9%) ███
  502 Bad Gateway          5,678 (0.5%) █
  503 Service Unavail      8,901 (0.7%) █

Success rate: 91.9%
Error rate: 8.1% (Client: 6.1%, Server: 1.9%)

⚠ High error rate detected: 8.1% exceeds threshold of 5%

Most common errors:
────────────────────────────────────────────────────────────────
1. 404 Not Found - 45,678 occurrences
   Top missing resources:
     /favicon.ico (12,345)
     /old-page.html (8,901)
     /api/v1/deprecated (5,678)

2. 500 Internal Error - 23,456 occurrences
   Peak times:
     2025-10-05 15:30 - 16:00 (2,345 errors)
     2025-10-12 10:15 - 10:45 (1,890 errors)

══════════════════════════════════════════════════════════════
LOG LEVEL ANALYSIS
══════════════════════════════════════════════════════════════

Extracting log levels from error logs...

Level distribution:
────────────────────────────────────────────────────────────────
INFO:    892,345 (72.3%) ██████████████████
WARN:    145,678 (11.8%) ███
ERROR:   123,456 (10.0%) ██
DEBUG:    45,678 (3.7%)  █
FATAL:    27,410 (2.2%)  ░

⚠ FATAL errors detected: 27,410 occurrences

Top FATAL errors:
────────────────────────────────────────────────────────────────
1. Database connection lost (8,901)
2. Out of memory error (6,789)
3. Critical service failure (5,432)
4. Configuration error (3,456)
5. Security violation (2,832)

Error trend:
────────────────────────────────────────────────────────────────
Week 1:  15,678 errors
Week 2:  18,901 errors (+20.5%) ↑
Week 3:  23,456 errors (+24.1%) ↑↑

⚠ Increasing error trend detected!

══════════════════════════════════════════════════════════════
URL PATTERN ANALYSIS
══════════════════════════════════════════════════════════════

Unique URLs accessed: 8,567

Top 10 most accessed URLs:
────────────────────────────────────────────────────────────────
1. /                    234,567 (19.0%)
2. /api/users           89,012 (7.2%)
3. /login               67,890 (5.5%)
4. /dashboard           56,789 (4.6%)
5. /api/products        45,678 (3.7%)
6. /search              34,567 (2.8%)
7. /logout              23,456 (1.9%)
8. /profile             19,234 (1.6%)
9. /settings            15,678 (1.3%)
10. /api/orders         12,345 (1.0%)

URL categories:
────────────────────────────────────────────────────────────────
API endpoints:    456,789 (37.0%)
Static pages:     345,678 (28.0%)
User actions:     234,567 (19.0%)
Admin panel:       89,012 (7.2%)
Other:            108,521 (8.8%)

Slowest endpoints (avg response time):
────────────────────────────────────────────────────────────────
1. /api/report/generate    4.5s
2. /api/export/data        3.8s
3. /search?complex=true    2.9s
4. /api/analytics          2.3s
5. /dashboard/heavy        1.8s

══════════════════════════════════════════════════════════════
USER AGENT ANALYSIS
══════════════════════════════════════════════════════════════

Browsers:
────────────────────────────────────────────────────────────────
Chrome:    567,890 (46.0%)
Firefox:   234,567 (19.0%)
Safari:    189,012 (15.3%)
Edge:       89,012 (7.2%)
Other:     154,086 (12.5%)

Operating Systems:
────────────────────────────────────────────────────────────────
Windows:   456,789 (37.0%)
macOS:     345,678 (28.0%)
Linux:     234,567 (19.0%)
iOS:       123,456 (10.0%)
Android:    74,077 (6.0%)

Bots detected: 45,678 (3.7%)
────────────────────────────────────────────────────────────────
Googlebot:    23,456
Bingbot:      12,345
Other bots:    9,877

══════════════════════════════════════════════════════════════
SECURITY ANALYSIS
══════════════════════════════════════════════════════════════

Potential security issues:

SQL Injection attempts: 234
────────────────────────────────────────────────────────────────
Pattern: ' OR '1'='1
From IPs: 203.0.113.99, 198.51.100.55, ...

XSS attempts: 156
────────────────────────────────────────────────────────────────
Pattern: <script>
From IPs: 192.0.2.123, 203.0.113.88, ...

Path traversal: 89
────────────────────────────────────────────────────────────────
Pattern: ../../../
From IPs: 198.51.100.77, ...

Brute force login attempts: 1,234
────────────────────────────────────────────────────────────────
Threshold: >50 failed logins from same IP
Affected IPs: 23

╔════════════════════════════════════════════════════════════════╗
║                    ANALYSIS SUMMARY                            ║
╚════════════════════════════════════════════════════════════════╝

Log file: /var/log/apache/access.log
Analysis duration: 45.6 seconds
Lines processed: 1,234,567

Key findings:
────────────────────────────────────────────────────────────────
✓ Generally healthy traffic patterns
⚠ Error rate (8.1%) exceeds threshold
⚠ Increasing error trend over past 3 weeks
⚠ 27,410 FATAL errors require attention
⚠ Security threats detected (SQL injection, XSS)
⚠ 23 IPs engaged in brute force attempts

Recommendations:
────────────────────────────────────────────────────────────────
1. Investigate and fix recurring 500 errors
2. Review missing resources causing 404 errors
3. Optimize slow API endpoints
4. Block suspicious IPs attempting attacks
5. Review FATAL error logs for critical issues
6. Consider rate limiting to prevent brute force
7. Implement WAF rules for injection attacks

Reports generated:
────────────────────────────────────────────────────────────────
• Full report: log_analysis_20251019.txt
• Error summary: errors_20251019.txt
• IP blacklist: suspicious_ips.txt
• JSON export: log_data_20251019.json
• CSV export: log_stats_20251019.csv

Next steps:
────────────────────────────────────────────────────────────────
• Run: ./log_parser.sh --errors-only
• Run: ./log_parser.sh --security-scan
• Run: ./log_parser.sh --compare <previous_log>
```
### Bonus Challenges:
**Level 1 (Intermediate):**
- Add real-time log monitoring (tail -f)
- Support compressed logs (gzip, bzip2)
- Parse multiple log formats simultaneously
- Create custom pattern definitions
- Add log correlation across files
- Generate HTML reports with charts
- Support log rotation detection
- Add performance profiling

**Level 2 (Advanced):**
- Machine learning for anomaly detection
- Predictive analysis (forecast trends)
- Integration with ELK stack
- Real-time alerting system
- Distributed log parsing
- Graph database integration
- Natural language query interface
- Automated incident response

**Level 3 (Expert):**
- Full SIEM capabilities
- AI-powered threat detection
- Behavioral analysis
- Attack pattern recognition
- Compliance reporting (PCI, HIPAA)
- Integration with security tools
- Automated forensics
- Threat intelligence feeds