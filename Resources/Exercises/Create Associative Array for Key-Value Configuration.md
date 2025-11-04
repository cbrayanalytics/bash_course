### Goal:
Create a script named `config.sh` that uses associative arrays to store and manage configuration settings.
### Requirements:
- Create an associative array with configuration key-value pairs
- Include at least 6-8 config settings (host, port, debug, timeout, etc.)
- Display all configuration settings in a formatted table
- Implement these functions:
  - Get a specific config value by key
  - Update a config value
  - Add a new config entry
  - Check if a key exists
- Show examples of all operations
### Hints:
- Use `declare -A config`
- Access with `${config[key]}`
- Check existence with `[[ -v config[key] ]]`
- Get all keys with `${!config[@]}`
- Format with `printf` for aligned output
### Expected Output Example:
```bash
./config.sh
```
```
════════════════════════════════════════
Application Configuration
════════════════════════════════════════

Key              Value
────────────────────────────────────────
host             localhost
port             8080
debug            true
timeout          30
max_connections  100
log_level        info
database         production
ssl_enabled      false

────────────────────────────────────────
Total settings: 8

--- Get Operation ---
config[host] = localhost
config[port] = 8080

--- Update Operation ---
Updating: port = 9000
✓ Updated successfully
New value: config[port] = 9000

--- Add Operation ---
Adding: api_key = abc123xyz
✓ Added successfully
Total settings: 9

--- Check Existence ---
Does 'host' exist? Yes
Does 'password' exist? No

--- Final Configuration ---
Total settings: 9
Debug mode: enabled
```
### Bonus Challenge:
- Load configuration from file (key=value format)
- Save configuration back to file
- Validate values (e.g., port must be 1-65535)
- Support nested configurations using naming convention (db.host, db.port)
- Add comments support in config file
- Implement default values for missing keys

***
