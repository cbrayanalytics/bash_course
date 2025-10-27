### Goal:
Create a script named `debug_example.sh` that demonstrates effective use of debugging techniques, particularly set -x.
### Requirements:
- Show normal execution
- Show debug mode with set -x
- Show selective debugging
- Custom debug output formatting
- Debug level control (verbose, debug, trace)
- Variable state tracking
- Function call tracing
- Performance profiling
- Support debug log file output
- Add conditional debugging
### Expected Output Example:
```bash
./debug_example.sh
```
```
╔════════════════════════════════════════════════════════════════╗
║              DEBUGGING DEMONSTRATION                           ║
╚════════════════════════════════════════════════════════════════╝

[INFO] Running in normal mode (no debug output)

Step 1: Initializing...
✓ Configuration loaded
✓ Variables initialized

Step 2: Processing data...
✓ 1,247 records processed

Step 3: Generating output...
✓ Output file created

[INFO] Completed successfully
```

```bash
./debug_example.sh --debug
```
```
╔════════════════════════════════════════════════════════════════╗
║       DEBUGGING DEMONSTRATION (Debug Mode)                     ║
╚════════════════════════════════════════════════════════════════╝

[DEBUG] Debug mode enabled
[DEBUG] Trace output will be shown

Step 1: Initializing...
+ config_file=/etc/app/config.yaml
+ [[ -f /etc/app/config.yaml ]]
+ load_config /etc/app/config.yaml
++ cat /etc/app/config.yaml
++ parse_yaml
+ settings='host=localhost port=8080'
+ debug_var 'settings' 'host=localhost port=8080'
+ echo '[DEBUG] settings=host=localhost port=8080'
[DEBUG] settings=host=localhost port=8080
✓ Configuration loaded

+ count=0
+ total=1247
+ debug_var 'count' 0
[DEBUG] count=0
+ debug_var 'total' 1247
[DEBUG] total=1247
✓ Variables initialized

Step 2: Processing data...
+ for item in "${items[@]}"
+ process_item 'item1'
++ transform_data 'item1'
++ echo 'ITEM1'
+ result=ITEM1
+ debug_var 'result' 'ITEM1'
[DEBUG] result=ITEM1
+ (( count++ ))
+ [[ 1 -eq 100 ]]
+ [[ 1 -eq 200 ]]
[... processing continues ...]
✓ 1,247 records processed

Step 3: Generating output...
+ output_file=result.txt
+ echo 'Writing results...'
Writing results...
+ cat
+ tee result.txt
[... output data ...]
✓ Output file created

[DEBUG] Execution trace complete
[INFO] Completed successfully
```

```bash
./debug_example.sh --verbose --trace
```
```
╔════════════════════════════════════════════════════════════════╗
║       DEBUGGING DEMONSTRATION (Verbose + Trace)                ║
╚════════════════════════════════════════════════════════════════╝

[TRACE] Script: debug_example.sh
[TRACE] PID: 12345
[TRACE] User: john
[TRACE] Directory: /home/john/scripts
[TRACE] Start time: 2025-10-19 23:54:00

[TRACE] Function call: main()
[TRACE]   Line: 45

Step 1: Initializing...
[TRACE] Function call: load_config()
[TRACE]   Line: 67
[TRACE]   Args: /etc/app/config.yaml
[TRACE]   Entry: config_file=/etc/app/config.yaml

+ config_file=/etc/app/config.yaml
[TRACE] Variable set: config_file=/etc/app/config.yaml

+ [[ -f /etc/app/config.yaml ]]
[TRACE] Test: file exists check
[TRACE] Result: true

+ load_config /etc/app/config.yaml
[TRACE] Function call: load_config()
[TRACE]   Caller: main:45

++ cat /etc/app/config.yaml
[TRACE] Command: cat /etc/app/config.yaml
[TRACE] Output: (3 lines)

++ parse_yaml
[TRACE] Function call: parse_yaml()
[TRACE]   Reading from stdin

+ settings='host=localhost port=8080'
[TRACE] Variable set: settings=host=localhost port=8080
[TRACE] Function exit: load_config()
[TRACE]   Return code: 0
[TRACE]   Duration: 0.023s

[VERBOSE] Configuration loaded successfully
[VERBOSE]   Host: localhost
[VERBOSE]   Port: 8080
[VERBOSE]   Settings: 2 values parsed
✓ Configuration loaded

[TRACE] Function call: initialize_variables()
+ count=0
[TRACE] Variable set: count=0
+ total=1247
[TRACE] Variable set: total=1247
[TRACE] Function exit: initialize_variables()
[TRACE]   Return code: 0
[TRACE]   Duration: 0.001s

✓ Variables initialized

[TRACE] Current state:
[TRACE]   config_file=/etc/app/config.yaml
[TRACE]   settings=host=localhost port=8080
[TRACE]   count=0
[TRACE]   total=1247

Step 2: Processing data...
[TRACE] Function call: process_data()
[TRACE]   Loop iteration: 1/1247

[... detailed trace continues ...]

[TRACE] Function exit: main()
[TRACE]   Return code: 0
[TRACE]   Total duration: 2.345s

[TRACE] Memory usage: 45.2 MB
[TRACE] Peak memory: 52.3 MB
[TRACE] CPU time: 1.234s

[INFO] Completed successfully
```

```bash
DEBUG_LOG=debug.log ./debug_example.sh
```
```
[INFO] Debug logging enabled
[INFO] Debug output: debug.log

[INFO] Running with debug logging to file...
✓ Processing complete

[INFO] Debug log created: debug.log (156 KB)
[INFO] View log: less debug.log
```
### Bonus Challenge:
- Add stack trace on error
- Implement breakpoint support
- Add watch variables
- Create debug replay
- Support remote debugging
- Add performance profiling
- Implement conditional breakpoints
- Create debug report generator

***