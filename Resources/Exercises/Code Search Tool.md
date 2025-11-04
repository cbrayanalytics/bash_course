### Goal:
Build a comprehensive code search tool named `code_search.sh` that finds function definitions and usage across project files.
### Requirements:

**Search Capabilities:**
1. **Function Definitions:**
   - Python: `def function_name`
   - JavaScript: `function name`, `const name =`, `=> {}`
   - Bash: `function_name()`
   - Java: `public/private type name`
   - C/C++: `type name(`
   - Go: `func name`
   - Ruby: `def name`
   - PHP: `function name`

2. **Function Calls/Usage:**
   - Find where functions are called
   - Count usage frequency
   - Show call hierarchy
   - Detect unused functions

3. **Advanced Features:**
   - Class definitions and usage
   - Variable declarations
   - Import/include statements
   - Comments and documentation
   - TODO/FIXME markers
   - Deprecated code

**Analysis Features:**
- Code complexity metrics
- Function size (lines of code)
- Cyclomatic complexity
- Documentation coverage
- Dead code detection
- Dependency analysis
- Cross-file references
- Call graphs

**Output Options:**
- Interactive mode
- JSON export
- HTML report with syntax highlighting
- Graph visualizations (call trees)
- IDE integration (VS Code, etc.)
### Expected Output Example:
```bash
./code_search.sh --function "calculate.*" --lang python,javascript
```
```
╔════════════════════════════════════════════════════════════════╗
║                CODE SEARCH TOOL v1.0                           ║
║                Function Pattern: calculate.*                   ║
╚════════════════════════════════════════════════════════════════╝

Configuration:
────────────────────────────────────────────────────────────────
Root directory:   /home/user/projects/myapp
Languages:        Python, JavaScript
Pattern:          calculate.*
Search depth:     Unlimited
Excluded:         node_modules/, __pycache__/, .git/

Scanning project...
████████████████████████████████████████ 100%

Files scanned: 347
Time: 1.8 seconds

══════════════════════════════════════════════════════════════
FUNCTION DEFINITIONS FOUND: 23
══════════════════════════════════════════════════════════════

Python Functions (15):
────────────────────────────────────────────────────────────────

📄 src/utils/calculator.py
────────────────────────────────────────────────────────────────

[Line 15] def calculate_sum(numbers: List[int]) -> int
  Description: Calculate the sum of a list of numbers
  Parameters: numbers (List[int])
  Returns: int
  Lines: 4
  Complexity: O(n)
  Documentation: ✓ Complete
  Used in: 12 places
  
  Definition:
    15 | def calculate_sum(numbers: List[int]) -> int:
    16 |     """Calculate the sum of a list of numbers."""
    17 |     return sum(numbers)
  
  Usage locations:
    • main.py:45 - calculate_sum(user_inputs)
    • tests/test_calc.py:23 - result = calculate_sum([1,2,3])
    • api/handlers.py:89 - total = calculate_sum(items)
    [+9 more...]

────────────────────────────────────────────────────────────────

[Line 23] def calculate_average(numbers: List[float]) -> float
  Description: Calculate arithmetic mean
  Parameters: numbers (List[float])
  Returns: float
  Lines: 6
  Complexity: O(n)
  Documentation: ✓ Complete
  Used in: 8 places
  
  Definition:
    23 | def calculate_average(numbers: List[float]) -> float:
    24 |     """Calculate the arithmetic mean of numbers."""
    25 |     if not numbers:
    26 |         return 0.0
    27 |     return sum(numbers) / len(numbers)

────────────────────────────────────────────────────────────────

[Line 45] def calculate_median( List[float]) -> float
  Description: Calculate the median value
  Parameters: data (List[float])
  Returns: float
  Lines: 8
  Complexity: O(n log n)
  Documentation: ✓ Complete
  Used in: 3 places

────────────────────────────────────────────────────────────────

📄 src/finance/calculator.py
────────────────────────────────────────────────────────────────

[Line 12] def calculate_interest(principal, rate, time)
  Description: Calculate compound interest
  Parameters: principal, rate, time
  Returns: float
  Lines: 5
  Documentation: ⚠ Incomplete (missing return type)
  Used in: 15 places
  
  ⚠ This function has high usage - consider adding type hints

[Line 34] def calculate_tax(amount, rate=0.2)
  Description: Calculate tax amount
  Parameters: amount, rate (default 0.2)
  Returns: float
  Lines: 3
  Documentation: ✓ Complete
  Used in: 24 places
  
  ℹ Most used calculation function in project

[...10 more Python functions]

JavaScript Functions (8):
────────────────────────────────────────────────────────────────

📄 src/frontend/utils.js
────────────────────────────────────────────────────────────────

[Line 23] function calculateTotal(items)
  Description: Calculate total price of items
  Parameters: items (Array)
  Returns: number
  Lines: 8
  Documentation: ✓ JSDoc present
  Used in: 7 places
  
  Definition:
    23 | /**
    24 |  * Calculate total price of items
    25 |  * @param {Array} items - Array of items with price
    26 |  * @returns {number} Total price
    27 |  */
    28 | function calculateTotal(items) {
    29 |     return items.reduce((sum, item) => sum + item.price, 0);
    30 | }

────────────────────────────────────────────────────────────────

[Line 67] const calculateDiscount = (price, percent) => {...}
  Description: Arrow function for discount calculation
  Parameters: price, percent
  Returns: number
  Lines: 3
  Documentation: ✗ Missing
  Used in: 5 places
  
  ⚠ No documentation found - consider adding JSDoc

[...6 more JavaScript functions]

══════════════════════════════════════════════════════════════
USAGE ANALYSIS
══════════════════════════════════════════════════════════════

Most used functions:
────────────────────────────────────────────────────────────────
1. calculate_tax           24 uses
2. calculate_interest      15 uses
3. calculate_sum           12 uses
4. calculate_average        8 uses
5. calculateTotal           7 uses

Unused functions: 2
────────────────────────────────────────────────────────────────
⚠ calculate_standard_deviation (defined but never called)
⚠ calculate_variance (defined but never called)

Consider removing unused functions or adding tests.

══════════════════════════════════════════════════════════════
CODE QUALITY METRICS
══════════════════════════════════════════════════════════════

Documentation coverage:
────────────────────────────────────────────────────────────────
Fully documented:    18 (78%)
Partially documented: 3 (13%)
Undocumented:         2 (9%)

Average function length: 5.3 lines
Longest function: calculate_complex_formula (23 lines)
  Location: src/math/advanced.py:145
  ⚠ Consider breaking into smaller functions

Complexity distribution:
────────────────────────────────────────────────────────────────
Low (O(1), O(log n)):    12 (52%)
Medium (O(n)):           9 (39%)
High (O(n²), O(n log n)): 2 (9%)

Type hints:
────────────────────────────────────────────────────────────────
Python functions with type hints: 12 of 15 (80%)
Missing type hints in: calculate_interest, legacy_calculate

══════════════════════════════════════════════════════════════
DEPENDENCY GRAPH
══════════════════════════════════════════════════════════════

Function call hierarchy (top-level):
────────────────────────────────────────────────────────────────
main()
├─ process_data()
│  ├─ calculate_sum()
│  ├─ calculate_average()
│  └─ calculate_median()
├─ generate_report()
│  ├─ calculate_total()
│  └─ calculate_tax()
└─ finalize()
   └─ calculate_final_amount()

External dependencies:
────────────────────────────────────────────────────────────────
• numpy (used by 3 functions)
• decimal (used by 5 functions)
• math (used by 8 functions)

══════════════════════════════════════════════════════════════
CROSS-LANGUAGE ANALYSIS
══════════════════════════════════════════════════════════════

API endpoints calling calculate functions:
────────────────────────────────────────────────────────────────
POST /api/calculate-total
  └─ Calls: calculateTotal (JS)
      └─ Calls: calculate_tax (Python via API)

GET /api/statistics
  └─ Calls: calculate_average, calculate_median (Python)

Potential optimization:
────────────────────────────────────────────────────────────────
⚠ calculate_tax called 24 times across codebase
  Consider caching results for repeated calculations

╔════════════════════════════════════════════════════════════════╗
║                     RECOMMENDATIONS                            ║
╚════════════════════════════════════════════════════════════════╝

📝 Documentation:
  • Add documentation to calculateDiscount (utils.js:67)
  • Complete type hints for calculate_interest

🔧 Code Quality:
  • Remove or document unused functions (2 found)
  • Break down long function: calculate_complex_formula

⚡ Performance:
  • Consider caching for calculate_tax (called 24 times)
  • Review O(n²) complexity in calculate_combinations

✅ Testing:
  • Add tests for unused functions or remove them
  • Ensure test coverage for high-usage functions

╔════════════════════════════════════════════════════════════════╗
║                        EXPORT OPTIONS                          ║
╚════════════════════════════════════════════════════════════════╝

Generated reports:
────────────────────────────────────────────────────────────────
📄 Text report:     code_search_report.txt
📊 JSON export:     code_search_data.json
📈 HTML report:     code_search_report.html (with syntax highlighting)
🔗 Call graph:      call_graph.dot (use graphviz to visualize)

Open HTML report? (y/n): 
```
### Bonus Challenges:
**Level 1 (Intermediate):**
- Add refactoring suggestions
- Support more programming languages
- Create function signature comparison
- Add code duplication detection
- Support macro/template detection
- Add performance profiling integration
- Create code coverage analysis
- Support multi-repo searches

**Level 2 (Advanced):**
- Build abstract syntax tree (AST) parser
- Add semantic code search
- Create automated documentation generator
- Add code smell detection
- Support architectural analysis
- Create dependency vulnerability scanning
- Add license compliance checking
- Support code clone detection

**Level 3 (Expert):**
- Machine learning for code patterns
- Automated code review
- Intelligent refactoring suggestions
- Code generation from patterns
- Real-time code analysis in editors
- Distributed code search across repos
- Code evolution tracking
- AI-powered code explanation
