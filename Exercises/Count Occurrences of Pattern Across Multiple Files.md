### Goal:
Create a script named `pattern_counter.sh` that counts pattern occurrences across multiple files with detailed statistics.
### Requirements:
- Count total occurrences of pattern
- Count per file
- Count per line (multiple matches per line)
- Support multiple patterns simultaneously
- Group results:
  - By file
  - By directory
  - By file type
  - By time period
- Calculate statistics:
  - Total count
  - Average per file
  - Maximum/minimum counts
  - Distribution
- Visualizations:
  - Bar charts (ASCII)
  - Pie charts
  - Trend graphs
- Export to various formats
- Support large file handling
- Show progress for large searches
### Expected Output Example:
```bash
./pattern_counter.sh "error|warning|critical" /var/log/*.log
```
```
╔════════════════════════════════════════════════════════════════╗
║              PATTERN OCCURRENCE COUNTER                        ║
║              Pattern: error|warning|critical                   ║
╚════════════════════════════════════════════════════════════════╝

Analyzing 47 log files...
██████████████████████████████████████ 100%

══════════════════════════════════════════════════════════════
OVERALL STATISTICS
══════════════════════════════════════════════════════════════

Total occurrences:     15,678
Files with matches:    42 of 47 (89.4%)
Total lines scanned:   2,456,789
Match rate:            0.64% of lines

Pattern breakdown:
────────────────────────────────────────────────────────────────
"error":      10,234 (65.3%) ████████████████████████████
"warning":     4,567 (29.1%) ████████████████
"critical":      877 (5.6%)  ███

══════════════════════════════════════════════════════════════
TOP 10 FILES BY COUNT
══════════════════════════════════════════════════════════════

1. application.log          3,456 matches
   ██████████████████████████████████████████████

2. system.log               2,345 matches
   ████████████████████████████████

3. error.log                1,890 matches
   █████████████████████████

4. database.log             1,234 matches
   █████████████████

5. api.log                    987 matches
   █████████████

6. auth.log                   678 matches
   █████████

7. security.log               567 matches
   ███████

8. access.log                 456 matches
   ██████

9. performance.log            345 matches
   ████

10. backup.log                234 matches
    ███

══════════════════════════════════════════════════════════════
DISTRIBUTION ANALYSIS
══════════════════════════════════════════════════════════════

By file type:
────────────────────────────────────────────────────────────────
.log files:    15,234 (97.2%)
.txt files:       344 (2.2%)
.err files:       100 (0.6%)

By directory:
────────────────────────────────────────────────────────────────
/var/log/app/:        8,901 (56.8%)
/var/log/system/:     4,567 (29.1%)
/var/log/services/:   2,210 (14.1%)

By size category:
────────────────────────────────────────────────────────────────
Large files (>10MB):   9,876 matches (62.9%)
Medium files (1-10MB): 4,567 matches (29.1%)
Small files (<1MB):    1,235 matches (7.9%)

Statistical summary:
────────────────────────────────────────────────────────────────
Mean per file:     333.6 matches
Median:            187.0 matches
Std deviation:     512.3
Maximum:         3,456 matches (application.log)
Minimum:             1 match (debug.log)

══════════════════════════════════════════════════════════════
TEMPORAL ANALYSIS
══════════════════════════════════════════════════════════════

Matches by hour (last 24 hours):
────────────────────────────────────────────────────────────────
00:00 ████░░░░░░░░░░░░  234
01:00 ███░░░░░░░░░░░░░  189
02:00 ██░░░░░░░░░░░░░░  156
03:00 █████████████████ 890 ⚠ Spike!
04:00 ███░░░░░░░░░░░░░  201
...
23:00 ████░░░░░░░░░░░░  245

Peak hour: 03:00 (890 matches)
Quiet hour: 02:00 (156 matches)

Trend: ↗ Increasing (12% higher than yesterday)

══════════════════════════════════════════════════════════════
DETAILED BREAKDOWN
══════════════════════════════════════════════════════════════

Files with no matches (5):
────────────────────────────────────────────────────────────────
• clean.log
• success.log
• info.log
• debug.log
• trace.log

Files with high match density (>5% of lines):
────────────────────────────────────────────────────────────────
• error.log (12.3% of lines contain pattern)
• critical.log (8.7% of lines contain pattern)
• failure.log (6.2% of lines contain pattern)

╔════════════════════════════════════════════════════════════════╗
║                     EXPORT OPTIONS                             ║
╚════════════════════════════════════════════════════════════════╝

Results saved to:
  📄 Text report:  pattern_count_20251019.txt
  📊 CSV export:   pattern_count_20251019.csv
  📈 JSON export:  pattern_count_20251019.json

Generate visualizations? (y/n): y

Creating charts...
  ✓ Bar chart: count_by_file.txt
  ✓ Timeline: hourly_distribution.txt
  ✓ Pie chart: pattern_breakdown.txt

All exports complete!
```
### Bonus Challenge:
- Add real-time counting (live updates)
- Support weighted patterns (different importance)
- Create heatmaps
- Add anomaly detection
- Support pattern combinations (AND, OR, NOT)
- Add statistical significance testing
- Create baseline comparisons
- Support rolling time windows
- Add forecasting/prediction
- Create dashboards

***