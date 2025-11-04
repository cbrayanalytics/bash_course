### Goal:
Create a script named `file_list.sh` that stores filenames in an array and performs operations on them.
### Requirements:
- Create an array with at least 5 filenames
- Display all filenames with their index numbers
- Display the total count of files
- Show the first and last filename
- Loop through and display each filename with its character length
- Add a new filename to the array and display updated list
### Hints:
- Use `files=("file1" "file2" ...)` syntax
- Use `${#files[@]}` for array length
- Use `${!files[@]}` to get indices
- Use `${#filename}` for string length of each element
### Expected Output Example:
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

### Bonus Challenge:
- Sort the array alphabetically
- Filter files by extension
- Find the longest and shortest filename
- Accept filenames as command-line arguments

***
