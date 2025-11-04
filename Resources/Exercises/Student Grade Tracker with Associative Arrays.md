### Goal:
Build a comprehensive script named `grade_tracker.sh` that manages student grades using associative arrays with add, search, update, delete, and display functions.
### Requirements:

**Data structure:**
- Use associative array where key=student_name, value=grade
- Support multiple students
- Grades can be numeric (0-100) or letter (A-F)

**Core functions:**
1. **Add student** - Add new student with grade
2. **Search student** - Find and display student's grade
3. **Update grade** - Modify existing student's grade
4. **Delete student** - Remove student from tracker
5. **Display all** - Show all students and grades in formatted table
6. **Statistics** - Calculate average, highest, lowest grades
7. **Grade distribution** - Count students in each grade range

**Features:**
- Interactive menu system
- Input validation (grades must be valid)
- Prevent duplicate students
- Confirm before deletion
- Sort options (by name, by grade)
- Export to file
- Load from file
### Hints:
- Main associative array: `declare -A grades`
- Use case statement for menu
- Use while loop for menu repetition
- Validate numeric grades: `[[ $grade =~ ^[0-9]+$ ]] && (( grade >= 0 && grade <= 100 ))`
- For statistics, iterate through values and calculate
- Use `sort` command for sorting operations
### Expected Output Example:
```bash
./grade_tracker.sh
```
```
╔════════════════════════════════════════╗
║     Student Grade Tracker              ║
╚════════════════════════════════════════╝

[1] Add student
[2] Search student
[3] Update grade
[4] Delete student
[5] Display all students
[6] Show statistics
[7] Grade distribution
[8] Export to file
[9] Load from file
[0] Exit

Select option: 1

--- Add Student ---
Enter student name: John Smith
Enter grade (0-100): 85
✓ Student added successfully

Select option: 1

--- Add Student ---
Enter student name: Jane Doe
Enter grade (0-100): 92
✓ Student added successfully

Select option: 5

--- All Students ---
┌─────────────────────────────────────┐
│ Name              │ Grade │ Letter  │
├─────────────────────────────────────┤
│ Jane Doe          │   92  │   A     │
│ John Smith        │   85  │   B     │
└─────────────────────────────────────┘

Total students: 2

Select option: 2

--- Search Student ---
Enter student name: John Smith

Student: John Smith
Grade: 85 (B)
Status: Passing

Select option: 6

--- Statistics ---
Total students: 2
Average grade: 88.50
Highest grade: 92 (Jane Doe)
Lowest grade: 85 (John Smith)
Passing rate: 100% (2/2 students)

Select option: 7

--- Grade Distribution ---
A (90-100): 1 student  [████████░░] 50%
B (80-89):  1 student  [████████░░] 50%
C (70-79):  0 students [░░░░░░░░░░] 0%
D (60-69):  0 students [░░░░░░░░░░] 0%
F (0-59):   0 students [░░░░░░░░░░] 0%

Select option: 0

Exiting... Goodbye!
```

### Bonus Challenges:
- Support multiple grades per student (array of grades)
- Calculate GPA with weighted courses
- Add attendance tracking
- Generate report cards
- Support class sections (multiple classes)
- Implement grade curving function
- Add student ID numbers as additional key
- Create backup before modifications
- Undo last operation
- Color-code grades (green=passing, red=failing)
- Generate graphs/charts of grade distribution
- Email reports to students (simulation)
- Import from CSV file
- Support extra credit (grades > 100)
- Track grade history (changes over time)

***