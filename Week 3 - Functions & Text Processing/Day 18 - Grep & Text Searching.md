### What is Grep?
`grep` (Global Regular Expression Print) is a command-line tool for searching text using patterns. It's one of the most powerful and commonly used tools in Unix/Linux.

**Basic syntax:**
```bash
grep [options] pattern [file...]
```
### Basic Grep Usage
**Search for a pattern in a file:**
```bash
grep "error" logfile.txt
```

**Search in multiple files:**
```bash
grep "error" file1.txt file2.txt file3.txt
```

**Search from stdin:**
```bash
echo "hello world" | grep "hello"
cat file.txt | grep "pattern"
```
### Essential Grep Options
**`-i` - Case-insensitive search:**
```bash
grep -i "error" logfile.txt
# Matches: error, Error, ERROR, ErRoR
```

**`-v` - Invert match (show lines that DON'T match):**
```bash
grep -v "debug" logfile.txt
# Shows all lines except those containing "debug"
```

**`-n` - Show line numbers:**
```bash
grep -n "error" logfile.txt
# Output: 15:error occurred at startup
```

**`-c` - Count matching lines:**
```bash
grep -c "error" logfile.txt
# Output: 42
```

**`-l` - List filenames with matches:**
```bash
grep -l "TODO" *.txt
# Output: file1.txt file3.txt
```

**`-L` - List filenames WITHOUT matches:**
```bash
grep -L "TODO" *.txt
# Output: file2.txt file4.txt
```

**`-w` - Match whole words only:**
```bash
grep -w "cat" file.txt
# Matches: "cat" but NOT "category" or "concatenate"
```

**`-x` - Match whole lines only:**
```bash
grep -x "error" file.txt
# Matches only lines that are exactly "error"
```

**`-q` - Quiet mode (exit code only, no output):**
```bash
if grep -q "error" logfile.txt; then
    echo "Errors found"
fi
```
### Context Options
**`-A N` - Show N lines After match:**
```bash
grep -A 3 "error" logfile.txt
# Shows the matching line plus 3 lines after it
```

**`-B N` - Show N lines Before match:**
```bash
grep -B 2 "error" logfile.txt
# Shows 2 lines before the match plus the matching line
```

**`-C N` - Show N lines of Context (before and after):**
```bash
grep -C 2 "error" logfile.txt
# Shows 2 lines before, the match, and 2 lines after
```

**Example output:**
```
15-Starting application
16-Loading configuration
17:ERROR: Configuration file not found
18-Using default configuration
19-Continuing startup
```
### Recursive Search
**`-r` or `-R` - Recursive search through directories:**
```bash
grep -r "TODO" /path/to/project
# Searches all files in directory and subdirectories
```

**`-r` with specific file types:**
```bash
grep -r --include="*.py" "import" .
# Only search Python files
```

**`--exclude` - Exclude files:**
```bash
grep -r --exclude="*.log" "error" .
# Search all files except .log files
```

**`--exclude-dir` - Exclude directories:**
```bash
grep -r --exclude-dir=node_modules "function" .
# Skip node_modules directory
```
### Extended Regular Expressions
**`-E` - Use extended regex (supports +, ?, |, etc.):**

Without `-E`:
```bash
# Must escape special characters
grep 'error\|warning' file.txt
grep '[0-9]\+' file.txt
```

With `-E`:
```bash
# More natural syntax
grep -E 'error|warning' file.txt
grep -E '[0-9]+' file.txt
```

**Extended regex features:**
```bash
# Alternation
grep -E 'cat|dog|bird' animals.txt

# One or more (+)
grep -E '[0-9]+' file.txt

# Zero or one (?)
grep -E 'colou?r' file.txt  # Matches color or colour

# Grouping
grep -E '(error|warning):' logfile.txt

# Word boundaries
grep -E '\b(start|end)\b' file.txt
```

**`-P` - Perl-compatible regex (PCRE):**
```bash
# Advanced features like lookahead/lookbehind
grep -P '(?<=@)\w+' emails.txt
# Matches domain after @
```
### Color and Highlighting
**`--color=auto` - Highlight matches:**
```bash
grep --color=auto "error" logfile.txt
# Highlights "error" in red (typically)
```

**Set as default in .bashrc:**
```bash
alias grep='grep --color=auto'
```
### Binary Files
**`-a` - Treat binary files as text:**
```bash
grep -a "pattern" binary_file
```

**`-I` - Skip binary files:**
```bash
grep -I "pattern" *
# Won't search binary files
```
### Combining Options
**Multiple options together:**
```bash
# Case-insensitive recursive search with line numbers
grep -rin "error" /var/log/

# Recursive search, show context, only .py files
grep -rC 2 --include="*.py" "def " .

# Invert match, show line numbers, quiet mode for scripting
grep -vnq "success" results.txt
```
### Practical Patterns
**Search for IP addresses:**
```bash
grep -E '\b([0-9]{1,3}\.){3}[0-9]{1,3}\b' logfile.txt
```

**Search for email addresses:**
```bash
grep -E '\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b' file.txt
```

**Search for URLs:**
```bash
grep -E 'https?://[^\s]+' file.txt
```

**Search for dates (YYYY-MM-DD):**
```bash
grep -E '[0-9]{4}-[0-9]{2}-[0-9]{2}' logfile.txt
```

**Find function definitions (various languages):**
```bash
# Python
grep -E '^def \w+' *.py

# JavaScript
grep -E 'function \w+|const \w+ = \(' *.js

# Bash
grep -E '^\w+\(\)' *.sh
```
### Performance Tips
**Use fixed strings when possible:**
```bash
grep -F "literal.string" file.txt
# -F treats pattern as fixed string (faster)
```

**Use file patterns to limit search:**
```bash
grep -r --include="*.log" "error" /var/log/
# Faster than searching all files
```

**Exclude large directories:**
```bash
grep -r --exclude-dir={node_modules,.git,vendor} "pattern" .
```
### Exit Codes
`grep` returns different exit codes:
- `0` - Match found
- `1` - No match found
- `2` - Error occurred

```bash
if grep -q "error" logfile.txt; then
    echo "Errors found"
    exit 1
fi
```
### Practical Examples
**Find all TODO comments in code:**
```bash
grep -rn "TODO" --include="*.py" --include="*.js" .
```

**Find errors in last 100 lines of log:**
```bash
tail -100 /var/log/syslog | grep -i error
```

**Count errors per file:**
```bash
grep -c "error" /var/log/*.log
```

**Find files containing a specific function:**
```bash
grep -rl "function_name" /path/to/code
```

**Search with multiple patterns:**
```bash
grep -E "error|warning|critical" logfile.txt
```

***

**Exercise 1:** [[Search Log Files for Error Messages]]
**Exercise 2:** [[Recursive Search Through Directory Tree]]
**Exercise 3:** [[Count Occurrences of Pattern Across Multiple Files]]

**Daily Project:** [[Code Search Tool]]