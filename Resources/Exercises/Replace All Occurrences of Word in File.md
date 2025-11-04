### Goal:
Create a script named `word_replacer.sh` that replaces all occurrences of a word in files using sed, with various options and safety features.
### Requirements:
- Accept three arguments: old_word, new_word, file(s)
- Replace all occurrences (case-sensitive and case-insensitive options)
- Support multiple files
- Preview changes before applying
- Create backups before modification
- Options:
  - Case-sensitive/insensitive
  - Whole words only (not partial matches)
  - Dry-run mode (show what would change)
  - Interactive confirmation
  - Undo capability
- Show statistics:
  - Number of replacements
  - Lines affected
  - Files modified
- Validate inputs
- Handle special characters safely
### Expected Output Example:
```bash
./word_replacer.sh "error" "warning" logfile.txt
```
```
╔════════════════════════════════════════════════════════════════╗
║                WORD REPLACER UTILITY                           ║
╚════════════════════════════════════════════════════════════════╝

Configuration:
────────────────────────────────────────────────────────────────
Old word:         error
New word:         warning
Target file:      logfile.txt
Case-sensitive:   Yes
Whole words only: No
Backup:           Yes (.bak)

Analyzing file...

Preview of changes:
────────────────────────────────────────────────────────────────
File: logfile.txt (1,234 lines)

Line 15: (1 replacement)
  Before: An error occurred during startup
  After:  An warning occurred during startup

Line 23: (1 replacement)
  Before: error: connection timeout
  After:  warning: connection timeout

Line 45: (2 replacements)
  Before: error handling error cases
  After:  warning handling warning cases

[... showing first 10 changes]

Total changes to be made:
────────────────────────────────────────────────────────────────
Replacements:     47
Lines affected:   42
Files to modify:  1

Proceed with replacement? [y/n/p] (p=preview all): y

Creating backup...
✓ Backup created: logfile.txt.bak

Applying changes...
████████████████████████████████████████ 100%

╔════════════════════════════════════════════════════════════════╗
║                     OPERATION COMPLETE                         ║
╚════════════════════════════════════════════════════════════════╝

Summary:
────────────────────────────────────────────────────────────────
✓ Successfully replaced 47 occurrences
✓ Modified 42 lines in logfile.txt
✓ Backup saved to: logfile.txt.bak

To undo: mv logfile.txt.bak logfile.txt
```

```bash
./word_replacer.sh "Error" "Warning" *.log --case-insensitive --whole-words --dry-run
```
```
╔════════════════════════════════════════════════════════════════╗
║           WORD REPLACER - DRY RUN MODE                         ║
╚════════════════════════════════════════════════════════════════╝

Configuration:
────────────────────────────────────────────────────────────────
Old word:         Error
New word:         Warning
Target files:     app.log, system.log, error.log (3 files)
Case-insensitive: Yes (matches: error, Error, ERROR, etc.)
Whole words only: Yes (won't match 'errors' or 'terrorism')
Mode:             DRY RUN (no changes will be made)

Scanning files...

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📄 app.log (15 matches)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Would change:
  Line 12:  ERROR → Warning
  Line 23:  error → Warning
  Line 34:  Error → Warning
  [+12 more]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📄 system.log (23 matches)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Would change:
  Line 5:   ERROR → Warning
  Line 17:  error → Warning
  [+21 more]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📄 error.log (89 matches)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Would change:
  Line 1:   error → Warning
  Line 2:   ERROR → Warning
  Line 4:   Error → Warning
  [+86 more]

╔════════════════════════════════════════════════════════════════╗
║                    DRY RUN SUMMARY                             ║
╚════════════════════════════════════════════════════════════════╝

Would make these changes:
────────────────────────────────────────────────────────────────
Total replacements: 127
Files affected:     3
Lines affected:     98

⚠ THIS WAS A DRY RUN - NO FILES WERE MODIFIED

To apply these changes, run without --dry-run flag:
  ./word_replacer.sh "Error" "Warning" *.log --case-insensitive --whole-words
```
### Bonus Challenge:
- Add regex pattern support
- Support find-and-replace from CSV file
- Add spell-check integration
- Create interactive mode (approve each change)
- Support multiple simultaneous replacements
- Add search history
- Create templates for common replacements
- Support contextual replacements
- Add rollback to specific version
- Create diff viewer for changes

***