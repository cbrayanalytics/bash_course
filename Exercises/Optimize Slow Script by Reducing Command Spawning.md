### Goal:
Create two versions of a script: `slow_script.sh` (inefficient) and `fast_script.sh` (optimized), demonstrating performance improvements.
### Requirements:
- Process a large dataset (10,000+ lines)
- Perform multiple operations per line
- Show execution time comparison
- Document optimization techniques
- Measure resource usage
- Provide detailed performance analysis
- Show CPU and memory improvements
- Generate benchmark report
### Expected Output Example:
```bash
./benchmark.sh
```
```
╔════════════════════════════════════════════════════════════════╗
║         SCRIPT OPTIMIZATION BENCHMARK                          ║
╚════════════════════════════════════════════════════════════════╝

Test Setup:
────────────────────────────────────────────────────────────────
Dataset: 10,000 records
Operations per record: 5
Test iterations: 3
System: Ubuntu 22.04, 8 cores, 16GB RAM

Generating test data...
✓ Test data created (10,000 records, 2.3 MB)

══════════════════════════════════════════════════════════════
TEST 1: SLOW SCRIPT (Unoptimized)
══════════════════════════════════════════════════════════════

Running slow_script.sh (iteration 1)...

Performance Issues Detected:
────────────────────────────────────────────────────────────────
⚠ 50,000 subshell spawns detected
⚠ 30,000 external command calls (cat, echo, cut, etc.)
⚠ Inefficient string operations
⚠ Multiple file reads
⚠ Unnecessary pipes

Iteration 1: 45.23 seconds
Iteration 2: 44.89 seconds
Iteration 3: 45.67 seconds

Average: 45.26 seconds
CPU usage: 85%
Memory peak: 234 MB
Process spawns: ~50,000
Context switches: 234,567

Slow Operations Identified:
────────────────────────────────────────────────────────────────
1. $(cat file) - 10,000 times (15.3s total)
2. echo | cut  - 10,000 times (8.7s total)
3. echo | grep - 10,000 times (7.2s total)
4. $(basename) - 10,000 times (5.4s total)
5. echo | sed  - 10,000 times (8.6s total)

══════════════════════════════════════════════════════════════
TEST 2: FAST SCRIPT (Optimized)
══════════════════════════════════════════════════════════════

Running fast_script.sh (iteration 1)...

Optimizations Applied:
────────────────────────────────────────────────────────────────
✓ Parameter expansion instead of cut/sed
✓ Built-in string operations
✓ Single file read with mapfile
✓ Array processing
✓ Eliminated unnecessary subshells
✓ Bash arithmetic instead of bc

Iteration 1: 2.34 seconds
Iteration 2: 2.28 seconds
Iteration 3: 2.31 seconds

Average: 2.31 seconds
CPU usage: 45%
Memory peak: 89 MB
Process spawns: ~10
Context switches: 5,678

╔════════════════════════════════════════════════════════════════╗
║                    BENCHMARK RESULTS                           ║
╚════════════════════════════════════════════════════════════════╝

Performance Improvement:
────────────────────────────────────────────────────────────────
Speed:          19.6x faster (45.26s → 2.31s)
CPU usage:      47% reduction (85% → 45%)
Memory:         62% reduction (234MB → 89MB)
Process spawns: 99.98% reduction (50,000 → 10)

Time saved: 42.95 seconds per run
Over 1000 runs: 11.9 hours saved

Optimization Breakdown:
────────────────────────────────────────────────────────────────
Eliminated $(cat):          15.3s saved (33.8%)
Parameter expansion:        16.5s saved (36.5%)
Single file read:            8.7s saved (19.2%)
Built-in operations:         4.8s saved (10.6%)

Code Changes:
────────────────────────────────────────────────────────────────
Lines of code: 156 → 134 (14% reduction)
Readability: Improved (fewer external commands)
Maintainability: Better (fewer dependencies)

╔════════════════════════════════════════════════════════════════╗
║              OPTIMIZATION EXAMPLES                             ║
╚════════════════════════════════════════════════════════════════╝

Example 1: String Extraction
────────────────────────────────────────────────────────────────
Before (slow):
  first=$(echo "$string" | cut -d' ' -f1)
  Time per call: 4.5ms

After (fast):
  first=${string%% *}
  Time per call: 0.001ms

Improvement: 4500x faster

Example 2: String Replacement
────────────────────────────────────────────────────────────────
Before (slow):
  result=$(echo "$string" | sed 's/old/new/g')
  Time per call: 4.2ms

After (fast):
  result=${string//old/new}
  Time per call: 0.001ms

Improvement: 4200x faster

Example 3: String Length
────────────────────────────────────────────────────────────────
Before (slow):
  length=$(echo -n "$string" | wc -c)
  Time per call: 3.8ms

After (fast):
  length=${#string}
  Time per call: 0.001ms

Improvement: 3800x faster

Example 4: File Reading
────────────────────────────────────────────────────────────────
Before (slow):
  while read line; do
      data=$(cat "$line")  # Read file each iteration
  done

After (fast):
  mapfile -t lines < file
  # Process array in memory

Improvement: Read file once instead of N times

Example 5: Uppercase Conversion
────────────────────────────────────────────────────────────────
Before (slow):
  upper=$(echo "$string" | tr '[:lower:]' '[:upper:]')
  Time per call: 4.1ms

After (fast):
  upper=${string^^}  # Bash 4+
  Time per call: 0.001ms

Improvement: 4100x faster

Recommendations:
────────────────────────────────────────────────────────────────
✓ Always use parameter expansion for string operations
✓ Read files once, process in memory
✓ Use bash arithmetic instead of bc (when possible)
✓ Avoid cat, use redirection
✓ Eliminate unnecessary pipes
✓ Use built-in commands over external ones
✓ Process arrays instead of line-by-line loops

Report saved to: benchmark_report_20251020.txt
```
### Bonus Challenge:
- Add profiling with `time` and `strace`
- Measure I/O operations
- Compare different Bash versions
- Test with various dataset sizes
- Add memory profiling
- Create optimization checklist
- Generate flame graphs
- Compare with other shells (zsh, dash)

***