### Goal:
Create a script named `csv_extractor.sh` that extracts and manipulates columns from CSV files using awk.
### Requirements:
- Parse CSV files (handle quoted fields, commas in values)
- Extract specific columns by:
  - Column number (1, 2, 3)
  - Column name (from header)
  - Multiple columns at once
  - Column ranges (1-5)
- Operations:
  - Reorder columns
  - Rename columns
  - Filter columns
  - Combine columns
  - Add calculated columns
- Handle edge cases:
  - Quoted fields with commas
  - Empty fields
  - Irregular column counts
  - Missing headers
- Output formats:
  - CSV
  - TSV
  - Pipe-delimited
  - Fixed-width
  - JSON
- Statistics on extracted data
### Expected Output Example:
```bash
./csv_extractor.sh --columns 1,3,5 data.csv
```
```
╔════════════════════════════════════════════════════════════════╗
║                CSV COLUMN EXTRACTOR                            ║
╚════════════════════════════════════════════════════════════════╝

Input file: data.csv
Columns to extract: 1, 3, 5

Analyzing file...
────────────────────────────────────────────────────────────────
Total rows: 1,247 (1 header + 1,246 data)
Total columns: 8
File size: 156 KB

Original columns:
────────────────────────────────────────────────────────────────
1. ID
2. Name
3. Email
4. Phone
5. City
6. State
7. Zip
8. Country

Extracting columns: ID, Email, City

Preview (first 5 rows):
────────────────────────────────────────────────────────────────
ID,Email,City
1001,john.doe@example.com,New York
1002,jane.smith@example.com,Los Angeles
1003,bob.jones@example.com,Chicago
1004,alice.brown@example.com,Houston
1005,charlie.wilson@example.com,Phoenix

Processing...
████████████████████████████████████████ 100%

╔════════════════════════════════════════════════════════════════╗
║                   EXTRACTION COMPLETE                          ║
╚════════════════════════════════════════════════════════════════╝

Output statistics:
────────────────────────────────────────────────────────────────
Rows extracted: 1,247 (including header)
Columns: 3
Output size: 45 KB
Size reduction: 71%

Unique values:
────────────────────────────────────────────────────────────────
ID: 1,246 unique
Email: 1,246 unique
City: 234 unique

Output saved to: extracted_data.csv
```

```bash
./csv_extractor.sh --columns "Name,Email,City" --filter "City=New York" users.csv
```
```
╔════════════════════════════════════════════════════════════════╗
║        CSV EXTRACTOR with FILTERING                            ║
╚════════════════════════════════════════════════════════════════╝

Input: users.csv
Columns: Name, Email, City
Filter: City = "New York"

Processing with filter...

Results:
────────────────────────────────────────────────────────────────
Name,Email,City
John Doe,john.doe@example.com,New York
Alice Brown,alice.brown@example.com,New York
David Lee,david.lee@example.com,New York
[...147 more rows]

Summary:
────────────────────────────────────────────────────────────────
Total input rows: 1,246
Rows matching filter: 150
Match rate: 12%
Output: filtered_data.csv
```

```bash
./csv_extractor.sh --columns "1,2" --add-column "FullInfo=$1-$2" --output json data.csv
```
```
╔════════════════════════════════════════════════════════════════╗
║       CSV EXTRACTOR with CALCULATED COLUMN                     ║
╚════════════════════════════════════════════════════════════════╝

Input: data.csv
Columns: ID, Name
Calculated: FullInfo (combining ID and Name)
Output format: JSON

Processing...

Preview (first 3 records):
────────────────────────────────────────────────────────────────
[
  {
    "ID": "1001",
    "Name": "John Doe",
    "FullInfo": "1001-John Doe"
  },
  {
    "ID": "1002",
    "Name": "Jane Smith",
    "FullInfo": "1002-Jane Smith"
  },
  {
    "ID": "1003",
    "Name": "Bob Jones",
    "FullInfo": "1003-Bob Jones"
  }
]

Output saved to: output.json
```
### Bonus Challenge:
- Add pivot table functionality
- Support Excel files (via conversion)
- Add data validation rules
- Create column type detection (string, number, date)
- Support column aggregation (sum, avg, count)
- Add deduplication by column
- Create column mapping/transformation rules
- Support joining multiple CSV files
- Add SQL-like queries
- Create data profiling reports

***