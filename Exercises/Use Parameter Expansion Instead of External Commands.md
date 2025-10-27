### Goal:
Create a script named `param_expansion_demo.sh` that demonstrates parameter expansion techniques replacing common external commands.
### Requirements:
- Show 20+ parameter expansion examples
- Compare with external command equivalents
- Demonstrate performance difference
- Include edge cases
- Create reference guide
- Interactive examples
- Practice exercises
- Speed comparison charts
### Expected Output Example:
```bash
./param_expansion_demo.sh
```
```
╔════════════════════════════════════════════════════════════════╗
║         PARAMETER EXPANSION REFERENCE                          ║
╚════════════════════════════════════════════════════════════════╝

[1] STRING LENGTH
════════════════════════════════════════════════════════════════
Old way:  length=$(echo -n "$string" | wc -c)
New way:  length=${#string}

Example:
  string="Hello World"
  ${#string} → 11

Speed: 3800x faster ⚡

────────────────────────────────────────────────────────────────

[2] SUBSTRING EXTRACTION
════════════════════════════════════════════════════════════════
Old way:  substr=$(echo "$string" | cut -c1-5)
New way:  substr=${string:0:5}

Syntax: ${string:position:length}

Examples:
  string="Hello World"
  ${string:0:5}  → "Hello"
  ${string:6}    → "World"
  ${string:6:2}  → "Wo"
  ${string: -5}  → "World" (note space before -)
  ${string: -5:3} → "Wor"

Speed: 4500x faster ⚡

────────────────────────────────────────────────────────────────

[3] REMOVE PREFIX (SHORTEST MATCH)
════════════════════════════════════════════════════════════════
Old way:  result=$(echo "$string" | sed 's/^prefix//')
New way:  result=${string#pattern}

Examples:
  path="/usr/local/bin/bash"
  ${path#*/}     → "usr/local/bin/bash"
  ${path#/*/}    → "local/bin/bash"

Use case: Remove path prefixes
  file="/path/to/file.txt"
  ${file##*/}    → "file.txt" (basename)

Speed: 4200x faster ⚡

────────────────────────────────────────────────────────────────

[4] REMOVE PREFIX (LONGEST MATCH)
════════════════════════════════════════════════════════════════
Syntax: ${string##pattern}

Examples:
  path="/usr/local/bin/bash"
  ${path##*/}    → "bash" (basename)
  
  url="https://example.com/path/page.html"
  ${url##*/}     → "page.html"

────────────────────────────────────────────────────────────────

[5] REMOVE SUFFIX (SHORTEST MATCH)
════════════════════════════════════════════════════════════════
Old way:  name=$(basename "$file" .txt)
New way:  name=${file%.txt}

Examples:
  file="document.tar.gz"
  ${file%.*}     → "document.tar"
  
  path="/etc/config.conf"
  ${path%/*}     → "/etc" (dirname)

Speed: 5400x faster ⚡

────────────────────────────────────────────────────────────────

[6] REMOVE SUFFIX (LONGEST MATCH)
════════════════════════════════════════════════════════════════
Syntax: ${string%%pattern}

Examples:
  file="document.tar.gz"
  ${file%%.*}    → "document"
  
  email="user@example.com"
  ${email%%@*}   → "user" (username part)

────────────────────────────────────────────────────────────────

[7] SEARCH AND REPLACE (FIRST OCCURRENCE)
════════════════════════════════════════════════════════════════
Old way:  result=$(echo "$string" | sed 's/old/new/')
New way:  result=${string/old/new}

Examples:
  text="hello world hello"
  ${text/hello/hi}  → "hi world hello"
  
  path="/old/path/old/file"
  ${path/old/new}   → "/new/path/old/file"

Speed: 4200x faster ⚡

────────────────────────────────────────────────────────────────

[8] SEARCH AND REPLACE (ALL OCCURRENCES)
════════════════════════════════════════════════════════════════
Old way:  result=$(echo "$string" | sed 's/old/new/g')
New way:  result=${string//old/new}

Examples:
  text="hello world hello"
  ${text//hello/hi}  → "hi world hi"
  
  spaces="a  b  c  d"
  ${spaces//  / }    → "a b c d" (remove extra spaces)

Speed: 4200x faster ⚡

────────────────────────────────────────────────────────────────

[9] REPLACE AT BEGINNING
════════════════════════════════════════════════════════════════
Syntax: ${string/#pattern/replacement}

Examples:
  path="/usr/local/bin"
  ${path/#\/usr/\/opt}  → "/opt/local/bin"
  
  url="http://example.com"
  ${url/#http/https}    → "https://example.com"

────────────────────────────────────────────────────────────────

[10] REPLACE AT END
════════════════════════════════════════════════════════════════
Syntax: ${string/%pattern/replacement}

Examples:
  file="document.txt"
  ${file/%.txt/.pdf}  → "document.pdf"
  
  sentence="Hello World."
  ${sentence/%./!}    → "Hello World!"

────────────────────────────────────────────────────────────────

[11] UPPERCASE CONVERSION (Bash 4+)
════════════════════════════════════════════════════════════════
Old way:  upper=$(echo "$string" | tr '[:lower:]' '[:upper:]')
New way:  upper=${string^^}

Examples:
  name="alice"
  ${name^^}           → "ALICE"
  
  text="Hello World"
  ${text^^}           → "HELLO WORLD"

Speed: 4100x faster ⚡

────────────────────────────────────────────────────────────────

[12] LOWERCASE CONVERSION (Bash 4+)
════════════════════════════════════════════════════════════════
Old way:  lower=$(echo "$STRING" | tr '[:upper:]' '[:lower:]')
New way:  lower=${STRING,,}

Examples:
  NAME="ALICE"
  ${NAME,,}           → "alice"
  
  TEXT="HELLO WORLD"
  ${TEXT,,}           → "hello world"

Speed: 4100x faster ⚡

────────────────────────────────────────────────────────────────

[13] CAPITALIZE FIRST LETTER
════════════════════════════════════════════════════════════════
Syntax: ${string^}

Examples:
  name="alice"
  ${name^}            → "Alice"
  
  sentence="hello world"
  ${sentence^}        → "Hello world"

────────────────────────────────────────────────────────────────

[14] CAPITALIZE EACH WORD
════════════════════════════════════════════════════════════════
Syntax: ${string^^pattern}

Examples:
  title="hello world from bash"
  ${title^^}          → "HELLO WORLD FROM BASH" (all caps)
  
  # For title case, need loop:
  words=($title)
  for word in "${words[@]}"; do
      echo -n "${word^} "
  done
  → "Hello World From Bash"

────────────────────────────────────────────────────────────────

[15] DEFAULT VALUES
════════════════════════════════════════════════════════════════
${var:-default}   Use default if var is unset or empty
${var:=default}   Set var to default if unset or empty
${var:?message}   Error with message if var is unset or empty
${var:+alternate} Use alternate if var is set

Examples:
  ${name:-"Guest"}        → "Guest" if name is empty
  ${PORT:=8080}           → Set PORT to 8080 if not set
  ${CONFIG:?No config}    → Error if CONFIG empty
  ${DEBUG:+--verbose}     → --verbose if DEBUG is set

────────────────────────────────────────────────────────────────

[16] REMOVE PATTERN
════════════════════════════════════════════════════════════════
Syntax: ${string//pattern}

Examples:
  text="a-b-c-d"
  ${text//-}          → "abcd" (remove hyphens)
  
  spaces="  hello  world  "
  ${spaces// }        → "helloworld" (remove all spaces)

────────────────────────────────────────────────────────────────

[17] ARRAY LENGTH
════════════════════════════════════════════════════════════════
Old way:  count=$(echo "${array[@]}" | wc -w)
New way:  count=${#array[@]}

Examples:
  fruits=("apple" "banana" "cherry")
  ${#fruits[@]}       → 3
  
  empty=()
  ${#empty[@]}        → 0

────────────────────────────────────────────────────────────────

[18] ARRAY ELEMENT LENGTH
════════════════════════════════════════════════════════════════
Syntax: ${#array[index]}

Examples:
  words=("hello" "world")
  ${#words[0]}        → 5 (length of "hello")
  ${#words[1]}        → 5 (length of "world")

────────────────────────────────────────────────────────────────

[19] ARRAY SLICING
════════════════════════════════════════════════════════════════
Syntax: ${array[@]:start:length}

Examples:
  numbers=(1 2 3 4 5 6 7 8 9 10)
  ${numbers[@]:0:3}   → 1 2 3
  ${numbers[@]:5}     → 6 7 8 9 10
  ${numbers[@]:3:4}   → 4 5 6 7

────────────────────────────────────────────────────────────────

[20] INDIRECT EXPANSION
════════════════════════════════════════════════════════════════
Syntax: ${!varname}

Examples:
  name="age"
  age=30
  ${!name}            → 30 (value of $age)
  
  # Useful for dynamic variable names
  for var in name age city; do
      echo "$var = ${!var}"
  done

╔════════════════════════════════════════════════════════════════╗
║                PERFORMANCE COMPARISON                          ║
╚════════════════════════════════════════════════════════════════╝

Test: 10,000 iterations of each operation

Operation               External Cmd    Param Expansion    Speedup
────────────────────────────────────────────────────────────────
String length           38.2s           0.01s              3820x ⚡
Substring extraction    45.1s           0.01s              4510x ⚡
Remove prefix           42.3s           0.01s              4230x ⚡
Remove suffix           54.2s           0.01s              5420x ⚡
Search/replace          42.1s           0.01s              4210x ⚡
Uppercase               41.2s           0.01s              4120x ⚡
Lowercase               41.3s           0.01s              4130x ⚡

Average speedup: 4348x faster ⚡⚡⚡

Memory usage:
  External commands: 234 MB peak
  Parameter expansion: 12 MB peak
  Reduction: 94.9%

╔════════════════════════════════════════════════════════════════╗
║                    QUICK REFERENCE                             ║
╚════════════════════════════════════════════════════════════════╝

${#var}              Length of $var
${var:pos:len}       Substring
${var#pattern}       Remove shortest prefix
${var##pattern}      Remove longest prefix
${var%pattern}       Remove shortest suffix
${var%%pattern}      Remove longest suffix
${var/old/new}       Replace first occurrence
${var//old/new}      Replace all occurrences
${var/#old/new}      Replace at beginning
${var/%old/new}      Replace at end
${var^^}             Uppercase (Bash 4+)
${var,,}             Lowercase (Bash 4+)
${var^}              Capitalize first letter
${var:-default}      Use default if empty
${var:=default}      Set default if empty
${var:?error}        Error if empty
${var:+alt}          Use alt if set

Save this reference: ./param_expansion_reference.txt
```
### Bonus Challenge:
- Add regex pattern examples
- Create interactive quiz
- Build cheat sheet generator
- Add performance profiler
- Create code converter (old → new)
- Support Bash version compatibility checks
- Add pattern matcher tool
- Create optimization linter

***