### Goal:
Create a script named `phone_validator.sh` that validates and formats phone numbers using regex.
### Requirements:
- Support multiple phone number formats:
  - US: `(555) 123-4567`, `555-123-4567`, `5551234567`
  - International: `+1 555-123-4567`, `+44 20 7946 0958`
  - With extension: `555-123-4567 ext. 123`
- Validate format correctness
- Extract components:
  - Country code
  - Area code
  - Exchange code
  - Line number
  - Extension (if present)
- Normalize to standard format
- Detect phone number type (mobile, landline, toll-free)
- Support batch validation from file
### Hints:
- US format regex: `^$$?([0-9]{3})$$?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$`
- International: `^\+([0-9]{1,3})[ .-]?`
- Use capturing groups for each component
- Strip non-numeric chars for validation
- Format output consistently
### Expected Output Example:
```bash
./phone_validator.sh "(555) 123-4567"
```
```
╔════════════════════════════════════════════════════════════════╗
║            PHONE NUMBER VALIDATOR                              ║
╚════════════════════════════════════════════════════════════════╝

Input: (555) 123-4567

Validation: ✓ Valid

Format detected: US Standard
Country: United States (+1)

Components:
────────────────────────────────────────
Area code:     555
Exchange:      123
Line number:   4567

Normalized formats:
────────────────────────────────────────
Standard:      (555) 123-4567
Dashes:        555-123-4567
Dots:          555.123.4567
Spaces:        555 123 4567
International: +1 555-123-4567
E.164:         +15551234567
```

```bash
./phone_validator.sh "+44 20 7946 0958"
```
```
╔════════════════════════════════════════════════════════════════╗
║            PHONE NUMBER VALIDATOR                              ║
╚════════════════════════════════════════════════════════════════╝

Input: +44 20 7946 0958

Validation: ✓ Valid

Format detected: International (UK)
Country: United Kingdom (+44)

Components:
────────────────────────────────────────
Country code:  44
Area code:     20
Subscriber:    7946 0958

Normalized formats:
────────────────────────────────────────
International: +44 20 7946 0958
E.164:         +442079460958
Local:         020 7946 0958
```

```bash
./phone_validator.sh "555-1234"
```
```
╔════════════════════════════════════════════════════════════════╗
║            PHONE NUMBER VALIDATOR                              ║
╚════════════════════════════════════════════════════════════════╝

Input: 555-1234

Validation: ✗ Invalid

Issues:
────────────────────────────────────────
✗ Too few digits (expected 10 for US, got 7)
✗ Missing area code
✗ Incomplete phone number

Suggestion:
Did you mean: (XXX) 555-1234?
(Area code required for US numbers)
```
### Bonus Challenge:
- Support all international formats
- Validate area codes (check if valid for country)
- Detect toll-free numbers (800, 888, etc.)
- Support vanity numbers (1-800-FLOWERS)
- Add phone number portability check
- Validate against real carrier databases
- Support SMS-capable number detection
- Add do-not-call list checking
- Create phone number generator
- Support phone number obfuscation

***
