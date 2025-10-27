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

## Exercise 1: Fetch and Parse JSON from Public API

### Goal:
Create a script named `api_fetcher.sh` that fetches data from public APIs and parses the JSON response.

### Requirements:
- Fetch data from multiple public APIs
- Parse JSON responses
- Extract specific fields
- Handle API errors
- Display formatted output
- Cache responses
- Support multiple data formats
- Rate limiting awareness

### Expected Output Example:

```bash
./api_fetcher.sh --api github --user octocat
```
```
╔════════════════════════════════════════════════════════════════╗
║              API FETCHER                                       ║
║              GitHub User Information                           ║
╚════════════════════════════════════════════════════════════════╝

[INFO] Fetching data from GitHub API...
[INFO] Endpoint: https://api.github.com/users/octocat

Making API Request:
────────────────────────────────────────────────────────────────
Method: GET
URL: https://api.github.com/users/octocat
Headers:
  Accept: application/json
  User-Agent: api-fetcher/1.0

[INFO] Request sent... ⏳
[INFO] Response received ✓

Response Status:
────────────────────────────────────────────────────────────────
HTTP/1.1 200 OK
Content-Type: application/json
X-RateLimit-Limit: 60
X-RateLimit-Remaining: 59

[INFO] Parsing JSON response...

╔════════════════════════════════════════════════════════════════╗
║              USER INFORMATION                                  ║
╚════════════════════════════════════════════════════════════════╝

Profile:
────────────────────────────────────────────────────────────────
Username:        octocat
Name:            The Octocat
Type:            User
Company:         @github
Location:        San Francisco
Bio:             
Created:         2011-01-25T18:44:36Z
Updated:         2025-10-19T12:34:56Z

Statistics:
────────────────────────────────────────────────────────────────
Public Repos:    8
Public Gists:    8
Followers:       12,345
Following:       9

Links:
────────────────────────────────────────────────────────────────
Profile:         https://github.com/octocat
Avatar:          https://avatars.githubusercontent.com/u/583231?v=4
Website:         https://github.blog

Recent Activity:
────────────────────────────────────────────────────────────────
[INFO] Fetching recent repositories...

Top Repositories:
────────────────────────────────────────────────────────────────
1. Hello-World
   ⭐ 2,345 stars | 🍴 1,234 forks
   Language: JavaScript
   https://github.com/octocat/Hello-World

2. Spoon-Knife
   ⭐ 12,345 stars | 🍴 145,678 forks
   Language: HTML
   https://github.com/octocat/Spoon-Knife

3. octocat.github.io
   ⭐ 234 stars | 🍴 123 forks
   Language: CSS
   https://github.com/octocat/octocat.github.io

API Rate Limit:
────────────────────────────────────────────────────────────────
Limit:           60 requests/hour
Remaining:       59
Reset:           2025-10-20 01:16:00

[INFO] Data cached to: cache/github_octocat.json
[INFO] Cache expires: 2025-10-20 00:36:00 (15 minutes)
```

```bash
./api_fetcher.sh --api coinbase --crypto BTC
```
```
╔════════════════════════════════════════════════════════════════╗
║              CRYPTOCURRENCY PRICE                              ║
╚════════════════════════════════════════════════════════════════╝

[INFO] Fetching Bitcoin price from Coinbase API...

Bitcoin (BTC):
────────────────────────────────────────────────────────────────
Current Price:   $67,234.56 USD
24h Change:      +$1,234.56 (+1.87%) 📈
24h High:        $68,123.45
24h Low:         $66,012.34
24h Volume:      $45.2B

Market Data:
────────────────────────────────────────────────────────────────
Market Cap:      $1.32T
Circulating:     19.5M BTC
Max Supply:      21M BTC

Last Updated:    2025-10-20 00:21:00 MDT
```

```bash
./api_fetcher.sh --api ipinfo
```
```
╔════════════════════════════════════════════════════════════════╗
║              IP GEOLOCATION INFO                               ║
╚════════════════════════════════════════════════════════════════╝

Your IP Information:
────────────────────────────────────────────────────────────────
IP Address:      203.0.113.42
Hostname:        example.isp.com
City:            Denver
Region:          Colorado
Country:         United States (US)
Coordinates:     39.7392° N, 104.9903° W
Timezone:        America/Denver (MDT)
ISP:             Example ISP
Organization:    Example Org
```

### Bonus Challenge:
- Add response caching with TTL
- Implement retry logic with backoff
- Support multiple output formats (JSON, CSV, table)
- Add API response validation
- Create API wrapper functions
- Support pagination
- Add request queuing
- Implement API monitoring

***

## Exercise 2: Extract Specific Fields from Complex JSON

### Goal:
Create a script named `json_parser.sh` that extracts and transforms data from complex nested JSON structures.

### Requirements:
- Parse deeply nested JSON
- Extract arrays and objects
- Filter based on conditions
- Transform data structure
- Handle missing fields gracefully
- Support multiple queries
- Output in various formats
- Create summary reports

### Expected Output Example:

```bash
./json_parser.sh --file complex.json --query '.users[] | select(.age > 25) | {name, email}'
```
```
╔════════════════════════════════════════════════════════════════╗
║              JSON PARSER & EXTRACTOR                           ║
╚════════════════════════════════════════════════════════════════╝

Input File: complex.json
Query: .users[] | select(.age > 25) | {name, email}

[INFO] Parsing JSON structure...

JSON Structure Analysis:
────────────────────────────────────────────────────────────────
Root type:       Object
Total keys:      5
Nested levels:   4
Array count:     3
Total objects:   47

[INFO] Applying query filter...

Results Found: 12 records
────────────────────────────────────────────────────────────────

Record 1:
{
  "name": "Alice Johnson",
  "email": "alice@example.com"
}

Record 2:
{
  "name": "Bob Smith",
  "email": "bob@example.com"
}

Record 3:
{
  "name": "Charlie Brown",
  "email": "charlie@example.com"
}

[... 9 more records]

Summary:
────────────────────────────────────────────────────────────────
Total records found: 12
Query execution time: 0.023s
Output format: JSON
```

```bash
./json_parser.sh --file api_response.json --extract-paths
```
```
╔════════════════════════════════════════════════════════════════╗
║              JSON PATH EXTRACTOR                               ║
╚════════════════════════════════════════════════════════════════╝

Analyzing JSON structure...

All Available Paths:
════════════════════════════════════════════════════════════════

Top-level fields:
────────────────────────────────────────────────────────────────
.status              → "success" (string)
.data                → {...} (object)
.metadata            → {...} (object)
.timestamp           → 1697750000 (number)

Data fields (.data):
────────────────────────────────────────────────────────────────
.data.users          → [...] (array of 47 objects)
.data.count          → 47 (number)
.data.page           → 1 (number)

User fields (.data.users[]):
────────────────────────────────────────────────────────────────
.data.users[].id     → (number)
.data.users[].name   → (string)
.data.users[].email  → (string)
.data.users[].age    → (number)
.data.users[].address → {...} (object)

Address fields (.data.users[].address):
────────────────────────────────────────────────────────────────
.data.users[].address.street  → (string)
.data.users[].address.city    → (string)
.data.users[].address.state   → (string)
.data.users[].address.zip     → (string)

Metadata fields (.metadata):
────────────────────────────────────────────────────────────────
.metadata.version    → "2.0" (string)
.metadata.generated  → "2025-10-20T00:21:00Z" (string)

Common Query Examples:
════════════════════════════════════════════════════════════════

Get all user names:
  jq '.data.users[].name' api_response.json

Get users in Colorado:
  jq '.data.users[] | select(.address.state == "Colorado")' api_response.json

Get name and email of users over 25:
  jq '.data.users[] | select(.age > 25) | {name, email}' api_response.json

Count users:
  jq '.data.users | length' api_response.json

Get cities (unique):
  jq '[.data.users[].address.city] | unique' api_response.json
```

```bash
./json_parser.sh --file data.json --transform table
```
```
╔════════════════════════════════════════════════════════════════╗
║              JSON TO TABLE CONVERTER                           ║
╚════════════════════════════════════════════════════════════════╝

Converting JSON to table format...

Users Table:
════════════════════════════════════════════════════════════════

┌─────┬──────────────────┬────────────────────────┬─────┬─────────────┐
│ ID  │ Name             │ Email                  │ Age │ City        │
├─────┼──────────────────┼────────────────────────┼─────┼─────────────┤
│ 001 │ Alice Johnson    │ alice@example.com      │ 30  │ Denver      │
│ 002 │ Bob Smith        │ bob@example.com        │ 28  │ Boulder     │
│ 003 │ Charlie Brown    │ charlie@example.com    │ 35  │ Aurora      │
│ 004 │ Diana Prince     │ diana@example.com      │ 27  │ Denver      │
│ 005 │ Edward Norton    │ edward@example.com     │ 42  │ Fort Collins│
└─────┴──────────────────┴────────────────────────┴─────┴─────────────┘

Statistics:
────────────────────────────────────────────────────────────────
Total records: 5
Average age: 32.4 years
Cities: 4 unique
```

### Bonus Challenge:
- Add JSON schema validation
- Implement JSON diff
- Support JSONPath expressions
- Add JSON merge functionality
- Create JSON to CSV converter
- Support jq scripting files
- Add JSON pretty printer with colors
- Implement JSON flattening/unflattening

***

## Exercise 3: POST Data to API Endpoint

### Goal:
Create a script named `api_post.sh` that sends POST requests to APIs with various data formats and authentication methods.

### Requirements:
- Send JSON data via POST
- Support form data
- Handle file uploads
- Various authentication methods
- Parse response
- Error handling
- Retry logic
- Request/response logging

### Expected Output Example:

```bash
./api_post.sh --url https://api.example.com/users --data '{"name":"Alice","email":"alice@example.com"}'
```
```
╔════════════════════════════════════════════════════════════════╗
║              API POST REQUEST                                  ║
╚════════════════════════════════════════════════════════════════╝

Request Configuration:
────────────────────────────────────────────────────────────────
Method:          POST
URL:             https://api.example.com/users
Content-Type:    application/json
Authentication:  None

Request Body:
────────────────────────────────────────────────────────────────
{
  "name": "Alice",
  "email": "alice@example.com"
}

[INFO] Sending request...

Request Details:
────────────────────────────────────────────────────────────────
curl -X POST \
  https://api.example.com/users \
  -H "Content-Type: application/json" \
  -d '{"name":"Alice","email":"alice@example.com"}'

[INFO] Response received ✓

Response:
════════════════════════════════════════════════════════════════

Status Code: 201 Created
Response Time: 234ms

Response Headers:
────────────────────────────────────────────────────────────────
Content-Type: application/json
Location: https://api.example.com/users/12345
X-Request-ID: abc123def456

Response Body:
────────────────────────────────────────────────────────────────
{
  "id": 12345,
  "name": "Alice",
  "email": "alice@example.com",
  "created_at": "2025-10-20T00:21:00Z",
  "status": "active"
}

╔════════════════════════════════════════════════════════════════╗
║              REQUEST SUCCESSFUL                                ║
╚════════════════════════════════════════════════════════════════╝

Summary:
────────────────────────────────────────────────────────────────
✓ User created successfully
✓ User ID: 12345
✓ Location: https://api.example.com/users/12345

Request logged to: logs/api_requests.log
```

```bash
./api_post.sh --url https://api.example.com/upload --file document.pdf --auth-token ABC123
```
```
╔════════════════════════════════════════════════════════════════╗
║              FILE UPLOAD REQUEST                               ║
╚════════════════════════════════════════════════════════════════╝

Upload Configuration:
────────────────────────────────────────────────────────────────
File:            document.pdf
Size:            2.3 MB
URL:             https://api.example.com/upload
Authentication:  Bearer Token (provided)

[INFO] Validating file...
✓ File exists
✓ File readable
✓ File size acceptable

[INFO] Uploading file...

Upload Progress:
████████████████████████████████████████ 100% (2.3 MB / 2.3 MB)

[INFO] Upload complete ✓

Response:
════════════════════════════════════════════════════════════════

Status Code: 200 OK
Upload Time: 3.2 seconds
Speed: 718 KB/s

Response Body:
────────────────────────────────────────────────────────────────
{
  "file_id": "file_abc123",
  "filename": "document.pdf",
  "size": 2415919,
  "mime_type": "application/pdf",
  "uploaded_at": "2025-10-20T00:21:15Z",
  "url": "https://cdn.example.com/files/file_abc123"
}

✓ File uploaded successfully
✓ File ID: file_abc123
✓ Access URL: https://cdn.example.com/files/file_abc123
```

### Bonus Challenge:
- Add multipart form data support
- Implement request signing
- Support OAuth authentication
- Add request templating
- Create request builder
- Support webhooks
- Add response validation
- Implement request mocking

***

## Daily Project: Weather Reporting Tool

### Goal:
Build a comprehensive weather reporting tool named `weather.sh` that fetches data from weather APIs and displays beautifully formatted forecasts.

### Requirements:

**Core Features:**
- Current weather conditions
- 7-day forecast
- Hourly forecast
- Weather alerts
- Multiple location support
- Temperature units (F/C)
- Wind speed units
- UV index
- Air quality

**Data Sources:**
- OpenWeatherMap API
- WeatherAPI
- National Weather Service
- Multiple API fallback

**Display Options:**
- Terminal output (formatted)
- ASCII weather icons
- Color-coded temperatures
- Charts and graphs
- Export to file

### Expected Output Example:

```bash
./weather.sh --location "Denver, CO"
```

```
╔════════════════════════════════════════════════════════════════╗
║              WEATHER REPORT                                    ║
║              Denver, Colorado                                  ║
╚════════════════════════════════════════════════════════════════╝

[INFO] Fetching weather data...
[INFO] API: OpenWeatherMap
[INFO] Location: Denver, CO (39.7392°N, 104.9903°W)

Current Conditions
════════════════════════════════════════════════════════════════
Updated: Monday, October 20, 2025, 12:21 AM MDT

    \   /     Partly Cloudy
     .-.      🌡️  Temperature:  52°F (11°C)
  ― (   ) ―   🌡️  Feels Like:   48°F (9°C)
     `-'      💧 Humidity:     45%
    /   \     💨 Wind:         8 mph NW
              🌧️  Precipitation: 0%
              👁️  Visibility:   10 mi
              🔆 UV Index:     0 (Low)
              🌅 Sunrise:      6:54 AM
              🌇 Sunset:       6:32 PM

Weather: Partly cloudy skies. Comfortable temperatures.

Air Quality: Good (AQI: 42)
────────────────────────────────────────────────────────────────
PM2.5: 10 μg/m³ | PM10: 15 μg/m³ | O₃: 25 ppb

7-Day Forecast
════════════════════════════════════════════════════════════════

Mon 10/20    \  /       Partly Cloudy      ⬆️ 68°F  ⬇️ 45°F   💧 10%
             ― ○ ―      Clear evening      💨 5-10 mph

Tue 10/21      ☀️        Sunny             ⬆️ 72°F  ⬇️ 48°F   💧 0%
                        Perfect day!       💨 3-8 mph

Wed 10/22    \ | /      Mostly Sunny       ⬆️ 70°F  ⬇️ 50°F   💧 5%
              ―○―       Mild weather       💨 5-12 mph
              / | \

Thu 10/23      ☁️        Cloudy            ⬆️ 65°F  ⬇️ 48°F   💧 20%
                        Overcast skies     💨 8-15 mph

Fri 10/24     ⛈️        Thunderstorms     ⬆️ 62°F  ⬇️ 45°F   💧 80%
              ⚡ 🌧️      Heavy rain         💨 10-20 mph
                        ⚠️  Severe weather alert

Sat 10/25    🌧️ 🌧️      Rain              ⬆️ 58°F  ⬇️ 42°F   💧 70%
                        Rainy day          💨 8-15 mph

Sun 10/26    \  /       Partly Cloudy      ⬆️ 64°F  ⬇️ 44°F   💧 30%
             ― ○ ―      Clearing up        💨 5-10 mph

Hourly Forecast (Next 24 Hours)
════════════════════════════════════════════════════════════════

Time        Temp    Condition       Rain    Wind
────────────────────────────────────────────────────────────────
01:00 AM    52°F    Partly Cloudy   0%      8 mph NW
02:00 AM    51°F    Partly Cloudy   0%      7 mph NW
03:00 AM    50°F    Partly Cloudy   0%      6 mph NW
04:00 AM    49°F    Mostly Clear    0%      5 mph NW
05:00 AM    48°F    Clear           0%      5 mph NW
06:00 AM    47°F    Clear           0%      4 mph W
07:00 AM    48°F    Clear           0%      4 mph W
08:00 AM    52°F    Sunny           0%      5 mph W
09:00 AM    56°F    Sunny           0%      6 mph W
10:00 AM    60°F    Sunny           0%      7 mph W
11:00 AM    64°F    Sunny           0%      8 mph W
12:00 PM    67°F    Sunny           0%      9 mph W
[... continues for 24 hours]

Temperature Trend (Next 24 Hours)
════════════════════════════════════════════════════════════════

70°F ┤                            ╭╮
65°F ┤                        ╭───╯╰─╮
60°F ┤                   ╭────╯      ╰─╮
55°F ┤              ╭────╯              ╰─╮
50°F ┤         ╭────╯                     ╰──╮
45°F ┤    ╭────╯                             ╰───
40°F ┼────╯
     └┬──┬──┬──┬──┬──┬──┬──┬──┬──┬──┬──┬──┬──┬
      12A 4A 8A 12P 4P 8P 12A 4A 8A 12P

Weather Alerts
════════════════════════════════════════════════════════════════

⚠️  SEVERE WEATHER ALERT

Thunderstorm Watch
────────────────────────────────────────────────────────────────
Issued:    Oct 19, 2025 10:00 PM MDT
Expires:   Oct 20, 2025 6:00 AM MDT
Severity:  Moderate
Area:      Denver Metro Area

Description:
Scattered thunderstorms expected late Thursday evening through
Friday morning. Some storms may be severe with heavy rain, gusty
winds up to 40 mph, and small hail. Localized flooding possible.

Recommended Actions:
  • Monitor weather conditions
  • Secure outdoor items
  • Avoid unnecessary travel Thursday evening
  • Have emergency kit ready

Additional Information
════════════════════════════════════════════════════════════════

Location Details:
────────────────────────────────────────────────────────────────
City:            Denver
State:           Colorado
Country:         United States
Coordinates:     39.7392°N, 104.9903°W
Elevation:       5,280 ft (1,609 m)
Timezone:        America/Denver (MDT, UTC-6)
Population:      ~715,000

Climate:
────────────────────────────────────────────────────────────────
Type:            Semi-arid
Annual Rainfall: ~15 inches
Annual Snowfall: ~60 inches
Avg High:        64°F (18°C)
Avg Low:         37°F (3°C)

Records:
────────────────────────────────────────────────────────────────
Highest Temp:    105°F (Aug 8, 1878)
Lowest Temp:     -29°F (Jan 9, 1875)
Most Rain (24h): 4.5 inches (May 28, 2002)
Most Snow (24h): 23.8 inches (Mar 23, 2003)

╔════════════════════════════════════════════════════════════════╗
║                    WEATHER SUMMARY                             ║
╚════════════════════════════════════════════════════════════════╝

Today:  Partly cloudy with temperatures in the mid-60s. Light 
        winds from the northwest. Good conditions for outdoor 
        activities.

Tonight: Clear skies with temperatures dropping to the mid-40s.
         Light winds. Comfortable evening.

Tomorrow: Sunny and pleasant with highs near 72°F. Perfect 
          weather for outdoor plans.

Week Outlook: Generally mild with a storm system moving in 
              Thursday night into Friday. Heavy rain and 
              thunderstorms expected. Clearing by the weekend.

Best Days This Week: Tuesday, Wednesday (Sunny, 70-72°F)
Worst Day: Friday (Thunderstorms, 80% rain chance)

────────────────────────────────────────────────────────────────
Data source: OpenWeatherMap
Last updated: 2025-10-20 00:21:00 MDT
Next update: 2025-10-20 01:21:00 MDT

Save this report: ./weather.sh --location "Denver" --save
Set location default: ./weather.sh --set-default "Denver"
Check different location: ./weather.sh --location "Boulder"
```

```bash
./weather.sh --location "Denver" --forecast hourly --hours 12
```

```
╔════════════════════════════════════════════════════════════════╗
║              12-HOUR FORECAST - Denver, CO                     ║
╚════════════════════════════════════════════════════════════════╝

Monday, October 20, 2025

Hour      Temp    Feels  Condition      Rain   Wind    Humidity
────────────────────────────────────────────────────────────────
01:00 AM  52°F    48°F   Partly Cloudy  0%     8 mph   45%  🌙
02:00 AM  51°F    47°F   Partly Cloudy  0%     7 mph   46%  🌙
03:00 AM  50°F    46°F   Partly Cloudy  0%     6 mph   48%  🌙
04:00 AM  49°F    45°F   Mostly Clear   0%     5 mph   50%  🌙
05:00 AM  48°F    44°F   Clear          0%     5 mph   52%  🌙
06:00 AM  47°F    43°F   Clear          0%     4 mph   54%  🌙
07:00 AM  48°F    45°F   Clear          0%     4 mph   52%  🌅
08:00 AM  52°F    49°F   Sunny          0%     5 mph   48%  ☀️
09:00 AM  56°F    54°F   Sunny          0%     6 mph   42%  ☀️
10:00 AM  60°F    58°F   Sunny          0%     7 mph   38%  ☀️
11:00 AM  64°F    62°F   Sunny          0%     8 mph   34%  ☀️
12:00 PM  67°F    66°F   Sunny          0%     9 mph   30%  ☀️

Temperature Range: 47°F - 67°F (20° spread)
Warmest: 12:00 PM (67°F)
Coolest: 06:00 AM (47°F)
```

```bash
./weather.sh --location "40.0150,-105.2705" --units metric
```

```
╔════════════════════════════════════════════════════════════════╗
║              WEATHER REPORT (METRIC)                           ║
║              Boulder, Colorado                                 ║
╚════════════════════════════════════════════════════════════════╝

Current Conditions
════════════════════════════════════════════════════════════════

    \   /     Partly Cloudy
     .-.      
  ― (   ) ―   🌡️  Temperature:  10°C
     `-'      🌡️  Feels Like:   8°C
    /   \     💧 Humidity:     48%
              💨 Wind:         13 km/h NW
              🌧️  Precipitation: 0%

7-Day Forecast
════════════════════════════════════════════════════════════════

Mon 10/20    Partly Cloudy      ⬆️ 20°C  ⬇️ 7°C    💧 10%
Tue 10/21    Sunny             ⬆️ 22°C  ⬇️ 9°C    💧 0%
Wed 10/22    Mostly Sunny       ⬆️ 21°C  ⬇️ 10°C   💧 5%
Thu 10/23    Cloudy            ⬆️ 18°C  ⬇️ 9°C    💧 20%
Fri 10/24    Thunderstorms     ⬆️ 17°C  ⬇️ 7°C    💧 80%
Sat 10/25    Rain              ⬆️ 14°C  ⬇️ 6°C    💧 70%
Sun 10/26    Partly Cloudy      ⬆️ 18°C  ⬇️ 7°C    💧 30%
```

**Additional features:**

```bash
# Save default location
./weather.sh --set-default "Denver, CO"

# Compare two locations
./weather.sh --compare "Denver,CO" "Boulder,CO"

# Show moon phase
./weather.sh --moon

# Historical weather
./weather.sh --historical --date "2025-10-01"

# Export to file
./weather.sh --export weather_report.txt
./weather.sh --export weather.html --format html
./weather.sh --export weather.json --format json
```

This Day 27 content provides comprehensive API interaction skills with curl and jq, creating a professional weather tool that demonstrates real-world API integration and JSON parsing.

Sources
