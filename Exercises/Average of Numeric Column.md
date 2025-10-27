### Goal:
Create a script named `column_calculator.sh` that performs statistical calculations on numeric columns using awk.
### Requirements:
- Calculate for numeric columns:
  - Sum
  - Average (mean)
  - Median
  - Mode
  - Standard deviation
  - Min/Max
  - Count
  - Percentiles (25th, 50th, 75th)
- Handle:
  - Missing values
  - Non-numeric values
  - Scientific notation
  - Negative numbers
  - Decimal numbers
- Multiple column analysis
- Group by calculations
- Output formatting:
  - Human-readable
  - JSON
  - Table format
- Visualizations (ASCII charts)
### Expected Output Example:
```bash
./column_calculator.sh --sum --column 3 sales.csv
```
```
╔════════════════════════════════════════════════════════════════╗
║              COLUMN CALCULATOR - SUM                           ║
╚════════════════════════════════════════════════════════════════╝

File: sales.csv
Column: 3 (Amount)
Operation: Sum

Analyzing column...
────────────────────────────────────────────────────────────────
Total rows: 1,246
Valid numeric values: 1,242
Non-numeric/empty: 4
Column type: Float

Processing...
████████████████████████████████████████ 100%

╔════════════════════════════════════════════════════════════════╗
║                        RESULT                                  ║
╚════════════════════════════════════════════════════════════════╝

Sum of Amount: $1,456,789.50

Additional statistics:
────────────────────────────────────────────────────────────────
Count: 1,242 values
Average: $1,173.22
Min: $10.00
Max: $9,999.99
Range: $9,989.99
```

```bash
./column_calculator.sh --stats --column Amount data.csv
```
```
╔════════════════════════════════════════════════════════════════╗
║          COMPREHENSIVE STATISTICS - Amount Column              ║
╚════════════════════════════════════════════════════════════════╝

File: data.csv
Column: Amount (column 4)

Dataset Overview:
────────────────────────────────────────────────────────────────
Total rows: 1,246
Valid values: 1,242
Missing/Invalid: 4 (0.3%)
Data type: Numeric (float)

Central Tendency:
────────────────────────────────────────────────────────────────
Sum:            $1,456,789.50
Mean:           $1,173.22
Median:         $895.50
Mode:           $499.99 (appears 23 times)

Spread:
────────────────────────────────────────────────────────────────
Min:            $10.00
Max:            $9,999.99
Range:          $9,989.99
Variance:       2,345,678.90
Std Deviation:  $1,531.69
Coefficient of Variation: 130.6%

Quartiles:
────────────────────────────────────────────────────────────────
Q1 (25th):      $450.25
Q2 (50th):      $895.50  (median)
Q3 (75th):      $1,650.75
IQR:            $1,200.50

Distribution:
────────────────────────────────────────────────────────────────
    $0-1000     ██████████████████████████ 652 (52.5%)
$1000-2000     ████████████████ 342 (27.5%)
$2000-5000     ████████ 189 (15.2%)
$5000-10000    ██ 59 (4.8%)

Outliers detected: 12 values
  High outliers (>$5,527): 12 values
  Low outliers (<-$2,152): 0 values

╔════════════════════════════════════════════════════════════════╗
║                    VISUALIZATION                               ║
╚════════════════════════════════════════════════════════════════╝

Box Plot:
────────────────────────────────────────────────────────────────
     Min      Q1      Median    Q3       Max
      |       |         |       |         |
  ────┼───────┤─────────┼───────┤─────────┼────
     $10    $450      $896   $1,651   $9,999

Histogram:
────────────────────────────────────────────────────────────────
   0-500  ████████████████████████████ 556
 500-1000 █████████████ 96
1000-1500 ████████████ 234
1500-2000 ████████ 108
2000-2500 █████ 89
2500-5000 ████ 100
5000+     ██ 59
```

```bash
./column_calculator.sh --group-by Category --sum Amount sales.csv
```
```
╔════════════════════════════════════════════════════════════════╗
║          GROUPED CALCULATION - Sum by Category                 ║
╚════════════════════════════════════════════════════════════════╝

File: sales.csv
Group by: Category (column 2)
Calculate: Sum of Amount (column 4)

Processing grouped data...

Results by Category:
────────────────────────────────────────────────────────────────
Category        | Count | Total Sum    | Avg        | % of Total
────────────────────────────────────────────────────────────────
Electronics     |   456 | $567,890.00  | $1,245.37  | 39.0%
Clothing        |   342 | $234,567.00  | $685.90    | 16.1%
Home & Garden   |   289 | $345,678.00  | $1,196.08  | 23.7%
Sports          |   159 | $308,654.50  | $1,941.22  | 21.2%
────────────────────────────────────────────────────────────────
TOTAL           | 1,246 | $1,456,789.50| $1,169.19  | 100.0%

Visualization:
────────────────────────────────────────────────────────────────
Electronics     ████████████████████████████████████ $567,890
Clothing        ███████████████ $234,567
Home & Garden   ██████████████████████ $345,679
Sports          █████████████████████ $308,655

Top performing category: Electronics ($567,890)
Lowest performing: Clothing ($234,567)
Difference: $333,323 (142% higher)
```
### Bonus Challenge:
- Add time-series analysis
- Support weighted averages
- Add correlation analysis between columns
- Create moving averages
- Support cumulative calculations
- Add percentile ranks
- Create Z-score calculations
- Support binning/bucketing
- Add confidence intervals
- Create comparison analysis (year-over-year)

***