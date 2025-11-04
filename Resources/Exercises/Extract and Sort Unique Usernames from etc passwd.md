### Goal:
Create a script named `user_extractor.sh` that extracts, sorts, and analyzes user information from /etc/passwd and similar system files.
### Requirements:
- Extract usernames from /etc/passwd
- Sort alphabetically
- Remove duplicates (if any)
- Additional extractions:
  - UIDs and usernames
  - User shells
  - Home directories
  - User groups
- Filtering options:
  - System users (UID < 1000)
  - Regular users (UID >= 1000)
  - Users with specific shells
  - Users without home directories
- Statistics:
  - Total user count
  - Shell distribution
  - UID ranges
- Output formats:
  - Simple list
  - Detailed table
  - CSV export
  - JSON format
### Expected Output Example:
```bash
./user_extractor.sh
```
```
╔════════════════════════════════════════════════════════════════╗
║           SYSTEM USER EXTRACTOR                                ║
║           Source: /etc/passwd                                  ║
╚════════════════════════════════════════════════════════════════╝

Extracting and analyzing users...

Unique Usernames (Alphabetically Sorted):
────────────────────────────────────────────────────────────────
alice
backup
bin
bob
charlie
daemon
games
john
lp
mail
messagebus
mysql
nginx
nobody
postgres
root
sync
sys
www-data
[...total: 45 users]

══════════════════════════════════════════════════════════════
USER STATISTICS
══════════════════════════════════════════════════════════════

Total Users: 45
────────────────────────────────────────────────────────────────
System users (UID < 1000):     38
Regular users (UID >= 1000):   7

UID Ranges:
────────────────────────────────────────────────────────────────
0           : root (1 user)
1-999       : System accounts (37 users)
1000-1999   : Regular users (7 users)
65534       : nobody (1 user)

Shell Distribution:
────────────────────────────────────────────────────────────────
/bin/bash           : 8 users (17.8%) ████████████████████
/bin/sh             : 12 users (26.7%) ███████████████████████████
/usr/sbin/nologin   : 15 users (33.3%) █████████████████████████████████
/bin/false          : 8 users (17.8%) ████████████████████
/bin/sync           : 1 user (2.2%)   ███
/usr/bin/tmux       : 1 user (2.2%)   ███

══════════════════════════════════════════════════════════════
REGULAR USERS (UID >= 1000)
══════════════════════════════════════════════════════════════

Username    UID    GID    Shell           Home
────────────────────────────────────────────────────────────────
john        1000   1000   /bin/bash       /home/john
alice       1001   1001   /bin/bash       /home/alice
bob         1002   1002   /bin/bash       /home/bob
charlie     1003   1003   /bin/bash       /home/charlie
[...3 more users]

══════════════════════════════════════════════════════════════
SERVICE ACCOUNTS
══════════════════════════════════════════════════════════════

Common Service Users:
────────────────────────────────────────────────────────────────
mysql       : UID 111  | Shell: /bin/false
postgres    : UID 112  | Shell: /bin/bash
nginx       : UID 113  | Shell: /usr/sbin/nologin
www-data    : UID 33   | Shell: /usr/sbin/nologin
messagebus  : UID 101  | Shell: /usr/sbin/nologin

╔════════════════════════════════════════════════════════════════╗
║                    EXPORT OPTIONS                              ║
╚════════════════════════════════════════════════════════════════╝

Data exported to:
  📄 users_list.txt       (simple list)
  📊 users_detailed.csv   (full details)
  📈 users_data.json      (structured data)
```

```bash
./user_extractor.sh --shell bash --sort-by uid
```
```
╔════════════════════════════════════════════════════════════════╗
║     USERS WITH BASH SHELL (Sorted by UID)                      ║
╚════════════════════════════════════════════════════════════════╝

UID    Username    Home Directory          Groups
────────────────────────────────────────────────────────────────
0      root        /root                   root
112    postgres    /var/lib/postgresql     postgres
1000   john        /home/john              john,sudo,docker
1001   alice       /home/alice             alice,sudo
1002   bob         /home/bob               bob,developers
1003   charlie     /home/charlie           charlie,www-data
1004   david       /home/david             david
1005   eve         /home/eve               eve,admin

Total: 8 users with /bin/bash shell

Summary:
────────────────────────────────────────────────────────────────
Root user:      1
Service users:  1 (postgres)
Regular users:  6
```
### Bonus Challenge:
- Add password expiry analysis
- Check for inactive accounts
- Identify shared UIDs/GIDs
- Detect security issues (passwordless accounts)
- Compare across multiple systems
- Generate compliance reports
- Add group membership analysis
- Create user audit trail
- Support LDAP/AD integration
- Generate user provisioning scripts

***