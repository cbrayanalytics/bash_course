## Goal:
Build a script named `disk_calc.sh` that converts byte values to human-readable formats (KB, MB, GB, TB) with proper formatting.

***
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

***
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
## Hints:
- Use `bc` with `scale=2` for decimal precision
- Division factors: 1024 for KB, 1048576 for MB, 1073741824 for GB
- For "best unit", compare value ranges and choose most readable
- Use `printf` for aligned table formatting
- Get file size with `stat -f%z filename` (macOS) or `stat -c%s filename` (Linux)

***

## Pseudocode:
```bash
BEGIN disk_calc.sh

  ENABLE errexit, nounset, pipefail

  # Binary (base 1024) factors
  SET KB_FACTOR      = 1024
  SET MB_FACTOR      = 1_048_576       # 1024^2
  SET GB_FACTOR      = 1_073_741_824   # 1024^3
  SET TB_FACTOR      = 1_099_511_627_776 # 1024^4

  # SI/Decimal (base 1000) factors
  SET KB_FACTOR_SI   = 1_000
  SET MB_FACTOR_SI   = 1_000_000
  SET GB_FACTOR_SI   = 1_000_000_000
  SET TB_FACTOR_SI   = 1_000_000_000_000

  # Display settings
  SET DECIMAL_PRECISION = 2          # digits after decimal
  SET USE_SI_UNITS      = true       # true => base 1000, false => base 1024
  SET USE_COLOR         = true       # true => ANSI colors enabled

  # Color codes
  SET COLOR_HEADER      = "<cyan-bold>"
  SET COLOR_RESULT      = "<green-bold>"
  SET COLOR_RESET       = "<reset>"



FUNCTION display_usage()
  PRINT usage lines:
    "Usage: ./disk_calc.sh <bytes>"
    "       ./disk_calc.sh reverse <value> <unit>"
    "       ./disk_calc.sh file <filename> [filename2...]"
    "       ./disk_calc.sh scan <directory>"
    "       ./disk_calc.sh transfer <bytes> <speed_MBps>"
    "       ./disk_calc.sh compare <bytes>"
    "       ./disk_calc.sh file-csv <directory> <output.csv>"
    "Units: B, KB, MB, GB, TB"
    "Options:"
    "  --si        Use SI (base 1000) instead of binary (base 1024)"
    "  --no-color  Disable colored output"
    "Examples: ..."
END FUNCTION


FUNCTION display_error(message)
  PRINT "✗ Error: " + message TO stderr
END FUNCTION


FUNCTION colorize(text, color_code) RETURNS string
  IF USE_COLOR is true
    RETURN color_code + text + COLOR_RESET
  ELSE
    RETURN text
  END IF
END FUNCTION


FUNCTION is_number(value) RETURNS boolean
  IF value matches regex "^-?[0-9]+$"
    RETURN true
  ELSE
    RETURN false
  END IF
END FUNCTION


FUNCTION format_with_commas(number) RETURNS string
  # Format as floating number with DECIMAL_PRECISION and thousands separators
  CONVERT number to string with thousands separators and DECIMAL_PRECISION digits
  RETURN that formatted string
END FUNCTION


FUNCTION get_file_size(filename) RETURNS (success, bytes)
  IF filename does not exist OR is not a regular file
    display_error("File not found: " + filename)
    RETURN (false, 0)
  END IF

  TRY:
    size = result of "stat -c %s filename" (Linux)
    RETURN (true, size)
  IF that fails:
    TRY:
      size = result of "stat -f%z filename" (macOS/BSD)
      RETURN (true, size)
    IF that also fails:
      display_error("Unable to determine file size: " + filename)
      RETURN (false, 0)
END FUNCTION


FUNCTION bytes_to_kb(bytes, scale) RETURNS string
  IF USE_SI_UNITS is true
    factor = KB_FACTOR_SI
  ELSE
    factor = KB_FACTOR
  END IF

  result = bc("scale=scale; bytes / factor")
  RETURN result
END FUNCTION


FUNCTION determine_best_unit(bytes) RETURNS (value_string, unit_string)
  kb = bytes_to_kb(bytes, DECIMAL_PRECISION)
  mb = bytes_to_mb(bytes, DECIMAL_PRECISION)
  gb = bytes_to_gb(bytes, DECIMAL_PRECISION)
  tb = bytes_to_tb(bytes, DECIMAL_PRECISION)

  IF tb >= 1.0 (checked via bc)
    RETURN (tb, "TB")
  ELSE IF gb >= 1.0
    RETURN (gb, "GB")
  ELSE IF mb >= 1.0
    RETURN (mb, "MB")
  ELSE IF kb >= 1.0
    RETURN (kb, "KB")
  ELSE
    RETURN (bytes as string, "B")
  END IF
END FUNCTION


FUNCTION unit_to_bytes(value, unit) RETURNS integer_bytes
  unit_upper = uppercase(unit)

  SWITCH unit_upper:
    CASE "B":
      RETURN integer(value)
    CASE "KB":
      IF USE_SI_UNITS
        factor = KB_FACTOR_SI
      ELSE
        factor = KB_FACTOR
      END IF
    CASE "MB":
      IF USE_SI_UNITS
        factor = MB_FACTOR_SI
      ELSE
        factor = MB_FACTOR
      END IF
    CASE "GB":
      IF USE_SI_UNITS
        factor = GB_FACTOR_SI
      ELSE
        factor = GB_FACTOR
      END IF
    CASE "TB":
      IF USE_SI_UNITS
        factor = TB_FACTOR_SI
      ELSE
        factor = TB_FACTOR
      END IF
    DEFAULT:
      display_error("Invalid unit: " + unit)
      EXIT 1
  END SWITCH

  # For non-B units:
  result_float = bc("scale=DECIMAL_PRECISION; value * factor")
  result_int = round_down(result_float)
  RETURN result_int
END FUNCTION


FUNCTION display_header()
  header_text = colorize("Disk Space Calculator", COLOR_HEADER)

  PRINT "╔════════════════════════════════════════╗"
  PRINT "║         " + header_text + "          ║"
  PRINT "╚════════════════════════════════════════╝"
  PRINT blank line
END FUNCTION


FUNCTION display_conversion_table(bytes)
  kb = bytes_to_kb(bytes, DECIMAL_PRECISION)
  mb = bytes_to_mb(bytes, DECIMAL_PRECISION)
  gb = bytes_to_gb(bytes, DECIMAL_PRECISION)
  tb = bytes_to_tb(bytes, DECIMAL_PRECISION)

  formatted_bytes = format_with_commas(bytes)

  SET labels and unit abbreviations based on USE_SI_UNITS:
    IF USE_SI_UNITS:
      b_label  = "Bytes";      b_abbr  = "B"
      kb_label = "Kilobytes";  kb_abbr = "KB"
      mb_label = "Megabytes";  mb_abbr = "MB"
      gb_label = "Gigabytes";  gb_abbr = "GB"
      tb_label = "Terabytes";  tb_abbr = "TB"
    ELSE:
      b_label  = "Bytes";      b_abbr  = "B"
      kb_label = "Kibibytes";  kb_abbr = "KiB"
      mb_label = "Mebibytes";  mb_abbr = "MiB"
      gb_label = "Gibibytes";  gb_abbr = "GiB"
      tb_label = "Tebibytes";  tb_abbr = "TiB"

  PRINT "Input: " + formatted_bytes + " bytes"
  PRINT table top border and "Conversions" header

  total_width   = 40  # content width between borders
  label_width   = 12
  abbr_width    = 2
  value_width   = total_width - label_width - abbr_width

  PRINT row with label-width + value-width, left aligned:
    row1: b_label,  formatted_bytes + " " + b_abbr
    row2: kb_label, kb            + " " + kb_abbr
    row3: mb_label, mb            + " " + mb_abbr
    row4: gb_label, gb            + " " + gb_abbr
    row5: tb_label, tb            + " " + tb_abbr

  PRINT bottom border
END FUNCTION


FUNCTION display_best_representation(bytes)
  (best_value, best_unit) = determine_best_unit(bytes)
  colored = colorize(best_value + " " + best_unit, COLOR_RESULT)
  PRINT "Best Representation: " + colored
END FUNCTION


FUNCTION process_single_file(filename)
  (ok, bytes) = get_file_size(filename)
  IF ok is false
    RETURN

  IF bytes <= 0
    RETURN

  PRINT "File: " + filename
  PRINT blank line

  display_conversion_table(bytes)
  display_best_representation(bytes)
END FUNCTION


FUNCTION process_multiple_files(filenames_array)
  PRINT "Analyzing multiple files..."
  PRINT blank line

  total_bytes = 0
  DECLARE map file_sizes

  FOR each filename IN filenames_array:
    (ok, size) = get_file_size(filename)
    IF ok:
      file_sizes[filename] = size
      total_bytes += size
  END FOR

  IF total_bytes == 0:
    display_error("No valid files to process")
    RETURN failure

  PRINT table header: File | Size (Bytes) | Size (MB) | %

  FOR each filename, bytes IN file_sizes:
    file_only = basename(filename)
    mb        = bytes_to_mb(bytes, DECIMAL_PRECISION)
    formatted_bytes = format_with_commas(bytes)
    percentage = (bytes * 100) / total_bytes  (integer)
    PRINT row with file_only, formatted_bytes, mb, percentage%
  END FOR

  PRINT table footer

  total_formatted = format_with_commas(total_bytes)
  (total_value, total_unit) = determine_best_unit(total_bytes)
  PRINT "Total: total_formatted bytes (total_value total_unit)"
END FUNCTION


FUNCTION reverse_convert(value, unit)
  IF is_number(value) is false
    display_error("Value must be a number")
    EXIT 1
  END IF

  bytes = unit_to_bytes(value, unit)
  formatted = format_with_commas(bytes)

  PRINT "Converting: value unit to bytes"
  PRINT "Result: formatted bytes"
END FUNCTION


FUNCTION show_storage_comparison(bytes)
  cd_size  = 700 * MB_FACTOR        # 700 MB
  dvd_size = 4.7 * GB_FACTOR (approximated) 
  bd_size  = 25 * GB_FACTOR
  usb_size = 32 * GB_FACTOR

  PRINT "Storage Media Comparison:"
  PRINT separator line

  IF bytes < cd_size:
    cd_percent = bc("scale=DECIMAL_PRECISION; bytes / cd_size * 100")
    PRINT "CD (700MB): cd_percent% full"
    draw_progress_bar(bytes, cd_size)
  END IF

  IF bytes < dvd_size:
    dvd_percent = similar formula
    PRINT "DVD (4.7GB): dvd_percent% full"
    draw_progress_bar(bytes, dvd_size)
  END IF

  IF bytes < bd_size:
    bd_percent = similar formula
    PRINT "BD (25GB): bd_percent% full"
    draw_progress_bar(bytes, bd_size)
  END IF

  IF bytes < usb_size:
    usb_percent = similar formula
    PRINT "USB (32GB): usb_percent% full"
    draw_progress_bar(bytes, usb_size)
  END IF

  PRINT separator line
END FUNCTION


FUNCTION draw_progress_bar(current, total)
  bar_width = 40

  percent = bc("scale=DECIMAL_PRECISION; 100 * current / total")
  filled  = bc("scale=0; bar_width * percent / 100")  # integer count

  PRINT "[" without newline
  PRINT '█' repeated 'filled' times without newline
  PRINT ' ' repeated (bar_width - filled) times without newline
  PRINT "] percent%" with newline
END FUNCTION


FUNCTION export_to_csv(data_array, output_file)
  WRITE "Filename,Bytes,KB,MB,GB,TB" to output_file

  FOR each entry IN data_array:
    APPEND entry to output_file as a line
  END FOR

  PRINT "Exported to: output_file"
END FUNCTION


FUNCTION scan_directory_to_csv(directory, output_file)
  file_list = list of all regular files under directory (recursive)

  DECLARE array csv_lines

  FOR each filename IN file_list:
    (ok, bytes) = get_file_size(filename)
    IF not ok: CONTINUE

    kb = bytes_to_kb(bytes, DECIMAL_PRECISION)
    mb = bytes_to_mb(bytes, DECIMAL_PRECISION)
    gb = bytes_to_gb(bytes, DECIMAL_PRECISION)
    tb = bytes_to_tb(bytes, DECIMAL_PRECISION)

    csv_line = quoted(filename) + "," + bytes + "," + kb + "," + mb + "," + gb + "," + tb
    APPEND csv_line to csv_lines
  END FOR

  export_to_csv(csv_lines, output_file)
END FUNCTION


FUNCTION scan_directory(directory)
  file_list = list of all regular files under directory (recursive)
  PRINT "Scanning directory: directory"
  process_multiple_files(file_list)
END FUNCTION

FUNCTION calculate_transfer_time(bytes, speed_mbps)
  megabytes = bytes_to_mb(bytes, DECIMAL_PRECISION)
  seconds   = bc("scale=0; megabytes / speed_mbps")
  minutes   = seconds / 60
  hours     = minutes / 60

  PRINT "Transfer time at speed_mbps MB/s:"
  IF hours >= 1:
    PRINT "  hours hours"
  ELSE IF minutes >= 1:
    PRINT "  minutes minutes"
  ELSE
    PRINT "  seconds seconds"
  END IF
END FUNCTION


FUNCTION main(args...)
  # Parse global flags
  WHILE there is at least one arg AND first arg starts with "-":
    SWITCH first arg:
      CASE "--si":
        USE_SI_UNITS = true
        REMOVE first arg
      CASE "--no-color":
        USE_COLOR = false
        REMOVE first arg
      CASE "--help" OR "-h":
        display_usage()
        EXIT 0
      DEFAULT:
        display_error("Unknown flag: " + first_arg)
        EXIT 1
    END SWITCH
  END WHILE

  IF no arguments remain:
    display_error("No arguments provided")
    display_usage()
    EXIT 1
  END IF

  mode = first remaining argument

  SWITCH mode:

    CASE "reverse":
      REQUIRE at least 2 more args: value, unit
      CALL reverse_convert(value, unit)

    CASE "file":
      REQUIRE at least 1 more arg (one or more filenames)
      filenames = remaining args
      IF only 1 filename:
        process_single_file(filenames[0])
      ELSE:
        process_multiple_files(filenames)
      END IF

    CASE "transfer":
      REQUIRE bytes and speed
      IF either not numeric: error
      calculate_transfer_time(bytes, speed)

    CASE "compare":
      REQUIRE bytes
      IF not numeric: error
      show_storage_comparison(bytes)

    CASE "scan":
      REQUIRE directory
      IF directory not a valid dir: error
      scan_directory(directory)

    CASE "file-csv":
      REQUIRE directory and output_file
      VALIDATE directory is a dir
      scan_directory_to_csv(directory, output_file)

    DEFAULT:
      # Treat mode itself as a byte count
      bytes_default = mode
      IF not numeric: error
      display_header()
      display_conversion_table(bytes_default)
      display_best_representation(bytes_default)

  END SWITCH
END FUNCTION

CALL main(with command-line arguments)

END disk_calc.sh
```

***
## Expected Output Example:

```bash
./disk_calc.sh 1536000

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

***
