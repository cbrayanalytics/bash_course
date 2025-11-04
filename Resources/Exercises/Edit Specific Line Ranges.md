### Goal:
Create a script named `range_editor.sh` that performs operations on specific line ranges in files.
### Requirements:
- Edit by line numbers (single, range, multiple ranges)
- Edit by pattern (first occurrence, last occurrence, all)
- Operations:
  - Substitute text in range
  - Delete range
  - Duplicate range
  - Move range
  - Copy range to another file
  - Extract range
  - Insert at specific line
- Preview changes
- Show original and modified side-by-side
- Validate line numbers
- Handle out-of-range safely
- Support relative addressing (from end)
- Batch operations
### Expected Output Example:
```bash
./range_editor.sh --lines 10-20 --substitute "old:new" document.txt
```
```
╔════════════════════════════════════════════════════════════════╗
║              RANGE EDITOR UTILITY                              ║
╚════════════════════════════════════════════════════════════════╝

File: document.txt
Total lines: 156
Operation: Substitute "old" → "new" in lines 10-20

Analyzing range...
────────────────────────────────────────────────────────────────
Range: Lines 10-20 (11 lines)
Matches found: 5 occurrences in 4 lines

Preview of changes in range:
────────────────────────────────────────────────────────────────
Line 12 (1 match):
  Before: This is the old version of the system
  After:  This is the new version of the system

Line 15 (2 matches):
  Before: The old method is old and deprecated
  After:  The new method is new and deprecated

Line 18 (1 match):
  Before: Replace old with something better
  After:  Replace new with something better

Line 20 (1 match):
  Before: The old configuration file
  After:  The new configuration file

Context (lines outside range remain unchanged):
────────────────────────────────────────────────────────────────
Line 9:  [unchanged]
Line 10: [unchanged]
Line 21: [unchanged]
Line 22: [unchanged]

Apply changes? [y/n/d] (d=show detailed diff): y

Applying changes...
✓ Modified 4 lines in range 10-20
✓ File updated successfully

Backup: document.txt.bak
```

```bash
./range_editor.sh --extract 100-150 --output section.txt largefile.txt
```
```
╔════════════════════════════════════════════════════════════════╗
║           RANGE EXTRACTOR                                      ║
╚════════════════════════════════════════════════════════════════╝

Source file: largefile.txt (2,456 lines)
Extract range: Lines 100-150 (51 lines)
Output file: section.txt

Extracting lines...

Preview of extraction:
────────────────────────────────────────────────────────────────
Line 100: This is line 100 of the file
Line 101: Content continues...
Line 102: More content here
...
Line 150: This is line 150
────────────────────────────────────────────────────────────────

✓ Extracted 51 lines to section.txt
✓ Original file unchanged

Summary:
  Source: largefile.txt (remains at 2,456 lines)
  Extracted: section.txt (51 lines)
  Size: 3.2 KB
```

```bash
./range_editor.sh --from-pattern "START" --to-pattern "END" --delete file.txt
```
```
╔════════════════════════════════════════════════════════════════╗
║         PATTERN-BASED RANGE DELETION                           ║
╚════════════════════════════════════════════════════════════════╝

File: file.txt
Start pattern: START
End pattern: END

Found ranges:
────────────────────────────────────────────────────────────────
Range 1: Lines 23-45 (23 lines)
  23: <!-- START -->
  ...
  45: <!-- END -->

Range 2: Lines 67-89 (23 lines)
  67: <!-- START -->
  ...
  89: <!-- END -->

Range 3: Lines 134-156 (23 lines)
  134: <!-- START -->
  ...
  156: <!-- END -->

Total: 3 ranges, 69 lines to delete

⚠ This will delete 69 lines from the file.
Proceed? [y/n]: y

Deleting ranges...
✓ Range 1 deleted
✓ Range 2 deleted
✓ Range 3 deleted

Result:
  Original: 200 lines
  After deletion: 131 lines
  Backup: file.txt.bak
```
### Bonus Challenge:
- Add line range arithmetic (10+5 = lines 10-15)
- Support named bookmarks/markers
- Add visual range selection (interactive mode)
- Create range templates
- Support column-based editing
- Add multi-cursor editing
- Create range macros
- Support conditional ranges
- Add range validation rules
- Create range history tracking

***