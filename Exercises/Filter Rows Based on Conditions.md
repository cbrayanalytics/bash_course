### Goal:
Create a script named `row_filter.sh` that filters CSV/data files based on complex conditions using awk.
### Requirements:
- Filter conditions:
  - Exact match (column = value)
  - Numeric comparisons (>, <, >=, <=, !=)
  - String matching (contains, starts with, ends with)
  - Regex patterns
  - Date comparisons
  - Multiple conditions (AND, OR, NOT)
  - Range queries (BETWEEN)
  - IN list queries
- Advanced filtering:
  - Compound conditions
  - Nested conditions
  - Column-to-column comparisons
  - Calculated field filters
- Output options:
  - Filtered data
  - Excluded data
  - Both in separate files
  - Statistics on filtering
- Performance optimization for large files
### Expected Output Example:
```bash
./row_filter.sh --filter "Amount>1000 AND Category=Electronics" sales.csv
```
```
╔════════════════════════════════════════════════════════════════╗
║                    ROW FILTER UTILITY                          ║
╚════════════════════════════════════════════════════════════════╝

Input file: sales.csv
Filter: Amount > 1000 AND Category = "Electronics"

Analyzing data...
────────────────────────────────────────────────────────────────
Total rows: 1,246 (including header)
Columns: 5

Applying filter...
████████████████████████████████████████ 100%

Filter Results:
────────────────────────────────────────────────────────────────
Rows matching filter: 234 (18.8%)
Rows excluded: 1,012 (81.2%)

Preview of filtered data (first 5 rows):
────────────────────────────────────────────────────────────────
ID,Date,Category,Description,Amount
1045,2025-10-15,Electronics,Laptop,1299.99
1067,2025-10-16,Electronics,TV 55",1499.99
1089,2025-10-17,Electronics,Gaming Console,1099.99
1123,2025-10-18,Electronics,Camera,1899.99
1156,2025-10-19,Electronics,Tablet,1149.99

Statistics on filtered 
────────────────────────────────────────────────────────────────
Amount range: $1,001.00 - $9,999.99
Average amount: $2,345.67
Total value: $548,891.78

Output saved to: filtered_sales.csv
Excluded rows saved to: excluded_sales.csv
```

```bash
./row_filter.sh --complex "(Amount>500 AND Amount<2000) OR Category IN (Electronics,Sports)" data.csv
```
```
╔════════════════════════════════════════════════════════════════╗
║              COMPLEX FILTER APPLICATION                        ║
╚════════════════════════════════════════════════════════════════╝

Input: data.csv
Filter: (Amount>500 AND Amount<2000) OR Category IN (Electronics, Sports)

Filter breakdown:
────────────────────────────────────────────────────────────────
Condition 1: Amount BETWEEN 500 AND 2000
  Matched: 345 rows

Condition 2: Category IN (Electronics, Sports)
  Matched: 615 rows

Combined (OR): 823 rows (some overlap)

Venn Diagram:
────────────────────────────────────────────────────────────────
         Condition 1            Condition 2
           (345)                  (615)
              ╱                    ╲
             ╱                      ╲
            ╱        Both            ╲
           ╱         (137)            ╲
          ╱                            ╲
         ╱                              ╲
        ───────────────────────────────────
           Only 1: 208    Only 2: 478
           
Total unique matches: 823

Output generated: complex_filtered.csv
```

```bash
./row_filter.sh --filter "Date>='2025-10-01' AND Date<='2025-10-31'" --date-format "%Y-%m-%d" logs.csv
```
```
╔════════════════════════════════════════════════════════════════╗
║              DATE RANGE FILTER                                 ║
╚════════════════════════════════════════════════════════════════╝

Input: logs.csv
Date column: Date (detected automatically)
Format: YYYY-MM-DD
Range: 2025-10-01 to 2025-10-31 (October 2025)

Analyzing dates...
────────────────────────────────────────────────────────────────
Earliest date in file: 2025-09-15
Latest date in file: 2025-11-05
Total span: 52 days

Filtering for October 2025...

Results:
────────────────────────────────────────────────────────────────
Rows in range: 678
Days covered: 31
Average rows per day: 21.9

Daily distribution:
────────────────────────────────────────────────────────────────
Oct 01-07:  ████████████████ 145 rows
Oct 08-14:  ██████████████████ 167 rows
Oct 15-21:  ████████████████████ 189 rows ← Peak
Oct 22-28:  ███████████████ 134 rows
Oct 29-31:  ████ 43 rows

Output: october_logs.csv
```
### Bonus Challenge:
- Add fuzzy matching
- Support geospatial filtering (within radius)
- Add machine learning-based filtering
- Support sampling (random N rows matching filter)
- Add filter templates/presets
- Create filter builder UI (interactive)
- Support filter chaining
- Add filter performance profiling
- Create filter optimization suggestions
- Support distributed filtering (large files)

***