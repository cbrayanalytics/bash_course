### Goal:
Create a script called `greet` (no .sh extension) that can be executed from any directory without using `./` by adding it to your PATH.
### Requirements:
- Create a script named `greet` that displays a greeting message
- Place the script in a directory that's in your PATH (or create one)
- Make it executable
- Verify you can run it by typing just `greet` from any directory

### Hints:
- Common practice: Create a `~/bin` directory for personal scripts
- Check your current PATH with `echo $PATH`
- If `~/bin` isn't in your PATH, add it to `~/.bashrc` or `~/.bash_profile`
- Remember: no file extension needed for commands in PATH
- After modifying PATH, either restart your terminal or run `source ~/.bashrc`

### Tasks:
1. Create a `~/bin` directory if it doesn't exist
2. Write your `greet` script and save it in `~/bin/`
3. Make the script executable
4. Add `~/bin` to your PATH (if not already there)
5. Test by running `greet` from your home directory
6. Test again by running `greet` from a different directory (like `/tmp`)

### Expected Behavior:
```bash
# From any directory:
$ greet
Hello! This script runs from anywhere!

# Verify which script is being executed:
$ which greet
/home/yourusername/bin/greet
```

### Verification Commands:
```bash
# Check if ~/bin is in PATH
echo $PATH | grep -o "$HOME/bin"

# Verify script location
which greet

# Test from different directories
cd ~
greet

cd /tmp
greet
```

### Bonus Challenge:
Make the PATH addition permanent by adding the export line to your `~/.bashrc` file so it persists across terminal sessions.

***
