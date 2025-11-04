### Goal:
Create a script named `url_extractor.sh` that finds and extracts URLs from text using regex.
### Requirements:
- Find all URLs in text (from file, argument, or stdin)
- Support multiple URL schemes:
  - `http://`, `https://`
  - `ftp://`, `ftps://`
  - `file://`
  - `mailto:`
- Extract URL components:
  - Protocol/scheme
  - Domain/host
  - Port (if specified)
  - Path
  - Query parameters
  - Fragment/anchor
- Validate URL format
- Handle URLs with or without protocol
- Support IPv4 and IPv6 addresses in URLs
- Detect broken/incomplete URLs
- Remove duplicates
- Sort by domain
### Hints:
- Basic URL regex: `(https?|ftp)://[^\s/$.?#].[^\s]*`
- Domain: `([a-zA-Z0-9]([a-zA-Z0-9\-]{0,61}[a-zA-Z0-9])?\.)+[a-zA-Z]{2,}`
- Use `grep -Eo` for extraction
- Parse components with capturing groups
### Expected Output Example:
```bash
./url_extractor.sh "Visit https://example.com/path?q=search#section or ftp://files.example.com"
```
```
╔════════════════════════════════════════════════════════════════╗
║                  URL EXTRACTOR                                 ║
╚════════════════════════════════════════════════════════════════╝

Input text:
"Visit https://example.com/path?q=search#section or ftp://files.example.com"

Extracting URLs...

══════════════════════════════════════════════════════════════
URL #1
══════════════════════════════════════════════════════════════
Full URL:       https://example.com/path?q=search#section
Protocol:       https
Domain:         example.com
Port:           443 (default)
Path:           /path
Query string:   q=search
Fragment:       section

Query parameters:
  q = search

Validation:     ✓ Valid
Type:           Secure web page
Status:         (would check if --validate flag used)

══════════════════════════════════════════════════════════════
URL #2
══════════════════════════════════════════════════════════════
Full URL:       ftp://files.example.com
Protocol:       ftp
Domain:         files.example.com
Port:           21 (default)
Path:           /
Query string:   (none)
Fragment:       (none)

Validation:     ✓ Valid
Type:           FTP server

╔════════════════════════════════════════════════════════════════╗
║                       SUMMARY                                  ║
╚════════════════════════════════════════════════════════════════╝

Total URLs found: 2
Valid: 2
Invalid: 0

By protocol:
  https: 1
  ftp: 1

By domain:
  example.com: 2

Unique domains: 1
```

```bash
./url_extractor.sh webpage.html
```
```
╔════════════════════════════════════════════════════════════════╗
║           URL EXTRACTOR - File Mode                            ║
╚════════════════════════════════════════════════════════════════╝

Processing file: webpage.html
File size: 15.3 KB

Extracting URLs...

Found 47 URLs:

Internal links (same domain): 23
External links: 18
Resources (images, scripts, CSS): 6

Top domains:
────────────────────────────────────────
1. example.com (23 URLs)
2. cdn.example.com (6 URLs)
3. analytics.google.com (3 URLs)
4. fonts.googleapis.com (2 URLs)

Protocol distribution:
────────────────────────────────────────
https: 42 (89%)
http: 5 (11%)

⚠ Mixed content detected (HTTP resources on HTTPS page)

Resource types:
────────────────────────────────────────
HTML pages: 41
Images: 3
Stylesheets: 2
Scripts: 1

Extracted URLs saved to: webpage_urls.txt
```
### Bonus Challenge:
- Check URL availability (HTTP status codes)
- Detect redirect chains
- Find broken links
- Extract metadata (title, description)
- Screenshot URL content
- Detect phishing URLs
- Check URL reputation/safety
- Archive URLs (Wayback Machine)
- Convert relative to absolute URLs
- Create site map from URLs
- Detect URL shorteners and expand them
- Check robots.txt compliance
- Measure page load time
- Extract structured data

***