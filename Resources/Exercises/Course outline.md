## 30-Day Bash Scripting Course

This course is designed for users with basic Linux familiarity who want to master Bash scripting for system administration and automation tasks[1][2].

**Day 6: Arithmetic Operations**
- **Lesson:** Arithmetic expansion $(()), expr, let, bc for floating-point
- **Exercise 1:** Calculator script for basic operations (+, -, *, /)
- **Exercise 2:** Perform modulo and exponentiation operations
- **Exercise 3:** Floating-point calculations using bc
- **Daily Project:** Create a disk space calculator that converts bytes to KB/MB/GB with formatted output

**Day 7: Arrays & Associative Arrays**
- **Lesson:** Array declaration, indexing, iteration, array length, associative arrays (hashes)
- **Exercise 1:** Store and loop through a list of filenames
- **Exercise 2:** Implement stack operations (push/pop) using arrays
- **Exercise 3:** Create associative array to store key-value configuration pairs
- **Daily Project:** Build a student grade tracker using associative arrays with add/search/display functions

**Week 1 Portfolio Project:** System Information Dashboard
Create a comprehensive script that displays formatted system information including OS details, memory usage, disk space, logged-in users, and network interfaces. Use variables, arrays, arithmetic, and string operations to format output attractively.

***

### Week 2: Control Flow & Logic

**Day 8: Conditional Statements (if/elif/else)**
- **Lesson:** Test commands ([[ ]]), comparison operators (-eq, -ne, -gt, -lt, -ge, -le), string comparisons
- **Exercise 1:** Script that checks if a number is positive, negative, or zero
- **Exercise 2:** Validate user age input (numeric, within range)
- **Exercise 3:** Check multiple conditions with logical operators (&&, ||)
- **Daily Project:** Create a file permission checker that analyzes and reports file access permissions

**Day 9: File Test Operators**
- **Lesson:** File existence (-e), type (-f, -d, -L), permissions (-r, -w, -x), comparisons (-nt, -ot)
- **Exercise 1:** Check if file exists before attempting to read it
- **Exercise 2:** Verify directory existence and create if missing
- **Exercise 3:** Compare modification times of two files
- **Daily Project:** Build a pre-deployment validator that checks for required files, directories, and permissions

**Day 10: Case Statements**
- **Lesson:** Case syntax, pattern matching, fall-through, default case
- **Exercise 1:** Menu-driven script with 4 options
- **Exercise 2:** File type identifier based on extension
- **Exercise 3:** Multi-pattern matching (combining patterns with |)
- **Daily Project:** Create a service manager script with start/stop/restart/status options using case statements

**Day 11: For Loops**
- **Lesson:** C-style for loops, range iteration {1..10}, array iteration, file globbing
- **Exercise 1:** Print numbers 1-20 with loop
- **Exercise 2:** Iterate through files in directory with specific extension
- **Exercise 3:** Nested loops to create multiplication table
- **Daily Project:** Build a batch file renamer that adds timestamps or prefixes to multiple files

**Day 12: While & Until Loops**
- **Lesson:** While loop syntax, reading files line-by-line, infinite loops, until loops
- **Exercise 1:** Counter script using while loop
- **Exercise 2:** Read and process file contents line-by-line
- **Exercise 3:** Menu system with until loop (exit when user selects quit)
- **Daily Project:** Create a log file monitor that continuously checks for new entries and alerts on keywords

**Day 13: Loop Control (break/continue)**
- **Lesson:** Break statement, continue statement, loop exit codes
- **Exercise 1:** Find first even number in array and exit loop
- **Exercise 2:** Skip processing of hidden files using continue
- **Exercise 3:** Nested loop control with labeled breaks
- **Daily Project:** Build a file searcher that stops at first match or continues based on user flags

**Day 14: Exit Codes & Return Values**
- **Lesson:** Exit codes (0-255), $?, exit command, return codes in functions, set -e
- **Exercise 1:** Script with different exit codes for success/error conditions
- **Exercise 2:** Check exit codes of external commands and respond accordingly
- **Exercise 3:** Chain commands with && and || operators
- **Daily Project:** Create a validation script that runs multiple checks and returns specific exit codes for different failure scenarios

**Week 2 Portfolio Project:** Interactive File Manager
Develop a menu-driven file management tool with options to list, copy, move, delete, search, and rename files. Implement proper error checking, exit codes, and user-friendly prompts using all control flow structures learned this week.

***

### Week 3: Functions & Text Processing

**Day 15: Function Basics**
- **Lesson:** Function declaration, calling functions, function scope, local variables
- **Exercise 1:** Create greeting function that accepts name parameter
- **Exercise 2:** Math functions library (add, subtract, multiply, divide)
- **Exercise 3:** Demonstrate global vs local variable scope
- **Daily Project:** Build a logging utility with functions for different log levels (info, warning, error)

**Day 16: Function Arguments & Return Values**
- **Lesson:** Passing arguments to functions ($1, $2), $@, return vs echo, capturing function output
- **Exercise 1:** Function that calculates area of rectangle given length and width
- **Exercise 2:** Return success/failure codes from functions
- **Exercise 3:** Capture and use function output in variables
- **Daily Project:** Create a validation library with functions for email, IP address, and URL validation

**Day 17: Regular Expressions Basics**
- **Lesson:** Regex patterns, character classes, quantifiers, anchors (^, $), bracket expressions
- **Exercise 1:** Match email pattern in string
- **Exercise 2:** Validate phone number formats
- **Exercise 3:** Extract URLs from text
- **Daily Project:** Build a log parser that extracts specific patterns (IP addresses, timestamps, error codes)

**Day 18: Grep & Text Searching**
- **Lesson:** Grep options (-i, -r, -v, -n, -A, -B, -C), extended regex (-E), practical patterns
- **Exercise 1:** Search log files for error messages
- **Exercise 2:** Recursive search through directory tree
- **Exercise 3:** Count occurrences of pattern across multiple files
- **Daily Project:** Create a code search tool that finds function definitions and usage across project files

**Day 19: Sed for Stream Editing**
- **Lesson:** Sed substitution (s///), deletion (d), addressing, in-place editing (-i)
- **Exercise 1:** Replace all occurrences of word in file
- **Exercise 2:** Delete lines matching pattern
- **Exercise 3:** Edit specific line ranges
- **Daily Project:** Build a configuration file updater that modifies settings in place with backups

**Day 20: Awk for Text Processing**
- **Lesson:** Awk basics, field processing ($1, $2), patterns and actions, BEGIN/END blocks
- **Exercise 1:** Extract specific columns from CSV file
- **Exercise 2:** Calculate sum/average of numeric column
- **Exercise 3:** Filter rows based on conditions
- **Daily Project:** Create a system resource analyzer that processes ps/df output to generate formatted reports

**Day 21: Cut, Sort, Uniq, and Pipes**
- **Lesson:** Cut for column extraction, sort options, uniq for duplicates, pipe chaining
- **Exercise 1:** Extract and sort unique usernames from /etc/passwd
- **Exercise 2:** Pipeline to find top 10 most common words in file
- **Exercise 3:** Complex pipeline combining multiple tools
- **Daily Project:** Build a web server log analyzer that extracts, sorts, and counts unique visitors and popular pages

**Week 3 Portfolio Project:** Advanced Log Analysis Tool
Create a comprehensive log analyzer that processes system/application logs with regex pattern matching, extracts key metrics, generates statistics (error rates, top users, time-based trends), and outputs formatted reports. Include functions for each analysis type and support multiple log formats.

***

### Week 4: Advanced Topics & Production Scripting

**Day 22: Error Handling & Debugging**
- **Lesson:** Set options (set -e, -u, -x, -o pipefail), trap command, error messages to stderr
- **Exercise 1:** Script with comprehensive error checking
- **Exercise 2:** Implement trap to clean up temporary files on exit
- **Exercise 3:** Debug script using set -x
- **Daily Project:** Create a robust installer script with proper error handling and rollback capabilities

**Day 23: Signal Handling & Process Management**
- **Lesson:** Trap signals (SIGINT, SIGTERM, SIGHUP), background processes (&), wait, jobs, kill
- **Exercise 1:** Handle Ctrl+C gracefully with cleanup
- **Exercise 2:** Run background processes and wait for completion
- **Exercise 3:** Script that monitors and restarts failed processes
- **Daily Project:** Build a process supervisor that starts, monitors, and restarts services on failure

**Day 24: Here Documents & Here Strings**
- **Lesson:** Here document syntax (<<EOF), here strings (<<<), variable substitution, indentation
- **Exercise 1:** Generate multi-line configuration file
- **Exercise 2:** Create email body with variable substitution
- **Exercise 3:** Pass multi-line input to commands
- **Daily Project:** Create a report generator that produces formatted HTML output using here documents

**Day 25: Script Optimization & Best Practices**
- **Lesson:** Efficient command usage, avoiding subshells, parameter expansion tricks, readonly variables
- **Exercise 1:** Optimize slow script by reducing command spawning
- **Exercise 2:** Use parameter expansion instead of external commands
- **Exercise 3:** Implement readonly constants for configuration
- **Daily Project:** Refactor previous project scripts applying optimization techniques and style guidelines

**Day 26: Command-Line Parsing & Getopts**
- **Lesson:** Getopts basics, option handling, optional arguments, combining short options
- **Exercise 1:** Script with -h (help), -v (verbose), -f (file) options
- **Exercise 2:** Handle required vs optional arguments
- **Exercise 3:** Implement long option equivalents manually
- **Daily Project:** Create a backup utility with comprehensive option parsing (-s source, -d dest, -c compress, -v verbose)

**Day 27: Working with JSON & APIs**
- **Lesson:** Using jq for JSON parsing, curl basics, API authentication, parsing responses
- **Exercise 1:** Fetch and parse JSON from public API
- **Exercise 2:** Extract specific fields from complex JSON
- **Exercise 3:** POST data to API endpoint
- **Daily Project:** Build a weather reporting tool that fetches data from weather API and displays formatted forecast

**Day 28: Cron Integration & Scheduling**
- **Lesson:** Crontab syntax, environment considerations, logging scheduled scripts, anacron
- **Exercise 1:** Create script suitable for cron (absolute paths, no TTY)
- **Exercise 2:** Implement email notifications for scheduled tasks
- **Exercise 3:** Handle concurrent execution with lockfiles
- **Daily Project:** Create an automated backup system with rotation that runs via cron and emails status reports

**Day 29: Testing & Documentation**
- **Lesson:** Unit testing with assert functions, integration testing, inline documentation, usage messages
- **Exercise 1:** Write test suite for validation functions
- **Exercise 2:** Create comprehensive help documentation
- **Exercise 3:** Implement --dry-run mode for testing
- **Daily Project:** Add tests and documentation to previous projects with automated test runner script

**Day 30: Final Portfolio Project**
- **No new lesson - integration day**
- **Final Project:** Automated System Administration Suite
  - Build a comprehensive sysadmin toolkit that includes:
    - User management (add/remove/modify with validation)
    - Automated backups with compression and rotation
    - System monitoring dashboard with alerts
    - Log analysis and reporting
    - Service health checks
    - Security audit functions
  - Requirements: Use functions, error handling, getopts, cron integration, proper documentation, test suite
  - The script should be production-ready with robust error handling and logging

**Week 4 Portfolio Project:** (Same as Day 30 Final Project)
Spend Days 29-30 building, testing, documenting, and refining your comprehensive system administration suite. This project should showcase all skills learned throughout the 30 days.

***

### Course Philosophy

Each daily project builds practical skills applicable to real-world system administration and automation tasks[3][4]. The progression moves from basic syntax to production-ready scripting with emphasis on error handling, maintainability, and best practices[5][6][2]. Weekly portfolio projects integrate multiple concepts and create reusable tools for your personal automation library.


```