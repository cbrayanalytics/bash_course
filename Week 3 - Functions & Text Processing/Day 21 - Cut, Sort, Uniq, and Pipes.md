### The Cut Command
`cut` extracts specific columns or characters from each line of a file.

**Cut by delimiter (fields):**
```bash
cut -d':' -f1 /etc/passwd
# -d: delimiter
# -f1: field 1 (first column)
```

**Multiple fields:**
```bash
cut -d':' -f1,3,5 /etc/passwd
# Extract fields 1, 3, and 5
```

**Field ranges:**
```bash
cut -d':' -f1-3 /etc/passwd
# Fields 1 through 3

cut -d':' -f3- /etc/passwd
# Field 3 to end

cut -d':' -f-3 /etc/passwd
# Start to field 3
```

**Character positions:**
```bash
cut -c1-5 file.txt
# Characters 1-5 from each line

cut -c1,5,10 file.txt
# Characters at positions 1, 5, and 10

cut -c-10 file.txt
# First 10 characters
```

**Tab-delimited (default):**
```bash
cut -f1,3 file.txt
# Default delimiter is tab
```

**Output delimiter:**
```bash
cut -d':' -f1,3 --output-delimiter=',' /etc/passwd
# Change output separator
```
### The Sort Command
`sort` arranges lines in sorted order.

**Basic alphabetical sort:**
```bash
sort file.txt
# Ascending alphabetical order
```

**Reverse sort:**
```bash
sort -r file.txt
# Descending order
```

**Numeric sort:**
```bash
sort -n numbers.txt
# Sort numerically (not alphabetically)
# Without -n: 1, 10, 2, 20
# With -n: 1, 2, 10, 20
```

**Sort by specific column:**
```bash
sort -k2 file.txt
# Sort by 2nd field (default whitespace delimiter)

sort -t':' -k3 -n /etc/passwd
# -t: delimiter
# -k3: sort by field 3
# -n: numeric sort
```

**Multiple sort keys:**
```bash
sort -k2,2 -k3,3n file.txt
# First by field 2 (string), then by field 3 (numeric)
```

**Case-insensitive sort:**
```bash
sort -f file.txt
# Ignore case
```

**Unique sort (remove duplicates):**
```bash
sort -u file.txt
# Same as: sort file.txt | uniq
```

**Sort by month:**
```bash
sort -M file.txt
# Jan, Feb, Mar, etc.
```

**Sort by human-readable numbers:**
```bash
sort -h file.txt
# Understands K, M, G suffixes (1K, 2M, 3G)
```

**Check if sorted:**
```bash
sort -c file.txt
# Exit with error if not sorted
```

**Reverse field order:**
```bash
sort -k3,3 -k1,1 file.txt
# Sort by field 3, then field 1
```
### The Uniq Command
`uniq` filters out repeated adjacent lines (requires sorted input).

**Remove duplicate lines:**
```bash
sort file.txt | uniq
# Must sort first!
```

**Count occurrences:**
```bash
sort file.txt | uniq -c
# Shows count of each unique line
```

**Show only duplicates:**
```bash
sort file.txt | uniq -d
# Lines that appear more than once
```

**Show only unique lines (no duplicates):**
```bash
sort file.txt | uniq -u
# Lines that appear exactly once
```

**Case-insensitive:**
```bash
sort file.txt | uniq -i
# Treat Hello and hello as same
```

**Compare specific fields:**
```bash
sort file.txt | uniq -f1
# Skip first field when comparing
```

**Compare specific characters:**
```bash
sort file.txt | uniq -s5
# Skip first 5 characters
```

**Show duplicate count with reverse sort:**
```bash
sort file.txt | uniq -c | sort -rn
# Most frequent items first
```
### Pipe Chaining
Combine commands by piping output of one to input of another.

**Basic pipeline:**
```bash
cat file.txt | grep "error" | sort | uniq
# Find errors, sort, remove duplicates
```

**Extract and count:**
```bash
cut -d':' -f1 /etc/passwd | sort | uniq -c
# Count users per username
```

**Top 10 pattern:**
```bash
command | sort | uniq -c | sort -rn | head -10
# Find top 10 most frequent items
```
### Practical Examples
**Find unique IP addresses in log:**
```bash
awk '{print $1}' access.log | sort | uniq
```

**Count most common words:**
```bash
tr ' ' '\n' < file.txt | sort | uniq -c | sort -rn | head -10
```

**Extract usernames and shells:**
```bash
cut -d':' -f1,7 /etc/passwd | sort -t':' -k2
```

**Find duplicate lines:**
```bash
sort file.txt | uniq -d
```

***

- [ ] **Exercise 1:** [[Extract and Sort Unique Usernames from etc passwd]]
- [ ] **Exercise 2:** [[Pipeline to Find Top 10 Most Common Words]]
- [ ] **Exercise 3:** [[Complex Pipeline Combining Multiple Tools]]
- [ ] **Daily Project:** [[Web Server Log Analyzer]]
