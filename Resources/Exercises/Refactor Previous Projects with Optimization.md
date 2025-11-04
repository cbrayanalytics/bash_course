### Goal:
Refactor one or more previous week projects (log analyzer, process supervisor, installer, etc.) applying all optimization techniques and style guidelines learned.
### Requirements:
**Optimization Techniques to Apply:**
1. Replace external commands with parameter expansion
2. Eliminate unnecessary subshells
3. Use bash arithmetic instead of bc
4. Read files once with mapfile
5. Use arrays for data processing
6. Eliminate useless cat, echo, etc.
7. Optimize loops
8. Use built-in string operations

**Code Style Guidelines:**
1. Use readonly for constants
2. Consistent naming conventions (CONSTANTS, variables, functions)
3. Comprehensive error handling
4. Proper quoting
5. ShellCheck compliance
6. Comments and documentation
7. Function modularity
8. DRY principle (Don't Repeat Yourself)

**Benchmarking:**
- Before/after performance comparison
- Memory usage analysis
- CPU usage comparison
- Line count reduction
- Readability improvements
### Expected Output Example:
```bash
./refactor_analyzer.sh --project log_analyzer --output optimized_log_analyzer.sh
```

```
╔════════════════════════════════════════════════════════════════╗
║         PROJECT REFACTORING ANALYZER                           ║
╚════════════════════════════════════════════════════════════════╝

Project: Advanced Log Analyzer (Week 3 Portfolio)
Original: advanced_log_analyzer.sh
Output: optimized_log_analyzer.sh

Analyzing original code...
████████████████████████████████████████ 100%

Original Code Analysis:
════════════════════════════════════════════════════════════════

Code Metrics:
────────────────────────────────────────────────────────────────
Total lines:           1,247
Code lines:             892
Comment lines:          213
Blank lines:            142
Functions:               34
Constants:               12 (not readonly)
Variables:              127

Optimization Opportunities Found: 67
────────────────────────────────────────────────────────────────
🔴 Critical (15):
  • 8 instances of $(cat file)
  • 4 instances of echo | cut
  • 3 instances of echo | sed

⚠  Warning (32):
  • 15 instances of $(echo "$var" | command)
  • 12 instances of unnecessary subshells
  • 5 instances of useless cat

ℹ  Info (20):
  • 10 constants not marked readonly
  • 7 magic numbers (should be constants)
  • 3 repeated code blocks

Performance Issues:
────────────────────────────────────────────────────────────────
• parse_log_line() called 10,000+ times with subshells
• extract_ip() spawns grep unnecessarily
• Multiple file reads (should read once)
• String operations using sed/awk instead of parameter expansion

Applying optimizations...
════════════════════════════════════════════════════════════════

[1/15] Replacing $(cat file) with $(<file)...
  ✓ 8 instances replaced
  
[2/15] Converting echo | cut to parameter expansion...
  ✓ 4 instances converted
  
[3/15] Replacing echo | sed with parameter expansion...
  ✓ 3 instances replaced
  
[4/15] Eliminating useless cat...
  ✓ 5 instances removed
  
[5/15] Converting to readonly constants...
  ✓ 10 constants converted
  
[6/15] Extracting magic numbers to constants...
  ✓ 7 magic numbers extracted
  
[7/15] Optimizing parse_log_line()...
  Before: Uses sed, awk, grep (3 subshells per call)
  After: Uses parameter expansion (0 subshells)
  ✓ Function optimized
  
[8/15] Optimizing extract_ip()...
  Before: grep -Eo for IP extraction
  After: Parameter expansion with regex
  ✓ Function optimized
  
[9/15] Converting to single file read...
  Before: File read multiple times in loops
  After: Read once with mapfile, process array
  ✓ File I/O optimized
  
[10/15] Refactoring repeated code...
  ✓ 3 code blocks extracted to functions
  
[11/15] Optimizing string operations...
  ✓ 15 operations converted to parameter expansion
  
[12/15] Eliminating unnecessary subshells...
  ✓ 12 subshells eliminated
  
[13/15] Converting bc to bash arithmetic...
  ✓ 3 instances converted
  
[14/15] Adding ShellCheck compliance...
  ✓ All warnings resolved
  
[15/15] Code formatting and style...
  ✓ Consistent formatting applied

╔════════════════════════════════════════════════════════════════╗
║                REFACTORING COMPLETE                            ║
╚════════════════════════════════════════════════════════════════╝

Refactored Code Metrics:
════════════════════════════════════════════════════════════════

Total lines:           1,134 (↓ 9.1%)
Code lines:             823 (↓ 7.7%)
Comment lines:          198 (↓ 7.0%)
Blank lines:            113 (↓ 20.4%)
Functions:               37 (↑ 8.8% - better modular)
Readonly constants:      17 (↑ 41.7%)
Variables:              103 (↓ 18.9%)

Performance Benchmark:
════════════════════════════════════════════════════════════════

Test: Processing 100,000 log lines

Original Version:
────────────────────────────────────────────────────────────────
Execution time:    45.67 seconds
CPU usage:         87%
Memory peak:       234 MB
Process spawns:    ~50,000

Optimized Version:
────────────────────────────────────────────────────────────────
Execution time:    3.42 seconds  (13.3x faster ⚡)
CPU usage:         52%           (40% reduction)
Memory peak:       89 MB         (62% reduction)
Process spawns:    ~15           (99.97% reduction)

Improvements:
════════════════════════════════════════════════════════════════
✓ Speed:           13.3x faster
✓ CPU:             40% less usage
✓ Memory:          62% reduction
✓ Process spawns:  99.97% fewer
✓ Code size:       9% smaller
✓ Readability:     Improved
✓ Maintainability: Better

Key Optimizations:
────────────────────────────────────────────────────────────────
1. parse_log_line():     45% time saved
2. File I/O:             25% time saved
3. String operations:    20% time saved
4. Eliminated subshells: 10% time saved

Code Quality Improvements:
────────────────────────────────────────────────────────────────
✓ All constants now readonly
✓ No magic numbers
✓ Better error handling
✓ Consistent naming
✓ DRY principle applied
✓ ShellCheck clean
✓ Better documentation

Side-by-Side Comparison:
════════════════════════════════════════════════════════════════

Example: parse_log_line() function

BEFORE:
────────────────────────────────────────────────────────────────
parse_log_line() {
    local line=$1
    ip=$(echo "$line" | awk '{print $1}')
    timestamp=$(echo "$line" | awk '{print $4}' | sed 's/\[//')
    method=$(echo "$line" | grep -Eo 'GET|POST|PUT|DELETE')
    url=$(echo "$line" | awk '{print $7}')
    status=$(echo "$line" | awk '{print $9}')
}
# 3 subshells per call × 100,000 calls = 300,000 subshells

AFTER:
────────────────────────────────────────────────────────────────
parse_log_line() {
    local line=$1
    # Parse using parameter expansion and regex
    [[ $line =~ ^([^ ]+)\ .*\[([^\]]+)\]\ \"([A-Z]+)\ ([^ ]+).*\"\ ([0-9]+) ]]
    ip=${BASH_REMATCH[1]}
    timestamp=${BASH_REMATCH[2]}
    method=${BASH_REMATCH[3]}
    url=${BASH_REMATCH[4]}
    status=${BASH_REMATCH[5]}
}
# 0 external commands, 0 subshells

Performance gain: 4500x faster for this function

Files Generated:
════════════════════════════════════════════════════════════════
✓ optimized_log_analyzer.sh     (refactored script)
✓ refactoring_report.txt         (this report)
✓ optimization_details.txt       (detailed changes)
✓ before_after_benchmark.txt     (performance data)

Next Steps:
────────────────────────────────────────────────────────────────
1. Review: diff advanced_log_analyzer.sh optimized_log_analyzer.sh
2. Test: Run both versions and compare output
3. Benchmark: ./benchmark.sh --both
4. Deploy: Replace old version with optimized

To run optimized version:
  ./optimized_log_analyzer.sh --file /var/log/access.log
```

**Detailed optimization example:**
```bash
cat optimization_details.txt
```

```
╔════════════════════════════════════════════════════════════════╗
║         DETAILED OPTIMIZATION CHANGES                          ║
╚════════════════════════════════════════════════════════════════╝

OPTIMIZATION 1: Extract IP from Log Line
════════════════════════════════════════════════════════════════

BEFORE (Old approach):
────────────────────────────────────────────────────────────────
extract_ip() {
    local line=$1
    echo "$line" | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' | head -1
}

ip=$(extract_ip "$log_line")

Performance:
  • Spawns 3 processes (grep, head, subshell)
  • Time per call: ~4.2ms
  • For 100,000 lines: 420 seconds

AFTER (Optimized):
────────────────────────────────────────────────────────────────
extract_ip() {
    local line=$1
    [[ $line =~ ^([0-9]{1,3}\.){3}[0-9]{1,3} ]]
    echo "${BASH_REMATCH[0]}"
}

ip=$(extract_ip "$log_line")

# Or even better, inline:
[[ $log_line =~ ^([0-9]{1,3}\.){3}[0-9]{1,3} ]]
ip=${BASH_REMATCH[0]}

Performance:
  • 0 external processes
  • Time per call: ~0.001ms
  • For 100,000 lines: 0.1 seconds

Improvement: 4200x faster, 420s → 0.1s saved

════════════════════════════════════════════════════════════════

OPTIMIZATION 2: String Manipulation
════════════════════════════════════════════════════════════════

BEFORE:
────────────────────────────────────────────────────────────────
url="/api/v1/users"
endpoint=$(echo "$url" | sed 's/^\/api\///')  # Remove /api/ prefix

Performance: ~4.1ms per call

AFTER:
────────────────────────────────────────────────────────────────
url="/api/v1/users"
endpoint=${url#/api/}  # Remove /api/ prefix

Performance: ~0.001ms per call

Improvement: 4100x faster

════════════════════════════════════════════════════════════════

OPTIMIZATION 3: Read File Multiple Times → Read Once
════════════════════════════════════════════════════════════════

BEFORE:
────────────────────────────────────────────────────────────────
while read -r line; do
    process_line "$line"
done < logfile.txt

# Inside process_line, other functions read the file again:
count_errors() {
    grep -c "ERROR" logfile.txt  # Reads entire file!
}

# File read: N+1 times (N lines + 1 for count)

AFTER:
────────────────────────────────────────────────────────────────
# Read file once into array
mapfile -t lines < logfile.txt

# Process array
for line in "${lines[@]}"; do
    process_line "$line"
done

# Count errors from array, not file
count_errors() {
    local count=0
    for line in "${lines[@]}"; do
        [[ $line =~ ERROR ]] && ((count++))
    done
    echo "$count"
}

# File read: 1 time total

Improvement: For 100,000 line file, saved 100,000 file reads

════════════════════════════════════════════════════════════════

OPTIMIZATION 4: Constants Made Readonly
════════════════════════════════════════════════════════════════

BEFORE:
────────────────────────────────────────────────────────────────
LOG_LEVEL="info"
MAX_ERRORS=100
TIMEOUT=30

# Risk: Can be accidentally modified
LOG_LEVEL="debug"  # Oops!

AFTER:
────────────────────────────────────────────────────────────────
readonly LOG_LEVEL="info"
readonly MAX_ERRORS=100
readonly TIMEOUT=30

# Protection: Cannot be modified
LOG_LEVEL="debug"  # Error: LOG_LEVEL: readonly variable

Improvement: Prevents bugs from accidental modification

════════════════════════════════════════════════════════════════

Summary of All Changes: 67 optimizations applied
Total time saved per run: 42.25 seconds
Total performance improvement: 13.3x faster
```
