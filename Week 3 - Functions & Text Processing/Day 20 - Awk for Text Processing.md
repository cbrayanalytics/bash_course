### What is Awk?
`awk` is a powerful text-processing language designed for pattern scanning and data extraction. It's particularly good at working with structured data (columns/fields).

**Basic syntax:**
```bash
awk 'pattern { action }' file
```
### Basic Awk Structure
**Print entire file:**
```bash
awk '{ print }' file.txt
# Same as: cat file.txt
```

**Print with action:**
```bash
awk '{ print "Line:", $0 }' file.txt
# $0 = entire line
```
### Field Processing
Awk automatically splits each line into fields (columns).

**Field variables:**
- `$0` - Entire line
- `$1` - First field
- `$2` - Second field
- `$3` - Third field
- `$NF` - Last field
- `$(NF-1)` - Second-to-last field

**Default field separator is whitespace:**
```bash
# Input: "John Doe 30"
awk '{ print $1 }' file.txt
# Output: John

awk '{ print $2 }' file.txt
# Output: Doe

awk '{ print $3 }' file.txt
# Output: 30
```

**Print multiple fields:**
```bash
awk '{ print $1, $3 }' file.txt
# Comma adds space between fields
```

**Concatenate fields:**
```bash
awk '{ print $1 $2 }' file.txt
# No space between fields

awk '{ print $1 "-" $2 }' file.txt
# Custom separator
```
### Field Separator (-F)
Change how awk splits fields:

**Colon separator:**
```bash
awk -F: '{ print $1, $3 }' /etc/passwd
# Username and UID from passwd file
```

**Comma separator (CSV):**
```bash
awk -F, '{ print $1, $3 }' data.csv
```

**Multiple character separator:**
```bash
awk -F'::' '{ print $1 }' file.txt
```

**Regex separator:**
```bash
awk -F'[,:]' '{ print $1 }' file.txt
# Split on comma OR colon
```

**Tab separator:**
```bash
awk -F'\t' '{ print $1 }' file.txt
```
### Patterns
Execute actions only when pattern matches:

**Pattern matching:**
```bash
awk '/pattern/ { print }' file.txt
# Print lines containing "pattern"

awk '/error/ { print $0 }' logfile.txt
# Print lines with "error"
```

**Regex patterns:**
```bash
awk '/^[0-9]/ { print }' file.txt
# Lines starting with digit

awk '/error|warning/ { print }' file.txt
# Lines with error OR warning
```

**Field matching:**
```bash
awk '$3 > 100 { print }' file.txt
# Lines where 3rd field > 100

awk '$1 == "John" { print }' file.txt
# Lines where 1st field equals "John"

awk '$2 ~ /^[A-Z]/ { print }' file.txt
# Lines where 2nd field starts with uppercase
```

**Comparison operators:**
- `==` - Equal
- `!=` - Not equal
- `>` - Greater than
- `<` - Less than
- `>=` - Greater than or equal
- `<=` - Less than or equal
- `~` - Matches regex
- `!~` - Doesn't match regex

**Logical operators:**
```bash
awk '$3 > 50 && $4 < 100 { print }' file.txt
# AND condition

awk '$1 == "John" || $1 == "Jane" { print }' file.txt
# OR condition

awk '$2 !~ /test/ { print }' file.txt
# NOT matching pattern
```
### Actions
**Print with formatting:**
```bash
awk '{ print "Name:", $1, "Age:", $2 }' file.txt
```

**Printf for formatted output:**
```bash
awk '{ printf "%-10s %5d\n", $1, $2 }' file.txt
# Left-aligned string (10 chars), right-aligned number (5 digits)
```

**Calculations:**
```bash
awk '{ print $1, $2 * 2 }' file.txt
# Multiply 2nd field by 2

awk '{ print $1, $2 + $3 }' file.txt
# Add 2nd and 3rd fields
```
### BEGIN and END Blocks
**BEGIN block - executes before processing any input:**
```bash
awk 'BEGIN { print "Starting processing..." }
     { print $0 }
     END { print "Processing complete" }' file.txt
```

**Common uses for BEGIN:**
```bash
# Set field separator
awk 'BEGIN { FS=":" } { print $1 }' /etc/passwd

# Print header
awk 'BEGIN { print "Name\tAge\tCity" } { print }' file.txt

# Initialize variables
awk 'BEGIN { total=0 } { total+=$1 } END { print total }' file.txt
```

**END block - executes after processing all input:**
```bash
awk '{ sum += $1 } END { print "Total:", sum }' numbers.txt
```
### Built-in Variables
**NF - Number of Fields:**
```bash
awk '{ print NF }' file.txt
# Print number of fields in each line

awk 'NF > 3 { print }' file.txt
# Print lines with more than 3 fields

awk '{ print $NF }' file.txt
# Print last field of each line
```

**NR - Number of Records (line number):**
```bash
awk '{ print NR, $0 }' file.txt
# Add line numbers

awk 'NR==5 { print }' file.txt
# Print only line 5

awk 'NR>=10 && NR<=20 { print }' file.txt
# Print lines 10-20
```

**FS - Field Separator (input):**
```bash
awk 'BEGIN { FS=":" } { print $1 }' file.txt
```

**OFS - Output Field Separator:**
```bash
awk 'BEGIN { OFS="|" } { print $1, $2, $3 }' file.txt
# Output fields separated by |
```

**RS - Record Separator (input, default newline):**
```bash
awk 'BEGIN { RS=";" } { print }' file.txt
# Split records on semicolon instead of newline
```

**ORS - Output Record Separator:**
```bash
awk 'BEGIN { ORS="\n\n" } { print }' file.txt
# Double-space output
```
### Variables and Calculations
**User-defined variables:**
```bash
awk '{ sum += $1; count++ } END { print sum/count }' numbers.txt
# Calculate average
```

**String concatenation:**
```bash
awk '{ full = $1 " " $2; print full }' file.txt
```

**Conditional assignments:**
```bash
awk '{ status = ($3 > 100) ? "high" : "low"; print $1, status }' file.txt
```
### Arrays
**Associative arrays:**
```bash
awk '{ count[$1]++ } END { for (key in count) print key, count[key] }' file.txt
# Count occurrences of each unique value in field 1
```
### Practical Examples
**Sum a column:**
```bash
awk '{ sum += $1 } END { print sum }' numbers.txt
```

**Average of column:**
```bash
awk '{ sum += $1; count++ } END { print sum/count }' numbers.txt
```

**Print lines longer than 80 characters:**
```bash
awk 'length($0) > 80' file.txt
```

**Print usernames from /etc/passwd:**
```bash
awk -F: '{ print $1 }' /etc/passwd
```

**Count lines:**
```bash
awk 'END { print NR }' file.txt
```

**Remove duplicate lines:**
```bash
awk '!seen[$0]++' file.txt
```

***

**Exercise 1:** [[Extract Specific Columns from CSV File]]
**Exercise 2:** [[Average of Numeric Column]]
**Exercise 3:** [[Filter Rows Based on Conditions]]

**Daily Project:** [[System Resource Analyzer]]


