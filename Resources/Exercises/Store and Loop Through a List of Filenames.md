### Goal:
Create a script named `file_list.sh` that stores filenames in an array and performs operations on them.

***
### Requirements:
- Create an array with at least 5 filenames
- Display all filenames with their index numbers
- Display the total count of files
- Show the first and last filename
- Loop through and display each filename with its character length
- Add a new filename to the array and display updated list

***
### Hints:
- Use `files=("file1" "file2" ...)` syntax
- Use `${#files[@]}` for array length
- Use `${!files[@]}` to get indices
- Use `${#filename}` for string length of each element

***
### Bonus Challenges:
- Sort the array alphabetically
- Filter files by extension
- Find the longest and shortest filename
- Accept filenames as command-line arguments

***
## Pseudocode for file_list.sh

```bash
BEGIN file_list.sh

  // ========================================
  // CONFIGURATION & SETUP
  // ========================================
  
  ENABLE strict error handling:
    - Exit on any command error
    - Exit on undefined variable usage
    - Exit on pipe failure
  
  SET internal field separator to newline and tab (for safer parsing)
  
  // ========================================
  // GLOBAL VARIABLES
  // ========================================
  
  DECLARE files as empty array  # Note: Currently unused in script
  
  // ========================================
  // HELPER FUNCTIONS ⚙️
  // ========================================
  
  FUNCTION display_usage()
    # Display script usage information
    DISPLAY "Usage: ./file_list.sh [filename1] [filename2] ..."
    DISPLAY ""
    DISPLAY "If no arguments provided, uses default file list."
    DISPLAY ""
    DISPLAY "Examples:"
    DISPLAY "  ./file_list.sh"
    DISPLAY "  ./file_list.sh document.txt report.pdf image.png"
    DISPLAY ""
  ENDFUNCTION
  
  FUNCTION display_error(message)
    # Display formatted error message to stderr
    DISPLAY "✗ Error: " + message TO stderr
  ENDFUNCTION
  
  // ========================================
  // ARRAY DISPLAY FUNCTIONS 📋
  // ========================================
  
  FUNCTION display_file_list(file_array_ref, header_message)
    # Display all filenames with their index numbers
    DISPLAY blank line
    DISPLAY header_message
    DISPLAY "---------"
    
    FOR each index IN indices of file_array_ref DO
      DISPLAY "[" + index + "] " + file_array_ref[index]
    END FOR
    
    DISPLAY blank line
  ENDFUNCTION
  
  FUNCTION display_file_count(file_array_ref)
    # Display total count of files in array
    SET count to length of file_array_ref
    DISPLAY blank line
    DISPLAY "Total files: " + count
  ENDFUNCTION
  
  FUNCTION display_first_and_last(file_array_ref)
    # Display first and last filenames in array
    SET first_file to file_array_ref[0]
    SET last_file to file_array_ref[last_index]
    
    DISPLAY blank line
    DISPLAY "First file: " + first_file
    DISPLAY "Last file: " + last_file
    DISPLAY blank line
  ENDFUNCTION
  
  FUNCTION display_file_lengths(file_array_ref)
    # Display character length for each filename
    DISPLAY blank line
    DISPLAY "File lengths:"
    DISPLAY "-------------"
    
    FOR each file IN file_array_ref DO
      SET length to character count of file
      DISPLAY file + " - " + length + " characters"
    END FOR
    
    DISPLAY blank line
  ENDFUNCTION
  
  // ========================================
  // ARRAY MODIFICATION FUNCTIONS ✏️
  // ========================================
  
  FUNCTION add_file_to_array(file_array_ref, new_filename)
    # Add a new filename to the array
    DISPLAY blank line
    DISPLAY "Adding new file: " + new_filename
    
    APPEND new_filename to file_array_ref
    
    SET new_count to length of file_array_ref
    DISPLAY "Updated total: " + new_count + " files"
  ENDFUNCTION
  
  FUNCTION remove_file_from_array(file_array_ref, filename_to_remove)
    # Remove specified file from array
    DECLARE new_array as empty array
    SET found to false
    
    FOR each file IN file_array_ref DO
      IF file equals filename_to_remove THEN
        SET found to true
        CONTINUE to next iteration  # Skip this file
      END IF
      
      APPEND file to new_array
    END FOR
    
    IF found is true THEN
      SET file_array_ref to new_array
      DISPLAY "Removed: " + filename_to_remove
      RETURN success (0)
    ELSE
      DISPLAY "File not found: " + filename_to_remove TO stderr
      RETURN failure (1)
    END IF
  ENDFUNCTION
  
  // ========================================
  // ARRAY PROCESSING FUNCTIONS 🔄
  // ========================================
  
  FUNCTION sort_array_alphabetically(source_array_ref, destination_array_ref)
    # Sort files alphabetically into new array
    DISPLAY blank line
    DISPLAY "Sorting files alphabetically..."
    DISPLAY blank line
    
    # Create sorted array by:
    # 1. Print each element on separate line
    # 2. Pipe to sort command
    # 3. Read sorted lines into destination array
    SET destination_array_ref to sorted version of source_array_ref
  ENDFUNCTION
  
  FUNCTION filter_by_extension(file_array_ref, extension, verbose_mode)
    # Filter files by extension and output matches
    DECLARE filtered_array as empty array
    
    # Display header if verbose mode enabled
    IF verbose_mode is "true" THEN
      DISPLAY blank line
      DISPLAY "Filtering files by extension: " + extension
      DISPLAY "-----------------------------------"
    END IF
    
    # Build filtered array
    FOR each filename IN file_array_ref DO
      IF filename contains "." THEN
        SET file_extension to everything after last "."
        
        IF file_extension equals extension THEN
          APPEND filename to filtered_array
        END IF
      END IF
    END FOR
    
    # Output results
    IF length of filtered_array is 0 THEN
      IF verbose_mode is "true" THEN
        DISPLAY "No files found with extension: " + extension TO stderr
      END IF
    ELSE
      FOR each file IN filtered_array DO
        DISPLAY file
      END FOR
    END IF
  ENDFUNCTION
  
  FUNCTION get_unique_extensions(source_array_ref, destination_extensions_ref)
    # Extract all unique file extensions from array
    
    # Clear destination array
    SET destination_extensions_ref to empty array
    
    FOR each filename IN source_array_ref DO
      IF filename contains "." THEN
        SET extension to everything after last "."
        
        # Check if extension already exists in array
        SET found to false
        FOR each existing_ext IN destination_extensions_ref DO
          IF existing_ext equals extension THEN
            SET found to true
            BREAK loop
          END IF
        END FOR
        
        # Add extension if not found
        IF found is false THEN
          APPEND extension to destination_extensions_ref
        END IF
      END IF
    END FOR
  ENDFUNCTION
  
  // ========================================
  // SEARCH AND ANALYSIS FUNCTIONS 🔍
  // ========================================
  
  FUNCTION search_files(files_array_ref, matches_ref, search_term)
    # Search for files containing search term
    DISPLAY blank line
    DISPLAY "Searching for: " + search_term
    DISPLAY "------------------------"
    
    FOR each file IN files_array_ref DO
      IF file contains search_term THEN
        APPEND file to matches_ref
        DISPLAY "  ✓ " + file
      END IF
    END FOR
    
    IF length of matches_ref is 0 THEN
      DISPLAY "No matches found."
    END IF
    
    DISPLAY blank line
  ENDFUNCTION
  
  FUNCTION find_longest_filename(file_array_ref) RETURNS (filename, length)
    # Find the filename with most characters
    SET longest to ""
    SET max_length to 0
    
    # Handle empty array
    IF length of file_array_ref is 0 THEN
      RETURN ("No-File", 0)
    END IF
    
    # Iterate to find longest
    FOR each filename IN file_array_ref DO
      SET current_length to character count of filename
      
      IF current_length is greater than max_length THEN
        SET max_length to current_length
        SET longest to filename
      END IF
    END FOR
    
    RETURN (longest, max_length)
  ENDFUNCTION
  
  FUNCTION find_shortest_filename(file_array_ref) RETURNS (filename, length)
    # Find the filename with least characters
    
    # Handle empty array
    IF length of file_array_ref is 0 THEN
      RETURN ("No-File", 0)
    END IF
    
    # Initialize with first element
    SET shortest to file_array_ref[0]
    SET min_length to character count of shortest
    
    # Iterate to find shortest
    FOR each filename IN file_array_ref DO
      SET current_length to character count of filename
      
      IF current_length is less than min_length THEN
        SET min_length to current_length
        SET shortest to filename
      END IF
    END FOR
    
    RETURN (shortest, min_length)
  ENDFUNCTION
  
  FUNCTION display_longest_and_shortest(file_array_ref)
    # Display filename length statistics
    DISPLAY blank line
    DISPLAY "Filename Statistics:"
    DISPLAY "--------------------"
    
    # Get shortest filename info
    SET (shortest, shortest_len) to find_shortest_filename(file_array_ref)
    
    # Get longest filename info
    SET (longest, longest_len) to find_longest_filename(file_array_ref)
    
    DISPLAY "Shortest: " + shortest + " (" + shortest_len + " characters)"
    DISPLAY "Longest: " + longest + " (" + longest_len + " characters)"
    DISPLAY blank line
  ENDFUNCTION
  
  FUNCTION display_files_by_extension(files_array_ref)
    # Display files grouped by their extensions
    DECLARE unique_extensions as empty array
    
    # Get all unique extensions
    CALL get_unique_extensions(files_array_ref, unique_extensions)
    
    DISPLAY blank line
    DISPLAY "Files Grouped by Extension:"
    DISPLAY "----------------------------"
    
    FOR each ext IN unique_extensions DO
      DISPLAY "." + ext + " files:"
      
      # Get filtered list for this extension
      DECLARE filtered as empty array
      SET filtered to filter_by_extension(files_array_ref, ext, "false")
      
      # Display each matching file
      FOR each file IN filtered DO
        DISPLAY "  - " + file
      END FOR
      
      DISPLAY blank line  # Spacing between groups
    END FOR
  ENDFUNCTION
  
  // ========================================
  // MAIN LOGIC 🚀
  // ========================================
  
  FUNCTION main(command_line_arguments)
    # Main execution function
    DECLARE files_array as empty array
    
    # Determine file list source
    IF number of command_line_arguments is greater than 0 THEN
      # Use command-line arguments
      SET files_array to command_line_arguments
      DISPLAY blank line
      DISPLAY "Using command-line arguments as file list"
      DISPLAY blank line
    ELSE
      # Use default hardcoded list
      SET files_array to ["document.txt", "report.pdf", "image.png", 
                          "script.sh", "data.csv"]
    END IF
    
    // ========================================
    // CORE FUNCTIONALITY
    // ========================================
    
    # Display initial state
    CALL display_file_list(files_array, "Initial File List:")
    CALL display_file_count(files_array)
    CALL display_first_and_last(files_array)
    CALL display_file_lengths(files_array)
    
    # Modify array
    CALL add_file_to_array(files_array, "backup.tar.gz")
    CALL display_file_list(files_array, "Updated File List:")
    
    // ========================================
    // BONUS FEATURES
    // ========================================
    
    # Declare arrays for bonus operations
    DECLARE sorted_array as empty array
    DECLARE extensions as empty array
    DECLARE matches as empty array
    
    # Sort and display
    CALL sort_array_alphabetically(files_array, sorted_array)
    CALL display_file_list(sorted_array, "Sorted File List:")
    
    # Display statistics
    CALL display_longest_and_shortest(files_array)
    
    # Filter demonstrations
    CALL filter_by_extension(files_array, "pdf", "true")
    CALL filter_by_extension(files_array, "txt", "true")
    
    # Get and display unique extensions
    CALL get_unique_extensions(files_array, extensions)
    IF length of extensions is greater than 0 THEN
      SET extension_string to join(extensions, ", ")
      DISPLAY blank line
      DISPLAY blank line
      DISPLAY "Unique extensions found: " + extension_string
      DISPLAY blank line
    END IF
    
    # Search functionality demonstration
    CALL search_files(files_array, matches, "report")
    
    # Group files by extension
    CALL display_files_by_extension(files_array)
    
    EXIT with success (0)
  ENDFUNCTION
  
  // ========================================
  // SCRIPT ENTRY POINT
  // ========================================
  
  CALL main(all command-line arguments)
  
END file_list.sh
```

***
## Key Implementation Notes

### Array Operations Reference:
```sh
# Create array
files=("file1" "file2" "file3")

# Array length
${#files[@]}

# Get all indices
${!files[@]}

# Get element at index
${files[0]}

# Last element
${files[-1]}  OR  ${files[${#files[@]}-1]}

# String length of element
${#files[0]}

# Add element
files+=("newfile")

# Loop through array
for file in "${files[@]}"; do
  echo "$file"
done

# Loop with indices
for i in "${!files[@]}"; do
  echo "[$i] ${files[$i]}"
done

# Sort array
IFS=$'\n' sorted=($(sort <<<"${files[*]}")); unset IFS

# Extract extension
extension="${filename##*.}"

# Extract basename without extension
basename="${filename%.*}"
```

***
## Expected Output Example:

```bash
./file_list.sh
```
```
File List:
----------
[0] document.txt
[1] report.pdf
[2] image.png
[3] script.sh
[4] data.csv

Total files: 5
First file: document.txt
Last file: data.csv

File Lengths:
-------------
document.txt - 12 characters
report.pdf - 10 characters
image.png - 9 characters
script.sh - 9 characters
data.csv - 8 characters

Adding new file: backup.tar.gz
Updated total: 6 files
```
