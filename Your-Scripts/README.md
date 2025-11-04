# 30-Day Beginner Bash Scripting Course

This repository contains an introductory to intermediate-level Bash course designed to be completed over 30 days. The daily layout serves as a suggested structure, but you can move at your own pace.  

The course is designed to be explored inside Obsidian, a markdown-based knowledge management and note-taking tool. Using Obsidian makes it easier to browse the lessons, track your progress, and take connected notes throughout the course.

***

### Getting Started

Follow these steps to set up the course on your local system and open it inside Obsidian.

---

# 🎓 Bash 30-Day Mastery Course
## Complete Introduction & Setup Guide

Welcome to the Bash 30-Day Mastery Course! This comprehensive guide will help you set up your learning environment using Obsidian as your knowledge management system.

---

## 📋 Table of Contents

1. [What is This Course?](#what-is-this-course)
2. [Why Use Obsidian?](#why-use-obsidian)
3. [Installation Steps](#installation-steps)
4. [Setting Up Your Vault](#setting-up-your-vault)
5. [Navigating the Course](#navigating-the-course)
6. [Tips for Success](#tips-for-success)

***

## 🎯 What is This Course?

The **Bash 30-Day Mastery Course** is a comprehensive, hands-on learning program designed to take you from Bash beginner to confident shell scripter in just 30 days. Each day includes:

- **Lessons** - Core concepts explained clearly
- **Exercises** - Practice exercises with real-world scenarios
- **Daily Projects** - Hands-on projects to solidify learning
- **Automation Tasks** - Practical scripts for system administration

### Course Structure

- **Week 1 (Days 1-7):** Shell Basics & Fundamentals
- **Week 2 (Days 8-14):** Control Flow & Functions
- **Week 3 (Days 15-21):** File Operations & Text Processing
- **Week 4 (Days 22-30):** Advanced Scripting & Automation

### Who Should Take This Course?

This course is perfect for:
- System administrators looking to automate tasks
- DevOps engineers strengthening scripting foundations
- Linux enthusiasts wanting to master the command line
- Developers working in Unix/Linux environments
- Anyone interested in process automation

***

## 💡 Why Use Obsidian?

**Obsidian** is a powerful knowledge management tool perfect for this course because:

✅ **Local-first** - Your notes are stored as plain Markdown files on your computer
✅ **Linked thinking** - Connect concepts across days and weeks
✅ **Graph view** - Visualize your learning journey
✅ **Plugins** - Extend functionality with community plugins
✅ **Cross-platform** - Available on Windows, Mac, Linux, iOS, and Android
✅ **Free** - Personal use is completely free

***

## 🚀 Installation Steps

### Step 1: Install Obsidian

#### Windows
1. Go to [obsidian.md/download](https://obsidian.md/download)
2. Click **"Get Obsidian for Windows"**
3. Download the installer (Universal installer recommended)
4. Run the `.exe` file
5. Follow the installation wizard
6. Launch Obsidian

#### macOS
1. Go to [obsidian.md/download](https://obsidian.md/download)
2. Click **"Get Obsidian for macOS"**
3. Download the `.dmg` file
4. Open the downloaded file
5. Drag Obsidian to your Applications folder
6. Launch Obsidian from Applications

#### Linux

**Option A: Snap (Recommended)**
```bash
# Download the Snap package from obsidian.md/download
# Then install with:
sudo snap install obsidian_<version>_<arch>.snap --dangerous --classic
```

**Option B: AppImage**
```bash
# Download the AppImage from obsidian.md/download
# Make it executable:
chmod u+x Obsidian-<version>.AppImage

# Run it:
./Obsidian-<version>.AppImage --no-sandbox
```

### Step 2: Install Git (Required for Cloning)

Git is needed to clone the course repository.

#### Windows
1. Download Git from [git-scm.com](https://git-scm.com/download/win)
2. Run the installer
3. Use default settings (or customize as needed)
4. Verify installation:
   ```bash
   git --version
   ```

#### macOS
Git comes pre-installed, but you can install the latest version:
```bash
# Using Homebrew (install Homebrew first if needed)
brew install git

# Verify installation
git --version
```

#### Linux
```bash
# Ubuntu/Debian
sudo apt-get install git

# Fedora
sudo dnf install git

# Arch
sudo pacman -S git

# Verify installation
git --version
```

***

## 📦 Setting Up Your Vault

### Method 1: Clone as New Vault (Recommended)

This method clones the course repository and uses it directly as your Obsidian vault.

#### Step-by-Step Instructions:

**1. Choose a Location**

First, decide where you want to store your course vault. For example:
- Windows: `C:\Users\YourName\Documents\ObsidianVaults`
- macOS: `~/Documents/ObsidianVaults`
- Linux: `~/Documents/ObsidianVaults`

**2. Open Terminal/Command Prompt**

- **Windows:** Press `Win + R`, type `cmd`, and press Enter
- **macOS:** Press `Cmd + Space`, type `Terminal`, and press Enter
- **Linux:** Press `Ctrl + Alt + T`

**3. Navigate to Your Chosen Location**

```bash
# Windows
cd C:\Users\YourName\Documents\ObsidianVaults

# macOS/Linux
cd ~/Documents/ObsidianVaults
```

**4. Clone the Repository**

```bash
git clone https://github.com/cbrayanalytics/bash_course.git
```

This creates a folder called `bash_course` with all course materials.

**5. Open Vault in Obsidian**

1. Launch Obsidian
2. If this is your first time, you'll see the vault picker screen
3. Click **"Open folder as vault"**
4. Navigate to the cloned folder: `ObsidianVaults/bash_course`
5. Click **"Open"**

**6. Trust the Vault**

Obsidian will ask if you trust the author of this vault (for community plugins and settings).
- Click **"Trust author and enable plugins"** to use recommended settings

***

### Method 2: Clone into Existing Vault

If you already have an Obsidian vault and want to add the course materials:

**1. Navigate to Your Existing Vault**

```bash
cd /path/to/your/existing/vault
```

**2. Create a Subfolder for the Course**

```bash
mkdir Bash-Course
cd Bash-Course
```

**3. Clone the Repository**

```bash
git clone https://github.com/cbrayanalytics/bash_course.git .
```

Note the `.` at the end - this clones directly into the current folder without creating a subfolder.

**4. Refresh Obsidian**

The course materials should now appear in your vault under the `Bash-Course` folder.

***

### Method 3: Download as ZIP (No Git Required)

If you prefer not to use Git:

**1. Download the Repository**

1. Go to [github.com/cbrayanalytics/bash_course](https://github.com/cbrayanalytics/bash_course)
2. Click the green **"Code"** button
3. Click **"Download ZIP"**
4. Save the file to your computer

**2. Extract the Files**

- **Windows:** Right-click → Extract All
- **macOS:** Double-click the ZIP file
- **Linux:** Use your file manager or: `unzip bash_course.zip`

**3. Open in Obsidian**

1. Launch Obsidian
2. Click **"Open folder as vault"**
3. Select the extracted folder
4. Click **"Open"**

***

## 🗂️ Vault Structure

Once opened, your vault will have the following structure:

```
bash_course/
├── 📁 Week-1-Fundamentals/
│   ├── Day-01-Introduction.md
│   ├── Day-02-Variables.md
│   ├── ...
│   └── Week-1-Project.md
├── 📁 Week-2-Control-Flow/
│   ├── Day-08-Conditionals.md
│   ├── ...
│   └── Week-2-Project.md
├── 📁 Week-3-File-Operations/
│   ├── Day-15-File-Handling.md
│   ├── ...
│   └── Week-3-Project.md
├── 📁 Week-4-Advanced/
│   ├── Day-22-Advanced-Techniques.md
│   ├── ...
│   └── Week-4-Project.md
├── 📁 Resources/
│   ├── Cheat-Sheets/
│   ├── References/
│   └── Templates/
├── 📁 Your-Scripts/
│   └── (Your practice scripts go here)
├── 📄 README.md
```

***

## 🎨 Recommended Obsidian Settings

### Essential Settings

**1. Editor Settings**
- Settings → Editor → Enable **"Vim key bindings"** (optional, for advanced users)
- Enable **"Line numbers"** for code blocks
- Enable **"Readable line length"** for better readability

**2. Files & Links**
- Set **"Default location for new notes"** to `Your-Scripts`
- Enable **"Automatically update internal links"**

**3. Appearance**
- Choose a theme that's comfortable for your eyes
- Recommended themes for coding:
  - **Minimal** (clean, distraction-free)
  - **Atom** (dark theme, great for code)
  - **Things** (beautiful, organized)

### Recommended Community Plugins

To install community plugins:
1. Settings → Community plugins
2. Turn off **"Safe mode"**
3. Click **"Browse"**
4. Search and install:

**Essential Plugins:**

1. **Dataview** - Query and display your notes
2. **Calendar** - Track your daily progress
3. **Obsidian Git** - Sync with GitHub (advanced)
4. **Mind Map** - Visualize connections
5. **Excalidraw** - Draw diagrams

**For Coding:**

1. **Code Block Enhancer** - Better code syntax highlighting
2. **Execute Code** - Run code directly in Obsidian
3. **Copy button for code blocks** - Easy code copying

***

## 🧭 Navigating the Course

### Daily Workflow

**1. Start Your Day**
- Open Obsidian
- Navigate to the current day's lesson (e.g., `Week-1-Fundamentals/Day-01-Introduction.md`)

**2. Read the Lesson**
- Work through the lesson content
- Take notes using Obsidian's features:
  - Create links: `[[related-concept]]`
  - Add tags: `#bash #scripting #automation`
  - Highlight: `==important text==`

**3. Complete Exercises**
- Read each exercise carefully
- Create a new note in `Your-Scripts` folder
- Write your script solutions
- Test your scripts in your terminal

**4. Build the Daily Project**
- Create a dedicated note for the project
- Follow the instructions
- Implement the solution
- Document your learnings

**5. Review and Reflect**
- Add notes to your daily summary
- Link related concepts
- Update your progress tracker

### Using the Graph View

1. Click the **Graph view** icon (circle with dots)
2. See how your notes connect
3. Find related concepts visually

### Quick Navigation Tips

- **Quick switcher:** `Ctrl/Cmd + O` - Jump to any note
- **Command palette:** `Ctrl/Cmd + P` - Access all commands
- **Search:** `Ctrl/Cmd + Shift + F` - Search all notes
- **Back/Forward:** `Ctrl/Cmd + Alt + Left/Right` - Navigate history

***

## 📝 Course Navigation Guide

### Start Here

Begin with these files in order:

1. **README.md** - Course overview (this file)
2. **Course-Overview.md** - Detailed curriculum
3. **Getting-Started.md** - Setup Bash environment
4. **Week-1-Fundamentals/Day-01-Introduction.md** - First lesson

### Weekly Structure

Each week has:
- 7 daily lessons (Monday-Sunday)
- Multiple exercises per day
- 1 daily project per day
- 1 week-ending capstone project

### Progress Tracking

Create a note called `My-Progress.md` with:

```markdown
# My Bash Learning Journey

## Week 1: Fundamentals
- [x] Day 1: Introduction to Bash
- [x] Day 2: Variables and Data Types
- [ ] Day 3: Command-Line Arguments
- [ ] Day 4: Operators
- [ ] Day 5: Conditionals
- [ ] Day 6: Loops
- [ ] Day 7: Functions
- [ ] Week 1 Project

## Week 2: Control Flow
- [ ] Day 8: Advanced Conditionals
...
```

***

## 💻 Setting Up Bash Environment

**Note:** While Obsidian holds your notes, you'll need a Bash environment to run scripts.

### Verify Bash Installation

**Linux/macOS:**
```bash
# Check Bash version
bash --version

# Check default shell
echo $SHELL
```

**Windows:**
You have several options:

1. **WSL (Windows Subsystem for Linux) - Recommended**
   - Open PowerShell as Administrator
   - Run: `wsl --install`
   - Restart your computer
   - Ubuntu will be installed by default

2. **Git Bash** (Already installed if you followed Step 2)
   - Comes with Git for Windows
   - Good for learning, limited for advanced features

3. **Cygwin**
   - Download from [cygwin.com](https://www.cygwin.com/)
   - Provides Unix-like environment

### Text Editor / IDE Recommendations

You'll need a text editor for writing scripts:

1. **VS Code** (Recommended) - [code.visualstudio.com](https://code.visualstudio.com/)
   - Install "Bash IDE" extension
   - Install "ShellCheck" extension for linting

2. **Vim/Neovim** - Built into most Linux/Unix systems
   - Powerful but steep learning curve

3. **Nano** - Simple terminal-based editor
   - Good for quick edits

4. **Sublime Text** - [sublimetext.com](https://www.sublimetext.com/)

### Making Scripts Executable

Remember to make your scripts executable:

```bash
chmod +x your-script.sh
```

Then run with:

```bash
./your-script.sh
```

***

## 🔄 Keeping Your Vault Updated

If the course receives updates, you can pull the latest changes:

### Using Git

```bash
# Navigate to your vault
cd /path/to/bash_course

# Pull latest changes
git pull origin main
```

**Warning:** This will overwrite local changes. To preserve your work:
- Keep your scripts in the `Your-Scripts` folder
- Don't modify original course files
- Or use Git branches (advanced)

---

## 💡 Tips for Success

### Learning Tips

1. **Consistency is Key**
   - Dedicate 1-3 hours daily
   - Don't skip days
   - Review previous concepts regularly

2. **Active Learning**
   - Type out all script examples
   - Don't just read - execute!
   - Experiment with variations

3. **Build, Build, Build**
   - Complete every exercise
   - Finish all projects
   - Automate your own tasks

4. **Use Obsidian Effectively**
   - Link concepts together
   - Tag important notes
   - Review your graph view weekly
   - Create your own summaries

5. **Embrace the Unknown**
   - Some exercises include concepts from later lessons
   - Use this as an opportunity to research independently
   - This mirrors real-world problem-solving

### Obsidian Tips

1. **Create a Daily Note**
   - Document what you learned
   - Track time spent
   - Note challenges and solutions

2. **Use Templates**
   - Create a template for daily notes
   - Create a template for script documentation

3. **Make Connections**
   - Link new concepts to previous days
   - Create a "Map of Content" note
   - Build a personal knowledge base

4. **Regular Reviews**
   - End of each week: review all days
   - End of course: review entire journey
   - Use spaced repetition

### Bash-Specific Tips

1. **Test in Safe Environments**
   - Use test directories for file operations
   - Be careful with `rm` commands
   - Always backup important data

2. **Read Error Messages**
   - Bash error messages are helpful
   - Learn to debug step-by-step
   - Use `set -x` for debugging

3. **Check ShellCheck**
   - Use ShellCheck to validate scripts
   - Learn from warnings and suggestions
   - Install: [shellcheck.net](https://www.shellcheck.net/)

4. **Practice System Administration**
   - Apply scripts to real tasks
   - Automate repetitive work
   - Build a personal toolkit

***

## 🆘 Troubleshooting

### Obsidian Won't Open

- **Windows:** Check if blocked by antivirus
- **macOS:** Go to System Preferences → Security & Privacy → Allow
- **Linux:** Ensure execute permissions: `chmod +x Obsidian.AppImage`

### Git Clone Issues

**"Permission denied"**
```bash
# Check Git installation
git --version

# Check SSH keys (if using SSH)
ssh -T git@github.com
```

**"Repository not found"**
- Check URL is correct
- Ensure repository is public or you're authenticated

### Bash Script Won't Execute

**"Permission denied"**
```bash
# Make script executable
chmod +x your-script.sh
```

**"Command not found"**
```bash
# Use ./ to run scripts in current directory
./your-script.sh
```

**"Bad interpreter"**
- Check shebang line: `#!/bin/bash`
- Verify Bash location: `which bash`

### Obsidian Sync Issues

If using Obsidian Git plugin:
1. Check Git plugin settings
2. Ensure credentials are correct
3. Check network connection

### Missing Files or Folders

- Refresh vault: Close and reopen Obsidian
- Check if files are in correct location
- Try Settings → Files → Refresh

***

## 📞 Getting Help

### Resources

- **Obsidian Help:** [help.obsidian.md](https://help.obsidian.md)
- **Obsidian Forum:** [forum.obsidian.md](https://forum.obsidian.md)
- **Bash Manual:** Run `man bash` in terminal
- **Course Repository:** [GitHub Issues](https://github.com/cbrayanalytics/bash_course/issues)

### Community

- Join the Obsidian Discord
- Unix & Linux Stack Exchange
- r/bash on Reddit
- LinuxQuestions.org forums

***

## ✅ Setup Checklist

Before starting Day 1, ensure you have:

- [ ] Obsidian installed and running
- [ ] Course vault cloned/downloaded and opened
- [ ] Vault structure visible in Obsidian
- [ ] Bash environment verified (run `bash --version`)
- [ ] Text editor (VS Code) installed
- [ ] Created `My-Progress.md` tracking note
- [ ] Created `Your-Scripts` folder for practice
- [ ] Installed recommended Obsidian plugins (optional)
- [ ] Configured Obsidian settings
- [ ] Read Course Overview
- [ ] Ready to start Day 1!

***

## 🎉 Ready to Begin!

Congratulations! You're all set up and ready to start your Bash mastery journey.

**Next Steps:**
1. Open `Course-Overview.md` to see the full curriculum
2. Read `Getting-Started.md` for Bash environment details
3. Start with `Week-1-Fundamentals/Day-01-Introduction.md`

**Remember:** This is a marathon, not a sprint. Some exercises may reference concepts not yet covered—this is intentional. Research, experiment, and embrace the learning process!

***

## 📚 Additional Resources

### Obsidian Learning
- [Obsidian for Beginners](https://www.youtube.com/watch?v=QgbLb6QCK88)
- [Linking Your Thinking](https://www.linkingyourthinking.com/)
- [Obsidian Roadmap](https://obsidian.md/roadmap)

### Bash Learning
- [GNU Bash Manual](https://www.gnu.org/software/bash/manual/)
- [ShellCheck](https://www.shellcheck.net/)
- [Bash Scripting Tutorial](https://linuxconfig.org/bash-scripting-tutorial)
- [Advanced Bash-Scripting Guide](https://tldp.org/LDP/abs/html/)

---

**Happy Scripting! 🐚💻✨**

*Last Updated: November 4, 2025*
