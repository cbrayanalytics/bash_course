### Goal:
Create a script named `pipeline_demo.sh` that demonstrates complex data processing pipelines combining cut, sort, uniq, grep, awk, and sed.
### Requirements:
- Demonstrate 5+ different complex pipelines
- Each pipeline should:
  - Solve a real-world problem
  - Use at least 3 different tools
  - Show clear input → transformation → output
  - Include performance metrics
  - Have practical use cases
- Categories:
  - Log analysis
  - System monitoring
  - Data extraction
  - Report generation
  - Security analysis
- Add explanations of each step
- Show alternative approaches
- Compare performance
### Expected Output Example:
```bash
./pipeline_demo.sh
```
```
╔════════════════════════════════════════════════════════════════╗
║         COMPLEX PIPELINE DEMONSTRATIONS                        ║
╚════════════════════════════════════════════════════════════════╝

This script demonstrates powerful data processing pipelines
combining multiple Unix tools.

══════════════════════════════════════════════════════════════
PIPELINE 1: Find Top 10 IP Addresses in Access Log
══════════════════════════════════════════════════════════════

Use Case: Identify most frequent visitors to web server

Pipeline:
────────────────────────────────────────────────────────────────
awk '{print $1}' access.log | sort | uniq -c | sort -rn | head -10

Step-by-step breakdown:
  1. awk '{print $1}' access.log
     → Extract first field (IP address) from each log line
     
  2. | sort
     → Sort IP addresses alphabetically (required for uniq)
     
  3. | uniq -c
     → Count consecutive duplicate IPs
     
  4. | sort -rn
     → Sort by count (reverse numeric order)
     
  5. | head -10
     → Show only top 10 results

Results:
────────────────────────────────────────────────────────────────
   4567 192.168.1.100
   3421 203.0.113.42
   2890 198.51.100.23
   2345 192.168.1.101
   1987 10.0.0.15
   1765 172.16.0.50
   1543 203.0.113.78
   1432 198.51.100.89
   1298 192.168.2.30
   1156 10.0.1.20

Analysis:
  Total unique IPs: 15,432
  Top 10 represent: 34.2% of all requests
  Potential bot: 192.168.1.100 (4,567 requests)

Time: 0.234 seconds

══════════════════════════════════════════════════════════════
PIPELINE 2: Extract and Count Unique User Agents
══════════════════════════════════════════════════════════════

Use Case: Analyze browser/client distribution

Pipeline:
────────────────────────────────────────────────────────────────
awk -F'"' '{print $6}' access.log | 
  sort | 
  uniq -c | 
  sort -rn | 
  head -20 | 
  awk '{$1=$1;print}'

Step-by-step:
  1. awk -F'"' '{print $6}'
     → Extract User-Agent field (6th quoted field)
     
  2. | sort | uniq -c
     → Count unique user agents
     
  3. | sort -rn
     → Sort by frequency
     
  4. | head -20
     → Top 20 user agents
     
  5. | awk '{$1=$1;print}'
     → Clean up whitespace

Results:
────────────────────────────────────────────────────────────────
5678 Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/118.0
3456 Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Safari/605.1
2890 Mozilla/5.0 (X11; Linux x86_64) Firefox/119.0
2345 Mozilla/5.0 (iPhone; CPU iPhone OS 16_6) Safari/604.1
[...16 more]

Browser breakdown:
  Chrome:  45.2%
  Safari:  28.7%
  Firefox: 18.3%
  Mobile:  7.8%

Time: 0.456 seconds

══════════════════════════════════════════════════════════════
PIPELINE 3: Find Most Accessed URLs
══════════════════════════════════════════════════════════════

Use Case: Identify popular pages for caching optimization

Pipeline:
────────────────────────────────────────────────────────────────
awk '{print $7}' access.log | 
  grep -v '\.(jpg|png|css|js|ico)$' | 
  sort | 
  uniq -c | 
  sort -rn | 
  head -15 | 
  awk '{printf "%-8s %s\n", $1, $2}'

Step-by-step:
  1. awk '{print $7}'
     → Extract URL path
     
  2. | grep -v '\.(jpg|png|css|js|ico)$'
     → Exclude static resources
     
  3. | sort | uniq -c
     → Count each URL
     
  4. | sort -rn | head -15
     → Top 15 URLs
     
  5. | awk '{printf "%-8s %s\n", $1, $2}'
     → Format output

Results:
────────────────────────────────────────────────────────────────
8901     /
5678     /api/users
3456     /dashboard
2890     /login
2345     /api/products
1987     /profile
1654     /settings
1432     /search
1298     /api/orders
1156     /help
[...5 more]

Optimization potential:
  - Cache /api/users (5,678 requests)
  - Optimize /dashboard queries
  - Consider CDN for top 5 pages

Time: 0.312 seconds

══════════════════════════════════════════════════════════════
PIPELINE 4: Analyze HTTP Status Codes
══════════════════════════════════════════════════════════════

Use Case: Monitor site health and errors

Pipeline:
────────────────────────────────────────────────────────────────
awk '{print $9}' access.log | 
  grep '^[0-9]' | 
  sort | 
  uniq -c | 
  sort -rn | 
  awk '{
    total+=$1;
    status[$2]=$1;
  } END {
    for (s in status) {
      pct = (status[s]/total)*100;
      printf "%3s: %6d (%5.2f%%) ", s, status[s], pct;
      for(i=0; i<pct; i++) printf "█";
      printf "\n"
    }
  }'

Results:
────────────────────────────────────────────────────────────────
200:  89234 (72.35%) ████████████████████████████████████
304:  12345 (10.01%) ██████████
404:   8901 (7.22%)  ███████
301:   5678 (4.60%)  █████
500:   2345 (1.90%)  ██
403:   1890 (1.53%)  ██
502:   1234 (1.00%)  █
503:    987 (0.80%)  █
401:    456 (0.37%)  ░
429:    234 (0.19%)  ░

Health Summary:
  Success rate (2xx): 72.35%
  Redirects (3xx): 14.61%
  Client errors (4xx): 10.31%
  Server errors (5xx): 3.70% ⚠ Above threshold!

Recommendations:
  • Investigate 500 errors (2,345 occurrences)
  • Review 404 patterns (8,901 broken links)
  • Monitor 502/503 for backend issues

Time: 0.567 seconds

══════════════════════════════════════════════════════════════
PIPELINE 5: Peak Traffic Hours Analysis
══════════════════════════════════════════════════════════════

Use Case: Capacity planning and scaling decisions

Pipeline:
────────────────────────────────────────────────────────────────
awk '{print $4}' access.log | 
  cut -d: -f2 | 
  sort | 
  uniq -c | 
  sort -k2n | 
  awk '{
    printf "%02d:00 - %02d:59 | %6d requests ", $2, $2, $1;
    for(i=0; i<$1/100; i++) printf "█";
    printf "\n"
  }'

Results:
────────────────────────────────────────────────────────────────
00:00 - 00:59 |   1234 requests ████████████
01:00 - 01:59 |    987 requests █████████
02:00 - 02:59 |    756 requests ███████
03:00 - 03:59 |    654 requests ██████
04:00 - 04:59 |    823 requests ████████
05:00 - 05:59 |   1456 requests ██████████████
06:00 - 06:59 |   2890 requests ████████████████████████████
07:00 - 07:59 |   4567 requests █████████████████████████████████████████████
08:00 - 08:59 |   6789 requests █████████████████████████████████████████████████████████████████
09:00 - 09:59 |   8901 requests ████████████████████████████████████████████████████████████████████████████████████ Peak!
10:00 - 10:59 |   8234 requests ██████████████████████████████████████████████████████████████████████████████
11:00 - 11:59 |   7456 requests ██████████████████████████████████████████████████████████████████████
12:00 - 12:59 |   6789 requests █████████████████████████████████████████████████████████████████
13:00 - 13:59 |   5678 requests ████████████████████████████████████████████████████████
14:00 - 14:59 |   6123 requests ████████████████████████████████████████████████████████████
15:00 - 15:59 |   5890 requests ███████████████████████████████████████████████████████████
16:00 - 16:59 |   4567 requests █████████████████████████████████████████████
17:00 - 17:59 |   3456 requests ██████████████████████████████████
18:00 - 18:59 |   2890 requests ████████████████████████████
19:00 - 19:59 |   2345 requests ███████████████████████
20:00 - 20:59 |   1987 requests ███████████████████
21:00 - 21:59 |   1654 requests ████████████████
22:00 - 22:59 |   1432 requests ██████████████
23:00 - 23:59 |   1234 requests ████████████

Traffic Pattern:
  Peak hour: 09:00 - 09:59 (8,901 requests)
  Quiet hour: 03:00 - 03:59 (654 requests)
  Peak/Quiet ratio: 13.6x
  
Scaling recommendations:
  • Scale up at 08:00
  • Scale down at 20:00
  • Maintain capacity 09:00-17:00

Time: 0.423 seconds

╔════════════════════════════════════════════════════════════════╗
║                    SUMMARY                                     ║
╚════════════════════════════════════════════════════════════════╝

Pipelines demonstrated: 5
Total processing time: 1.992 seconds
Average time per pipeline: 0.398 seconds

Key takeaways:
  • Combine simple tools for powerful analysis
  • Sort before uniq for accurate counting
  • Use awk for complex field extraction
  • Chain filters to refine results
  • Format output for readability

Next steps:
  • Save these pipelines as reusable functions
  • Add them to monitoring scripts
  • Schedule regular analysis with cron
  • Create alerts based on thresholds
```
### Bonus Challenge:
- Add real-time streaming pipelines
- Create pipeline optimizer (suggest improvements)
- Add parallel processing
- Support distributed pipelines
- Add pipeline debugging mode
- Create pipeline performance profiler
- Add pipeline visualization (flowchart)
- Support pipeline templating
- Add pipeline testing framework
- Create pipeline library/repository

***