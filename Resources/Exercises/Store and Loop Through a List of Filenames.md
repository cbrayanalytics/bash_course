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

```sh
BEGIN file_list.sh

  // ========================================
  // GLOBAL VARIABLES
  // ========================================
  
  DECLARE files as array
  
  // ========================================
  // HELPER FUNCTIONS ⚙️
  // ========================================
  
  FUNCTION display_usage()
    DISPLAY "Usage: ./file_list.sh [filename1] [filename2] ..."
    DISPLAY ""
    DISPLAY "If no arguments provided, uses default file list."
    DISPLAY ""
    DISPLAY "Examples:"
    DISPLAY "  ./file_list.sh"
    DISPLAY "  ./file_list.sh document.txt report.pdf image.png"
  ENDFUNCTION
  
  FUNCTION display_error(message)
    DISPLAY "✗ Error: " + message
  ENDFUNCTION
  
  // ========================================
  // ARRAY DISPLAY FUNCTIONS 📋
  // ========================================
  
  FUNCTION display_file_list(files_array)
    # Display all filenames with their index numbers
    DISPLAY "File List:"
    DISPLAY "----------"
    
    FOR each index IN indices of files_array DO
      DISPLAY "[" + index + "] " + files_array[index]
    END FOR
    
    DISPLAY ""
  ENDFUNCTION
  
  FUNCTION display_file_count(files_array)
    # Display total count of files
    SET count to length of files_array
    DISPLAY "Total files: " + count
  ENDFUNCTION
  
  FUNCTION display_first_and_last(files_array)
    # Show the first and last filename
    SET count to length of files_array
    
    IF count is 0 THEN
      DISPLAY "No files in array"
      RETURN
    END IF
    
    SET first_file to files_array[0]
    SET last_index to count - 1
    SET last_file to files_array[last_index]
    
    DISPLAY "First file: " + first_file
    DISPLAY "Last file: " + last_file
    DISPLAY ""
  ENDFUNCTION
  
  FUNCTION display_file_lengths(files_array)
    # Loop through and display each filename with its character length
    DISPLAY "File Lengths:"
    DISPLAY "-------------"
    
    FOR each filename IN files_array DO
      SET length to character count of filename
      DISPLAY filename + " - " + length + " characters"
    END FOR
    
    DISPLAY ""
  ENDFUNCTION
  
  // ========================================
  // ARRAY MODIFICATION FUNCTIONS ✏️
  // ========================================
  
  FUNCTION add_file_to_array(files_array_ref, new_filename)
    # Add a new filename to the array
    DISPLAY "Adding new file: " + new_filename
    
    APPEND new_filename to files_array_ref
    
    SET new_count to length of files_array_ref
    DISPLAY "Updated total: " + new_count + " files"
    DISPLAY ""
  ENDFUNCTION
  
  // ========================================
  // BONUS FUNCTIONS 🎁
  // ========================================
  
  FUNCTION sort_array_alphabetically(files_array)
    # BONUS: Sort the array alphabetically
    DISPLAY "Sorting files alphabetically..."
    DISPLAY ""
    
    # Use built-in sort functionality or implement bubble/quick sort
    SET sorted_array to sorted version of files_array (ascending order)
    
    RETURN sorted_array
  ENDFUNCTION
  
  FUNCTION filter_by_extension(files_array, extension)
    # BONUS: Filter files by extension
    DISPLAY "Filtering files by extension: " + extension
    DISPLAY "-----------------------------------"
    
    DECLARE filtered_array as empty array
    
    FOR each filename IN files_array DO
      # Extract extension from filename
      IF filename contains "." THEN
        SET file_extension to everything after last "."
        
        IF file_extension equals extension THEN
          APPEND filename to filtered_array
        END IF
      END IF
    END FOR
    
    IF length of filtered_array is 0 THEN
      DISPLAY "No files found with extension: " + extension
    ELSE
      FOR each file IN filtered_array DO
        DISPLAY "  - " + file
      END FOR
    END IF
    
    DISPLAY ""
    RETURN filtered_array
  ENDFUNCTION
  
  FUNCTION find_longest_filename(files_array)
    # BONUS: Find the longest filename
    SET longest to ""
    SET max_length to 0
    
    FOR each filename IN files_array DO
      SET current_length to character count of filename
      
      IF current_length is greater than max_length THEN
        SET max_length to current_length
        SET longest to filename
      END IF
    END FOR
    
    RETURN [longest, max_length]
  ENDFUNCTION
  
  FUNCTION find_shortest_filename(files_array)
    # BONUS: Find the shortest filename
    IF length of files_array is 0 THEN
      RETURN ["", 0]
    END IF
    
    SET shortest to files_array[0]
    SET min_length to character count of shortest
    
    FOR each filename IN files_array DO
      SET current_length to character count of filename
      
      IF current_length is less than min_length THEN
        SET min_length to current_length
        SET shortest to filename
      END IF
    END FOR
    
    RETURN [shortest, min_length]
  ENDFUNCTION
  
  FUNCTION display_longest_and_shortest(files_array)
    # BONUS: Display longest and shortest filenames
    DISPLAY "Filename Statistics:"
    DISPLAY "--------------------"
    
    SET [longest, longest_len] to find_longest_filename(files_array)
    SET [shortest, shortest_len] to find_shortest_filename(files_array)
    
    DISPLAY "Longest:  " + longest + " (" + longest_len + " characters)"
    DISPLAY "Shortest: " + shortest + " (" + shortest_len + " characters)"
    DISPLAY ""
  ENDFUNCTION
  
  FUNCTION get_unique_extensions(files_array)
    # BONUS: Get list of all unique extensions in array
    DECLARE extensions as empty array
    
    FOR each filename IN files_array DO
      IF filename contains "." THEN
        SET extension to everything after last "."
        
        # Add to array if not already present
        IF extension NOT IN extensions THEN
          APPEND extension to extensions
        END IF
      END IF
    END FOR
    
    RETURN extensions
  ENDFUNCTION
  
  FUNCTION display_files_by_extension(files_array)
    # BONUS: Group and display files by their extensions
    SET extensions to get_unique_extensions(files_array)
    
    DISPLAY "Files Grouped by Extension:"
    DISPLAY "----------------------------"
    
    FOR each ext IN extensions DO
      DISPLAY ""
      DISPLAY "." + ext + " files:"
      
      SET filtered to filter_by_extension(files_array, ext)
      # (filter function already displays, or display here)
    END FOR
    
    DISPLAY ""
  ENDFUNCTION
  
  FUNCTION remove_file_from_array(files_array_ref, filename_to_remove)
    # BONUS: Remove a specific file from array
    DECLARE new_array as empty array
    SET found to false
    
    FOR each filename IN files_array_ref DO
      IF filename equals filename_to_remove THEN
        SET found to true
        # Skip this file (don't add to new_array)
      ELSE
        APPEND filename to new_array
      END IF
    END FOR
    
    IF found THEN
      SET files_array_ref to new_array
      DISPLAY "Removed: " + filename_to_remove
    ELSE
      DISPLAY "File not found: " + filename_to_remove
    END IF
    
    RETURN found
  ENDFUNCTION
  
  FUNCTION search_files(files_array, search_term)
    # BONUS: Search for files containing a search term
    DISPLAY "Searching for: " + search_term
    DISPLAY "------------------------"
    
    DECLARE matches as empty array
    
    FOR each filename IN files_array DO
      IF filename contains search_term THEN
        APPEND filename to matches
        DISPLAY "  ✓ " + filename
      END IF
    END FOR
    
    IF length of matches is 0 THEN
      DISPLAY "No matches found"
    END IF
    
    DISPLAY ""
    RETURN matches
  ENDFUNCTION
  
  // ========================================
  // MAIN LOGIC 🚀
  // ========================================
  
  FUNCTION main(arguments)
    # Initialize array
    IF number of arguments is greater than 0 THEN
      # BONUS: Accept filenames as command-line arguments
      SET files to arguments array
      DISPLAY "Using command-line arguments as file list"
      DISPLAY ""
    ELSE
      # Use default hardcoded list
      SET files to ["document.txt", "report.pdf", "image.png", "script.sh", "data.csv"]
    END IF
    
    # Display initial file list
    CALL display_file_list(files)
    
    # Display count
    CALL display_file_count(files)
    
    # Display first and last
    CALL display_first_and_last(files)
    
    # Display file lengths
    CALL display_file_lengths(files)
    
    # Add new file
    CALL add_file_to_array(files, "backup.tar.gz")
    
    # Display updated list
    CALL display_file_list(files)
    
    # ========================================
    # BONUS FEATURES
    # ========================================
    
    # Sort alphabetically
    SET sorted_files to sort_array_alphabetically(files)
    DISPLAY "Sorted File List:"
    DISPLAY "-----------------"
    CALL display_file_list(sorted_files)
    
    # Find longest and shortest
    CALL display_longest_and_shortest(files)
    
    # Filter by extension
    CALL filter_by_extension(files, "pdf")
    CALL filter_by_extension(files, "txt")
    
    # Display all unique extensions
    SET extensions to get_unique_extensions(files)
    DISPLAY "Unique extensions found: " + join(extensions, ", ")
    DISPLAY ""
    
    # Search functionality
    CALL search_files(files, "report")
    
    # Display files grouped by extension
    CALL display_files_by_extension(files)
    
    EXIT 0
  ENDFUNCTION
  
  # Entry point
  CALL main($@)
  
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
