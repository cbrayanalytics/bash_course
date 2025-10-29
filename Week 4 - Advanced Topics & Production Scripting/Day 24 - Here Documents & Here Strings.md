### Here Documents (<<)
A here document allows you to pass multiple lines of text to a command or redirect to a file.

**Basic syntax:**
```bash
command <<DELIMITER
text line 1
text line 2
text line 3
DELIMITER
```

**Simple example:**
```bash
cat <<EOF
Hello, World!
This is a here document.
It spans multiple lines.
EOF
```

**Output:**
```
Hello, World!
This is a here document.
It spans multiple lines.
```
### Variable Substitution in Here Documents
**By default, variables are expanded:**
```bash
name="Alice"
age=30

cat <<EOF
Name: $name
Age: $age
Year: $(date +%Y)
EOF
```

**Output:**
```
Name: Alice
Age: 30
Year: 2025
```

**Prevent variable expansion (quote delimiter):**
```bash
name="Alice"

cat <<'EOF'
Name: $name
This will print literally: $name
EOF
```

**Output:**
```
Name: $name
This will print literally: $name
```

**Or escape with backslash:**
```bash
cat <<EOF
Expand: $name
Don't expand: \$name
EOF
```
### Redirecting to Files
**Write to file:**
```bash
cat <<EOF > config.txt
server=localhost
port=8080
debug=true
EOF
```

**Append to file:**
```bash
cat <<EOF >> config.txt
# Additional settings
timeout=30
EOF
```
### Indentation
**Problem: Leading tabs/spaces are included:**
```bash
if true; then
    cat <<EOF
    This line has leading spaces
    So does this one
EOF
fi
```

**Solution 1: Use <<- to strip leading tabs (not spaces):**
```bash
if true; then
	cat <<-EOF
		This line has leading tabs stripped
		So does this one
	EOF
fi
```

**Solution 2: Don't indent:**
```bash
if true; then
    cat <<EOF
No indentation here
But less readable
EOF
fi
```

**Solution 3: Use here string with printf:**
```bash
if true; then
    printf '%s\n' \
        "This line looks indented in code" \
        "But prints without indentation"
fi
```
### Here Strings (<<<)
Pass a string as input to a command:

**Basic syntax:**
```bash
command <<< "string"
```

**Examples:**
```bash
# Read a string
read name <<< "Alice"
echo $name  # Alice

# Count words in string
wc -w <<< "Hello World from Bash"  # 4

# Grep a string
grep "test" <<< "this is a test"  # this is a test
```

**With variables:**
```bash
data="apple,banana,cherry"
IFS=',' read -ra fruits <<< "$data"
echo "${fruits[1]}"  # banana
```
### Common Delimiters
You can use any word as a delimiter:
```bash
cat <<END
Using END as delimiter
END

cat <<HEREDOC
Using HEREDOC
HEREDOC

cat <<'STOP'
Using STOP with quotes
STOP
```

**Convention: Use EOF (End Of File) or similar descriptive names.**
### Practical Uses
**Create configuration file:**
```bash
server="localhost"
port="8080"

cat <<EOF > /etc/myapp/config.conf
[server]
host=$server
port=$port

[logging]
level=info
file=/var/log/myapp.log
EOF
```

**Generate SQL script:**
```bash
database="mydb"
table="users"

cat <<SQL
USE $database;
CREATE TABLE IF NOT EXISTS $table (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50),
    email VARCHAR(100)
);
SQL
```

**Multi-line echo:**
```bash
cat <<EOF
╔════════════════════════════╗
║     Welcome Message        ║
╚════════════════════════════╝

Hello, $USER!
Today is $(date +%A)
EOF
```

**Pass to pipe:**
```bash
cat <<EOF | grep "error"
info: system started
error: connection failed
warning: low memory
error: timeout
EOF
```
### Advanced Techniques
**Nested variable expansion:**
```bash
name="World"
cat <<EOF
Hello, $name!
Current directory: $(pwd)
Files: $(ls | wc -l)
EOF
```

**Command substitution:**
```bash
cat <<EOF
System Information:
Hostname: $(hostname)
Kernel: $(uname -r)
Uptime: $(uptime -p)
EOF
```

**Array expansion:**
```bash
servers=("web1" "web2" "web3")

cat <<EOF
Servers:
${servers[@]}
EOF
```

***

- [ ] **Exercise 1:** [[Generate Multi-Line Configuration File]]
- [ ] **Exercise 2:** [[Create Email Body with Variable Substitution]]
- [ ] **Exercise 3:** [[Pass Multi-Line Input to Commands]]
- [ ] **Daily Project:** [[HTML Report Generator]]