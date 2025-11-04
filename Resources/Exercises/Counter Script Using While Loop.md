### Goal:
Create a script named `counter.sh` that implements various counting patterns using while loops.
### Requirements:
- Accept starting number, ending number, and increment as arguments
- Default: count from 1 to 10, increment by 1
- Implement these counting modes:
  - **Up** - Count upward (1, 2, 3...)
  - **Down** - Count downward (10, 9, 8...)
  - **By** - Count by specific increment (2, 4, 6...)
  - **Interactive** - User controls counting (press Enter to continue)
  - **Timer** - Countdown timer with delay
- Display counter with formatting
- Show percentage complete
- Add visual progress indicator
- Support pause/resume (in interactive mode)
### Hints:
- Use `while ((count <= end))` for numeric comparison
- Increment: `((count += increment))`
- Sleep for delays: `sleep 1`
- Calculate percentage: `$((count * 100 / total))`
- Clear screen: `clear`
### Expected Output Example:
```bash
./counter.sh 1 10
```
```
╔════════════════════════════════════════╗
║          COUNTER - UPWARD              ║
╚════════════════════════════════════════╝

Counting from 1 to 10

Count: 1  [██░░░░░░░░] 10%
Count: 2  [████░░░░░░] 20%
Count: 3  [██████░░░░] 30%
Count: 4  [████████░░] 40%
Count: 5  [██████████] 50%
Count: 6  [████████████] 60%
Count: 7  [██████████████] 70%
Count: 8  [████████████████] 80%
Count: 9  [██████████████████] 90%
Count: 10 [████████████████████] 100%

✓ Counting complete!
Total iterations: 10
```

```bash
./counter.sh 10 1 -1
```
```
╔════════════════════════════════════════╗
║        COUNTER - COUNTDOWN             ║
╚════════════════════════════════════════╝

Counting down from 10 to 1

10...
9...
8...
7...
6...
5...
4...
3...
2...
1...

🚀 BLAST OFF!
```

```bash
./counter.sh 0 100 5
```
```
╔════════════════════════════════════════╗
║     COUNTER - INCREMENT BY 5           ║
╚════════════════════════════════════════╝

Counting from 0 to 100 by 5

[0]   [5]   [10]  [15]  [20]
[25]  [30]  [35]  [40]  [45]
[50]  [55]  [60]  [65]  [70]
[75]  [80]  [85]  [90]  [95]
[100]

Total steps: 21
```

```bash
./counter.sh --interactive
```
```
╔════════════════════════════════════════╗
║      INTERACTIVE COUNTER               ║
╚════════════════════════════════════════╝

Press Enter to count, 'q' to quit

Count: 1
[Press Enter]

Count: 2
[Press Enter]

Count: 3
[Press Enter]

q

Stopped at count: 3
```

```bash
./counter.sh --timer 10
```
```
╔════════════════════════════════════════╗
║        COUNTDOWN TIMER                 ║
╚════════════════════════════════════════╝

Time remaining: 10 seconds ████████████████████
Time remaining: 9 seconds  ██████████████████░░
Time remaining: 8 seconds  ████████████████░░░░
Time remaining: 7 seconds  ██████████████░░░░░░
Time remaining: 6 seconds  ████████████░░░░░░░░
Time remaining: 5 seconds  ██████████░░░░░░░░░░
Time remaining: 4 seconds  ████████░░░░░░░░░░░░
Time remaining: 3 seconds  ██████░░░░░░░░░░░░░░
Time remaining: 2 seconds  ████░░░░░░░░░░░░░░░░
Time remaining: 1 second   ██░░░░░░░░░░░░░░░░░░

⏰ TIME'S UP!
```
### Bonus Challenge:
- Add color effects (change color as counting progresses)
- Implement lap/split times
- Add sound effects (beep on milestones)
- Support floating-point increments
- Add statistics (average time per count)
- Create stopwatch mode (count up with milliseconds)
- Add multiple simultaneous counters
- Save counter state (resume later)

***
