### Goal:
Create a script named `error_finder.sh` that searches log files for various error patterns and provides detailed analysis.
### Requirements:
- Search for common error patterns:
  - ERROR, Error, error (case variations)
  - FATAL, CRITICAL
  - Exception, Traceback
  - Failed, Failure
  - Warning levels
- Accept log file path(s) as arguments
- Support multiple files and wildcards
- Display:
  - Line number of each error
  - Context around errors (configurable lines)
  - Total error count
  - Errors grouped by type
  - Timeline of errors (by hour/day)
- Highlight different error severities
- Filter by date/time range
- Export results to file
- Support real-time monitoring (tail -f)
### Expected Output Example:
```bash
./error_finder.sh /var/log/application.log
```
```
╔════════════════════════════════════════════════════════════════╗
║              ERROR FINDER - Log Analysis                       ║
║              File: /var/log/application.log                    ║
╚════════════════════════════════════════════════════════════════╝

Scanning for errors...
File size: 45.3 MB
Date range: 2025-10-01 to 2025-10-19

██████████████████████████████████████ 100% Complete

══════════════════════════════════════════════════════════════
ERRORS FOUND: 234
══════════════════════════════════════════════════════════════

By Severity:
────────────────────────────────────────────────────────────────
FATAL:     12 (5.1%)   ███████
CRITICAL:  23 (9.8%)   ████████████
ERROR:    156 (66.7%)  ████████████████████████████████
WARNING:   43 (18.4%)  ██████████████

══════════════════════════════════════════════════════════════
FATAL ERRORS (12)
══════════════════════════════════════════════════════════════

[Line 1,234] 2025-10-05 03:15:42
────────────────────────────────────────────────────────────────
1232 | Starting database connection
1233 | Attempting to connect to db.example.com:5432
1234 | FATAL: Database connection failed - timeout
1235 | Stack trace:
1236 |   at DatabaseManager.connect()
1237 |   at Application.initialize()

[Line 5,678] 2025-10-12 14:30:15
────────────────────────────────────────────────────────────────
5676 | Processing payment transaction
5677 | Validating payment details
5678 | FATAL: Payment gateway unreachable
5679 | Transaction rolled back
5680 | Notifying customer of failure

[...10 more FATAL errors]

══════════════════════════════════════════════════════════════
ERROR TIMELINE
══════════════════════════════════════════════════════════════

Errors by day:
────────────────────────────────────────────────────────────────
Oct 01: ████░░░░░░░░░░░░░░░░  8 errors
Oct 02: █████░░░░░░░░░░░░░░░  10 errors
Oct 03: ███████░░░░░░░░░░░░░  14 errors
Oct 04: ██████░░░░░░░░░░░░░░  12 errors
Oct 05: ████████████████████  45 errors ⚠ Spike!
Oct 06: ███████░░░░░░░░░░░░░  15 errors
...
Oct 19: █████░░░░░░░░░░░░░░░  11 errors

Peak error day: Oct 05 (45 errors)
Average: 12.3 errors/day

Errors by hour (Oct 19):
────────────────────────────────────────────────────────────────
00:00 ░░░░░░░░░░░░░░░░░░░░  0
01:00 ░░░░░░░░░░░░░░░░░░░░  0
02:00 ░░░░░░░░░░░░░░░░░░░░  0
03:00 ████████████████████  5 ⚠ Spike at 03:15
04:00 ░░░░░░░░░░░░░░░░░░░░  0
...
14:00 ████░░░░░░░░░░░░░░░░  1
15:00 ████████░░░░░░░░░░░░  2

══════════════════════════════════════════════════════════════
ERROR PATTERNS
══════════════════════════════════════════════════════════════

Most common errors:
────────────────────────────────────────────────────────────────
1. "Connection timeout" - 45 occurrences
2. "File not found" - 34 occurrences
3. "Permission denied" - 28 occurrences
4. "Invalid input" - 23 occurrences
5. "Database query failed" - 19 occurrences

Affected components:
────────────────────────────────────────────────────────────────
DatabaseManager:     67 errors (28.6%)
PaymentProcessor:    45 errors (19.2%)
FileHandler:         34 errors (14.5%)
AuthenticationServ:  28 errors (12.0%)
Other:               60 errors (25.6%)

╔════════════════════════════════════════════════════════════════╗
║                     RECOMMENDATIONS                            ║
╚════════════════════════════════════════════════════════════════╝

⚠ Critical Issues:
  1. Database connection failures - investigate network/credentials
  2. Error spike on Oct 05 at 03:15 - review system logs
  3. High rate of payment gateway errors - check service status

🔧 Actions:
  • Review database connection settings
  • Increase timeout values
  • Add retry logic for transient failures
  • Monitor Oct 05 03:00-04:00 window for recurring issues

📊 Report saved to: error_report_20251019.txt
📈 Full details: error_details_20251019.log
```
### Bonus Challenge:
- Add email alerts for critical errors
- Create error signatures/fingerprints
- Detect error patterns/anomalies
- Compare error rates between time periods
- Generate graphs/charts
- Support multiple log formats
- Add error deduplication
- Create error knowledge base
- Support distributed log analysis
- Add machine learning for error prediction

***