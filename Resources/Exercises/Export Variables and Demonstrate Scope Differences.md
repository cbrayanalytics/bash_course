### Goal:
Create two scripts that demonstrate variable scope: `parent.sh` (parent script) and `child.sh` (child script called by parent).
### Requirements:
- `parent.sh` should:
	  - Declare a regular variable
	  - Declare an exported variable
	  - Call `child.sh`
	  - Demonstrate local vs global scope with a function

- `child.sh` should:
  - Try to access both variables from parent
  - Show which one is accessible
### Hints:
- Use `export VAR_NAME="value"` to make variables available to child processes
- Regular variables won't be accessible in child scripts
- Use `local` keyword inside functions for local scope
- Call child script with `./child.sh` or `bash child.sh`

### Expected Output Example:
```
=== In parent.sh ===
Regular var: Hello
Exported var: World

=== Calling child.sh ===
In child: exported var = World
In child: regular var = (empty - not accessible)

=== Back in parent.sh ===
Testing function scope...
Global var inside function: accessible
Local var outside function: (not accessible)
```

***