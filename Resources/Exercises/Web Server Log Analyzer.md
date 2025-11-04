### Goal:
Build a comprehensive web server log analyzer named `log_analyzer.sh` that processes Apache/Nginx access logs to extract visitor statistics, popular pages, and traffic patterns using text processing pipelines.
### Requirements:

**Core Analysis:**
1. **Visitor Analysis:**
   - Unique visitors (IP addresses)
   - Visitor frequency
   - Geographic distribution (if GeoIP available)
   - Bot detection
   - Return visitor analysis

2. **Page Popularity:**
   - Most visited pages
   - Most visited resources
   - Entry/exit pages
   - Referrer analysis
   - User journey paths

3. **Traffic Patterns:**
   - Requests per hour/day
   - Peak traffic times
   - Traffic trends
   - Bandwidth usage
   - Response time analysis

4. **HTTP Analysis:**
   - Status code distribution
   - Error analysis (404, 500, etc.)
   - Success rate
   - Redirect patterns

5. **Security Analysis:**
   - Suspicious activity
   - Failed authentication attempts
   - SQL injection attempts
   - Path traversal attempts
   - DDoS patterns

6. **Technical Details:**
   - Browser distribution
   - Operating system breakdown
   - Device types (mobile/desktop)
   - HTTP methods (GET, POST, etc.)

**Output Features:**
- Executive summary dashboard
- Detailed reports
- ASCII visualizations
- Export options (CSV, JSON, HTML)
- Email reports
- Alerts for anomalies
### Expected Output Example:
```bash
./log_analyzer.sh /var/log/nginx/access.log
```
```
╔════════════════════════════════════════════════════════════════╗
║            WEB SERVER LOG ANALYZER                             ║
║            Log: /var/log/nginx/access.log                      ║
║            Generated: 2025-10-19 23:35:00 MDT                  ║
╚════════════════════════════════════════════════════════════════╝

Analyzing log file...
File size: 567 MB
Log entries: 2,456,789
Date range: 2025-10-01 to 2025-10-19
Time period: 19 days

████████████████████████████████████████ 100% Complete

══════════════════════════════════════════════════════════════
EXECUTIVE SUMMARY
══════════════════════════════════════════════════════════════

Total Requests:     2,456,789
Unique Visitors:    45,678
Pages Viewed:       1,234,567
Bandwidth:          1.2 TB
Success Rate:       94.2% ✓
Avg Response Time:  0.234s

Status:             🟢 Healthy
Performance:        Good
Security:           ⚠ 234 suspicious requests detected

══════════════════════════════════════════════════════════════
VISITOR ANALYSIS
══════════════════════════════════════════════════════════════

Unique Visitors: 45,678
────────────────────────────────────────────────────────────────

Top 20 Visitors by Request Count:
────────────────────────────────────────────────────────────────
Rank  IP Address        Requests  Pages  Bandwidth  Type
────────────────────────────────────────────────────────────────
1     192.168.1.100     12,345    2,456  45.6 GB    Regular
2     203.0.113.42      8,901     1,890  32.1 GB    Regular
3     198.51.100.23     7,654     1,567  28.9 GB    Regular
4     192.168.1.101     6,789     1,234  25.4 GB    Regular
5     66.249.66.1       5,432       543  12.3 GB    Bot (Googlebot)
6     10.0.0.15         4,567       987  18.7 GB    Regular
7     172.16.0.50       3,987       856  16.2 GB    Regular
8     203.0.113.78      3,456       678  14.5 GB    Regular
9     40.77.167.1       3,123       345   8.9 GB    Bot (Bingbot)
10    198.51.100.89     2,987       598  13.2 GB    Regular
[...10 more]

Visitor Type Distribution:
────────────────────────────────────────────────────────────────
Regular visitors: 41,234 (90.3%) ██████████████████████████████
Bots/Crawlers:     3,456 (7.6%)  ████████
Suspicious:          988 (2.2%)  ██

Bot Identification:
────────────────────────────────────────────────────────────────
Googlebot:    1,234 visits (3,456 requests)
Bingbot:        567 visits (1,890 requests)
Other bots:     456 visits (1,234 requests)

Geographic Distribution (Top 10 Countries):
────────────────────────────────────────────────────────────────
United States:   18,234 visitors (39.9%) ████████████████████
United Kingdom:   5,678 visitors (12.4%) ██████
Germany:          4,567 visitors (10.0%) █████
France:           3,456 visitors (7.6%)  ████
Canada:           2,890 visitors (6.3%)  ███
Australia:        2,345 visitors (5.1%)  ███
Japan:            1,987 visitors (4.3%)  ██
India:            1,654 visitors (3.6%)  ██
Brazil:           1,432 visitors (3.1%)  ██
Spain:            1,234 visitors (2.7%)  █
Other:            2,201 visitors (4.8%)  ██

Visitor Frequency:
────────────────────────────────────────────────────────────────
Single visit:     32,456 visitors (71.1%)
2-5 visits:        8,901 visitors (19.5%)
6-10 visits:       2,345 visitors (5.1%)
11-50 visits:      1,567 visitors (3.4%)
50+ visits:          409 visitors (0.9%)

Most loyal visitor: 192.168.1.100 (visited 156 times)

══════════════════════════════════════════════════════════════
POPULAR PAGES
══════════════════════════════════════════════════════════════

Most Visited Pages (excluding static resources):
────────────────────────────────────────────────────────────────
Rank  URL                              Visits    % Total  Unique IP
────────────────────────────────────────────────────────────────
1     /                                234,567   19.0%    12,345
2     /products                        89,012    7.2%     8,901
3     /about                           67,890    5.5%     6,789
4     /contact                         56,789    4.6%     5,678
5     /pricing                         45,678    3.7%     4,567
6     /blog                            34,567    2.8%     3,456
7     /support                         23,456    1.9%     2,345
8     /login                           19,234    1.6%     1,923
9     /signup                          15,678    1.3%     1,567
10    /dashboard                       12,345    1.0%     1,234
[...more pages]

Page Categories:
────────────────────────────────────────────────────────────────
Product pages:    289,012 visits (23.4%)
Documentation:    156,789 visits (12.7%)
Blog posts:       123,456 visits (10.0%)
User accounts:     89,012 visits (7.2%)
API endpoints:     67,890 visits (5.5%)
Other:            508,408 visits (41.2%)

Entry Pages (First page viewed):
────────────────────────────────────────────────────────────────
/                 45.2%  ██████████████████████████████████████████████
/products         18.7%  ███████████████████
/blog             12.3%  ████████████
/pricing           8.9%  █████████
Other             14.9%  ███████████████

Exit Pages (Last page before leaving):
────────────────────────────────────────────────────────────────
/contact          23.4%  ███████████████████████
/pricing          18.9%  ███████████████████
/signup           15.6%  ████████████████
/                 12.3%  ████████████
Other             29.8%  ██████████████████████████████

Most Common User Paths:
────────────────────────────────────────────────────────────────
1. / → /products → /pricing → /signup (5,678 users)
2. / → /about → /contact (4,567 users)
3. / → /blog → [article] → / (3,456 users)

══════════════════════════════════════════════════════════════
TRAFFIC PATTERNS
══════════════════════════════════════════════════════════════

Requests Over Time:
────────────────────────────────────────────────────────────────

By Day:
Oct 01  ████████████████████ 98,234
Oct 02  █████████████████████ 102,456
Oct 03  ███████████████████ 95,678
Oct 04  ██████████████████ 89,012
Oct 05  ████████████████████████ 115,678 ← Weekend spike
Oct 06  ███████████████████████ 110,234
Oct 07  ████████████████████ 98,765
Oct 08  █████████████████████ 105,432
Oct 09  ████████████████████████ 118,901
Oct 10  ██████████████████████ 112,345
Oct 11  ███████████████████ 95,678
Oct 12  ████████████████████████ 123,456 ← Peak day
Oct 13  █████████████████████ 108,901
Oct 14  ████████████████████ 102,345
Oct 15  ███████████████████ 98,234
Oct 16  ███████████████████ 96,789
Oct 17  ████████████████████ 101,234
Oct 18  ████████████████████ 99,876
Oct 19  ████████████████ 85,432 (partial day)

Peak day: Oct 12 (123,456 requests)
Average: 105,841 requests/day
Trend: ↗ Increasing (8.2% growth over period)

By Hour (Average):
────────────────────────────────────────────────────────────────
00:00 ████ 1,234      12:00 ████████████████████ 8,901
01:00 ███ 987          13:00 ███████████████████ 8,234
02:00 ██ 756           14:00 ██████████████████ 7,456
03:00 ██ 654           15:00 ██████████████████ 7,123
04:00 ███ 823          16:00 █████████████████ 6,789
05:00 █████ 1,456      17:00 ████████████████ 6,234
06:00 ████████ 2,890   18:00 ██████████████ 5,678
07:00 ███████████ 4,567 19:00 ████████████ 4,890
08:00 ████████████████ 6,789 20:00 ██████████ 3,987
09:00 █████████████████████ 8,901 ← Peak  21:00 ████████ 3,123
10:00 ███████████████████ 8,234  22:00 ██████ 2,345
11:00 ██████████████████ 7,890   23:00 █████ 1,890

Peak hour: 09:00 (8,901 avg requests/hour)
Quiet hour: 03:00 (654 avg requests/hour)

Day of Week Distribution:
────────────────────────────────────────────────────────────────
Monday:    ████████████████████ 342,567 (13.9%)
Tuesday:   ██████████████████████ 389,012 (15.8%)
Wednesday: █████████████████████ 376,890 (15.3%)
Thursday:  ███████████████████ 356,789 (14.5%)
Friday:    ████████████████ 298,765 (12.2%)
Saturday:  ██████████████ 289,012 (11.8%)
Sunday:    ███████████████ 303,754 (12.4%)

Busiest day: Tuesday
Weekend traffic: 24.2% of total

══════════════════════════════════════════════════════════════
HTTP STATUS ANALYSIS
══════════════════════════════════════════════════════════════

Status Code Distribution:
────────────────────────────────────────────────────────────────
Code  Count       % Total  Description
────────────────────────────────────────────────────────────────
200   2,089,234   85.0%    OK ████████████████████████████████████████████
304     156,789    6.4%    Not Modified ███████
404     123,456    5.0%    Not Found ██████
301      45,678    1.9%    Moved Permanently ██
302      23,456    1.0%    Found █
500       8,901    0.4%    Internal Server Error ░
403       5,678    0.2%    Forbidden ░
502       2,345    0.1%    Bad Gateway ░
503       1,234    0.1%    Service Unavailable ░

Success Rate: 94.2% (2xx + 3xx responses)
Error Rate: 5.8%
  Client errors (4xx): 5.3%
  Server errors (5xx): 0.5%

Most Common Errors:
────────────────────────────────────────────────────────────────
404 Errors (123,456 total):
  /favicon.ico               45,678 (37.0%)
  /old-page.html            23,456 (19.0%)
  /api/v1/deprecated        12,345 (10.0%)
  /wp-admin/                 8,901 (7.2%)  ← Wordpress probing
  [other]                   32,076 (26.0%)

500 Errors (8,901 total):
  Peak times: Oct 12 15:00-16:00 (2,345 errors)
  Affected endpoints: /api/process, /checkout

══════════════════════════════════════════════════════════════
BANDWIDTH ANALYSIS
══════════════════════════════════════════════════════════════

Total Bandwidth: 1.23 TB
Average per request: 524 KB
Peak daily: 78.9 GB (Oct 12)

Bandwidth by Content Type:
────────────────────────────────────────────────────────────────
Images (jpg,png,gif):  567 GB (46.1%) ██████████████████████████████████████████████
Videos (mp4):          345 GB (28.0%) ████████████████████████████
JavaScript/CSS:        156 GB (12.7%) █████████████
HTML:                   89 GB (7.2%)  ███████
Downloads (pdf,zip):    45 GB (3.7%)  ████
Other:                  28 GB (2.3%)  ██

Top Bandwidth Consumers:
────────────────────────────────────────────────────────────────
/videos/demo.mp4          123 GB
/downloads/software.zip    45 GB
/images/hero-bg.jpg        34 GB

Recommendations:
  • Enable CDN for images/videos (reduce 74.1% of bandwidth)
  • Compress JavaScript/CSS (potential 30% savings)
  • Implement lazy loading for images

══════════════════════════════════════════════════════════════
BROWSER & DEVICE ANALYSIS
══════════════════════════════════════════════════════════════

Browser Distribution:
────────────────────────────────────────────────────────────────
Chrome:    56.7% ████████████████████████████████████████████████████████
Safari:    23.4% ███████████████████████
Firefox:   12.8% █████████████
Edge:       4.5% █████
Other:      2.6% ███

Operating Systems:
────────────────────────────────────────────────────────────────
Windows:   45.2% █████████████████████████████████████████████
macOS:     28.9% █████████████████████████████
iOS:       12.3% ████████████
Android:    8.7% █████████
Linux:      4.9% █████

Device Types:
────────────────────────────────────────────────────────────────
Desktop:   67.8% ████████████████████████████████████████████████████████████████████
Mobile:    28.5% █████████████████████████████
Tablet:     3.7% ████

══════════════════════════════════════════════════════════════
SECURITY ANALYSIS
══════════════════════════════════════════════════════════════

Suspicious Activity Detected: 988 incidents
────────────────────────────────────────────────────────────────

SQL Injection Attempts: 234
────────────────────────────────────────────────────────────────
Top attacking IPs:
  203.0.113.99     89 attempts
  198.51.100.77    67 attempts
  192.0.2.123      45 attempts

Patterns detected:
  ' OR '1'='1        56 attempts
  UNION SELECT       43 attempts
  DROP TABLE         21 attempts

Path Traversal Attempts: 156
────────────────────────────────────────────────────────────────
../../../etc/passwd    78 attempts
../config.php          45 attempts
../../../windows/      23 attempts

XSS Attempts: 89
────────────────────────────────────────────────────────────────
<script> injections    45 attempts
javascript: URLs       34 attempts
onerror= attributes    10 attempts

Failed Authentication: 509
────────────────────────────────────────────────────────────────
/admin login:          234 failures
/wp-admin:             189 failures
/api/auth:              86 failures

Brute Force Detection:
────────────────────────────────────────────────────────────────
⚠ IP 203.0.113.88: 156 login attempts in 10 minutes
⚠ IP 198.51.100.55: 123 login attempts in 15 minutes

🔴 RECOMMENDATIONS:
────────────────────────────────────────────────────────────────
1. Block IPs: 203.0.113.99, 198.51.100.77, 192.0.2.123
2. Implement rate limiting on /admin, /api/auth
3. Add WAF rules for SQL injection patterns
4. Enable fail2ban for brute force protection
5. Review and patch vulnerable endpoints

══════════════════════════════════════════════════════════════
REFERRER ANALYSIS
══════════════════════════════════════════════════════════════

Top Traffic Sources:
────────────────────────────────────────────────────────────────
Direct:           45.2% (no referrer)
Google:           23.4%
Bing:              8.9%
Facebook:          6.7%
Twitter:           4.5%
LinkedIn:          3.2%
Reddit:            2.8%
Other:             5.3%

Top Referring Domains:
────────────────────────────────────────────────────────────────
google.com:        234,567 referrals
bing.com:           89,012 referrals
facebook.com:       67,890 referrals
twitter.com:        45,678 referrals
linkedin.com:       32,456 referrals

Search Keywords (from Google):
────────────────────────────────────────────────────────────────
"product name":     5,678 searches
"pricing":          3,456 searches
"reviews":          2,890 searches
[...more keywords]

╔════════════════════════════════════════════════════════════════╗
║                    RECOMMENDATIONS                             ║
╚════════════════════════════════════════════════════════════════╝

Performance:
✓ Good response times (0.234s average)
⚠ Optimize peak hour capacity (09:00-10:00)
✓ Consider CDN for static assets

Security:
🔴 Block malicious IPs immediately
🔴 Implement WAF for injection protection
⚠ Enable rate limiting on authentication endpoints
⚠ Review 500 errors on Oct 12

Content:
✓ Popular pages performing well
⚠ Fix 404 errors (123,456 occurrences)
✓ User paths show good conversion flow

Scaling:
⚠ Peak traffic growing - plan capacity increase
✓ Weekend traffic steady
✓ Geographic distribution balanced

╔════════════════════════════════════════════════════════════════╗
║                    EXPORT OPTIONS                              ║
╚════════════════════════════════════════════════════════════════╝

Reports generated:
────────────────────────────────────────────────────────────────
📄 Full text report:     log_analysis_20251019.txt
📊 CSV              log_data_20251019.csv
📈 JSON export:          log_analysis_20251019.json
🌐 HTML dashboard:       log_dashboard_20251019.html
📧 Email report sent to: admin@example.com

Alerts triggered: 3
  🔴 High security threats detected
  ⚠ Server errors above threshold
  ⚠ 404 rate elevated

Next analysis scheduled: 2025-10-20 00:00:00
To run again: ./log_analyzer.sh /var/log/nginx/access.log
For real-time: ./log_analyzer.sh --watch /var/log/nginx/access.log
```
### Bonus Challenges:
**Level 1 (Intermediate):**
- Add GeoIP database integration
- Support multiple log formats (Apache, Nginx, IIS)
- Add real-time log tailing and analysis
- Create custom alert rules
- Support log rotation handling
- Add historical comparison
- Create trend predictions
- Support distributed logs (multiple servers)

**Level 2 (Advanced):**
- Build interactive HTML dashboard
- Add machine learning for anomaly detection
- Create bot detection algorithms
- Support session reconstruction
- Add conversion funnel analysis
- Build heatmap visualizations
- Create automated incident response
- Support integration with SIEM systems

**Level 3 (Expert):**
- Full observability platform
- Real-time threat intelligence
- AI-powered attack pattern recognition
- Automated security remediation
- Performance optimization suggestions
- Business intelligence integration
- Multi-cloud log aggregation
- Compliance reporting (GDPR, PCI-DSS)
