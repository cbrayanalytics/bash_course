## Goal:
Create a comprehensive, menu-driven file management tool named `file_manager.sh` that provides an interactive interface for common file operations while demonstrating mastery of all control flow structures learned in Week 2.
## Requirements:

### Core Functionality - File Operations:
**1. List Files**
- Display files and directories in current or specified directory
- Show detailed information (size, permissions, date modified)
- Sort options (name, size, date, type)
- Filter options (show only files, only directories, by extension)
- Color-coded output (directories, executables, different file types)
- Display as list, grid, or tree view

**2. Copy Files**
- Copy single file
- Copy multiple files (with wildcards or selection)
- Copy directories recursively
- Progress indicator for large files
- Verify copy success with checksums
- Handle name conflicts (skip, overwrite, rename)
- Create destination directory if doesn't exist

**3. Move Files**
- Move single or multiple files
- Move directories
- Rename while moving
- Undo capability (restore from trash)
- Atomic moves (ensure data integrity)
- Cross-filesystem move detection

**4. Delete Files**
- Delete with confirmation
- Move to trash/recycle bin (soft delete)
- Permanent delete option
- Bulk delete with pattern matching
- Secure delete (overwrite data)
- Undo deleted files (restore from trash)
- Empty trash functionality

**5. Search Files**
- Search by name (exact or pattern)
- Search by content (text files)
- Search by size (greater than, less than)
- Search by date (modified, created, accessed)
- Search by permissions
- Recursive directory search
- Save search results
- Execute actions on search results

**6. Rename Files**
- Rename single file
- Batch rename with patterns
- Add prefix/suffix
- Replace text in names
- Change case (upper/lower/title)
- Add sequential numbers
- Preview before applying
- Undo rename operation

**7. File Information**
- Display detailed file properties
- Show file type and MIME type
- Display permissions (numeric and symbolic)
- Show ownership information
- Calculate checksums (MD5, SHA256)
- Count lines/words/characters (text files)
- View file contents (with pagination)

**8. Create Items**
- Create new files (empty or from template)
- Create directories
- Create symbolic links
- Create multiple items at once
- Set initial permissions
- Open in editor after creation

### Control Flow Requirements:
**Must demonstrate use of (from Week 2):**
1. **Conditional Statements (Day 8)**
   - File existence checks before operations
   - Permission validation
   - Input validation (numeric ranges, valid paths)
   - File type checking (regular file vs directory)

2. **File Test Operators (Day 9)**
   - Check file exists (-e)
   - Check file type (-f, -d, -L)
   - Check permissions (-r, -w, -x)
   - Compare file ages (-nt, -ot)

3. **Case Statements (Day 10)**
   - Main menu navigation
   - Sub-menu handling
   - File type identification
   - User input processing

4. **For Loops (Day 11)**
   - Iterate through files for operations
   - Process multiple file selections
   - Display directory contents
   - Batch operations

5. **While/Until Loops (Day 12)**
   - Main program loop (until user quits)
   - Read and process user input
   - Wait for valid input
   - Progress indicators

6. **Loop Control - Break/Continue (Day 13)**
   - Skip hidden files (continue)
   - Stop at first match in search (break)
   - Skip non-processable files (continue)
   - Early exit on critical errors (break)

7. **Exit Codes (Day 14)**
   - Return appropriate exit codes for all operations
   - Check command success/failure
   - Chain operations with && and ||
   - Handle errors gracefully with specific codes
### User Interface Requirements:
**Menu System:**
- Clear, hierarchical menu structure
- Breadcrumb navigation (show current location)
- Keyboard shortcuts for common actions
- Help system accessible from any menu
- Status messages for operations
- Confirmation prompts for destructive operations
- Progress indicators for long operations
- Summary statistics after operations

**Visual Design:**
- Box-drawing characters for menus
- Color-coded messages (success=green, error=red, warning=yellow)
- Consistent formatting throughout
- Clear section separators
- Aligned columns in listings
- Visual indicators (✓ ✗ ⚠ ➜)

**Navigation:**
- Main menu returns after each operation
- Ability to go back to previous menu
- Quick navigation shortcuts
- Current directory always visible
- Recent operations history
### Error Handling & Validation:
**Must include:**
- Validate all user input
- Check file/directory existence before operations
- Verify permissions before attempting operations
- Handle disk space issues
- Detect and prevent circular references (symlinks)
- Trap signals (Ctrl+C) gracefully
- Prevent accidental overwrites
- Provide meaningful error messages
- Suggest corrective actions
- Log errors to file

**Exit Codes:**
```bash
0   - Success
1   - General error
64  - File not found
65  - Permission denied
66  - Invalid input
67  - Disk full
68  - Operation cancelled by user
69  - Destination already exists
70  - Operation not supported
```

### Advanced Features (Optional but Recommended):
**Bookmarks:**
- Save favorite directories
- Quick navigation to bookmarks
- Organize bookmarks in categories

**File Operations History:**
- Track all operations
- Undo last N operations
- View operation history
- Export history to file

**Clipboard:**
- Copy file paths to clipboard
- Cut/copy/paste operations
- Multiple clipboard slots

**Configuration:**
- Save user preferences
- Configurable key bindings
- Customizable colors
- Default sort order
- Hidden files visibility toggle

**Bulk Operations:**
- Select multiple files (checkbox style)
- Apply operation to selection
- Deselect all/select all
- Inverse selection
## Expected Output Example:
```bash
./file_manager.sh
```

```
╔════════════════════════════════════════════════════════════════╗
║            INTERACTIVE FILE MANAGER v1.0                       ║
║            Current Directory: /home/user/documents             ║
╚════════════════════════════════════════════════════════════════╝

┌────────────────────────────────────────────────────────────────┐
│                         MAIN MENU                              │
├────────────────────────────────────────────────────────────────┤
│  [1] List Files                                                │
│  [2] Copy Files/Directories                                    │
│  [3] Move Files/Directories                                    │
│  [4] Delete Files/Directories                                  │
│  [5] Search Files                                              │
│  [6] Rename Files/Directories                                  │
│  [7] File Information                                          │
│  [8] Create New Item                                           │
│  [9] Change Directory                                          │
│  [A] Advanced Options                                          │
│  [H] Help                                                      │
│  [Q] Quit                                                      │
└────────────────────────────────────────────────────────────────┘

Files in current directory: 15 | Space used: 23.5 MB
Last operation: None

Select option [1-9, A, H, Q]: 1

╔════════════════════════════════════════════════════════════════╗
║                      LIST FILES                                ║
║                      /home/user/documents                      ║
╚════════════════════════════════════════════════════════════════╝

Sort by: [N]ame | [S]ize | [D]ate | [T]ype
Filter: [A]ll | [F]iles | [Di]rectories | [E]xtension
View: [L]ist | [G]rid | [Tr]ee

Choose option or press Enter for default [Name/All/List]: 

┌─────────────────────────────────────────────────────────────────┐
│ Name                 │ Type │ Size    │ Modified      │ Perms   │
├─────────────────────────────────────────────────────────────────┤
│ 📁 projects/         │ DIR  │ 4.0K    │ 2025-10-18    │ rwxr-xr-x│
│ 📁 backup/           │ DIR  │ 4.0K    │ 2025-10-15    │ rwxr-xr-x│
│ 📄 report.txt        │ TXT  │ 2.3 KB  │ 2025-10-19    │ rw-r--r--│
│ 📄 notes.md          │ MD   │ 5.1 KB  │ 2025-10-18    │ rw-r--r--│
│ 🖼  photo.jpg        │ JPG  │ 1.5 MB  │ 2025-10-17    │ rw-r--r--│
│ ⚙️  script.sh        │ SH   │ 3.2 KB  │ 2025-10-16    │ rwxr-xr-x│
│ 📦 archive.tar.gz    │ GZ   │ 12.8 MB │ 2025-10-15    │ rw-r--r--│
└─────────────────────────────────────────────────────────────────┘

Total: 7 items (2 directories, 5 files) | Total size: 14.5 MB

Press Enter to return to main menu...

╔════════════════════════════════════════════════════════════════╗
║                         MAIN MENU                              ║
╚════════════════════════════════════════════════════════════════╝

Select option [1-9, A, H, Q]: 2

╔════════════════════════════════════════════════════════════════╗
║                      COPY OPERATION                            ║
╚════════════════════════════════════════════════════════════════╝

Copy Options:
  [1] Copy single file
  [2] Copy multiple files
  [3] Copy directory (recursive)
  [B] Back to main menu

Select option: 1

Enter source file path (or leave empty to browse): report.txt

✓ File exists: report.txt
  Type: Regular file
  Size: 2.3 KB
  Readable: Yes

Enter destination path: backup/report_backup.txt

Checking destination...
⚠ Directory 'backup' exists

Confirm copy operation:
  Source: /home/user/documents/report.txt
  Destination: /home/user/documents/backup/report_backup.txt
  Size: 2.3 KB

Proceed with copy? [y/n]: y

Copying file...
████████████████████████████████████████ 100% (2.3 KB/2.3 KB)

✓ Copy completed successfully
  Time taken: 0.045 seconds
  Verifying integrity... ✓ Checksum match

Operation completed. Press Enter to continue...

╔════════════════════════════════════════════════════════════════╗
║                         MAIN MENU                              ║
╚════════════════════════════════════════════════════════════════╝

Last operation: Copy report.txt → backup/report_backup.txt ✓

Select option [1-9, A, H, Q]: 4

╔════════════════════════════════════════════════════════════════╗
║                      DELETE OPERATION                          ║
╚════════════════════════════════════════════════════════════════╝

Delete Options:
  [1] Move to trash (safe delete)
  [2] Permanent delete
  [3] Delete multiple files
  [4] View trash
  [5] Empty trash
  [B] Back to main menu

Select option: 1

Enter file/directory to delete: old_notes.txt

File Information:
  Name: old_notes.txt
  Type: Regular file
  Size: 850 bytes
  Modified: 2025-10-10 08:20:00
  Location: /home/user/documents/old_notes.txt

⚠ WARNING: This will move the file to trash

Confirm deletion? [y/n]: y

Moving to trash...
✓ File moved to trash: ~/.trash/old_notes.txt_20251019_014500

You can restore this file using option 4 (View trash)
Or undo with: Ctrl+Z in Advanced menu

Press Enter to continue...

╔════════════════════════════════════════════════════════════════╗
║                         MAIN MENU                              ║
╚════════════════════════════════════════════════════════════════╝

Select option [1-9, A, H, Q]: 5

╔════════════════════════════════════════════════════════════════╗
║                      SEARCH FILES                              ║
╚════════════════════════════════════════════════════════════════╝

Search Options:
  [1] Search by name
  [2] Search by content
  [3] Search by size
  [4] Search by date
  [5] Advanced search
  [B] Back to main menu

Select option: 1

Search Configuration:
  Starting directory: /home/user/documents
  Recursive: Yes
  Case-sensitive: No
  Match: Contains

Enter search term: report

Searching for files matching "report"...
████████████████████████░░░░░░░░░░░░ 65% (45/69 files scanned)

Search Results:
────────────────────────────────────────────────────────────────
[1] ./report.txt (2.3 KB) - Modified: 2025-10-19
[2] ./backup/report_backup.txt (2.3 KB) - Modified: 2025-10-19
[3] ./projects/monthly_report.pdf (1.2 MB) - Modified: 2025-10-15
[4] ./archive/old_reports/ (directory)

Found 4 matches in 0.234 seconds

Actions:
  [O] Open file (select number)
  [I] Show info (select number)
  [D] Delete (select number)
  [C] Copy all results
  [M] Move all results
  [S] Save results to file
  [N] New search
  [B] Back to main menu

Select action: S

Enter filename to save results [search_results.txt]: report_search.txt

✓ Search results saved to: /home/user/documents/report_search.txt

Press Enter to continue...

╔════════════════════════════════════════════════════════════════╗
║                         MAIN MENU                              ║
╚════════════════════════════════════════════════════════════════╗

Select option [1-9, A, H, Q]: H

╔════════════════════════════════════════════════════════════════╗
║                      HELP & DOCUMENTATION                      ║
╚════════════════════════════════════════════════════════════════╝

Interactive File Manager - Quick Help
────────────────────────────────────────────────────────────────

KEYBOARD SHORTCUTS:
  Ctrl+C    - Cancel current operation
  Ctrl+Z    - Undo last operation
  Ctrl+L    - Refresh screen
  ESC       - Go back to previous menu
  ?         - Context-specific help

MENU OPTIONS:
  1-9       - Select numbered options
  A         - Advanced options
  H         - Show this help
  Q         - Quit program

FILE OPERATIONS:
  • All destructive operations require confirmation
  • Deleted files go to trash (~/.trash)
  • Use Ctrl+Z in Advanced menu to undo operations
  • Progress shown for operations > 1 MB

EXIT CODES:
  0  - Success
  64 - File not found
  65 - Permission denied
  66 - Invalid input
  68 - Operation cancelled

For detailed documentation:
  View: README.md
  Online: github.com/user/file-manager

Press Enter to return to main menu...

╔════════════════════════════════════════════════════════════════╗
║                         MAIN MENU                              ║
╚════════════════════════════════════════════════════════════════╝

Select option [1-9, A, H, Q]: Q

╔════════════════════════════════════════════════════════════════╗
║                      EXIT CONFIRMATION                         ║
╚════════════════════════════════════════════════════════════════╝

Are you sure you want to quit? [y/n]: y

Session Summary:
────────────────────────────────────────────────────────────────
Operations performed: 3
  • Copied: 1 file
  • Deleted: 1 file
  • Searched: 1 query

Time spent: 5 minutes 23 seconds
No errors encountered

Thank you for using Interactive File Manager!
Goodbye!
```
## Technical Implementation Guidelines:

### Script Structure:
```bash
#!/bin/bash
#
# Interactive File Manager
# Week 2 Portfolio Project
#

# Constants
readonly VERSION="1.0.0"
readonly TRASH_DIR="$HOME/.trash"
readonly CONFIG_FILE="$HOME/.filemanager.conf"
readonly LOG_FILE="$HOME/.filemanager.log"

# Exit codes
readonly EXIT_SUCCESS=0
readonly EXIT_GENERAL_ERROR=1
readonly EXIT_FILE_NOT_FOUND=64
readonly EXIT_PERMISSION_DENIED=65
readonly EXIT_INVALID_INPUT=66
readonly EXIT_DISK_FULL=67
readonly EXIT_CANCELLED=68
readonly EXIT_ALREADY_EXISTS=69

# Color codes
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m' # No Color

# Global variables
current_dir=$(pwd)
last_operation=""
operation_count=0

# Function declarations
init_environment() { }
show_main_menu() { }
list_files() { }
copy_operation() { }
move_operation() { }
delete_operation() { }
search_files() { }
rename_operation() { }
show_file_info() { }
create_item() { }
change_directory() { }
show_help() { }
cleanup() { }

# Main program
main() {
    init_environment
    
    until [[ "$choice" == "Q" || "$choice" == "q" ]]; do
        show_main_menu
        read -p "Select option: " choice
        
        case $choice in
            1) list_files ;;
            2) copy_operation ;;
            3) move_operation ;;
            4) delete_operation ;;
            5) search_files ;;
            6) rename_operation ;;
            7) show_file_info ;;
            8) create_item ;;
            9) change_directory ;;
            [Aa]) advanced_options ;;
            [Hh]) show_help ;;
            [Qq]) break ;;
            *) echo "Invalid option" ;;
        esac
    done
    
    cleanup
}

# Trap signals
trap cleanup EXIT SIGINT SIGTERM

# Run main program
main "$@"
```

### Key Functions to Implement:

**1. Input Validation:**
```bash
validate_path() {
    local path=$1
    if [[ ! -e "$path" ]]; then
        return $EXIT_FILE_NOT_FOUND
    fi
    return $EXIT_SUCCESS
}
```

**2. Error Handling:**
```bash
handle_error() {
    local exit_code=$1
    local message=$2
    
    echo -e "${RED}✗ Error:${NC} $message"
    log_error "$message" "$exit_code"
    
    return $exit_code
}
```

**3. Progress Indicator:**
```bash
show_progress() {
    local current=$1
    local total=$2
    local percent=$((current * 100 / total))
    local filled=$((percent / 2))
    
    printf "\r["
    printf "%${filled}s" | tr ' ' '█'
    printf "%$((50-filled))s" | tr ' ' '░'
    printf "] %3d%%" $percent
}
```
## Testing Checklist:
Before submission, ensure your script handles:
- [ ] Empty directories
- [ ] Hidden files
- [ ] Files with spaces in names
- [ ] Symbolic links
- [ ] Permission-denied scenarios
- [ ] Disk full scenarios
- [ ] Invalid input at all prompts
- [ ] Ctrl+C gracefully
- [ ] Long file names
- [ ] Special characters in filenames
- [ ] Binary files
- [ ] Large files (> 100 MB)
- [ ] Nested directories (deep recursion)
- [ ] Read-only filesystems
- [ ] Non-existent paths
## Bonus Challenges:
**Level 1 (Intermediate):**
- Add file compression/decompression
- Support multiple window panes
- Add file preview (images, PDFs)
- Implement file synchronization
- Add FTP/SFTP support
- Create file templates
- Add macro recording
- Support custom themes

**Level 2 (Advanced):**
- Full keyboard navigation (no mouse)
- Split-pane view
- Background operations
- Network drive mounting
- Version control integration (git)
- Archive browsing (browse inside .zip, .tar)
- Diff tool for comparing files
- Batch scripting recorder

**Level 3 (Expert):**
- Plugin architecture
- Remote server management
- Database browser
- Built-in text editor
- Terminal multiplexer integration
- Cloud storage integration (S3, Dropbox)
- Full-text search indexing
- RESTful API for remote control
## Submission Requirements:
1. **Script file:** `file_manager.sh` with proper shebang and permissions
2. **README.md:** Documentation with:
   - Features list
   - Installation instructions
   - Usage examples
   - Exit code reference
   - Screenshots (optional)
3. **Test cases:** Document tested scenarios
4. **Known limitations:** List any limitations
5. **Code comments:** Explain complex sections

