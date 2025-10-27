### Goal:
Create a script named `recursive_search.sh` that performs intelligent recursive searches through directory structures.
### Requirements:
- Search recursively through all subdirectories
- Support file filtering:
  - By extension (*.txt, *.py, etc.)
  - By size (min/max)
  - By date (modified within last N days)
  - By permissions
- Exclude patterns:
  - Hidden directories (.git, .svn)
  - Build artifacts (node_modules, target, dist)
  - Binary files
  - Large files
- Display results:
  - Group by directory
  - Sort by relevance
  - Show file paths (relative or absolute)
  - Highlight matches in context
- Performance optimizations:
  - Skip large directories
  - Use parallel processing
  - Cache results
- Generate search statistics
- Save search queries for reuse
### Expected Output Example:
```bash
./recursive_search.sh "function.*calculate" --ext "py,js" --exclude-dir "node_modules,venv"
```
```
╔════════════════════════════════════════════════════════════════╗
║           RECURSIVE CODE SEARCH                                ║
║           Pattern: function.*calculate                         ║
╚════════════════════════════════════════════════════════════════╝

Search configuration:
────────────────────────────────────────────────────────────────
Root directory:    /home/user/projects/myapp
Pattern:           function.*calculate
File extensions:   py, js
Excluded dirs:     node_modules, venv, .git
Case sensitive:    Yes
Max depth:         Unlimited

Searching...
████████████████████████████████████████ 100%

Scanned: 1,247 files in 89 directories
Time: 2.3 seconds

══════════════════════════════════════════════════════════════
RESULTS: 23 matches in 12 files
══════════════════════════════════════════════════════════════

📁 src/utils/
────────────────────────────────────────────────────────────────
📄 calculator.py (3 matches)

  Line 15:
    14 | class Calculator:
    15 |     def function_calculate_sum(self, numbers):
    16 |         return sum(numbers)

  Line 23:
    22 |
    23 |     def function_calculate_average(self, numbers):
    24 |         return sum(numbers) / len(numbers)

  Line 31:
    30 |
    31 |     def function_calculate_median(self, numbers):
    32 |         sorted_nums = sorted(numbers)

📄 math_helper.py (2 matches)

  Line 8:
     7 | from decimal import Decimal
     8 | def function_calculate_percentage(value, total):
     9 |     return (value / total) * 100

  Line 45:
    44 |
    45 | async function_calculate_compound_interest(principal, rate, time):
    46 |     return principal * (1 + rate) ** time

📁 src/api/
────────────────────────────────────────────────────────────────
📄 handlers.js (4 matches)

  Line 67:
    66 | router.post('/calculate', async (req, res) => {
    67 |   const result = await function_calculate_total(req.body.items);
    68 |   res.json({ total: result });

  Line 89:
    88 |
    89 | function function_calculate_discount(price, percent) {
    90 |   return price * (1 - percent / 100);

[...8 more files with matches]

══════════════════════════════════════════════════════════════
SEARCH STATISTICS
══════════════════════════════════════════════════════════════

Files by type:
  Python (.py):     8 files, 15 matches
  JavaScript (.js): 4 files, 8 matches

Matches by directory:
  src/utils/:       8 matches (34.8%)
  src/api/:         6 matches (26.1%)
  src/services/:    5 matches (21.7%)
  tests/:           4 matches (17.4%)

Match density:
  Highest: calculator.py (3 matches in 78 lines)
  Average: 1.9 matches per file

Performance:
  Search speed:     541 files/second
  Skipped:          node_modules/ (12,345 files)
                    venv/ (2,567 files)
                    .git/ (456 files)

════════════════════════════════════════════════════════════════

💾 Save this search? (y/n): y
Search saved as: calculate_functions.search

To run again: ./recursive_search.sh --load calculate_functions

Export options:
  [1] Text file
  [2] JSON
  [3] HTML report
  [4] CSV
Select format or press Enter to skip:
```
### Bonus Challenge:
- Add fuzzy matching
- Support regex backreferences
- Create search index for faster repeated searches
- Add preview of matches
- Support search history
- Add search templates
- Create interactive mode
- Support remote directory search (SSH)
- Add file content preview
- Implement search refinement

***