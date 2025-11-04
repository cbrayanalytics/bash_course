### Goal:
Build a comprehensive batch file renaming tool named `batch_rename.sh` that can rename multiple files with various patterns, prefixes, suffixes, and timestamps.
### Requirements:
**Core Renaming Operations:**
1. Add prefix to filenames
2. Add suffix (before extension)
3. Add timestamp (various formats)
4. Replace text in filename
5. Remove text from filename
6. Change case (uppercase/lowercase/title case)
7. Sequential numbering
8. Remove spaces/special characters
9. Preserve file extensions

**Features:**
- Preview mode (show what will be renamed without doing it)
- Undo functionality (restore original names)
- Backup original names to log file
- Handle name collisions (auto-increment if exists)
- Support multiple file patterns (*.txt *.jpg)
- Recursive directory processing
- Filter by file age, size, or pattern
- Confirmation before batch operations
- Progress display for large batches
- Detailed operation report

**Safety:**
- Never overwrite existing files
- Validate all operations before executing
- Create backup of file list
- Allow dry-run mode
- Prompt for confirmation on risky operations
### Hints:
**Basic rename structure:**
```bash
for file in *.txt; do
    # Extract parts
    basename="${file%.*}"
    extension="${file##*.}"
    
    # Create new name
    newname="${basename}_new.${extension}"
    
    # Rename with safety check
    if [[ ! -e "$newname" ]]; then
        mv "$file" "$newname"
    fi
done
```

**Timestamp formats:**
```bash
timestamp=$(date +%Y%m%d)          # 20251019
timestamp=$(date +%Y%m%d_%H%M%S)   # 20251019_011400
timestamp=$(date +%s)               # 1697692440 (Unix epoch)
```

**Check for collisions:**
```bash
counter=1
newname="file.txt"
while [[ -e "$newname" ]]; do
    newname="file_${counter}.txt"
    ((counter++))
done
```

### Expected Output Example:
```bash
./batch_rename.sh
```

```
╔════════════════════════════════════════════════════════════════╗
║                   BATCH FILE RENAMER                           ║
╚════════════════════════════════════════════════════════════════╝

Usage: ./batch_rename.sh [options] <operation> <pattern>

Operations:
  prefix <text>          Add prefix to filenames
  suffix <text>          Add suffix before extension
  timestamp [format]     Add timestamp to filenames
  replace <old> <new>    Replace text in filenames
  remove <text>          Remove text from filenames
  uppercase              Convert filenames to uppercase
  lowercase              Convert filenames to lowercase
  number [start]         Add sequential numbers
  clean                  Remove spaces and special characters

Options:
  -p, --preview          Preview changes without renaming
  -r, --recursive        Process subdirectories
  -e, --extension EXT    Filter by extension (e.g., txt,jpg)
  -f, --force            Skip confirmation prompts
  -u, --undo             Undo last batch rename
  -l, --log FILE         Save operation log to file

Examples:
  ./batch_rename.sh prefix "backup_" *.txt
  ./batch_rename.sh timestamp "%Y%m%d" *.jpg
  ./batch_rename.sh replace "old" "new" *
  ./batch_rename.sh number 001 *.mp3
  ./batch_rename.sh --preview suffix "_archived" *.doc
```

```bash
./batch_rename.sh prefix "project_" *.txt
```

```
╔════════════════════════════════════════════════════════════════╗
║              BATCH RENAME - Add Prefix                         ║
╚════════════════════════════════════════════════════════════════╝

Operation: Add prefix "project_"
Pattern: *.txt
Files found: 5

Preview of changes:
────────────────────────────────────────────────────────────────
document.txt        → project_document.txt
notes.txt           → project_notes.txt
readme.txt          → project_readme.txt
todo.txt            → project_todo.txt
config.txt          → project_config.txt
────────────────────────────────────────────────────────────────

Proceed with renaming? (y/n): y

Renaming files...
[1/5] document.txt → project_document.txt ✓
[2/5] notes.txt → project_notes.txt ✓
[3/5] readme.txt → project_readme.txt ✓
[4/5] todo.txt → project_todo.txt ✓
[5/5] config.txt → project_config.txt ✓

╔════════════════════════════════════════════════════════════════╗
║                    OPERATION COMPLETE                          ║
╚════════════════════════════════════════════════════════════════╝

Successfully renamed: 5 files
Failed: 0
Skipped: 0
Time taken: 0.234 seconds

Backup log saved to: ~/.batch_rename_backup_20251019_011400.log
To undo: ./batch_rename.sh --undo
```

```bash
./batch_rename.sh timestamp "%Y%m%d" *.jpg --preview
```

```
╔════════════════════════════════════════════════════════════════╗
║         BATCH RENAME - Add Timestamp (PREVIEW MODE)            ║
╚════════════════════════════════════════════════════════════════╝

Operation: Add timestamp "20251019"
Pattern: *.jpg
Files found: 8

Preview of changes:
────────────────────────────────────────────────────────────────
photo1.jpg          → photo1_20251019.jpg
photo2.jpg          → photo2_20251019.jpg
vacation.jpg        → vacation_20251019.jpg
sunset.jpg          → sunset_20251019.jpg
beach.jpg           → beach_20251019.jpg
mountain.jpg        → mountain_20251019.jpg
city.jpg            → city_20251019.jpg
portrait.jpg        → portrait_20251019.jpg
────────────────────────────────────────────────────────────────

⚠ PREVIEW MODE - No files were actually renamed
Run without --preview flag to execute

Summary:
  Files to rename: 8
  No conflicts detected
  Estimated time: < 1 second
```

```bash
./batch_rename.sh number 001 *.mp3
```

```
╔════════════════════════════════════════════════════════════════╗
║           BATCH RENAME - Sequential Numbering                  ║
╚════════════════════════════════════════════════════════════════╝

Operation: Add sequential numbers starting from 001
Pattern: *.mp3
Files found: 12

Preview of changes:
────────────────────────────────────────────────────────────────
song.mp3            → 001_song.mp3
track.mp3           → 002_track.mp3
audio.mp3           → 003_audio.mp3
music.mp3           → 004_music.mp3
recording.mp3       → 005_recording.mp3
... (7 more files)
────────────────────────────────────────────────────────────────

Proceed with renaming? (y/n): y

Renaming files...
████████████████████████████████████████  100% (12/12)

✓ All files renamed successfully

To undo this operation:
  ./batch_rename.sh --undo
```

```bash
./batch_rename.sh replace " " "_" *
```

```
╔════════════════════════════════════════════════════════════════╗
║           BATCH RENAME - Replace Text                          ║
╚════════════════════════════════════════════════════════════════╝

Operation: Replace " " with "_"
Pattern: *
Files found: 15

Files with spaces detected: 6
────────────────────────────────────────────────────────────────
My Document.txt     → My_Document.txt
Photo Album.jpg     → Photo_Album.jpg
Project Notes.md    → Project_Notes.md
Meeting Notes.txt   → Meeting_Notes.txt
Work Files.zip      → Work_Files.zip
User Guide.pdf      → User_Guide.pdf
────────────────────────────────────────────────────────────────

Files without spaces: 9 (will be skipped)

Proceed with renaming 6 files? (y/n): y

Renaming files...
[1/6] My Document.txt → My_Document.txt ✓
[2/6] Photo Album.jpg → Photo_Album.jpg ✓
[3/6] Project Notes.md → Project_Notes.md ✓
[4/6] Meeting Notes.txt → Meeting_Notes.txt ✓
[5/6] Work Files.zip → Work_Files.zip ✓
[6/6] User Guide.pdf → User_Guide.pdf ✓

Successfully renamed: 6 files
Skipped (no change needed): 9 files
```

```bash
./batch_rename.sh clean *.txt
```

```
╔════════════════════════════════════════════════════════════════╗
║           BATCH RENAME - Clean Filenames                       ║
╚════════════════════════════════════════════════════════════════╝

Operation: Remove spaces and special characters
Pattern: *.txt
Files found: 7

Cleaning operations:
  • Remove spaces (replace with _)
  • Remove special characters: !@#$%^&*()[]{}
  • Remove multiple underscores (collapse to single)
  • Convert to lowercase
  • Remove leading/trailing underscores

Preview of changes:
────────────────────────────────────────────────────────────────
My File (Final).txt      → my_file_final.txt
Doc #123! [DRAFT].txt    → doc_123_draft.txt
--Report--.txt           → report.txt
___notes___.txt          → notes.txt
file@home.txt            → filehome.txt
UPPERCASE.txt            → uppercase.txt
normal_file.txt          → normal_file.txt (no change)
────────────────────────────────────────────────────────────────

Proceed with renaming? (y/n): y

Renaming files...
✓ 6 files renamed
✓ 1 file skipped (already clean)
```

```bash
./batch_rename.sh --undo
```

```
╔════════════════════════════════════════════════════════════════╗
║              UNDO LAST BATCH RENAME                            ║
╚════════════════════════════════════════════════════════════════╝

Loading backup log...
Found: ~/.batch_rename_backup_20251019_011400.log

Last operation:
  Operation: Add prefix "project_"
  Date: 2025-10-19 01:14:00
  Files renamed: 5

Files to restore:
────────────────────────────────────────────────────────────────
project_document.txt    → document.txt
project_notes.txt       → notes.txt
project_readme.txt      → readme.txt
project_todo.txt        → todo.txt
project_config.txt      → config.txt
────────────────────────────────────────────────────────────────

Restore original filenames? (y/n): y

Restoring files...
[1/5] project_document.txt → document.txt ✓
[2/5] project_notes.txt → notes.txt ✓
[3/5] project_readme.txt → readme.txt ✓
[4/5] project_todo.txt → todo.txt ✓
[5/5] project_config.txt → config.txt ✓

✓ All files restored successfully
Backup log archived
```

### Bonus Challenges:
**Level 1 (Intermediate):**
- Add regex pattern support
- Extract and use EXIF data from images (for photos)
- Support renaming based on file content
- Add custom templates (user-defined patterns)
- Support date-based renaming (use file modification date)
- Add conflict resolution strategies (append number, skip, overwrite)
- Create profiles for common rename operations
- Support renaming based on CSV mapping file

**Level 2 (Advanced):**
- GUI/TUI interface (using dialog or whiptail)
- Watch folder mode (auto-rename new files)
- Integration with image metadata (camera model, date taken)
- Support for music files (ID3 tags)
- Batch operations on different file types differently
- Version control integration (commit renames)
- Network folder support
- Multi-threaded processing for large batches
- Export rename script for reproducibility

**Level 3 (Expert):**
- Machine learning for smart renaming suggestions
- OCR text extraction for naming scanned documents
- Audio fingerprinting for music file naming
- Image recognition for photo naming
- Natural language processing for content-based naming
- Cloud storage integration
- Collaborative renaming (team workflows)
- Full revision history with branching
- API for integration with other tools
- Plugin system for custom rename operations

***
