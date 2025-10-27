### Goal:
Create a script named `word_frequency.sh` that analyzes text files to find the most common words using text processing pipelines.
### Requirements:
- Count word frequency in files
- Find top N most common words (default: 10)
- Text processing:
  - Convert to lowercase
  - Remove punctuation
  - Filter stop words (the, a, an, etc.)
  - Handle contractions
  - Remove numbers (optional)
- Options:
  - Case-sensitive/insensitive
  - Minimum word length
  - Exclude words from list
  - Include only words from list
- Statistics:
  - Total words
  - Unique words
  - Average word length
  - Vocabulary richness
- Visualizations:
  - Bar charts
  - Word cloud (ASCII)
  - Frequency distribution
### Expected Output Example:
```bash
./word_frequency.sh document.txt
```
```
╔════════════════════════════════════════════════════════════════╗
║           WORD FREQUENCY ANALYZER                              ║
║           File: document.txt                                   ║
╚════════════════════════════════════════════════════════════════╝

Analyzing text...

Document Statistics:
────────────────────────────────────────────────────────────────
Total words:        5,247
Unique words:       1,432
Vocabulary ratio:   27.3%
Average word length: 5.8 characters

Processing pipeline:
  1. Convert to lowercase ✓
  2. Remove punctuation ✓
  3. Filter stop words ✓
  4. Count frequency ✓
  5. Sort by frequency ✓

══════════════════════════════════════════════════════════════
TOP 10 MOST COMMON WORDS
══════════════════════════════════════════════════════════════

Rank  Word          Count    % of Total  Bar
────────────────────────────────────────────────────────────────
1     system        247      4.71%       ████████████████████████████
2     data          189      3.60%       ██████████████████████
3     process       156      2.97%       ██████████████████
4     user          134      2.55%       ████████████████
5     application   98       1.87%       ███████████
6     server        87       1.66%       ██████████
7     database      76       1.45%       █████████
8     network       65       1.24%       ████████
9     security      54       1.03%       ██████
10    configuration 48       0.91%       ██████

══════════════════════════════════════════════════════════════
WORD LENGTH DISTRIBUTION
══════════════════════════════════════════════════════════════

Length    Count     % of Total
────────────────────────────────────────────────────────────────
1-3       892       17.0%      █████████████████
4-6       2,345     44.7%      ████████████████████████████████████████████
7-9       1,567     29.9%      ██████████████████████████████
10+       443       8.4%       ████████

══════════════════════════════════════════════════════════════
WORD CLOUD (Top 25)
══════════════════════════════════════════════════════════════

        SYSTEM            data        process
    user        application    SERVER    database
network     SECURITY   configuration   management
    analysis    performance    INFORMATION    service
development      TECHNOLOGY        infrastructure
        implementation    INTEGRATION    monitoring
    optimization    DEPLOYMENT    documentation

(Size indicates relative frequency)

══════════════════════════════════════════════════════════════
EXCLUDED STOP WORDS
══════════════════════════════════════════════════════════════

Filtered: 2,134 occurrences
Common stop words: the (456), and (234), of (198), to (187), a (156)

Export Options:
────────────────────────────────────────────────────────────────
📄 Full frequency list: word_frequencies.txt
📊 CSV export: word_frequencies.csv
📈 JSON  word_frequencies.json
```

```bash
./word_frequency.sh --top 20 --min-length 5 --case-sensitive book.txt
```
```
╔════════════════════════════════════════════════════════════════╗
║     WORD FREQUENCY - Extended Analysis                         ║
║     File: book.txt (Case-Sensitive, Min Length: 5)             ║
╚════════════════════════════════════════════════════════════════╝

Processing with filters:
  ✓ Case-sensitive mode
  ✓ Minimum length: 5 characters
  ✓ Stop words excluded

Document Overview:
────────────────────────────────────────────────────────────────
Total words:         45,678
After filtering:     23,456 (51.4%)
Unique words:        4,567
Vocabulary richness: 19.5%

Top 20 Words (5+ characters):
────────────────────────────────────────────────────────────────
Rank  Word              Count   Frequency
────────────────────────────────────────────────────────────────
1     character         345     1.47%
2     narrative         298     1.27%
3     development       267     1.14%
4     situation         234     1.00%
5     understanding     198     0.84%
6     relationship      187     0.80%
7     perspective       176     0.75%
8     experience        165     0.70%
9     community         154     0.66%
10    important         143     0.61%
11    different         132     0.56%
12    several           121     0.52%
13    through           110     0.47%
14    continue          99      0.42%
15    significant       88      0.38%
16    particular        77      0.33%
17    information       66      0.28%
18    necessary         55      0.23%
19    available         44      0.19%
20    following         33      0.14%

Capitalization Analysis:
────────────────────────────────────────────────────────────────
"System" vs "system":
  System: 34 occurrences
  system: 213 occurrences
  
Notable proper nouns detected: 23 unique words
```
### Bonus Challenge:
- Add n-gram analysis (phrases)
- Support multiple files comparison
- Add sentiment analysis
- Detect readability metrics
- Add language detection
- Create topic modeling
- Support PDF/DOCX input
- Add spelling suggestions
- Create contextual word analysis
- Generate semantic networks

***