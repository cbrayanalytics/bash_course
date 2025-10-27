## Goal:
Build a comprehensive script named `sanitize.sh` that cleans and standardizes filenames according to best practices.
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

## Hints:
- Process in stages, storing intermediate results
- Use string replacement operations extensively
- Preserve the extension separately, sanitize basename, then recombine
- Use parameter expansion for most operations
- Consider using `tr` command for some character replacements
- Test with problematic filenames containing various special characters
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