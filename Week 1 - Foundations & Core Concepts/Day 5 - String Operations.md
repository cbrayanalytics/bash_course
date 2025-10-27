## String Concatenation
In Bash, strings can be concatenated simply by placing them next to each other:

```bash
first="Hello"
second="World"
result="$first $second"     # Hello World
result="${first}${second}"  # HelloWorld (no space)
```

**Concatenating with literals:**
```bash
name="John"
greeting="Hello, ${name}!"  # Hello, John!
```

## String Length
Use `${#variable}` to get the length of a string:

```bash
text="Hello World"
echo ${#text}  # Output: 11
```

## Substrings (String Slicing)

**Extract substring from position:**
```bash
text="Hello World"
echo ${text:0:5}   # Hello (start at 0, length 5)
echo ${text:6}     # World (start at 6, to end)
echo ${text:6:3}   # Wor (start at 6, length 3)
echo ${text: -5}   # World (last 5 characters, note the space)
```

## String Replacement

**Replace first occurrence:**
```bash
text="hello world hello"
echo ${text/hello/hi}  # hi world hello
```

**Replace all occurrences:**
```bash
text="hello world hello"
echo ${text//hello/hi}  # hi world hi
```

**Remove pattern (replace with nothing):**
```bash
filename="document.txt"
echo ${filename/.txt/}      # document (remove .txt)
echo ${filename/document/}  # .txt (remove document)
```

**Replace at beginning or end:**
```bash
text="hello world"
echo ${text/#hello/hi}   # hi world (# = beginning)
echo ${text/%world/you}  # hello you (% = end)
```

## Case Conversion

**Convert to uppercase:**
```bash
text="Hello World"
echo ${text^^}      # HELLO WORLD (all uppercase)
echo ${text^^[hw]}  # Hello World (only h and w)
```

**Convert to lowercase:**
```bash
text="Hello World"
echo ${text,,}      # hello world (all lowercase)
echo ${text,,[HW]}  # hello world (only H and W)
```

**Toggle first character:**
```bash
text="hello"
echo ${text^}   # Hello (first char to uppercase)

text="HELLO"
echo ${text,}   # hELLO (first char to lowercase)
```

## Remove Prefix/Suffix

**Remove shortest match from beginning:**
```bash
path="/home/user/document.txt"
echo ${path#*/}   # home/user/document.txt (remove shortest /)
```

**Remove longest match from beginning:**
```bash
path="/home/user/document.txt"
echo ${path##*/}  # document.txt (remove longest /, keeps filename)
```

**Remove shortest match from end:**
```bash
filename="archive.tar.gz"
echo ${filename%.*}   # archive.tar (remove shortest .extension)
```

**Remove longest match from end:**
```bash
filename="archive.tar.gz"
echo ${filename%%.*}  # archive (remove longest .extension)
```

## Practical Examples

**Extract filename and extension:**
```bash
fullpath="/home/user/documents/report.pdf"
filename=${fullpath##*/}        # report.pdf
basename=${filename%.*}         # report
extension=${filename##*.}       # pdf
directory=${fullpath%/*}        # /home/user/documents
```

***

**Exercise 1:** [[Extract Filename and Extension from Full Path]]
**Exercise 2:** [[Lowercase]]
**Exercise 3:** [[Replace Text Patterns Within Strings]]

**Daily Project:** [[Filename Sanitizer]]

