### Goal:
Create a script named `command_router.sh` that routes commands to different handlers using multi-pattern matching.
### Requirements:
- Accept a command as first argument
- Accept additional arguments as command parameters
- Support these command groups with multiple aliases:
  - **Help commands:** help, h, -h, --help, ?
  - **Version commands:** version, v, -v, --version
  - **List commands:** list, ls, show, display
  - **Add commands:** add, create, new, insert
  - **Delete commands:** delete, remove, rm, del
  - **Update commands:** update, modify, edit, change
  - **Search commands:** search, find, query, lookup
- Each command group should perform a relevant action
- Handle unknown commands with suggestions
- Display usage if no command provided
### Hints:
- Use `$1` for command, `$2` `$3` etc. for parameters
- Use `shift` after processing command to access remaining args
- Combine multiple patterns with `|`
- Make matching case-insensitive by converting to lowercase: `${1,,}`
- Provide helpful error messages
### Expected Output Example:
```bash
./command_router.sh
```
```
Error: No command provided

Usage: ./command_router.sh <command> [arguments]

Available commands:
  help, h, -h, --help, ?          Show this help message
  version, v, -v, --version       Show version information
  list, ls, show, display         List all items
  add, create, new, insert        Add a new item
  delete, remove, rm, del         Delete an item
  update, modify, edit, change    Update an item
  search, find, query, lookup     Search for items

Examples:
  ./command_router.sh list
  ./command_router.sh add "new item"
  ./command_router.sh search "keyword"
```

```bash
./command_router.sh help
```
```
╔════════════════════════════════════════╗
║         COMMAND ROUTER HELP            ║
╚════════════════════════════════════════╝

Available Commands:

HELP COMMANDS (help, h, -h, --help, ?)
  Display this help message

VERSION COMMANDS (version, v, -v, --version)
  Show version information

LIST COMMANDS (list, ls, show, display)
  List all items in the system
  Usage: ./command_router.sh list [filter]

ADD COMMANDS (add, create, new, insert)
  Add a new item to the system
  Usage: ./command_router.sh add <name> [description]

DELETE COMMANDS (delete, remove, rm, del)
  Remove an item from the system
  Usage: ./command_router.sh delete <id>

UPDATE COMMANDS (update, modify, edit, change)
  Modify an existing item
  Usage: ./command_router.sh update <id> <new_value>

SEARCH COMMANDS (search, find, query, lookup)
  Search for items by keyword
  Usage: ./command_router.sh search <keyword>
```

```bash
./command_router.sh ls
```
```
Executing: LIST command

Items in system:
  1. Item One
  2. Item Two
  3. Item Three

Total: 3 items
```

```bash
./command_router.sh create "New Task" "Task description"
```
```
Executing: ADD command

Adding new item:
  Name: New Task
  Description: Task description

✓ Item added successfully (ID: 4)
```

```bash
./command_router.sh find "task"
```
```
Executing: SEARCH command

Searching for: task

Results found:
  1. New Task (ID: 4)
     Description: Task description

Total results: 1
```

```bash
./command_router.sh invalid
```
```
✗ Error: Unknown command 'invalid'

Did you mean one of these?
  • list (ls, show, display)
  • add (create, new, insert)
  • delete (remove, rm, del)

Run './command_router.sh help' for full command list
```

```bash
./command_router.sh --version
```
```
Command Router v1.0.0
Build date: 2025-10-19
Author: Your Name
```
### Bonus Challenge:
- Add command abbreviation support (auto-complete)
- Implement fuzzy matching for similar commands
- Add command history
- Support command chaining (multiple commands in sequence)
- Add interactive mode (REPL)
- Implement command aliases (user-defined)
- Add tab completion hints
- Log all commands to file
- Add undo/redo functionality

***
