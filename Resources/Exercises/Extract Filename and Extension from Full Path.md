## Goal:
Create a script named `path_parser.sh` that accepts a full file path and extracts various components.

***
## Requirements:
- Accept one argument: a full file path
- Extract and display:
  - Full path
  - Directory path (without filename)
  - Filename with extension
  - Filename without extension (basename)
  - File extension only
- Handle paths with multiple dots (e.g., `archive.tar.gz`)

***
## Hints:
- Use `${path##*/}` to get filename from path
- Use `${path%/*}` to get directory from path
- Use `${filename%.*}` to remove last extension
- Use `${filename##*.}` to get last extension
- For double extensions, you'll need different patterns

***
## Pseudocode:
```bash
BEGIN path_parser.sh

  // Step 1: Argument Validation
  IF argument count ($#) is NOT equal to 1 THEN
    DISPLAY "✗ Error: Exactly one argument (a full path) is required"
    DISPLAY "Usage: ./path_parser.sh <full_file_path>"
    EXIT with status 1
  END IF

  // Step 2: Assign and Validate Path String
  SET path to $1

  // BONUS: Validate path format
  IF path is empty OR path does NOT contain '/' THEN
    DISPLAY "✗ Error: Argument does not appear to be a valid path"
    EXIT with status 1
  END IF

  // Step 3: Extract Directory
  IF path contains '/' THEN
    SET directory to part before the last '/'
    USE `${path%/*}` to extract
  ELSE
    SET directory to "."
  END IF

  // Step 4: Extract Filename with extension
  SET filename to part after the last '/'
  USE `${path##*/}` to extract

  // Step 5: Extract Base Name (filename without last extension)
  IF filename contains '.' THEN
    SET basename to part before last '.'
    USE `${filename%.*}` to extract
  ELSE
    SET basename to filename
  END IF

  // Step 6: Extract Extension (last extension only)
  IF filename contains '.' THEN
    SET last_extension to part after last '.'
    USE `${filename##*.}` to extract
  ELSE
    SET last_extension to ""
  END IF

  // Step 7: Extract Full Extension (everything after first '.')
  IF filename contains '.' THEN
    SET extension to everything after first '.'
    IF filename contains multiple '.' THEN
      SET extension to substring after the first '.'
      E.g., for archive.tar.gz, extension is "tar.gz"
      Use pattern manipulation or substring logic
    ELSE
      SET extension to last_extension
    END IF
  ELSE
    SET extension to ""
  END IF

  // Step 8: Display Results
  DISPLAY "Full path:      " + path
  DISPLAY "Directory:      " + directory
  DISPLAY "Filename:       " + filename
  DISPLAY "Base name:      " + basename
  DISPLAY "Extension:      " + extension
  DISPLAY "Last extension: " + last_extension

END path_parser.sh
```

***
## Expected Output Example:
```bash
./path_parser.sh /home/user/documents/report.pdf
```
```
Full path:      /home/user/documents/report.pdf
Directory:      /home/user/documents
Filename:       report.pdf
Base name:      report
Extension:      pdf
```

```bash
./path_parser.sh /var/log/archive.tar.gz
```
```
Full path:      /var/log/archive.tar.gz
Directory:      /var/log
Filename:       archive.tar.gz
Base name:      archive
Extension:      tar.gz
Last extension: gz
```

*** 
## Bonus Challenge:
Validate that the argument is a valid path format and handle edge cases like paths without extensions or directories.

***
## Bonus Pseudocode:
```bash
BEGIN path_parser.sh

  // Step 1: Argument Validation
  IF argument count ($#) is NOT equal to 1 THEN
    DISPLAY "✗ Error: Exactly one argument (a full path) is required"
    DISPLAY "Usage: ./path_parser.sh <full_file_path>"
    EXIT with status 1
  END IF

  // Step 2: Assign and Validate Path String
  SET path to $1

  // BONUS: Validate path format
  IF path is empty OR path does NOT contain '/' THEN
    DISPLAY "✗ Error: Argument does not appear to be a valid path"
    EXIT with status 1
  END IF

  // Step 3: Extract Directory
  IF path contains '/' THEN
    SET directory to part before the last '/'
    USE `${path%/*}` to extract
  ELSE
    SET directory to "."
  END IF

  // Step 4: Extract Filename with extension
  SET filename to part after the last '/'
  USE `${path##*/}` to extract

  // Step 5: Extract Base Name (filename without last extension)
  IF filename contains '.' THEN
    SET basename to part before last '.'
    USE `${filename%.*}` to extract
  ELSE
    SET basename to filename
  END IF

  // Step 6: Extract Extension (last extension only)
  IF filename contains '.' THEN
    SET last_extension to part after last '.'
    USE `${filename##*.}` to extract
  ELSE
    SET last_extension to ""
  END IF

  // Step 7: Extract Full Extension (everything after first '.')
  IF filename contains '.' THEN
    SET extension to everything after first '.'
    IF filename contains multiple '.' THEN
      SET extension to substring after the first '.'
      E.g., for archive.tar.gz, extension is "tar.gz"
      Use pattern manipulation or substring logic
    ELSE
      SET extension to last_extension
    END IF
  ELSE
    SET extension to ""
  END IF

  // Step 8: Display Results
  DISPLAY "Full path:      " + path
  DISPLAY "Directory:      " + directory
  DISPLAY "Filename:       " + filename
  DISPLAY "Base name:      " + basename
  DISPLAY "Extension:      " + extension
  DISPLAY "Last extension: " + last_extension

END path_parser.sh
```
