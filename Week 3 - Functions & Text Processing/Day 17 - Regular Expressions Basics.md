### What are Regular Expressions?
Regular expressions (regex or regexp) are patterns that describe sets of strings. They're used for searching, matching, and manipulating text based on patterns rather than exact strings.

**In Bash, regex can be used with:**
- `[[ ]]` test construct with `=~` operator (built-in)
- `grep` command for searching files
- `sed` for stream editing
- `awk` for text processing
### Using Regex in Bash with =~
The `=~` operator allows pattern matching within `[[ ]]`:

```bash
string="hello123"

if [[ $string =~ [0-9]+ ]]; then
    echo "Contains numbers"
fi
```

**Important:** The right side of `=~` is treated as a regex pattern, not a string.
### Basic Regex Syntax
**Literal characters** - Match themselves:
```bash
if [[ "hello" =~ hello ]]; then
    echo "Match!"
fi
```

**The dot `.` - Matches any single character:**
```bash
if [[ "cat" =~ c.t ]]; then  # Matches cat, cot, cut, c9t, etc.
    echo "Match!"
fi
```
### Character Classes (Bracket Expressions)
Character classes `[ ]` match any single character from a set:

**Basic character class:**
```bash
[[ "a" =~ [abc] ]]  # Matches a, b, or c
[[ "5" =~ [0-9] ]]  # Matches any digit
```

**Range notation:**
```bash
[a-z]     # Any lowercase letter
[A-Z]     # Any uppercase letter
[0-9]     # Any digit
[a-zA-Z]  # Any letter (upper or lower)
```

**Negation with `^` inside brackets:**
```bash
[^0-9]    # Any character that is NOT a digit
[^abc]    # Any character except a, b, or c
```

**POSIX character classes:**
```bash
[[:alpha:]]  # Any letter
[[:digit:]]  # Any digit (same as [0-9])
[[:alnum:]]  # Any alphanumeric character
[[:space:]]  # Any whitespace character
[[:upper:]]  # Any uppercase letter
[[:lower:]]  # Any lowercase letter
[[:punct:]]  # Any punctuation character
```

**Examples:**
```bash
# Match any digit
if [[ "abc123" =~ [0-9] ]]; then
    echo "Contains a digit"
fi

# Match vowel
if [[ "hello" =~ [aeiou] ]]; then
    echo "Contains a vowel"
fi

# Match non-digit
if [[ "abc" =~ [^0-9] ]]; then
    echo "Contains non-digit character"
fi
```
### Quantifiers
Quantifiers specify how many times a pattern should match:

**`*` - Zero or more times:**
```bash
[[ "helllo" =~ hel*o ]]     # Matches ho, helo, hello, helllo, etc.
[[ "color" =~ colou*r ]]    # Matches color, colour
```

**`+` - One or more times:**
```bash
[[ "hello" =~ hel+o ]]      # Matches helo, hello, helllo (not ho)
[[ "123" =~ [0-9]+ ]]       # Matches one or more digits
```

**`?` - Zero or one time (optional):**
```bash
[[ "color" =~ colou?r ]]    # Matches color or colour
[[ "http" =~ https? ]]      # Matches http or https
```

**`{n}` - Exactly n times:**
```bash
[[ "abc" =~ [a-z]{3} ]]     # Matches exactly 3 lowercase letters
[[ "12345" =~ [0-9]{5} ]]   # Matches exactly 5 digits
```

**`{n,}` - n or more times:**
```bash
[[ "hello" =~ [a-z]{3,} ]]  # Matches 3 or more lowercase letters
```

**`{n,m}` - Between n and m times:**
```bash
[[ "hello" =~ [a-z]{2,4} ]] # Matches 2 to 4 lowercase letters
```
### Anchors
Anchors match positions, not characters:

**`^` - Start of string:**
```bash
[[ "hello" =~ ^hel ]]       # true (starts with hel)
[[ "hello" =~ ^lo ]]        # false (doesn't start with lo)
```

**`$` - End of string:**
```bash
[[ "hello" =~ lo$ ]]        # true (ends with lo)
[[ "hello" =~ hel$ ]]       # false (doesn't end with hel)
```

**Combined anchors for exact match:**
```bash
[[ "hello" =~ ^hello$ ]]    # true (exact match)
[[ "hello world" =~ ^hello$ ]]  # false (not exact match)
```
### Grouping and Capturing
**Parentheses `( )` create capturing groups:**
```bash
string="http://example.com"

if [[ $string =~ ^(https?):// ]]; then
    protocol="${BASH_REMATCH[1]}"
    echo "Protocol: $protocol"  # Output: http
fi
```

**The `BASH_REMATCH` array:**
- `${BASH_REMATCH[0]}` - Entire matched string
- `${BASH_REMATCH[1]}` - First captured group
- `${BASH_REMATCH[2]}` - Second captured group, etc.

**Example with multiple groups:**
```bash
email="john.doe@example.com"

if [[ $email =~ ^([^@]+)@([^@]+)$ ]]; then
    username="${BASH_REMATCH[1]}"
    domain="${BASH_REMATCH[2]}"
    echo "Username: $username"  # john.doe
    echo "Domain: $domain"      # example.com
fi
```

### Alternation (OR)
**Use `|` for alternatives:**
```bash
[[ "cat" =~ cat|dog ]]      # Matches cat or dog
[[ "http" =~ http|https ]]  # Matches http or https
[[ "yes" =~ yes|y|Y ]]      # Matches yes, y, or Y
```

**With grouping:**
```bash
if [[ $url =~ ^(http|https)://([^/]+) ]]; then
    protocol="${BASH_REMATCH[1]}"
    domain="${BASH_REMATCH[2]}"
fi
```
### Escaping Special Characters
Special characters need to be escaped with backslash `\`:

```bash
# Special characters: . * + ? { } [ ] ( ) ^ $ | \

# Match a literal dot
[[ "file.txt" =~ \.txt ]]   # true

# Match literal parentheses
[[ "(hello)" =~ \(.*\) ]]   # true

# Match literal dollar sign
[[ "$100" =~ \$[0-9]+ ]]    # true
```
### Common Regex Patterns
**Email validation (simplified):**
```bash
email_regex='^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'

if [[ $email =~ $email_regex ]]; then
    echo "Valid email"
fi
```

**URL validation:**
```bash
url_regex='^(https?|ftp)://[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}(/.*)?$'

if [[ $url =~ $url_regex ]]; then
    echo "Valid URL"
fi
```

**IP address (IPv4):**
```bash
ip_regex='^([0-9]{1,3}\.){3}[0-9]{1,3}$'

if [[ $ip =~ $ip_regex ]]; then
    echo "Valid IP format"
fi
```

**Phone number (US format):**
```bash
phone_regex='^[0-9]{3}-[0-9]{3}-[0-9]{4}$'

if [[ $phone =~ $phone_regex ]]; then
    echo "Valid phone"
fi
```
### Practical Example
```bash
#!/bin/bash

# Parse log entry
log_line="2025-10-19 21:30:00 [ERROR] Connection failed (192.168.1.100)"

# Extract components
if [[ $log_line =~ ([0-9-]+)\ ([0-9:]+)\ \[([A-Z]+)\]\ (.*)\ \(([0-9.]+)\) ]]; then
    date="${BASH_REMATCH[1]}"
    time="${BASH_REMATCH[2]}"
    level="${BASH_REMATCH[3]}"
    message="${BASH_REMATCH[4]}"
    ip="${BASH_REMATCH[5]}"
    
    echo "Date: $date"
    echo "Time: $time"
    echo "Level: $level"
    echo "Message: $message"
    echo "IP: $ip"
fi
```

***

- [ ] **Exercise 1:** [[Match Email Pattern in String]]
- [ ] **Exercise 2:** [[Validate Phone Number Formats]]
- [ ] **Exercise 3:** [[Extract URLs from Text]]
- [ ] **Daily Project:** [[Log Parser]]
