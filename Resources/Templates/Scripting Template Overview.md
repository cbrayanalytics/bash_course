## 💡 Quick Reference Guide

### Choose Your Template Based On:

1. **[[Super Minimal Template]]** - Quick tests, throwaway scripts
2. **[[Minimal Template]]** - Most common use cases, personal scripts
3. **[[Template with Logging]]** - Scripts you'll run frequently and need feedback
4. **[[Template with Error Handling]]** - Production scripts, automation, cron jobs

### Essential Elements Explained:

```bash
#!/usr/bin/env bash          # Shebang - makes script executable
set -euo pipefail            # Fail fast on errors
readonly VARIABLE="value"    # Constants that shouldn't change
"${variable}"                # Always quote variables
main() { }                   # Wrap logic in functions
main "$@"                    # Pass all arguments to main
```

***

## ✅ Before Running Your Script:

```bash
# Make executable
chmod +x your-script.sh

# Test syntax without running
bash -n your-script.sh

# Run with debug mode
bash -x your-script.sh

# Run normally
./your-script.sh
```

***

## 📚 Template Usage Tips:

1. **Copy the template** that fits your needs
2. **Update the header** with your script name and description
3. **Replace the placeholder code** in the `main()` function
4. **Add functions** above `main()` as needed
5. **Make it executable** with `chmod +x`
6. **Test thoroughly** before deploying

***

These templates provide a solid foundation while remaining easy to copy and customize. Start with the minimal version and add complexity only as needed!
