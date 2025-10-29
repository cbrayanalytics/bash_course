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
