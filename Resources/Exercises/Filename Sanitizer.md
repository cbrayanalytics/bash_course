## Goal:
Build a comprehensive script named `sanitize.sh` that cleans and standardizes filenames according to best practices.

***
## Requirements:
**Input:**
- Accept one or more filenames as arguments
- Process each filename individually

**Sanitization operations:**
1. Convert to lowercase
2. Replace spaces with underscores or hyphens
3. Remove or replace special characters (!@#$%^&*()etc.)
4. Remove multiple consecutive underscores/hyphens (collapse to single)
5. Remove leading/trailing underscores or hyphens
6. Truncate to reasonable length (e.g., 255 characters max)
7. Preserve file extension
8. Ensure filename doesn't start with a dot or dash
9. Replace accented characters (optional: é→e, ñ→n)

**Output:**
- Show original filename
- Show sanitized filename
- Show what changes were made
- Optionally rename the actual file (with confirmation)

***
## Hints:
- Process in stages, storing intermediate results
- Use string replacement operations extensively
- Preserve the extension separately, sanitize basename, then recombine
- Use parameter expansion for most operations
- Consider using `tr` command for some character replacements
- Test with problematic filenames containing various special characters

***
## Pseudocode:
```bash
  // ==============================
  // Configuration / Defaults
  // ==============================
  SET MAX_LENGTH = 255
  SET DEFAULT_SEPARATOR = "_"          // can be changed to "-" via flag
  SET rename_mode = false              // -r
  SET preview_mode = false             // -p (no actual renames)
  SET separator = DEFAULT_SEPARATOR
  SET backup_enabled = false
  SET whitelist_mode = false
  SET naming_convention = "snake"      // snake | kebab | camel | pascal
  SET log_file = ""                    // set if logging enabled

  // ==============================
  // Helper Functions
  // ==============================

  FUNCTION display_usage()
    DISPLAY "Usage: sanitize.sh [options] <file1> [file2 ...]"
    DISPLAY "Options:"
    DISPLAY "  -r              Rename files on disk (with confirmation)"
    DISPLAY "  -p              Preview only (no renames)"
    DISPLAY "  -b              Create backup mapping of original->sanitized"
    DISPLAY "  -s <char>       Replacement separator (_ or -)"
    DISPLAY "  -w              Whitelist mode (only allow safe chars)"
    DISPLAY "  -n <style>      Naming style: snake, kebab, camel, pascal"
    DISPLAY "  -h              Show help"
  END FUNCTION

  FUNCTION display_error(msg)
    DISPLAY "✗ Error: " + msg
  END FUNCTION

  FUNCTION log_change(original, sanitized, status)
    IF log_file is empty THEN
      RETURN
    END IF
    SET timestamp = current date+time string
    APPEND (timestamp + " | " + status + " | " + original + " -> " + sanitized) TO log_file
  END FUNCTION

  FUNCTION extract_extension(filename)
    IF filename contains "." THEN
      SET ext = substring from last "." to end (including dot)
      RETURN ext                    // e.g. ".pdf", ".tar.gz" (you can decide policy)
    ELSE
      RETURN ""                     // no extension
    END IF
  END FUNCTION

  FUNCTION extract_basename(filename, extension)
    IF extension is empty THEN
      RETURN filename
    ELSE
      RETURN filename without trailing extension part
    END IF
  END FUNCTION

  FUNCTION to_lowercase(text)
    RETURN text converted to lowercase
  END FUNCTION

  FUNCTION replace_spaces(text, sep)
    RETURN text with all spaces replaced by sep
  END FUNCTION

  FUNCTION transliterate_accents(text)
    // basic manual replacements; could also use iconv
    REPLACE "áàäâ" with "a" (case insensitive)
    REPLACE "éèëê" with "e"
    REPLACE "íìïî" with "i"
    REPLACE "óòöô" with "o"
    REPLACE "úùüû" with "u"
    REPLACE "ñ" with "n"
    // handle uppercase equivalents similarly
    RETURN result
  END FUNCTION

  FUNCTION remove_special_chars(text)
    // keep letters, digits, separator, dot
    // remove characters like !@#$%^&*()[]{}|;:'"<>?,/`\~
    FOR each char in text
      IF char NOT in [a-z A-Z 0-9 separator "."]
        REMOVE char
      END IF
    END FOR
    RETURN result
  END FUNCTION

  FUNCTION whitelist_filter(text)
    // whitelist mode: only allow a-z, A-Z, 0-9, separator, dot
    FOR each char in text
      IF char NOT in [a-z A-Z 0-9 separator "."]
        REMOVE char
      END IF
    END FOR
    RETURN result
  END FUNCTION

  FUNCTION collapse_separators(text, sep)
    LOOP
      SET double = sep + sep
      IF text contains double
        REPLACE all occurrences of double with sep
      ELSE
        BREAK
      END IF
    END LOOP
    RETURN text
  END FUNCTION

  FUNCTION trim_separators(text, sep)
    WHILE text starts with sep
      REMOVE first character
    END WHILE
    WHILE text ends with sep
      REMOVE last character
    END WHILE
    RETURN text
  END FUNCTION

  FUNCTION ensure_valid_start(text)
    // must not start with "." or "-"
    WHILE text starts with "." OR text starts with "-"
      REMOVE first character
    END WHILE
    IF text is empty
      text = "unnamed"
    END IF
    RETURN text
  END FUNCTION

  FUNCTION truncate_to_max(text, max_len)
    IF length(text) > max_len
      RETURN first max_len characters of text
    ELSE
      RETURN text
    END IF
  END FUNCTION

  FUNCTION apply_naming_convention(basename, style, sep)
    IF style == "snake"
      // already using lowercase + separator, nothing extra
      RETURN basename
    ELSE IF style == "kebab"
      REPLACE all separators in basename with "-"
      RETURN basename
    ELSE IF style == "camel"
      SPLIT basename on separator into words array
      IF words length == 0
        RETURN basename
      END IF
      SET result = first word in lowercase
      FOR each remaining word
        CAPITALIZE first letter, lowercase rest, append to result
      END FOR
      RETURN result
    ELSE IF style == "pascal"
      SPLIT basename on separator into words array
      SET result = empty
      FOR each word
        CAPITALIZE first letter, lowercase rest, append to result
      END FOR
      RETURN result
    ELSE
      RETURN basename
    END IF
  END FUNCTION

  FUNCTION generate_unique_name(dir, sanitized_name)
    SET candidate = sanitized_name
    SET counter = 1
    WHILE file (dir + "/" + candidate) exists
      SPLIT candidate into base and ext via extract_extension
      SET base_only = extract_basename(candidate, ext)
      candidate = base_only + "_" + counter + ext
      INCREMENT counter
    END WHILE
    RETURN candidate
  END FUNCTION

  FUNCTION sanitize_basename(basename, sep, style, use_whitelist)
    SET changes = empty list
    SET original = basename
    SET current = basename

    // 1) Accents
    SET new = transliterate_accents(current)
    IF new != current
      ADD "Replaced accented characters" to changes
      current = new
    END IF

    // 2) lowercase
    SET new = to_lowercase(current)
    IF new != current
      ADD "Converted to lowercase" to changes
      current = new
    END IF

    // 3) spaces → separator
    IF current contains space
      SET new = replace_spaces(current, sep)
      ADD "Replaced spaces with " + sep to changes
      current = new
    END IF

    // 4) remove or whitelist special chars
    IF use_whitelist
      SET new = whitelist_filter(current)
      IF new != current
        ADD "Removed non-whitelisted characters" to changes
        current = new
      END IF
    ELSE
      SET new = remove_special_chars(current)
      IF new != current
        ADD "Removed special characters" to changes
        current = new
      END IF
    END IF

    // 5) collapse separators
    SET new = collapse_separators(current, sep)
    IF new != current
      ADD "Collapsed multiple separators" to changes
      current = new
    END IF

    // 6) trim separators
    SET new = trim_separators(current, sep)
    IF new != current
      ADD "Trimmed leading/trailing separators" to changes
      current = new
    END IF

    // 7) ensure valid start
    SET new = ensure_valid_start(current)
    IF new != current
      ADD "Adjusted leading characters (no dot/dash)" to changes
      current = new
    END IF

    // 8) apply naming convention
    SET new = apply_naming_convention(current, style, sep)
    IF new != current
      ADD "Applied naming convention: " + style to changes
      current = new
    END IF

    // length truncation handled after extension recombine
    RETURN [current, changes]
  END FUNCTION

  FUNCTION process_single_filename(path)
    DISPLAY "════════════════════════════════════════"
    DISPLAY "Processing: " + path
    DISPLAY "════════════════════════════════════════"

    IF file path does not exist
      DISPLAY "Original:   " + path
      DISPLAY "Sanitized:  (skipped - file not found)"
      RETURN
    END IF

    SET dir = directory part of path
    SET name = filename part of path (no directory)

    SET ext = extract_extension(name)
    SET base = extract_basename(name, ext)

    [sanitized_base, changes] = sanitize_basename(base, separator, naming_convention, whitelist_mode)

    SET sanitized_name = sanitized_base + ext

    // truncate including extension
    SET truncated_name = truncate_to_max(sanitized_name, MAX_LENGTH)
    IF truncated_name != sanitized_name
      ADD "Truncated to " + MAX_LENGTH + " characters" to changes
      sanitized_name = truncated_name
    END IF

    // ensure no collision (in directory)
    SET final_name = generate_unique_name(dir, sanitized_name)
    IF final_name != sanitized_name
      ADD "Adjusted to avoid collision (appended number)" to changes
    END IF

    DISPLAY "Original:   " + name
    DISPLAY "Sanitized:  " + final_name
    DISPLAY ""

    IF changes list is not empty
      DISPLAY "Changes applied:"
      FOR each item in changes
        DISPLAY "  ✓ " + item
      END FOR
      IF ext not empty
        DISPLAY "  ✓ Preserved extension: " + ext
      END IF
    ELSE
      DISPLAY "No changes needed."
    END IF
    DISPLAY ""

    // Renaming logic
    IF rename_mode is true AND preview_mode is false
      DISPLAY "Rename file on disk? [y/N]: " (no newline)
      READ answer
      IF answer is "y" or "Y"
        SET old_path = dir + "/" + name
        SET new_path = dir + "/" + final_name
        ATTEMPT to mv old_path new_path
        IF success
          DISPLAY "Renamed: " + old_path + " -> " + new_path
          CALL log_change(old_path, new_path, "RENAMED")
        ELSE
          DISPLAY "Failed to rename: " + old_path
          CALL log_change(old_path, final_name, "FAILED")
        END IF
      ELSE
        DISPLAY "Skipped renaming."
        CALL log_change(path, final_name, "SKIPPED")
      END IF
    ELSE
      // preview only
      CALL log_change(path, final_name, "PREVIEW")
    END IF
  END FUNCTION

  FUNCTION backup_original_names(file_list)
    SET backup_file = "sanitize_backup_" + current date + ".txt"
    FOR each f in file_list
      APPEND f to backup_file
    END FOR
    DISPLAY "Backup of original filenames saved to: " + backup_file
  END FUNCTION

  FUNCTION process_directory_recursive(dir)
    FOR each file in directory dir and subdirectories
      CALL process_single_filename(file)
    END FOR
  END FUNCTION

  // ==============================
  // Main
  // ==============================

  // parse options
  SET positional_files = empty list
  WHILE there are arguments AND arg starts with "-"
    IF arg == "-r"
      rename_mode = true
    ELSE IF arg == "-p"
      preview_mode = true
    ELSE IF arg == "-b"
      backup_enabled = true
    ELSE IF arg == "-s"
      MOVE to next argument; separator = that value
    ELSE IF arg == "-w"
      whitelist_mode = true
    ELSE IF arg == "-n"
      MOVE to next argument; naming_convention = that value
    ELSE IF arg == "-h"
      CALL display_usage()
      EXIT 0
    ELSE
      CALL display_error("Unknown option: " + arg)
      CALL display_usage()
      EXIT 1
    END IF
    MOVE to next argument
  END WHILE

  // remaining arguments are filenames or directories
  IF no remaining arguments
    CALL display_error("No filenames provided.")
    CALL display_usage()
    EXIT 1
  END IF

  SET positional_files = all remaining arguments

  // optional: set log file name
  SET log_file = "sanitize_log_" + current date + ".log"

  // optional: backup list of names
  IF backup_enabled is true
    CALL backup_original_names(positional_files)
  END IF

  SET processed_count = 0

  FOR each item in positional_files
    IF item is a directory
      // bonus: recursive processing
      CALL process_directory_recursive(item)
    ELSE
      CALL process_single_filename(item)
    END IF
    INCREMENT processed_count
  END FOR

  DISPLAY "════════════════════════════════════════"
  DISPLAY "Summary: " + processed_count + " items processed"
  DISPLAY "════════════════════════════════════════"
  IF preview_mode is true
    DISPLAY "Note: Preview mode only. No files were renamed. Use -r to rename."
  END IF

  EXIT 0

END sanitize.sh
```

***
## Expected Output Example:
```bash
./sanitize.sh "My Document (Final Version)!.pdf" "Test___File   123.txt"
```
```
════════════════════════════════════════
Processing: My Document (Final Version)!.pdf
════════════════════════════════════════
Original:   My Document (Final Version)!.pdf
Sanitized:  my_document_final_version.pdf

Changes applied:
  ✓ Converted to lowercase
  ✓ Replaced spaces with underscores
  ✓ Removed special characters: ( ) !
  ✓ Preserved extension: .pdf

════════════════════════════════════════
Processing: Test___File   123.txt
════════════════════════════════════════
Original:   Test___File   123.txt
Sanitized:  test_file_123.txt

Changes applied:
  ✓ Converted to lowercase
  ✓ Replaced spaces with underscores
  ✓ Collapsed multiple underscores
  ✓ Preserved extension: .txt

════════════════════════════════════════
Summary: 2 files processed
════════════════════════════════════════
```
## Bonus Challenges:
- Add `-r` flag to actually rename files on disk (with confirmation)
- Process all files in a directory recursively
- Create backup of original filenames before renaming
- Add `-p` flag to preview changes without applying
- Support custom replacement character (dash vs underscore)
- Generate unique names if sanitized name already exists (append number)
- Create undo functionality (restore from backup)
- Add whitelist mode (only allow certain characters)
- Log all changes to a file for auditing

**Advanced bonus:**
- Handle Unicode characters properly
- Detect and prevent filename collisions
- Support different naming conventions (camelCase, snake_case, kebab-case)
- Batch rename with pattern matching and replacement

***
