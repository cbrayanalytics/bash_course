
### Goal

Build a comprehensive script named `grade_tracker.sh` that manages student grades using associative arrays with add, search, update, delete, and display functions.

---

### Requirements

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

---

### Hints

- Main associative array: `declare -A grades`
- Use case statement for menu
- Use while loop for menu repetition
- Validate numeric grades: `[[ $grade =~ ^[0-9]+$ ]] && (( grade >= 0 && grade <= 100 ))`
- For statistics, iterate through values and calculate
- Use `sort` command for sorting operations

---

### Bonus Challenges

- Support multiple grades per student (array of grades)
- Calculate GPA with weighted courses
- Add attendance tracking
- Generate report cards
- Support class sections (multiple classes)
- Implement grade curving function
- Undo last operation
- Color-code grades (green=passing, red=failing)
- Generate graphs/charts of grade distribution
- Email reports to students (simulation)
- Import from CSV file
- Support extra credit (grades > 100)

---

## Pseudocode

```bash
CONSTANTS:
    GRADE_FILE = "grades_backup.bak"
    CSV_EXPORT = "grades_export.csv"
    LOG_FILE = "/tmp/grade_tracker_YYYYMMDD.log"
    A_GRADE = 90, B_GRADE = 80, C_GRADE = 70, D_GRADE = 60
    MIN_GRADE = 0, MAX_GRADE = 150, STANDARD_MAX_GRADE = 100
    MAX_UNDO_OPERATIONS = 20
    ATTENDANCE_EXCELLENT = 90, ATTENDANCE_GOOD = 75
    GPA_A = 4.0, GPA_B = 3.0, GPA_C = 2.0, GPA_D = 1.0, GPA_F = 0.0
    COLORS = {RED, GREEN, YELLOW, BLUE, RESET}

DATA_STRUCTURES:
    grades = ASSOCIATIVE_ARRAY[student_name → grade]
    students = ASSOCIATIVE_ARRAY[student_name → extended_info]
    class_sections = ASSOCIATIVE_ARRAY[section_name → student_list]
    operation_history = ARRAY[operation_records]

FUNCTION cleanup():
    exit_code = GET_EXIT_CODE()
    IF TEMP_DIR EXISTS THEN
        DELETE TEMP_DIR
    EXIT(exit_code)

FUNCTION check_dependencies():
    required_commands = ["bc", "sort", "date"]
    missing = 0
    FOR EACH cmd IN required_commands DO
        IF NOT COMMAND_EXISTS(cmd) THEN
            PRINT_ERROR("Missing: " + cmd)
            missing++
    IF missing > 0 THEN RETURN ERROR
    IF BASH_VERSION < 4.3 THEN RETURN ERROR
    RETURN SUCCESS

FUNCTION log(level, message):
    timestamp = CURRENT_TIMESTAMP()
    LOG_ENTRY = "[" + timestamp + "] [" + level + "] " + message
    APPEND_TO_FILE(LOG_FILE, LOG_ENTRY)
    IF level IN [ERROR, WARN] THEN
        PRINT_TO_STDERR(LOG_ENTRY)

FUNCTION display_header(title):
    border = "═══════════════════════════════════════"
    padding_left = (LENGTH(border) - LENGTH(title)) / 2
    padding_right = LENGTH(border) - LENGTH(title) - padding_left
    PRINT "╔" + border + "╗"
    PRINT "║" + SPACES(padding_left) + title + SPACES(padding_right) + "║"
    PRINT "╚" + border + "╝"

FUNCTION display_menu():
    display_header("Student Grade Tracker")
    PRINT "[1]  Add student"
    PRINT "[2]  Search student"
    PRINT "[3]  Update grade"
    PRINT "[4]  Delete student"
    PRINT "[5]  Display all students"
    PRINT "[6]  Show statistics"
    PRINT "[7]  Grade distribution"
    PRINT "[8]  Export to file"
    PRINT "[9]  Load from file"
    PRINT "[10] Sort students"
    PRINT "[11] Undo last operation"
    PRINT "[12] Apply grade curve"
    PRINT "[13] Extended features"
    PRINT "[14] Class sections"
    PRINT "[0]  Exit"
    PRINT "Select option: "

FUNCTION display_error(message):
    PRINT_COLORED(RED, "✗ Error: " + message)
    log("ERROR", message)

FUNCTION display_success(message):
    PRINT_COLORED(GREEN, "✓ Success: " + message)
    log("INFO", message)

FUNCTION display_warning(message):
    PRINT_COLORED(YELLOW, "⚠ Warning: " + message)
    log("WARN", message)

FUNCTION pause(message = "Press Enter to continue..."):
    PRINT_COLORED(BLUE, message)
    READ_INPUT()

FUNCTION get_letter_grade(numeric_grade):
    IF numeric_grade >= A_GRADE THEN RETURN "A"
    ELSE IF numeric_grade >= B_GRADE THEN RETURN "B"
    ELSE IF numeric_grade >= C_GRADE THEN RETURN "C"
    ELSE IF numeric_grade >= D_GRADE THEN RETURN "D"
    ELSE RETURN "F"

FUNCTION get_grade_color(numeric_grade):
    IF numeric_grade >= B_GRADE THEN RETURN GREEN
    ELSE IF numeric_grade >= C_GRADE THEN RETURN YELLOW
    ELSE RETURN RED

FUNCTION get_passing_status(numeric_grade):
    IF numeric_grade >= D_GRADE THEN RETURN "Passing"
    ELSE RETURN "Failing"

FUNCTION validate_grade(grade_input):
    IF NOT IS_INTEGER(grade_input) THEN
        display_error("Grade must be a number")
        RETURN ERROR
    grade_value = TO_INTEGER(grade_input)
    IF grade_value < MIN_GRADE OR grade_value > MAX_GRADE THEN
        display_error("Grade must be between 0 and 150")
        RETURN ERROR
    IF grade_value > STANDARD_MAX_GRADE THEN
        display_warning("Extra credit grade detected")
    RETURN SUCCESS

FUNCTION validate_student_name(name_input):
    trimmed_name = TRIM_WHITESPACE(name_input)
    IF IS_EMPTY(trimmed_name) THEN
        display_error("Student name cannot be empty")
        RETURN ERROR
    RETURN SUCCESS

FUNCTION validate_attendance(attendance_input):
    IF NOT IS_INTEGER(attendance_input) THEN
        display_error("Attendance must be a number")
        RETURN ERROR
    IF attendance_input < 0 OR attendance_input > 100 THEN
        display_error("Attendance must be between 0 and 100")
        RETURN ERROR
    RETURN SUCCESS

FUNCTION validate_student_id(id_input):
    IF NOT IS_INTEGER(id_input) THEN
        display_error("Student ID must be a number")
        RETURN ERROR
    RETURN SUCCESS

FUNCTION confirm_action(prompt_message):
    PRINT prompt_message + " (y/n): "
    user_input = READ_INPUT()
    IF user_input IN ["y", "yes"] THEN RETURN TRUE
    ELSE IF user_input IN ["n", "no"] THEN RETURN FALSE
    ELSE
        display_error("Invalid input")
        RETURN ERROR

FUNCTION add_student(grades_ref, operations_ref):
    PRINT "---- Add Student ----"
    student_name = READ_INPUT("Enter student name: ")
    IF NOT validate_student_name(student_name) THEN RETURN ERROR
    IF student_name EXISTS IN grades_ref THEN
        display_error("Student already exists")
        RETURN ERROR
    grade_input = READ_INPUT("Enter grade (0-100): ")
    IF NOT validate_grade(grade_input) THEN RETURN ERROR
    grade = TO_INTEGER(grade_input)
    grades_ref[student_name] = grade
    IF record_operation(operations_ref, "add", student_name, "", grade) THEN
        display_success("Student added successfully")
        log("INFO", "Added student: " + student_name)
        RETURN SUCCESS
    ELSE
        display_error("Failed to record operation")
        RETURN ERROR

FUNCTION search_student(grades_ref):
    PRINT "---- Search Student ----"
    student_name = READ_INPUT("Enter student name: ")
    IF student_name NOT IN grades_ref THEN
        display_error("Student not found")
        RETURN ERROR
    grade = grades_ref[student_name]
    letter = get_letter_grade(grade)
    status = get_passing_status(grade)
    color = get_grade_color(grade)
    PRINT "Student: " + student_name
    PRINT_COLORED(color, "Grade: " + grade + " (" + letter + ")")
    PRINT "Status: " + status
    log("INFO", "Searched student: " + student_name)
    RETURN SUCCESS

FUNCTION update_grade(grades_ref, operations_ref):
    PRINT "--- Update Grade ---"
    student_name = READ_INPUT("Enter student name: ")
    IF student_name NOT IN grades_ref THEN
        display_error("Student not found")
        RETURN ERROR
    old_grade = grades_ref[student_name]
    PRINT "Current grade: " + old_grade
    grade_input = READ_INPUT("Enter new grade (0-100): ")
    IF NOT validate_grade(grade_input) THEN RETURN ERROR
    new_grade = TO_INTEGER(grade_input)
    grades_ref[student_name] = new_grade
    IF record_operation(operations_ref, "update", student_name, old_grade, new_grade) THEN
        display_success("Grade updated successfully")
        log("INFO", "Updated: " + student_name + " " + old_grade + " → " + new_grade)
        RETURN SUCCESS
    ELSE RETURN ERROR

FUNCTION delete_student(grades_ref, operations_ref):
    PRINT "--- Delete Student ---"
    student_name = READ_INPUT("Enter student name: ")
    IF student_name NOT IN grades_ref THEN
        display_error("Student not found")
        RETURN ERROR
    grade = grades_ref[student_name]
    IF NOT confirm_action("Delete '" + student_name + "'?") THEN
        display_error("Deletion cancelled")
        RETURN ERROR
    DELETE grades_ref[student_name]
    IF record_operation(operations_ref, "delete", student_name, grade, "") THEN
        display_success("Student deleted successfully")
        log("INFO", "Deleted student: " + student_name)
        RETURN SUCCESS
    ELSE RETURN ERROR

FUNCTION display_all_students(grades_ref, sort_option):
    PRINT "---- All Students ----"
    IF LENGTH(grades_ref) = 0 THEN
        PRINT "No students in the system"
        RETURN SUCCESS
    PRINT TABLE_HEADER
    SWITCH sort_option:
        CASE "name":
            sorted_keys = SORT_ALPHABETICALLY(KEYS(grades_ref))
            FOR EACH key IN sorted_keys DO
                grade_value = grades_ref[key]
                letter = get_letter_grade(grade_value)
                color = get_grade_color(grade_value)
                PRINT_TABLE_ROW(key, COLORED(color, grade_value), letter)
        CASE "grade_asc":
            sorted_pairs = SORT_BY_VALUE_ASCENDING(grades_ref)
            FOR EACH (key, grade_value) IN sorted_pairs DO
                letter = get_letter_grade(grade_value)
                color = get_grade_color(grade_value)
                PRINT_TABLE_ROW(key, COLORED(color, grade_value), letter)
        CASE "grade_desc":
            sorted_pairs = SORT_BY_VALUE_DESCENDING(grades_ref)
            FOR EACH (key, grade_value) IN sorted_pairs DO
                letter = get_letter_grade(grade_value)
                color = get_grade_color(grade_value)
                PRINT_TABLE_ROW(key, COLORED(color, grade_value), letter)
    PRINT TABLE_FOOTER
    PRINT "Total students: " + LENGTH(grades_ref)
    RETURN SUCCESS

FUNCTION calculate_statistics(grades_ref):
    IF LENGTH(grades_ref) = 0 THEN
        display_error("No students to analyze")
        RETURN ERROR
    PRINT "--- Statistics ---"
    total_students = LENGTH(grades_ref)
    sum = 0, highest_grade = -1, lowest_grade = 999
    highest_student = "", lowest_student = "", passing_count = 0
    FOR EACH (student, grade) IN grades_ref DO
        sum += grade
        IF grade > highest_grade THEN
            highest_grade = grade
            highest_student = student
        IF grade < lowest_grade THEN
            lowest_grade = grade
            lowest_student = student
        IF grade >= D_GRADE THEN
            passing_count++
    average = sum / total_students
    passing_rate = (passing_count * 100) / total_students
    PRINT "Total students: " + total_students
    PRINT "Average grade: " + average
    PRINT "Highest grade: " + highest_grade + " (" + highest_student + ")"
    PRINT "Lowest grade: " + lowest_grade + " (" + lowest_student + ")"
    PRINT "Passing rate: " + passing_rate + "% (" + passing_count + "/" + total_students + ")"
    log("INFO", "Statistics calculated for " + total_students + " students")
    RETURN SUCCESS

FUNCTION show_grade_distribution(grades_ref):
    IF LENGTH(grades_ref) = 0 THEN
        display_error("No students to analyze")
        RETURN ERROR
    PRINT "--- Grade Distribution ---"
    distribution = {A:0, B:0, C:0, D:0, F:0}
    FOR EACH (student, grade) IN grades_ref DO
        letter = get_letter_grade(grade)
        distribution[letter]++
    display_grade_bar("A (90-100)", distribution[A], LENGTH(grades_ref))
    display_grade_bar("B (80-89)", distribution[B], LENGTH(grades_ref))
    display_grade_bar("C (70-79)", distribution[C], LENGTH(grades_ref))
    display_grade_bar("D (60-69)", distribution[D], LENGTH(grades_ref))
    display_grade_bar("F (0-59)", distribution[F], LENGTH(grades_ref))
    RETURN SUCCESS

FUNCTION display_grade_bar(label, count, total):
    percentage = (count * 100) / total
    filled_blocks = percentage / 10
    empty_blocks = 10 - filled_blocks
    bar = REPEAT("█", filled_blocks) + REPEAT("░", empty_blocks)
    plural = IF count = 1 THEN "student" ELSE "students"
    PRINT label + ": " + count + " " + plural + " [" + bar + "] " + percentage + "%"

FUNCTION export_to_file(grades_ref, filename):
    IF LENGTH(grades_ref) = 0 THEN
        display_error("No students to export")
        RETURN ERROR
    PRINT "Exporting grades to: " + filename
    WRITE_TO_FILE(filename, "# Student Grade Data")
    WRITE_TO_FILE(filename, "# Generated: " + CURRENT_TIMESTAMP())
    WRITE_TO_FILE(filename, "# Total Students: " + LENGTH(grades_ref))
    sorted_pairs = SORT_BY_VALUE(grades_ref)
    FOR EACH (student, grade) IN sorted_pairs DO
        WRITE_TO_FILE(filename, student + "=" + grade)
    display_success("Grades exported to " + filename)
    log("INFO", "Exported " + LENGTH(grades_ref) + " students")
    RETURN SUCCESS

FUNCTION load_from_file(grades_ref, filename):
    IF NOT FILE_EXISTS(filename) THEN
        display_error("File not found: " + filename)
        RETURN ERROR
    PRINT "Loading grades from: " + filename
    loaded_count = 0
    line_count = 0
    FOR EACH line IN FILE(filename) DO
        line_count++
        IF IS_EMPTY(line) OR STARTS_WITH(line, "#") THEN CONTINUE
        line = TRIM(line)
        IF NOT CONTAINS(line, "=") THEN
            display_error("Invalid format at line " + line_count)
            CONTINUE
        name = SUBSTRING_BEFORE(line, "=")
        value = SUBSTRING_AFTER(line, "=")
        IF validate_grade(value) AND validate_student_name(name) THEN
            grades_ref[name] = value
            loaded_count++
        ELSE
            display_error("Skipping invalid entry at line " + line_count)
    display_success("Loaded " + loaded_count + " students")
    log("INFO", "Loaded " + loaded_count + " students from " + filename)
    RETURN SUCCESS

FUNCTION sort_students_menu(grades_ref):
    PRINT "--- Sort Students ---"
    PRINT "[1] Sort by name (A-Z)"
    PRINT "[2] Sort by grade (lowest first)"
    PRINT "[3] Sort by grade (highest first)"
    choice = READ_INPUT("Select option: ")
    SWITCH choice:
        CASE 1: display_all_students(grades_ref, "name")
        CASE 2: display_all_students(grades_ref, "grade_asc")
        CASE 3: display_all_students(grades_ref, "grade_desc")
        DEFAULT: display_error("Invalid option")
    RETURN SUCCESS

FUNCTION record_operation(operations_ref, op_type, student_name, old_value, new_value):
    entry = op_type + "," + student_name + "," + old_value + "," + new_value
    APPEND(operations_ref, entry)
    IF LENGTH(operations_ref) > MAX_UNDO_OPERATIONS THEN
        REMOVE_FIRST(operations_ref)
    log("DEBUG", "Recorded operation: " + entry)
    RETURN SUCCESS

FUNCTION undo_last_operation(operations_ref, grades_ref):
    IF LENGTH(operations_ref) = 0 THEN
        PRINT "No operations to undo"
        RETURN ERROR
    last_operation = POP_LAST(operations_ref)
    (op_type, student_name, old_value, new_value) = PARSE_CSV(last_operation)
    PRINT "Undoing: " + op_type + " operation on " + student_name
    SWITCH op_type:
        CASE "add":
            DELETE grades_ref[student_name]
            display_success("Undone: Student removed")
        CASE "update":
            grades_ref[student_name] = old_value
            display_success("Undone: Grade restored to " + old_value)
        CASE "delete":
            grades_ref[student_name] = old_value
            display_success("Undone: Student restored")
        DEFAULT:
            PRINT "Unknown operation type"
            RETURN ERROR
    log("INFO", "Undone operation: " + op_type + " on " + student_name)
    RETURN SUCCESS

FUNCTION apply_grade_curve(grades_ref, curve_points):
    user_input = READ_INPUT("Apply " + curve_points + " point curve? (y/n): ")
    IF user_input = "n" THEN
        PRINT "Curve cancelled"
        RETURN SUCCESS
    curved_count = 0
    FOR EACH (student_name, student_grade) IN grades_ref DO
        student_grade += curve_points
        IF student_grade > MAX_GRADE THEN
            student_grade = MAX_GRADE
        grades_ref[student_name] = student_grade
        curved_count++
    PRINT "Applied curve to " + curved_count + " students"
    log("INFO", "Applied " + curve_points + " point curve to " + curved_count + " students")
    RETURN SUCCESS

FUNCTION add_student_extended(students_ref):
    PRINT "--- Add Student (Extended) ---"
    name_input = READ_INPUT("Enter student name: ")
    IF NOT validate_student_name(name_input) THEN RETURN ERROR
    id_input = READ_INPUT("Enter student ID: ")
    IF NOT validate_student_id(id_input) THEN RETURN ERROR
    grade_input = READ_INPUT("Enter grade (0-150): ")
    IF NOT validate_grade(grade_input) THEN RETURN ERROR
    attendance_input = READ_INPUT("Enter attendance (0-100): ")
    IF NOT validate_attendance(attendance_input) THEN RETURN ERROR
    gpa = 0.0
    serialized_record = id_input + "," + grade_input + "," + attendance_input + "," + gpa
    students_ref[name_input] = serialized_record
    display_success("Student added with extended information")
    log("INFO", "Added extended student: " + name_input)
    RETURN SUCCESS

FUNCTION add_course_grade(students_ref, student_name):
    IF student_name NOT IN students_ref THEN
        display_error("Student not found")
        RETURN ERROR
    course_name = READ_INPUT("Enter course name: ")
    IF IS_EMPTY(TRIM(course_name)) THEN RETURN ERROR
    grade = READ_INPUT("Enter grade (0-100): ")
    IF NOT IS_INTEGER(grade) OR grade < 0 OR grade > 100 THEN RETURN ERROR
    credits = READ_INPUT("Enter credit hours: ")
    IF NOT IS_INTEGER(credits) OR credits <= 0 THEN RETURN ERROR
    weighted = READ_INPUT("Weighted course? (y/n): ")
    IF weighted NOT IN ["y", "n"] THEN RETURN ERROR
    extra_credit = READ_INPUT("Extra credit points: ")
    IF NOT IS_INTEGER(extra_credit) THEN RETURN ERROR
    course_record = course_name + "," + grade + "," + credits + "," + weighted + "," + extra_credit
    student_record = students_ref[student_name]
    updated_record = student_record + "|" + course_record
    students_ref[student_name] = updated_record
    calculate_gpa(students_ref, student_name)
    display_success("Course grade added")
    log("INFO", "Added course to " + student_name)
    RETURN SUCCESS

FUNCTION calculate_gpa(students_ref, student_name):
    IF student_name NOT IN students_ref THEN RETURN ERROR
    total_points = 0.0
    total_credits = 0
    record = students_ref[student_name]
    attributes = SPLIT(record, "|")
    FOR i FROM 1 TO LENGTH(attributes) - 1 DO
        course_data = SPLIT(attributes[i], ",")
        grade = course_data[1]
        credits = course_data[2]
        weighted = course_data[3]
        IF grade >= A_GRADE THEN grade_point = GPA_A
        ELSE IF grade >= B_GRADE THEN grade_point = GPA_B
        ELSE IF grade >= C_GRADE THEN grade_point = GPA_C
        ELSE IF grade >= D_GRADE THEN grade_point = GPA_D
        ELSE grade_point = GPA_F
        IF weighted = "y" THEN
            grade_point += 0.5
        total_points += grade_point * credits
        total_credits += credits
    IF total_credits > 0 THEN
        gpa = total_points / total_credits
        student_info = SPLIT(attributes[0], ",")
        student_info[3] = gpa
        attributes[0] = JOIN(student_info, ",")
        new_record = JOIN(attributes, "|")
        students_ref[student_name] = new_record
        RETURN SUCCESS
    RETURN ERROR

FUNCTION generate_report_card(students_ref, student_name):
    IF student_name NOT IN students_ref THEN
        display_error("Student not found")
        RETURN ERROR
    student_data = students_ref[student_name]
    attributes = SPLIT(student_data, "|")
    student_info = attributes[0]
    student_classes = attributes[1:]
    info_parts = SPLIT(student_info, ",")
    PRINT "╔════════════════════════════════════════╗"
    PRINT "║              REPORT CARD               ║"
    PRINT "╠════════════════════════════════════════╣"
    PRINT "║ Student: " + student_name
    PRINT "║ ID: " + info_parts[0]
    PRINT "╠════════════════════════════════════════╣"
    PRINT "║ Course Grades:                         ║"
    FOR EACH course IN student_classes DO
        class_parts = SPLIT(course, ",")
        course_name = class_parts[0]
        course_grade = class_parts[1]
        course_credits = class_parts[2]
        PRINT "║ " + course_name + ": " + course_grade + "% (" + get_letter_grade(course_grade) + ") " + course_credits + " cr ║"
    gpa = info_parts[3]
    attendance = info_parts[2]
    PRINT "╠════════════════════════════════════════╣"
    PRINT "║ GPA: " + gpa
    PRINT "║ Attendance: " + attendance + "%"
    PRINT "╚════════════════════════════════════════╝"
    log("INFO", "Generated report card for " + student_name)
    RETURN SUCCESS

FUNCTION show_attendance_report(students_ref):
    PRINT "--- Attendance Report ---"
    IF LENGTH(students_ref) = 0 THEN
        PRINT "No students with extended information"
        RETURN SUCCESS
    FOR EACH (student_name, student_data) IN students_ref DO
        attributes = SPLIT(student_data, "|")
        student_info = attributes[0]
        info_parts = SPLIT(student_info, ",")
        attendance_percentage = info_parts[2]
        IF attendance_percentage >= ATTENDANCE_EXCELLENT THEN
            status = COLORED(GREEN, "Excellent")
        ELSE IF attendance_percentage >= ATTENDANCE_GOOD THEN
            status = COLORED(YELLOW, "Good")
        ELSE
            status = COLORED(RED, "At risk")
        PRINT student_name + ": " + attendance_percentage + "% - " + status
    RETURN SUCCESS

FUNCTION add_section(sections_ref, section_name):
    IF IS_EMPTY(TRIM(section_name)) THEN RETURN ERROR
    IF section_name IN sections_ref THEN
        display_error("Section already exists")
        RETURN ERROR
    sections_ref[section_name] = ""
    display_success("Section created")
    log("INFO", "Created section: " + section_name)
    RETURN SUCCESS

FUNCTION assign_student_to_section(sections_ref, grades_ref, section_name, student_name):
    IF student_name NOT IN grades_ref THEN RETURN ERROR
    IF section_name NOT IN sections_ref THEN RETURN ERROR
    current_students = sections_ref[section_name]
    IF student_name IN current_students THEN
        display_error("Student already in section")
        RETURN ERROR
    IF IS_EMPTY(current_students) THEN
        sections_ref[section_name] = student_name
    ELSE
        sections_ref[section_name] = current_students + "," + student_name
    display_success("Student assigned to section")
    log("INFO", "Assigned " + student_name + " to " + section_name)
    RETURN SUCCESS

FUNCTION list_students_in_section(sections_ref, grades_ref, section_name):
    IF section_name NOT IN sections_ref THEN RETURN ERROR
    PRINT "--- Students in Section: " + section_name + " ---"
    student_list = sections_ref[section_name]
    IF IS_EMPTY(student_list) THEN
        PRINT "No students in this section"
        RETURN SUCCESS
    students = SPLIT(student_list, ",")
    PRINT TABLE_HEADER
    FOR EACH student_name IN students DO
        IF student_name IN grades_ref THEN
            grade = grades_ref[student_name]
            letter = get_letter_grade(grade)
            color = get_grade_color(grade)
            PRINT_TABLE_ROW(student_name, COLORED(color, grade), letter)
        ELSE
            PRINT_TABLE_ROW(student_name, "N/A", "N/A")
    PRINT TABLE_FOOTER
    PRINT "Total students: " + LENGTH(students)
    RETURN SUCCESS

FUNCTION section_statistics(sections_ref, grades_ref, section_name):
    IF section_name NOT IN sections_ref THEN RETURN ERROR
    student_list = sections_ref[section_name]
    IF IS_EMPTY(student_list) THEN RETURN ERROR
    students = SPLIT(student_list, ",")
    PRINT "--- Statistics for Section: " + section_name + " ---"
    sum = 0, count = 0, highest = -1, lowest = 999
    highest_student = "", lowest_student = "", passing = 0
    FOR EACH student IN students DO
        IF student IN grades_ref THEN
            grade = grades_ref[student]
            sum += grade
            count++
            IF grade > highest THEN
                highest = grade
                highest_student = student
            IF grade < lowest THEN
                lowest = grade
                lowest_student = student
            IF grade >= D_GRADE THEN passing++
    IF count > 0 THEN
        average = sum / count
        passing_rate = (passing * 100) / count
        PRINT "Total students: " + count
        PRINT "Average grade: " + average
        PRINT "Highest: " + highest + " (" + highest_student + ")"
        PRINT "Lowest: " + lowest + " (" + lowest_student + ")"
        PRINT "Passing rate: " + passing_rate + "%"
    ELSE
        PRINT "No students with grades"
    RETURN SUCCESS

FUNCTION extended_features_menu(students_ref):
    PRINT "--- Extended Features ---"
    PRINT "[1] Add student (extended)"
    PRINT "[2] Add course grade"
    PRINT "[3] Generate report card"
    PRINT "[4] Email report (simulation)"
    PRINT "[5] Show attendance report"
    PRINT "[0] Return"
    choice = READ_INPUT("Select option: ")
    SWITCH choice:
        CASE 1: add_student_extended(students_ref)
        CASE 2:
            student_name = READ_INPUT("Student name: ")
            add_course_grade(students_ref, student_name)
        CASE 3:
            student_name = READ_INPUT("Student name: ")
            generate_report_card(students_ref, student_name)
        CASE 4:
            student_name = READ_INPUT("Student name: ")
            PRINT "Simulating email send..."
            SLEEP(2)
            display_success("Email sent (simulated)")
        CASE 5: show_attendance_report(students_ref)
        CASE 0: RETURN
        DEFAULT: display_error("Invalid option")
    RETURN SUCCESS

FUNCTION sections_menu(sections_ref, grades_ref):
    PRINT "--- Class Sections Management ---"
    PRINT "[1] Create section"
    PRINT "[2] List all sections"
    PRINT "[3] Assign student"
    PRINT "[4] Remove student"
    PRINT "[5] List students in section"
    PRINT "[6] Section statistics"
    PRINT "[0] Return"
    choice = READ_INPUT("Select option: ")
    SWITCH choice:
        CASE 1:
            section_name = READ_INPUT("Section name: ")
            add_section(sections_ref, section_name)
        CASE 2: list_sections(sections_ref)
        CASE 3:
            section_name = READ_INPUT("Section name: ")
            student_name = READ_INPUT("Student name: ")
            assign_student_to_section(sections_ref, grades_ref, section_name, student_name)
        CASE 4:
            section_name = READ_INPUT("Section name: ")
            student_name = READ_INPUT("Student name: ")
            remove_student_from_section(sections_ref, section_name, student_name)
        CASE 5:
            section_name = READ_INPUT("Section name: ")
            list_students_in_section(sections_ref, grades_ref, section_name)
        CASE 6:
            section_name = READ_INPUT("Section name: ")
            section_statistics(sections_ref, grades_ref, section_name)
        CASE 0: RETURN
        DEFAULT: display_error("Invalid option")
    RETURN SUCCESS

FUNCTION main():
    running = TRUE
    IF NOT check_dependencies() THEN
        display_error("Dependency check failed")
        EXIT(1)
    PRINT "Welcome to Grade Tracker System"
    PRINT "Logging to: " + LOG_FILE
    log("INFO", "Grade Tracker started")
    WHILE running DO
        CLEAR_SCREEN()
        display_menu()
        user_choice = READ_INPUT()
        SWITCH user_choice:
            CASE 1: add_student(grades, operation_history)
            CASE 2: search_student(grades)
            CASE 3: update_grade(grades, operation_history)
            CASE 4: delete_student(grades, operation_history)
            CASE 5: display_all_students(grades, "name")
            CASE 6: calculate_statistics(grades)
            CASE 7: show_grade_distribution(grades)
            CASE 8: export_to_file(grades, CSV_EXPORT)
            CASE 9: load_from_file(grades, GRADE_FILE)
            CASE 10: sort_students_menu(grades)
            CASE 11: undo_last_operation(operation_history, grades)
            CASE 12:
                curve_points = READ_INPUT("Curve points: ")
                IF validate_grade(curve_points) THEN
                    apply_grade_curve(grades, curve_points)
            CASE 13: extended_features_menu(students)
            CASE 14: sections_menu(class_sections, grades)
            CASE 0:
                running = FALSE
                CLEAR_SCREEN()
                PRINT "Exiting Grade Tracker. Goodbye!"
                log("INFO", "Grade Tracker exited")
            DEFAULT: display_error("Invalid option")
        pause()
    RETURN SUCCESS

BEGIN PROGRAM:
    INITIALIZE_TRAP(cleanup)
    INITIALIZE_DATA_STRUCTURES()
    main()
END PROGRAM
```

---

### Expected Output Example

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
