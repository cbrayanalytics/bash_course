### What is Sed?
`sed` (Stream EDitor) is a powerful text processing tool that performs text transformations on an input stream (file or pipe). It processes text line by line, applying commands to each line.

**Basic syntax:**
```bash
sed 'command' file
sed -e 'command1' -e 'command2' file
```
### Substitution Command (s///)
The substitution command is the most commonly used sed operation.

**Basic syntax:**
```bash
s/pattern/replacement/flags
```

**Simple substitution (first occurrence on each line):**
```bash
sed 's/old/new/' file.txt
# Replaces first "old" with "new" on each line
```

**Example:**
```bash
echo "hello world hello" | sed 's/hello/hi/'
# Output: hi world hello (only first "hello" replaced)
```

**Global substitution (all occurrences):**
```bash
sed 's/old/new/g' file.txt
# g flag = global (all occurrences per line)
```

**Example:**
```bash
echo "hello world hello" | sed 's/hello/hi/g'
# Output: hi world hi (all "hello" replaced)
```
### Substitution Flags
**`g` - Global (all occurrences):**
```bash
sed 's/pattern/replacement/g' file.txt
```

**`i` - Case-insensitive:**
```bash
sed 's/error/ERROR/gi' file.txt
# Replaces error, Error, ERROR, ErRoR with ERROR
```

**`p` - Print matched lines:**
```bash
sed -n 's/pattern/replacement/p' file.txt
# Only prints lines where substitution occurred
```

**Numeric flag (replace Nth occurrence):**
```bash
sed 's/hello/hi/2' file.txt
# Replace only 2nd occurrence per line
```
### Delimiters
You can use different delimiters (useful when pattern contains `/`):
```bash
# Using | as delimiter
sed 's|/path/to/old|/path/to/new|g' file.txt

# Using # as delimiter
sed 's#/usr/local#/opt#g' file.txt

# Using : as delimiter
sed 's:/home/user:/home/newuser:g' file.txt
```
### Addressing (Selecting Lines)
Apply commands to specific lines or ranges:
**Single line number:**
```bash
sed '3s/old/new/' file.txt
# Substitute only on line 3
```

**Range of lines:**
```bash
sed '1,5s/old/new/' file.txt
# Lines 1 through 5

sed '10,$s/old/new/' file.txt
# Line 10 to end of file ($)
```

**Pattern matching:**
```bash
sed '/pattern/s/old/new/' file.txt
# Only lines containing "pattern"

sed '/^ERROR/s/ERROR/WARNING/' file.txt
# Lines starting with ERROR
```

**Negation (NOT matching):**
```bash
sed '/pattern/!s/old/new/' file.txt
# Lines NOT containing "pattern"
```

**Multiple addresses:**
```bash
sed '1,10s/old/new/; 20,30s/foo/bar/' file.txt
```
### Deletion Command (d)
Delete entire lines:
**Delete specific line:**
```bash
sed '3d' file.txt
# Delete line 3
```

**Delete range:**
```bash
sed '1,5d' file.txt
# Delete lines 1-5

sed '10,$d' file.txt
# Delete from line 10 to end
```

**Delete by pattern:**
```bash
sed '/pattern/d' file.txt
# Delete lines containing "pattern"

sed '/^#/d' file.txt
# Delete comment lines (starting with #)

sed '/^$/d' file.txt
# Delete empty lines
```

**Delete negation:**
```bash
sed '/pattern/!d' file.txt
# Delete lines NOT containing pattern
# (keeps only lines with pattern)
```
### In-Place Editing (-i)
Modify files directly (dangerous - creates no output):
**With backup:**
```bash
sed -i.bak 's/old/new/g' file.txt
# Creates file.txt.bak before modifying file.txt
```

**Without backup (RISKY!):**
```bash
sed -i 's/old/new/g' file.txt
# Modifies file directly, no backup
```

**macOS note:**
```bash
# macOS requires argument for -i (even if empty)
sed -i '' 's/old/new/g' file.txt  # No backup
sed -i '.backup' 's/old/new/g' file.txt  # With backup
```
### Special Characters and Escaping
**Literal dots:**
```bash
sed 's/\.txt/\.md/g' file.txt
# Escape . to match literal dot
```

**Variables in sed:**
```bash
old="hello"
new="hi"
sed "s/$old/$new/g" file.txt
# Use double quotes to expand variables
```

**Ampersand (&) - Matched string:**
```bash
sed 's/[0-9]\+/(&)/' file.txt
# Wraps numbers in parentheses
# 123 becomes (123)
```

**Backreferences:**
```bash
sed 's/\([a-z]\+\)-\([0-9]\+\)/\2-\1/' file.txt
# Swap word-number to number-word
# abc-123 becomes 123-abc
```
### Multiple Commands
**Using -e flag:**
```bash
sed -e 's/old/new/' -e 's/foo/bar/' file.txt
```

**Using semicolon:**
```bash
sed 's/old/new/; s/foo/bar/' file.txt
```

**Using newline (multi-line script):**
```bash
sed '
s/old/new/
s/foo/bar/
/pattern/d
' file.txt
```
### Advanced Operations
**Append text after line:**
```bash
sed '/pattern/a\New line to append' file.txt
```

**Insert text before line:**
```bash
sed '/pattern/i\New line to insert' file.txt
```

**Change (replace entire line):**
```bash
sed '/pattern/c\Replacement line' file.txt
```

**Print specific lines:**
```bash
sed -n '1,10p' file.txt
# Print lines 1-10 only (-n suppresses default output)
```

**Quit after pattern:**
```bash
sed '/pattern/q' file.txt
# Quit after first match
```
### Practical Examples
**Remove trailing whitespace:**
```bash
sed 's/[[:space:]]*$//' file.txt
```

**Remove comments and empty lines:**
```bash
sed '/^#/d; /^$/d' file.txt
```

**Add line numbers:**
```bash
sed = file.txt | sed 'N; s/\n/: /'
```

**Double-space a file:**
```bash
sed 'G' file.txt
```

**Convert Windows line endings to Unix:**
```bash
sed 's/\r$//' dos_file.txt > unix_file.txt
```

**Extract sections between patterns:**
```bash
sed -n '/START/,/END/p' file.txt
```

***

**Exercise 1:** [[Replace All Occurrences of Word in File]]
**Exercise 2:** [[Delete Lines Matching Pattern]]
**Exercise 3:** [[Edit Specific Line Ranges]]

**Daily Project:** [[Configuration File Updater]]

