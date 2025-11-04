## Goal:
Create a script named `text_replacer.sh` that performs various text replacement operations.
## Requirements:
- Accept input text as an argument
- Perform and display these replacements:
  - Replace first occurrence of a word
  - Replace all occurrences of a word
  - Remove all spaces
  - Replace multiple spaces with single space
  - Remove all numbers
  - Replace underscores with hyphens
## Hints:
- Use `${text/pattern/replacement}` for first occurrence
- Use `${text//pattern/replacement}` for all occurrences
- Use `${text// /}` to remove spaces (replace with nothing)
- For multiple replacements, chain them or store intermediate results
- Patterns can be literal text or character classes
## Expected Output Example:
```bash
./text_replacer.sh "hello world hello universe"
```
```
Original text:           hello world hello universe

Replace first 'hello':   hi world hello universe
Replace all 'hello':     hi world hi universe
Remove spaces:           helloworldhellouniverse
Replace spaces w/dash:   hello-world-hello-universe
```

```bash
./text_replacer.sh "test_file_123.txt"
```
```
Original text:           test_file_123.txt

Remove numbers:          test_file_.txt
Underscores to hyphens:  test-file-123.txt
Remove extension:        test_file_123
```
## Bonus Challenge:
- Accept pattern and replacement as arguments (custom find/replace)
- Support regex-like patterns
- Case-insensitive replacement option

***
