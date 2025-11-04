### Goal:
Build a comprehensive validation library named `validators.sh` that provides reusable validation functions for common data types.
### Requirements:
**Core Validation Functions:**

1. **Email Validation:**
   - `validate_email(email)` - Basic RFC-compliant validation
   - Check format: `user@domain.tld`
   - Support plus addressing: `user+tag@domain.com`
   - Validate domain format
   - Check for common typos
   - Return 0 if valid, 1 if invalid
   - Optional: Output error message explaining why invalid

2. **IP Address Validation:**
   - `validate_ipv4(ip)` - Validate IPv4 address
   - `validate_ipv6(ip)` - Validate IPv6 address
   - Check format and range (0-255 for each octet)
   - Support CIDR notation
   - Validate private vs public ranges
   - Check for reserved addresses

3. **URL Validation:**
   - `validate_url(url)` - Full URL validation
   - Support http/https protocols
   - Validate domain and TLD
   - Check port format
   - Validate query parameters
   - Support internationalized domains

4. **Additional Validators:**
   - `validate_phone(number)` - Phone number (multiple formats)
   - `validate_date(date)` - Date format validation
   - `validate_credit_card(number)` - Luhn algorithm
   - `validate_username(name)` - Username format
   - `validate_password_strength(pwd)` - Password requirements
   - `validate_zip_code(zip, country)` - Postal codes

**Features:**
- Each function returns 0 (valid) or 1 (invalid)
- Optional verbose mode that outputs error details
- Support for custom validation rules
- Batch validation (validate multiple values)
- Generate sample valid/invalid data for testing
- Performance benchmarking
- Comprehensive test suite
### Expected Output Example:
```bash
source validators.sh

# Basic usage
if validate_email "user@example.com"; then
    echo "Valid email"
fi
```

**Complete demonstration script:**
```bash
#!/bin/bash

source ./validators.sh

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║              VALIDATION LIBRARY DEMONSTRATION                  ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo

# Email Validation
echo "══════════════════════════════════════════════════════════════"
echo "EMAIL VALIDATION"
echo "══════════════════════════════════════════════════════════════"
echo

test_emails=(
    "user@example.com"
    "john.doe@company.co.uk"
    "invalid.email@"
    "@example.com"
    "user@domain"
    "user+tag@example.com"
)

for email in "${test_emails[@]}"; do
    if validate_email "$email"; then
        echo "✓ VALID:   $email"
    else
        echo "✗ INVALID: $email"
        validate_email_verbose "$email"
    fi
done

echo
echo "══════════════════════════════════════════════════════════════"
echo "IP ADDRESS VALIDATION"
echo "══════════════════════════════════════════════════════════════"
echo

test_ips=(
    "192.168.1.1"
    "10.0.0.1"
    "256.1.1.1"
    "192.168.1"
    "192.168.1.1.1"
    "::1"
    "2001:0db8:85a3::8a2e:0370:7334"
)

for ip in "${test_ips[@]}"; do
    if validate_ipv4 "$ip"; then
        echo "✓ VALID IPv4:   $ip"
    elif validate_ipv6 "$ip"; then
        echo "✓ VALID IPv6:   $ip"
    else
        echo "✗ INVALID:      $ip"
    fi
done

echo
echo "══════════════════════════════════════════════════════════════"
echo "URL VALIDATION"
echo "══════════════════════════════════════════════════════════════"
echo

test_urls=(
    "https://www.example.com"
    "http://example.com/path?query=value"
    "ftp://files.example.com"
    "not-a-url"
    "https://example.com:8080/api"
)

for url in "${test_urls[@]}"; do
    if validate_url "$url"; then
        echo "✓ VALID:   $url"
    else
        echo "✗ INVALID: $url"
    fi
done
```

**Output:**
```
╔════════════════════════════════════════════════════════════════╗
║              VALIDATION LIBRARY DEMONSTRATION                  ║
╚════════════════════════════════════════════════════════════════╝

══════════════════════════════════════════════════════════════
EMAIL VALIDATION
══════════════════════════════════════════════════════════════

✓ VALID:   user@example.com
✓ VALID:   john.doe@company.co.uk
✗ INVALID: invalid.email@
  └─ Error: Missing domain after '@'
✗ INVALID: @example.com
  └─ Error: Missing local part before '@'
✗ INVALID: user@domain
  └─ Error: Invalid domain (missing TLD)
✓ VALID:   user+tag@example.com

══════════════════════════════════════════════════════════════
IP ADDRESS VALIDATION
══════════════════════════════════════════════════════════════

✓ VALID IPv4:   192.168.1.1
✓ VALID IPv4:   10.0.0.1
✗ INVALID:      256.1.1.1
  └─ Error: Octet out of range (256 > 255)
✗ INVALID:      192.168.1
  └─ Error: Insufficient octets (expected 4)
✗ INVALID:      192.168.1.1.1
  └─ Error: Too many octets (expected 4)
✓ VALID IPv6:   ::1
✓ VALID IPv6:   2001:0db8:85a3::8a2e:0370:7334

══════════════════════════════════════════════════════════════
URL VALIDATION
══════════════════════════════════════════════════════════════

✓ VALID:   https://www.example.com
✓ VALID:   http://example.com/path?query=value
✓ VALID:   ftp://files.example.com
✗ INVALID: not-a-url
  └─ Error: Missing protocol (http://, https://, etc.)
✓ VALID:   https://example.com:8080/api

══════════════════════════════════════════════════════════════
VALIDATION STATISTICS
══════════════════════════════════════════════════════════════

Emails tested: 6
  Valid: 4 (67%)
  Invalid: 2 (33%)

IP Addresses tested: 7
  Valid IPv4: 2 (29%)
  Valid IPv6: 2 (29%)
  Invalid: 3 (43%)

URLs tested: 5
  Valid: 4 (80%)
  Invalid: 1 (20%)

Total validations: 18
Overall success rate: 67%
```

**Implementation example (validators.sh):**
```bash
#!/bin/bash
#
# validators.sh - Comprehensive validation library
#

# Email validation
validate_email() {
    local email=$1
    local regex='^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
    
    [[ $email =~ $regex ]]
}

# Verbose email validation with error details
validate_email_verbose() {
    local email=$1
    
    if [[ ! $email =~ @ ]]; then
        echo "  └─ Error: Missing '@' symbol"
        return 1
    fi
    
    local local_part="${email%@*}"
    local domain_part="${email#*@}"
    
    if [[ -z $local_part ]]; then
        echo "  └─ Error: Missing local part before '@'"
        return 1
    fi
    
    if [[ -z $domain_part ]]; then
        echo "  └─ Error: Missing domain after '@'"
        return 1
    fi
    
    if [[ ! $domain_part =~ \. ]]; then
        echo "  └─ Error: Invalid domain (missing TLD)"
        return 1
    fi
    
    return 0
}

# IPv4 validation
validate_ipv4() {
    local ip=$1
    local regex='^([0-9]{1,3}\.){3}[0-9]{1,3}$'
    
    # Check basic format
    if [[ ! $ip =~ $regex ]]; then
        return 1
    fi
    
    # Check each octet is 0-255
    IFS='.' read -ra octets <<< "$ip"
    
    for octet in "${octets[@]}"; do
        if ((octet > 255)); then
            return 1
        fi
    done
    
    return 0
}

# IPv6 validation (simplified)
validate_ipv6() {
    local ip=$1
    
    # Simplified IPv6 regex
    if [[ $ip =~ ^([0-9a-fA-F]{0,4}:){2,7}[0-9a-fA-F]{0,4}$ ]] || \
       [[ $ip == "::1" ]]; then
        return 0
    fi
    
    return 1
}

# URL validation
validate_url() {
    local url=$1
    local regex='^(https?|ftp)://[a-zA-Z0-9.-]+(:[0-9]+)?(/.*)?$'
    
    [[ $url =~ $regex ]]
}

# Phone number validation (US format)
validate_phone_us() {
    local phone=$1
    
    # Remove common separators
    phone=${phone//[- ()]/}
    
    # Check if 10 digits
    [[ $phone =~ ^[0-9]{10}$ ]]
}

# Date validation (YYYY-MM-DD)
validate_date() {
    local date=$1
    
    if [[ ! $date =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
        return 1
    fi
    
    # Validate with date command
    date -d "$date" &>/dev/null
}

# Password strength validation
validate_password_strength() {
    local password=$1
    local min_length=8
    
    # Check minimum length
    if [[ ${#password} -lt $min_length ]]; then
        echo "  └─ Error: Password too short (minimum $min_length characters)"
        return 1
    fi
    
    # Check for uppercase
    if [[ ! $password =~ [A-Z] ]]; then
        echo "  └─ Error: Must contain uppercase letter"
        return 1
    fi
    
    # Check for lowercase
    if [[ ! $password =~ [a-z] ]]; then
        echo "  └─ Error: Must contain lowercase letter"
        return 1
    fi
    
    # Check for number
    if [[ ! $password =~ [0-9] ]]; then
        echo "  └─ Error: Must contain number"
        return 1
    fi
    
    # Check for special character
    if [[ ! $password =~ [^a-zA-Z0-9] ]]; then
        echo "  └─ Error: Must contain special character"
        return 1
    fi
    
    return 0
}

# Username validation
validate_username() {
    local username=$1
    
    # 3-20 characters, alphanumeric and underscore only
    [[ $username =~ ^[a-zA-Z0-9_]{3,20}$ ]]
}

# Credit card validation (Luhn algorithm)
validate_credit_card() {
    local number=$1
    
    # Remove spaces and dashes
    number=${number//[ -]/}
    
    # Check if numeric and right length
    if [[ ! $number =~ ^[0-9]{13,19}$ ]]; then
        return 1
    fi
    
    # Luhn algorithm
    local sum=0
    local double=0
    
    for ((i=${#number}-1; i>=0; i--)); do
        local digit=${number:i:1}
        
        if ((double)); then
            digit=$((digit * 2))
            if ((digit > 9)); then
                digit=$((digit - 9))
            fi
        fi
        
        sum=$((sum + digit))
        double=$(( 1 - double ))
    done
    
    ((sum % 10 == 0))
}

# Batch validation
validate_batch() {
    local validator=$1
    shift
    local items=("$@")
    
    local valid=0
    local invalid=0
    
    for item in "${items[@]}"; do
        if $validator "$item"; then
            ((valid++))
        else
            ((invalid++))
        fi
    done
    
    echo "Valid: $valid, Invalid: $invalid"
}

# Export functions
export -f validate_email
export -f validate_email_verbose
export -f validate_ipv4
export -f validate_ipv6
export -f validate_url
export -f validate_phone_us
export -f validate_date
export -f validate_password_strength
export -f validate_username
export -f validate_credit_card
export -f validate_batch
```
### Bonus Challenges:
**Level 1 (Intermediate):**
- Add international phone number support
- Implement IBAN validation
- Add credit card type detection (Visa, Mastercard, etc.)
- Support custom validation rules
- Add data sanitization functions
- Create validation report generator
- Add performance profiling
- Support validation chains (multiple validators)

**Level 2 (Advanced):**
- Add DNS validation for domains
- Implement checksum algorithms (CRC, MD5)
- Create validation rule DSL
- Add async validation support
- Implement validation caching
- Support validation templates
- Add machine learning for pattern detection
- Create validation API

**Level 3 (Expert):**
- Full internationalization support
- Real-time validation as user types
- Integration with external validation services
- Blockchain address validation
- Biometric data validation
- AI-powered anomaly detection
- Distributed validation system
- Compliance validation (GDPR, HIPAA)