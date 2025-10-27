## Goal:
Build a comprehensive script named `config_wizard.sh` that collects system configuration preferences from the user and confirms before applying them.
## Requirements:
The wizard should collect at least 5-6 configuration options:
- Username for new account
- Email address
- Backup directory path
- Backup frequency (daily/weekly/monthly)
- Enable notifications (yes/no)
- Timezone preference

**Functionality:**
- Use appropriate `read` options for each input type:
  - Regular prompts for text input
  - Silent input for sensitive data (if any)
  - Timeout for optional inputs with defaults
- Validate each input:
  - Non-empty required fields
  - Email format validation (basic)
  - Valid directory paths
  - Limited choices for multiple-choice options
- Display a confirmation summary of all settings
- Ask user to confirm (y/n) before "saving"
- If confirmed, display success message
- If not confirmed, ask which setting to change
## Hints:
- Break the script into sections (collection, validation, confirmation)
- Use functions for repeated validation logic (optional but cleaner)
- Store all settings in variables
- Use a while loop for the confirmation process
- Consider using a case statement for handling user's change requests
### Expected Output Example:
```
╔════════════════════════════════════════╗
║   System Configuration Wizard          ║
╔════════════════════════════════════════╗

Enter username: jdoe
Enter email address: jdoe@example.com
Enter backup directory path: /home/jdoe/backups
Select backup frequency (daily/weekly/monthly): weekly
Enable notifications? (y/n): y
Enter timezone (e.g., America/Denver): America/Denver

════════════════════════════════════════
Configuration Summary:
════════════════════════════════════════
Username        : jdoe
Email          : jdoe@example.com
Backup Dir     : /home/jdoe/backups
Backup Freq    : weekly
Notifications  : Enabled
Timezone       : America/Denver
════════════════════════════════════════

Is this correct? (y/n): y

✓ Configuration saved successfully!
Settings have been applied to the system.
```
### Bonus Challenges:
- Actually write the configuration to a file (e.g., `~/.config/myapp.conf`)
- Allow user to edit specific fields without re-entering everything
- Add a progress indicator showing which step (e.g., "Step 3 of 6")
- Provide default values for optional settings with timeout
- Color-code the output (green for success, red for errors, yellow for warnings)
- Create a `--silent` mode that uses default values for everything

***