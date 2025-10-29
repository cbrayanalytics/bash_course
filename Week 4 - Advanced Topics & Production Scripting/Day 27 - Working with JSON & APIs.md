### curl Basics
`curl` is a command-line tool for transferring data using various protocols (HTTP, HTTPS, FTP, etc.).

**Simple GET request:**
```bash
curl https://api.example.com/data
```

**Common curl options:**
```bash
-X, --request METHOD      HTTP method (GET, POST, PUT, DELETE)
-H, --header HEADER       Add custom header
-d, --data DATA          Send data in POST request
-o, --output FILE        Write output to file
-s, --silent             Silent mode (no progress)
-i, --include            Include response headers
-v, --verbose            Verbose output (debugging)
-L, --location           Follow redirects
```

**GET request:**
```bash
curl https://api.github.com/users/octocat
```

**POST request:**
```bash
curl -X POST https://api.example.com/data \
     -H "Content-Type: application/json" \
     -d '{"name":"Alice","age":30}'
```

**PUT request:**
```bash
curl -X PUT https://api.example.com/data/123 \
     -H "Content-Type: application/json" \
     -d '{"name":"Bob"}'
```

**DELETE request:**
```bash
curl -X DELETE https://api.example.com/data/123
```
### API Authentication
**Bearer token:**
```bash
curl -H "Authorization: Bearer YOUR_TOKEN" \
     https://api.example.com/protected
```

**Basic authentication:**
```bash
curl -u username:password https://api.example.com/data

# Or
curl -H "Authorization: Basic $(echo -n user:pass | base64)" \
     https://api.example.com/data
```

**API key (query parameter):**
```bash
curl "https://api.example.com/data?api_key=YOUR_KEY"
```

**API key (header):**
```bash
curl -H "X-API-Key: YOUR_KEY" \
     https://api.example.com/data
```
### Introduction to jq
`jq` is a lightweight command-line JSON processor.

**Basic usage:**
```bash
echo '{"name":"Alice","age":30}' | jq '.'
```

**Pretty print JSON:**
```bash
curl -s https://api.github.com/users/octocat | jq '.'
```
### jq Basics
**Access field:**
```bash
echo '{"name":"Alice","age":30}' | jq '.name'
# Output: "Alice"
```

**Access nested field:**
```bash
echo '{"user":{"name":"Alice","age":30}}' | jq '.user.name'
# Output: "Alice"
```

**Access array element:**
```bash
echo '["apple","banana","cherry"]' | jq '.[0]'
# Output: "apple"
```

**Array length:**
```bash
echo '[1,2,3,4,5]' | jq 'length'
# Output: 5
```
### jq Filters
**Select specific fields:**
```bash
jq '.name, .age'
jq '{name: .name, age: .age}'
```

**Filter arrays:**
```bash
jq '.[] | select(.age > 25)'
```

**Map over arrays:**
```bash
jq '.users | map(.name)'
```

**Sort:**
```bash
jq 'sort_by(.age)'
```
### Working with Arrays
**Iterate array:**
```bash
echo '[{"name":"Alice"},{"name":"Bob"}]' | jq '.[]'
```

**Extract field from array:**
```bash
echo '[{"name":"Alice","age":30},{"name":"Bob","age":25}]' | jq '.[].name'
# Output:
# "Alice"
# "Bob"
```

**Filter array:**
```bash
jq '.[] | select(.age > 25)'
```
### jq Raw Output
**Remove quotes from strings:**
```bash
echo '{"name":"Alice"}' | jq -r '.name'
# Output: Alice (without quotes)
```
### Practical Examples
**Extract specific fields:**
```bash
curl -s https://api.github.com/users/octocat | jq '{login: .login, name: .name}'
```

**Count items:**
```bash
curl -s https://api.github.com/users/octocat/repos | jq 'length'
```

**Extract and format:**
```bash
curl -s https://api.github.com/users/octocat/repos | \
  jq -r '.[] | "\(.name): \(.stargazers_count) stars"'
```

***

- [ ] **Exercise 1:** [[Fetch and Parse JSON from Public API]]
- [ ] **Exercise 2:** [[Extract Specific Fields from Complex JSON]]
- [ ] **Exercise 3:** [[POST Data to API Endpoint]]
- [ ] **Daily Project:** [[Weather Reporting Tool]]

