### Goal:
Create a script named `heredoc_examples.sh` that demonstrates various uses of here documents and here strings for passing multi-line input to commands.
### Requirements:
- Examples with different commands (grep, awk, sed, etc.)
- Database queries (SQL, MongoDB)
- API requests (curl with JSON)
- Configuration updates
- Script generation
- Log analysis
- Data transformation
- Interactive command input
### Expected Output Example:
```bash
./heredoc_examples.sh
```
```
╔════════════════════════════════════════════════════════════════╗
║         HERE DOCUMENT EXAMPLES                                 ║
╚════════════════════════════════════════════════════════════════╝

[Example 1] Searching with grep
────────────────────────────────────────────────────────────────
grep -i "error" <<EOF
2025-10-20 INFO: System started
2025-10-20 ERROR: Connection failed
2025-10-20 WARN: Low memory
2025-10-20 ERROR: Timeout occurred
EOF

Result:
2025-10-20 ERROR: Connection failed
2025-10-20 ERROR: Timeout occurred

[Example 2] Processing with awk
────────────────────────────────────────────────────────────────
awk '{print $1, $NF}' <<DATA
alice 25 engineer
bob 30 manager
charlie 28 developer
DATA

Result:
alice engineer
bob manager
charlie developer

[Example 3] SQL Query
────────────────────────────────────────────────────────────────
mysql -u root -p mydb <<SQL
SELECT id, name, email
FROM users
WHERE status = 'active'
  AND created_at > '2025-01-01'
ORDER BY created_at DESC
LIMIT 10;
SQL

Result:
+----+-------------+----------------------+
| id | name        | email                |
+----+-------------+----------------------+
|  5 | Alice Smith | alice@example.com    |
|  7 | Bob Jones   | bob@example.com      |
+----+-------------+----------------------+

[Example 4] API Request with curl
────────────────────────────────────────────────────────────────
curl -X POST https://api.example.com/users \
  -H "Content-Type: application/json" \
  -d @- <<JSON
{
  "name": "John Doe",
  "email": "john@example.com",
  "age": 30,
  "address": {
    "city": "New York",
    "country": "USA"
  }
}
JSON

Result:
{"id": 123, "status": "created"}

[Example 5] Multi-line sed replacement
────────────────────────────────────────────────────────────────
sed 's/old/new/g' <<TEXT
This is old text
The old method
Replace old values
TEXT

Result:
This is new text
The new method
Replace new values

[Example 6] Python script from here document
────────────────────────────────────────────────────────────────
python3 <<PYTHON
data = [1, 2, 3, 4, 5]
squared = [x**2 for x in data]
print(f"Original: {data}")
print(f"Squared: {squared}")
print(f"Sum: {sum(squared)}")
PYTHON

Result:
Original: [1, 2, 3, 4, 5]
Squared: [1, 4, 9, 16, 25]
Sum: 55

[Example 7] Here string examples
────────────────────────────────────────────────────────────────
# Read a string
read name <<< "Alice"
echo "Name: $name"

# Process CSV
IFS=',' read -ra fields <<< "apple,banana,cherry"
echo "Second item: ${fields[1]}"

# Count words
wc -w <<< "Hello World from Bash"

Result:
Name: Alice
Second item: banana
4
```
### Bonus Challenge:
- Add Docker Compose generation
- Create Kubernetes manifest generator
- Generate Terraform configurations
- Support Ansible playbook creation
- Add GraphQL query examples
- Create test data generators
- Support multi-stage pipelines
- Add interactive tutorials

***