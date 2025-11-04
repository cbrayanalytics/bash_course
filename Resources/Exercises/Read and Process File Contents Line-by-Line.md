### Goal:
Create a script named `file_processor.sh` that reads a file line-by-line and performs various processing operations.
### Requirements:
- Accept filename as argument
- Read file line-by-line using while loop
- Implement these processing modes:
  - **Display** - Show each line with line numbers
  - **Filter** - Show only lines matching pattern
  - **Count** - Count lines, words, characters
  - **Transform** - Convert case, trim spaces, etc.
  - **Analyze** - Find longest line, most common word
  - **Search** - Find and highlight keywords
- Handle empty lines
- Handle special characters
- Show progress for large files
- Generate statistics report
### Hints:
- Basic pattern: `while IFS= read -r line; do ... done < file.txt`
- Line counter: `((line_num++))`
- Word count per line: `echo "$line" | wc -w`
- String length: `${#line}`
- Pattern matching: `[[ "$line" =~ pattern ]]`
### Expected Output Example:
```bash
./file_processor.sh data.txt
```
```
╔════════════════════════════════════════════════════════════════╗
║            FILE PROCESSOR - data.txt                           ║
╚════════════════════════════════════════════════════════════════╝

Processing file line-by-line...

[Mode: Display with line numbers]
────────────────────────────────────────────────────────────────
  1 | This is the first line of the file
  2 | Here is the second line
  3 | 
  4 | An empty line above
  5 | Line with numbers: 12345
  6 | Last line of the file
────────────────────────────────────────────────────────────────

Statistics:
  Total lines: 6
  Non-empty lines: 5
  Empty lines: 1
  Total words: 26
  Total characters: 142
  Average words per line: 5.2
  Longest line: 36 characters (line 1)
  Shortest line: 20 characters (line 2)
```

```bash
./file_processor.sh logfile.txt --filter "ERROR"
```
```
╔════════════════════════════════════════════════════════════════╗
║         FILE PROCESSOR - Filter Mode                           ║
╚════════════════════════════════════════════════════════════════╝

Filtering for: "ERROR"
Source: logfile.txt

Matching lines:
────────────────────────────────────────────────────────────────
  12 | [2025-10-19 00:15:30] ERROR: Connection failed
  28 | [2025-10-19 00:45:12] ERROR: Timeout occurred
  53 | [2025-10-19 01:20:45] ERROR: Invalid input
────────────────────────────────────────────────────────────────

Summary:
  Total lines in file: 100
  Matching lines: 3
  Match percentage: 3%
```

```bash
./file_processor.sh code.txt --analyze
```
```
╔════════════════════════════════════════════════════════════════╗
║           FILE PROCESSOR - Analysis Mode                       ║
╚════════════════════════════════════════════════════════════════╝

Analyzing: code.txt

Line Analysis:
──────────────────────────────────────────
  Total lines: 150
  Code lines: 120
  Comment lines: 25
  Blank lines: 5

Word Frequency (Top 10):
──────────────────────────────────────────
  "function" - 45 occurrences
  "if" - 38 occurrences
  "echo" - 32 occurrences
  "then" - 28 occurrences
  "fi" - 28 occurrences
  "done" - 15 occurrences
  "while" - 12 occurrences
  "for" - 10 occurrences
  "case" - 8 occurrences
  "esac" - 8 occurrences

Character Distribution:
──────────────────────────────────────────
  Letters: 85%
  Numbers: 5%
  Spaces: 8%
  Special chars: 2%

Longest line: Line 47 (128 characters)
Shortest non-empty line: Line 23 (5 characters)
Average line length: 42.3 characters
```

```bash
./file_processor.sh document.txt --search "important"
```
```
╔════════════════════════════════════════════════════════════════╗
║          FILE PROCESSOR - Search Mode                          ║
╚════════════════════════════════════════════════════════════════╝

Searching for: "important"
File: document.txt

Results:
────────────────────────────────────────────────────────────────
  5 | This is an **important** detail to remember
 12 | Another **important** point about the topic
 18 | Most **important** of all is consistency
────────────────────────────────────────────────────────────────

Found in 3 locations
Context lines shown: ±0

To show context: ./file_processor.sh document.txt --search "important" -C 2
```

```bash
./file_processor.sh config.txt --transform uppercase
```
```
╔════════════════════════════════════════════════════════════════╗
║        FILE PROCESSOR - Transform Mode                         ║
╚════════════════════════════════════════════════════════════════╝

Transformation: Convert to UPPERCASE
Source: config.txt
Output: config_upper.txt

Processing...
████████████████████████████████████████ 100% (42/42 lines)

Original:
  host=localhost
  port=8080
  debug=true

Transformed:
  HOST=LOCALHOST
  PORT=8080
  DEBUG=TRUE

✓ Transformation complete
Output saved to: config_upper.txt
```
### Bonus Challenge:
- Add CSV/JSON parsing modes
- Implement diff between two files
- Add syntax highlighting for code files
- Support regex search with groups
- Create word cloud from frequency
- Add spell checking
- Generate summary/abstract
- Support compressed files (gzip)
- Add encryption/decryption
- Create Markdown to HTML converter

***
