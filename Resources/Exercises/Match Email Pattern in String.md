### Goal:
Create a script named `email_matcher.sh` that finds and validates email addresses in text using regex.
### Requirements:
- Accept text input (from argument, file, or stdin)
- Find all email addresses in the text
- Validate each email against proper format
- Extract and display:
  - Complete email address
  - Username (before @)
  - Domain name (after @)
  - Top-level domain (TLD)
- Support multiple email formats:
  - Standard: `user@domain.com`
  - With dots: `first.last@domain.com`
  - With plus: `user+tag@domain.com`
  - Subdomains: `user@mail.domain.com`
- Highlight matches in original text
- Count total emails found
- Identify invalid email patterns
### Hints:
- Basic email regex: `[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}`
- Use capturing groups to extract parts
- Use `BASH_REMATCH` array to access captures
- Loop through text to find multiple matches
### Expected Output Example:
```bash
./email_matcher.sh "Contact us at support@example.com or sales@company.co.uk"
```
```
╔════════════════════════════════════════════════════════════════╗
║                EMAIL PATTERN MATCHER                           ║
╚════════════════════════════════════════════════════════════════╝

Input text:
"Contact us at support@example.com or sales@company.co.uk"

Searching for email addresses...

══════════════════════════════════════════════════════════════
Email #1
══════════════════════════════════════════════════════════════
Full address:    support@example.com
Username:        support
Domain:          example.com
TLD:             com
Validation:      ✓ Valid

══════════════════════════════════════════════════════════════
Email #2
══════════════════════════════════════════════════════════════
Full address:    sales@company.co.uk
Username:        sales
Domain:          company.co.uk
TLD:             uk
Validation:      ✓ Valid

╔════════════════════════════════════════════════════════════════╗
║                       SUMMARY                                  ║
╚════════════════════════════════════════════════════════════════╝

Total emails found: 2
Valid: 2
Invalid: 0

Text with highlighted emails:
Contact us at [support@example.com] or [sales@company.co.uk]
```

```bash
./email_matcher.sh "Email me at john.doe+tag@mail.example.com or bad@email"
```
```
╔════════════════════════════════════════════════════════════════╗
║                EMAIL PATTERN MATCHER                           ║
╚════════════════════════════════════════════════════════════════╝

Searching for email addresses...

══════════════════════════════════════════════════════════════
Email #1
══════════════════════════════════════════════════════════════
Full address:    john.doe+tag@mail.example.com
Username:        john.doe+tag
Local part:      john.doe
Tag:             +tag
Domain:          mail.example.com
Subdomain:       mail
Main domain:     example.com
TLD:             com
Validation:      ✓ Valid (supports plus addressing)

══════════════════════════════════════════════════════════════
Email #2
══════════════════════════════════════════════════════════════
Full address:    bad@email
Username:        bad
Domain:          email
TLD:             (missing)
Validation:      ✗ Invalid (missing TLD)

╔════════════════════════════════════════════════════════════════╗
║                       SUMMARY                                  ║
╚════════════════════════════════════════════════════════════════╝

Total emails found: 2
Valid: 1
Invalid: 1

Issues detected:
  • bad@email - Missing top-level domain
```
### Bonus Challenge:
- Support international domains (IDN)
- Validate against disposable email providers
- Check domain DNS records
- Detect common typos (gmial.com → gmail.com)
- Extract emails from HTML
- Support RFC-compliant email validation
- Detect email obfuscation patterns
- Add email normalization
- Support email address lists (comma-separated)
- Create email harvester from web pages

***
