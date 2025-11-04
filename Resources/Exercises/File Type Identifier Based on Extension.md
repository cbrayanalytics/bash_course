### Goal:
Create a script named `file_identifier.sh` that identifies file types based on their extensions and provides relevant information.
### Requirements:
- Accept one or more filenames as arguments
- Use case statement to match file extensions
- Identify these categories:
  - Documents (txt, doc, docx, pdf, odt)
  - Images (jpg, jpeg, png, gif, bmp, svg)
  - Videos (mp4, avi, mkv, mov, flv)
  - Audio (mp3, wav, flac, aac, ogg)
  - Archives (zip, tar, gz, rar, 7z)
  - Scripts (sh, bash, py, js, pl)
  - Source code (c, cpp, java, go, rs)
  - Data (csv, json, xml, yaml, sql)
- For each file, display:
  - Filename
  - Extension
  - Category
  - Suggested action/program
  - File size (if exists)
- Handle files without extensions
- Handle non-existent files
### Hints:
- Extract extension: `${filename##*.}`
- Convert to lowercase for case-insensitive matching: `${extension,,}`
- Use `|` for multiple extensions in one pattern
- Use `-e` to check if file exists
- Use `stat` or `ls -lh` for file size
### Expected Output Example:
```bash
./file_identifier.sh document.pdf image.jpg script.sh data.csv unknown
```

```
╔════════════════════════════════════════════════════════════════╗
║              FILE TYPE IDENTIFIER                              ║
╚════════════════════════════════════════════════════════════════╝

Analyzing 5 files...

┌────────────────────────────────────────────────────────────────┐
│ File 1: document.pdf                                           │
├────────────────────────────────────────────────────────────────┤
│ Extension:    .pdf                                             │
│ Category:     Document                                         │
│ Type:         PDF Document                                     │
│ Size:         2.3 MB                                           │
│ Exists:       ✓ Yes                                            │
│                                                                 │
│ Suggested Actions:                                             │
│   • Open with: evince, okular, Adobe Reader                   │
│   • Convert: pdf2txt (extract text)                           │
│   • Compress: gs (reduce size)                                │
└────────────────────────────────────────────────────────────────┘

┌────────────────────────────────────────────────────────────────┐
│ File 2: image.jpg                                              │
├────────────────────────────────────────────────────────────────┤
│ Extension:    .jpg                                             │
│ Category:     Image                                            │
│ Type:         JPEG Image                                       │
│ Size:         1.5 MB                                           │
│ Exists:       ✓ Yes                                            │
│                                                                 │
│ Suggested Actions:                                             │
│   • View with: feh, eog, gimp                                 │
│   • Edit: gimp, krita, photoshop                              │
│   • Convert: convert image.jpg image.png                      │
│   • Resize: convert -resize 50% image.jpg small.jpg           │
└────────────────────────────────────────────────────────────────┘

┌────────────────────────────────────────────────────────────────┐
│ File 3: script.sh                                              │
├────────────────────────────────────────────────────────────────┤
│ Extension:    .sh                                              │
│ Category:     Script                                           │
│ Type:         Shell Script                                     │
│ Size:         3.2 KB                                           │
│ Exists:       ✓ Yes                                            │
│ Executable:   ✓ Yes                                            │
│                                                                 │
│ Suggested Actions:                                             │
│   • Execute: ./script.sh or bash script.sh                    │
│   • Edit: nano, vim, vscode                                   │
│   • Check syntax: bash -n script.sh                           │
│   • Debug: bash -x script.sh                                  │
└────────────────────────────────────────────────────────────────┘

┌────────────────────────────────────────────────────────────────┐
│ File 4: data.csv                                               │
├────────────────────────────────────────────────────────────────┤
│ Extension:    .csv                                             │
│ Category:     Data                                             │
│ Type:         Comma-Separated Values                           │
│ Size:         850 KB                                           │
│ Exists:       ✓ Yes                                            │
│                                                                 │
│ Suggested Actions:                                             │
│   • View: column -t -s, data.csv | less                       │
│   • Edit: libreoffice calc, excel                             │
│   • Process: awk, csvkit, pandas (python)                     │
│   • Query: q (SQL for CSV)                                    │
└────────────────────────────────────────────────────────────────┘

┌────────────────────────────────────────────────────────────────┐
│ File 5: unknown                                                │
├────────────────────────────────────────────────────────────────┤
│ Extension:    (none)                                           │
│ Category:     Unknown                                          │
│ Type:         File without extension                           │
│ Exists:       ✗ No                                             │
│                                                                 │
│ ⚠ Cannot determine file type without extension                │
│ Try: file unknown (use magic numbers to detect type)          │
└────────────────────────────────────────────────────────────────┘

═══════════════════════════════════════════════════════════════
Summary:
═══════════════════════════════════════════════════════════════
Total files analyzed: 5
  Documents: 1
  Images: 1
  Scripts: 1
  Data: 1
  Unknown: 1
```
### Bonus Challenge:
- Use `file` command to verify extension matches actual file type
- Add MIME type detection
- Suggest conversion between formats
- Batch processing mode (process entire directory)
- Add file validation (corrupted files)
- Generate report with file statistics
- Support compressed extensions (.tar.gz)
- Add custom extension mappings via config file

***
