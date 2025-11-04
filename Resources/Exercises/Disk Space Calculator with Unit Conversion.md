## Goal:
Build a script named `disk_calc.sh` that converts byte values to human-readable formats (KB, MB, GB, TB) with proper formatting.
## Requirements:
**Core functionality:**
- Accept byte value as argument (or read from stdin)
- Convert to all common units:
  - Bytes (B)
  - Kilobytes (KB) - 1024 bytes
  - Megabytes (MB) - 1024 KB
  - Gigabytes (GB) - 1024 MB
  - Terabytes (TB) - 1024 GB
- Display all conversions in a formatted table
- Use 2 decimal places for precision
- Automatically determine best unit (show primary result)

**Additional features:**
- Support reverse conversion (KB/MB/GB to bytes)
- Handle multiple file sizes (if multiple arguments provided)
- Show percentage of total if calculating multiple files
- Colorize output for readability
## Hints:
- Use `bc` with `scale=2` for decimal precision
- Division factors: 1024 for KB, 1048576 for MB, 1073741824 for GB
- For "best unit", compare value ranges and choose most readable
- Use `printf` for aligned table formatting
- Get file size with `stat -f%z filename` (macOS) or `stat -c%s filename` (Linux)
## Expected Output Example:
```bash
./disk_calc.sh 1536000
```
```
╔════════════════════════════════════════╗
║       Disk Space Calculator            ║
╚════════════════════════════════════════╝

Input: 1536000 bytes

┌────────────────────────────────────────┐
│ Conversions:                           │
├────────────────────────────────────────┤
│ Bytes:      1,536,000 B                │
│ Kilobytes:  1,500.00 KB                │
│ Megabytes:  1.46 MB                    │
│ Gigabytes:  0.00 GB                    │
│ Terabytes:  0.00 TB                    │
└────────────────────────────────────────┘

Best representation: 1.46 MB
```

```bash
./disk_calc.sh reverse 5 GB
```
```
Converting: 5 GB to bytes
Result: 5,368,709,120 bytes
```

```bash
./disk_calc.sh file /home/user/large_file.iso
```
```
File: /home/user/large_file.iso

Size: 4,700,000,000 bytes
Best representation: 4.38 GB

┌────────────────────────────────────────┐
│ All Units:                             │
├────────────────────────────────────────┤
│ 4,700,000,000 B                        │
│ 4,589,843.75 KB                        │
│ 4,482.27 MB                            │
│ 4.38 GB                                │
│ 0.00 TB                                │
└────────────────────────────────────────┘
```

```bash
./disk_calc.sh file *.txt
```
```
Analyzing multiple files...

┌─────────────────────────────────────────────────────┐
│ File              │ Size (Bytes) │ Size (MB) │  %   │
├─────────────────────────────────────────────────────┤
│ file1.txt         │    1,048,576 │      1.00 │ 25%  │
│ file2.txt         │    2,097,152 │      2.00 │ 50%  │
│ file3.txt         │    1,048,576 │      1.00 │ 25%  │
└─────────────────────────────────────────────────────┘

Total: 4,194,304 bytes (4.00 MB)
```
## Bonus Challenges:
- Add support for decimal (base 10) vs binary (base 2) units (MB vs MiB)
- Create progress bar showing size relative to common storage media
- Compare against available disk space
- Support SI prefixes (1000-based instead of 1024-based)
- Add speed calculation (MB/s) if given time duration
- Create CSV export of results
- Scan entire directory recursively and show size breakdown
- Generate visual bar chart of file sizes
- Support both input from arguments and interactive mode
- Add compression estimation (predict compressed size)

***