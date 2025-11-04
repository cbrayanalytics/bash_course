### Goal:
Create a Bash script named `sysinfo.sh` that displays the current hostname, date, and username.
### Requirements:
- [x]  Include proper shebang line
- [x] Display three pieces of information:
	- [x] Current hostname
	- [x] Current date and time
	- [x] Current username
- [x] Make the output readable and formatted
- [x] Script must be executable
### Hints:
- The `hostname` command displays the system's hostname
- The `date` command shows current date and time
- The `whoami` command shows the current username
- Alternatively, you can use the `$USER` environment variable for username
- Use `echo` to format your output nicely

### Expected Output Example:
```
Hostname: mycomputer
Date: Thu Oct 16 11:27:45 PM MDT 2025
Username: john
```

### Bonus Challenge:
Format the output with labels to make it clear what each piece of information represents (as shown in the example above).

* Feel free to do use google and see how you can make this happen!

### Verification:
```bash
# Make executable and run
chmod +x sysinfo.sh
./sysinfo.sh
```

***
