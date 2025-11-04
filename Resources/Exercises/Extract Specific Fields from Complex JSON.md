### Goal:
Create a script named `json_parser.sh` that extracts and transforms data from complex nested JSON structures.
### Requirements:
- Parse deeply nested JSON
- Extract arrays and objects
- Filter based on conditions
- Transform data structure
- Handle missing fields gracefully
- Support multiple queries
- Output in various formats
- Create summary reports
### Expected Output Example:
```bash
./json_parser.sh --file complex.json --query '.users[] | select(.age > 25) | {name, email}'
```
```
╔════════════════════════════════════════════════════════════════╗
║              JSON PARSER & EXTRACTOR                           ║
╚════════════════════════════════════════════════════════════════╝

Input File: complex.json
Query: .users[] | select(.age > 25) | {name, email}

[INFO] Parsing JSON structure...

JSON Structure Analysis:
────────────────────────────────────────────────────────────────
Root type:       Object
Total keys:      5
Nested levels:   4
Array count:     3
Total objects:   47

[INFO] Applying query filter...

Results Found: 12 records
────────────────────────────────────────────────────────────────

Record 1:
{
  "name": "Alice Johnson",
  "email": "alice@example.com"
}

Record 2:
{
  "name": "Bob Smith",
  "email": "bob@example.com"
}

Record 3:
{
  "name": "Charlie Brown",
  "email": "charlie@example.com"
}

[... 9 more records]

Summary:
────────────────────────────────────────────────────────────────
Total records found: 12
Query execution time: 0.023s
Output format: JSON
```

```bash
./json_parser.sh --file api_response.json --extract-paths
```
```
╔════════════════════════════════════════════════════════════════╗
║              JSON PATH EXTRACTOR                               ║
╚════════════════════════════════════════════════════════════════╝

Analyzing JSON structure...

All Available Paths:
════════════════════════════════════════════════════════════════

Top-level fields:
────────────────────────────────────────────────────────────────
.status              → "success" (string)
.data                → {...} (object)
.metadata            → {...} (object)
.timestamp           → 1697750000 (number)

Data fields (.data):
────────────────────────────────────────────────────────────────
.data.users          → [...] (array of 47 objects)
.data.count          → 47 (number)
.data.page           → 1 (number)

User fields (.data.users[]):
────────────────────────────────────────────────────────────────
.data.users[].id     → (number)
.data.users[].name   → (string)
.data.users[].email  → (string)
.data.users[].age    → (number)
.data.users[].address → {...} (object)

Address fields (.data.users[].address):
────────────────────────────────────────────────────────────────
.data.users[].address.street  → (string)
.data.users[].address.city    → (string)
.data.users[].address.state   → (string)
.data.users[].address.zip     → (string)

Metadata fields (.metadata):
────────────────────────────────────────────────────────────────
.metadata.version    → "2.0" (string)
.metadata.generated  → "2025-10-20T00:21:00Z" (string)

Common Query Examples:
════════════════════════════════════════════════════════════════

Get all user names:
  jq '.data.users[].name' api_response.json

Get users in Colorado:
  jq '.data.users[] | select(.address.state == "Colorado")' api_response.json

Get name and email of users over 25:
  jq '.data.users[] | select(.age > 25) | {name, email}' api_response.json

Count users:
  jq '.data.users | length' api_response.json

Get cities (unique):
  jq '[.data.users[].address.city] | unique' api_response.json
```

```bash
./json_parser.sh --file data.json --transform table
```
```
╔════════════════════════════════════════════════════════════════╗
║              JSON TO TABLE CONVERTER                           ║
╚════════════════════════════════════════════════════════════════╝

Converting JSON to table format...

Users Table:
════════════════════════════════════════════════════════════════

┌─────┬──────────────────┬────────────────────────┬─────┬─────────────┐
│ ID  │ Name             │ Email                  │ Age │ City        │
├─────┼──────────────────┼────────────────────────┼─────┼─────────────┤
│ 001 │ Alice Johnson    │ alice@example.com      │ 30  │ Denver      │
│ 002 │ Bob Smith        │ bob@example.com        │ 28  │ Boulder     │
│ 003 │ Charlie Brown    │ charlie@example.com    │ 35  │ Aurora      │
│ 004 │ Diana Prince     │ diana@example.com      │ 27  │ Denver      │
│ 005 │ Edward Norton    │ edward@example.com     │ 42  │ Fort Collins│
└─────┴──────────────────┴────────────────────────┴─────┴─────────────┘

Statistics:
────────────────────────────────────────────────────────────────
Total records: 5
Average age: 32.4 years
Cities: 4 unique
```

### Bonus Challenge:
- Add JSON schema validation
- Implement JSON diff
- Support JSONPath expressions
- Add JSON merge functionality
- Create JSON to CSV converter
- Support jq scripting files
- Add JSON pretty printer with colors
- Implement JSON flattening/unflattening

***
