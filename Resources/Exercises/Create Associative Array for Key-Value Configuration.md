### Goal:

Create a script named `config.sh` that uses associative arrays to store and manage configuration settings.

---

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

---

### Hints:

- Use `declare -A config`
- Access with `${config[key]}`
- Check existence with `[[ -v config[key] ]]`
- Get all keys with `${!config[@]}`
- Format with `printf` for aligned output

---

### Bonus Challenge:

- Load configuration from file (key=value format)
- Save configuration back to file
- Validate values (e.g., port must be 1-65535)
- Support nested configurations using naming convention (db.host, db.port)
- Add comments support in config file
- Implement default values for missing keys

---

### Pseudocode:

```sh

// ========================================
// GLOBAL VARIABLES & CONFIGURATION
// ========================================

CONSTANT CONFIG_FILE = "config.conf"

// ========================================
// HELPER FUNCTIONS
// ========================================

FUNCTION display_usage()
  BEGIN
    DISPLAY "Usage: ./config.sh [load|save|interactive]"
    DISPLAY ""
    DISPLAY "Run without arguments for demo mode"
    DISPLAY ""
    DISPLAY "Options:"
    DISPLAY "  load        - Load configuration from file"
    DISPLAY "  save        - Save configuration to file"
    DISPLAY "  interactive - Interactive configuration mode"
    DISPLAY "  help / -h   - Show this help message"
    DISPLAY ""
    DISPLAY "Interactive Mode Commands:"
    DISPLAY "  get <key>              - Retrieve value for a key"
    DISPLAY "  set <key> <value>      - Set a key-value pair"
    DISPLAY "  delete <key>           - Delete a key"
    DISPLAY "  list                   - Display all configuration"
    DISPLAY "  exists <key>           - Check if a key exists"
    DISPLAY "  save [filename]        - Save configuration to file"
    DISPLAY "  load [filename]        - Load configuration from file"
    DISPLAY "  help                   - Show this help message"
    DISPLAY "  quit                   - Exit interactive mode"
    DISPLAY ""
  END

FUNCTION display_error(message)
  BEGIN
    OUTPUT "✗ Error: " + message TO stderr
  END

FUNCTION display_header(title)
  BEGIN
    SET bars = "════════════════════════════════════════"
    SET length = LENGTH(bars)
    SET title_length = LENGTH(title)
    SET padding_left = (length - title_length) / 2
    SET padding_right = length - padding_left - title_length

    DISPLAY bars
    DISPLAY SPACES(padding_left) + title + SPACES(padding_right)
    DISPLAY bars
  END

FUNCTION process_string(REFERENCE string_var)
  // Remove surrounding quotes and trim whitespace
  BEGIN
    // Remove quotes if present
    IF string_var STARTS WITH "'" AND ENDS WITH "'" THEN
      string_var = SUBSTRING(string_var, 1, LENGTH(string_var) - 2)
    ELSE IF string_var STARTS WITH '"' AND ENDS WITH '"' THEN
      string_var = SUBSTRING(string_var, 1, LENGTH(string_var) - 2)
    END IF

    // Trim leading whitespace
    string_var = TRIM_LEFT(string_var)
    // Trim trailing whitespace
    string_var = TRIM_RIGHT(string_var)
  END

// ========================================
// CORE CONFIGURATION FUNCTIONS
// ========================================

FUNCTION config_initialize(REFERENCE config_map)
  // Initialize associative array with default values
  BEGIN
    config_map["host"] = "localhost"
    config_map["port"] = "8080"
    config_map["debug"] = "true"
    config_map["timeout"] = "30"
    config_map["max_connections"] = "100"
    config_map["log_level"] = "info"
    config_map["database"] = "production"
    config_map["ssl_enabled"] = "false"
  END

FUNCTION config_display_all(REFERENCE config_map)
  // Display all configuration settings in formatted table
  BEGIN
    DISPLAY ""
    DISPLAY "Key              Value"
    DISPLAY "────────────────────────────────────────"

    // Get all keys and sort alphabetically
    SET keys_array = GET_KEYS(config_map)
    SET keys_array = SORT(keys_array)

    // Display each key-value pair
    FOR EACH key IN keys_array DO
      SET value = config_map[key]
      DISPLAY FORMAT("%-16s %s", key, value)
    END FOR

    DISPLAY "────────────────────────────────────────"
    SET count = SIZE(keys_array)
    DISPLAY "Total settings: " + count
    DISPLAY ""
  END

FUNCTION config_get(REFERENCE config_map, search_key)
  // Retrieve value for given key
  // Returns: value if found, error otherwise
  BEGIN
    IF KEY_EXISTS(config_map, search_key) THEN
      SET value = config_map[search_key]
      OUTPUT value
      RETURN SUCCESS
    ELSE
      CALL display_error("Key '" + search_key + "' not found")
      RETURN FAILURE
    END IF
  END

FUNCTION config_set(REFERENCE config_map, key, value)
  // Set configuration value with validation
  // Returns: SUCCESS if valid, FAILURE if validation fails
  BEGIN
    IF NOT validate_config_value(key, value) THEN
      RETURN FAILURE
    END IF

    config_map[key] = value
    RETURN SUCCESS
  END

FUNCTION config_exists(REFERENCE config_map, search_key)
  // Check if key exists in configuration
  // Returns: TRUE if exists, FALSE otherwise
  BEGIN
    IF KEY_EXISTS(config_map, search_key) THEN
      RETURN TRUE
    ELSE
      RETURN FALSE
    END IF
  END

FUNCTION config_delete(REFERENCE config_map, key)
  // Delete configuration key
  // Returns: SUCCESS if deleted, FAILURE if not found
  BEGIN
    IF NOT config_exists(config_map, key) THEN
      CALL display_error("Cannot delete - '" + key + "' not found")
      RETURN FAILURE
    END IF

    REMOVE config_map[key]
    DISPLAY "✓ Deleted key: " + key
    RETURN SUCCESS
  END

// ========================================
// VALIDATION FUNCTIONS
// ========================================

FUNCTION validate_config_value(key, value)
  // Validate configuration values based on key type
  // Returns: TRUE if valid, FALSE if invalid
  BEGIN
    SWITCH key
      CASE "port":
        IF NOT IS_INTEGER(value) THEN
          CALL display_error("Port must be an integer")
          RETURN FALSE
        END IF

        IF value < 1 OR value > 65535 THEN
          CALL display_error("Port must be between 1 and 65535")
          RETURN FALSE
        END IF

      CASE "debug" OR "ssl_enabled":
        IF value NOT IN ["true", "false", "yes", "no", "on", "off"] THEN
          CALL display_error("Value must be boolean")
          RETURN FALSE
        END IF

      CASE "timeout" OR "max_connections":
        IF NOT IS_INTEGER(value) THEN
          CALL display_error("Value must be a positive integer")
          RETURN FALSE
        END IF

      CASE "log_level":
        IF value NOT IN ["debug", "info", "warn", "error", "fatal"] THEN
          CALL display_error("Invalid log level")
          RETURN FALSE
        END IF

      DEFAULT:
        // No validation for unknown keys
        RETURN TRUE
    END SWITCH

    RETURN TRUE
  END

// ========================================
// FILE I/O FUNCTIONS
// ========================================

FUNCTION config_load_from_file(REFERENCE config_map, filename)
  // Load configuration from file (key=value format)
  // Returns: SUCCESS on completion, FAILURE on error
  BEGIN
    IF NOT FILE_EXISTS(filename) THEN
      CALL display_error("Config file not found: '" + filename + "'")
      RETURN FAILURE
    END IF

    DISPLAY "Loading configuration from: " + filename

    SET line_number = 0

    // Read file line by line
    OPEN FILE filename FOR READING AS file
    WHILE NOT END_OF_FILE(file) DO
      READ line FROM file
      INCREMENT line_number

      // Trim whitespace
      line = TRIM(line)

      // Skip empty lines and comments
      IF line IS EMPTY OR line STARTS WITH "#" THEN
        CONTINUE
      END IF

      // Validate line format (must contain =)
      IF line DOES NOT CONTAIN "=" THEN
        CALL display_error("Invalid format at line " + line_number)
        CONTINUE
      END IF

      // Parse key=value pair
      SET parts = SPLIT(line, "=", limit=2)
      SET key = parts[0]
      SET value = parts[1]

      // Clean up key and value
      CALL process_string(key)
      CALL process_string(value)

      // Set configuration with validation
      CALL config_set(config_map, key, value)
    END WHILE
    CLOSE FILE file

    DISPLAY "✓ Configuration loaded successfully"
    RETURN SUCCESS
  END

FUNCTION config_save_to_file(REFERENCE config_map, filename)
  // Save configuration to file
  // Returns: SUCCESS on completion, FAILURE on error
  BEGIN
    DISPLAY "Saving configuration to: " + filename

    // Check write permissions
    IF FILE_EXISTS(filename) AND NOT FILE_WRITABLE(filename) THEN
      CALL display_error("Cannot write to file: " + filename)
      RETURN FAILURE
    END IF

    // Open file for writing (overwrites existing)
    OPEN FILE filename FOR WRITING AS file

    // Write header with timestamp
    WRITE "# Configuration file" TO file
    SET current_datetime = GET_CURRENT_DATETIME()
    WRITE "# Generated: " + current_datetime TO file
    WRITE "" TO file

    // Get all keys and sort
    SET keys_array = GET_KEYS(config_map)
    SET keys_array = SORT(keys_array)

    // Write each key=value pair
    FOR EACH key IN keys_array DO
      SET value = config_map[key]
      WRITE key + "=" + value TO file
    END FOR

    CLOSE FILE file

    DISPLAY "✓ Configuration saved successfully"
    RETURN SUCCESS
  END

FUNCTION config_get_with_default(REFERENCE config_map, key, default_value)
  // Get configuration value with fallback default
  // Returns: value if key exists, default_value otherwise
  BEGIN
    IF KEY_EXISTS(config_map, key) THEN
      RETURN config_map[key]
    ELSE
      RETURN default_value
    END IF
  END

// ========================================
// DEMONSTRATION FUNCTIONS
// ========================================

FUNCTION demo_get_operations(REFERENCE config_map)
  BEGIN
    DISPLAY "--- Get Operation ---"

    SET host_value = config_get(config_map, "host")
    DISPLAY "config[host]: " + host_value

    SET port_value = config_get(config_map, "port")
    DISPLAY "config[port]: " + port_value

    DISPLAY ""
  END

FUNCTION demo_update_operations(REFERENCE config_map)
  BEGIN
    DISPLAY "--- Update Operation ---"
    DISPLAY "Updating: port = 9000"

    IF config_set(config_map, "port", 9000) = SUCCESS THEN
      DISPLAY "✓ Updated successfully"
      SET new_value = config_get(config_map, "port")
      DISPLAY "New value: config[port] = " + new_value
    END IF

    DISPLAY ""
  END

FUNCTION demo_add_operations(REFERENCE config_map)
  BEGIN
    DISPLAY "--- Add Operation ---"
    DISPLAY "Adding: api_key = abc123xyz"

    IF config_set(config_map, "api_key", "abc123xyz") = SUCCESS THEN
      DISPLAY "✓ Added successfully"
      DISPLAY "Total settings: " + SIZE(config_map)
    END IF

    DISPLAY ""
  END

FUNCTION demo_check_existence(REFERENCE config_map)
  BEGIN
    DISPLAY "--- Check Existence ---"

    IF config_exists(config_map, "host") THEN
      DISPLAY "Does 'host' exist? Yes"
    ELSE
      DISPLAY "Does 'host' exist? No"
    END IF

    IF config_exists(config_map, "password") THEN
      DISPLAY "Does 'password' exist? Yes"
    ELSE
      DISPLAY "Does 'password' exist? No"
    END IF

    DISPLAY ""
  END

FUNCTION display_final_status(REFERENCE config_map)
  BEGIN
    DISPLAY "--- Final Configuration ---"
    DISPLAY "Total settings: " + SIZE(config_map)

    SET debug_mode = config_get(config_map, "debug")
    IF debug_mode = "true" THEN
      DISPLAY "Debug mode: enabled"
    ELSE
      DISPLAY "Debug mode: disabled"
    END IF

    DISPLAY ""
  END

FUNCTION demo_all_operations(REFERENCE config_map)
  BEGIN
    CALL display_header("Application Configuration")
    CALL config_display_all(config_map)

    CALL demo_get_operations(config_map)
    CALL demo_update_operations(config_map)
    CALL demo_add_operations(config_map)
    CALL demo_check_existence(config_map)
    CALL display_final_status(config_map)
  END

// ========================================
// INTERACTIVE MODE
// ========================================

FUNCTION interactive_mode(REFERENCE config_map)
  // Interactive command-line interface for configuration management
  BEGIN
    CALL display_header("Interactive Configuration Mode")
    DISPLAY "Type 'help' for available commands"
    DISPLAY ""

    // Main REPL loop
    WHILE TRUE DO
      DISPLAY "> " WITHOUT_NEWLINE
      INPUT user_input

      SET input_parts = SPLIT(user_input, " ")
      SET command = input_parts[0]
      SET arguments = input_parts[1..END]

      SWITCH command
        CASE "get":
          IF SIZE(arguments) = 0 THEN
            DISPLAY "Usage: get <key>"
            CONTINUE
          END IF

          SET key = arguments[0]
          SET value = config_get(config_map, key)
          IF value IS NOT NULL THEN
            DISPLAY key + " = " + value
          END IF

        CASE "set":
          IF SIZE(arguments) < 2 THEN
            DISPLAY "Usage: set <key> <value>"
            CONTINUE
          END IF

          SET key = arguments[0]
          SET value = arguments[1]

          IF config_set(config_map, key, value) = SUCCESS THEN
            DISPLAY "✓ Set " + key + " = " + value
          END IF

        CASE "delete" OR "remove":
          IF SIZE(arguments) = 0 THEN
            DISPLAY "Usage: delete <key>"
            CONTINUE
          END IF

          CALL config_delete(config_map, arguments[0])

        CASE "list" OR "show" OR "display":
          CALL config_display_all(config_map)

        CASE "exists" OR "check":
          IF SIZE(arguments) = 0 THEN
            DISPLAY "Usage: exists <key>"
            CONTINUE
          END IF

          SET key = arguments[0]
          IF config_exists(config_map, key) THEN
            DISPLAY "Key '" + key + "' exists"
          ELSE
            DISPLAY "Key '" + key + "' does not exist"
          END IF

        CASE "save":
          SET filename = CONFIG_FILE
          IF SIZE(arguments) >= 1 THEN
            filename = arguments[0]
          END IF
          CALL config_save_to_file(config_map, filename)

        CASE "load":
          SET filename = CONFIG_FILE
          IF SIZE(arguments) >= 1 THEN
            filename = arguments[0]
          END IF
          CALL config_load_from_file(config_map, filename)

        CASE "help":
          CALL display_usage()

        CASE "quit" OR "exit":
          DISPLAY "Exiting..."
          BREAK

        CASE "":
          // Empty input, continue
          CONTINUE

        DEFAULT:
          DISPLAY "Unknown command: " + command
          DISPLAY "Type 'help' for available commands"
      END SWITCH
    END WHILE
  END

// ========================================
// MAIN PROGRAM LOGIC
// ========================================

FUNCTION main(command_line_args)
  BEGIN
    // Declare configuration storage (associative array/map/dictionary)
    DECLARE config_map AS MAP<String, String>

    SET first_arg = command_line_args[0]

    // Initialize with defaults
    CALL config_initialize(config_map)

    // Route to appropriate mode based on argument
    SWITCH first_arg
      CASE "load":
        SET filename = command_line_args[1] OR CONFIG_FILE
        CALL config_load_from_file(config_map, filename)
        CALL config_display_all(config_map)

      CASE "save":
        SET filename = command_line_args[1] OR CONFIG_FILE
        CALL config_save_to_file(config_map, filename)

      CASE "interactive" OR "-i":
        CALL interactive_mode(config_map)

      CASE "help" OR "-h":
        CALL display_usage()

      CASE "" OR NULL:
        // No arguments - run demo mode
        CALL demo_all_operations(config_map)

      DEFAULT:
        CALL display_error("Unknown command: " + first_arg)
        CALL display_usage()
        EXIT WITH ERROR_CODE
    END SWITCH

    EXIT WITH SUCCESS_CODE
  END

// Entry point
BEGIN PROGRAM
  CALL main(COMMAND_LINE_ARGUMENTS)
END PROGRAM
```

### Config file:

```sh
# Comment lines start with #
host=localhost
port=8080
debug=true

# Nested config using dot notation
db.host=dbserver
db.port=5432
```

---

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
