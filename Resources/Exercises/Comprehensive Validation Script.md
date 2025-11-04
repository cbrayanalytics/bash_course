### Goal:
Build a production-ready validation script named `validate.sh` that runs multiple checks and returns specific exit codes for different failure scenarios.
### Requirements:
**Validation Categories:**
1. **Environment validation** (exit codes 64-69)
   - Required commands present
   - Required environment variables set
   - Working directory accessible
   - Exit codes: 64=missing command, 65=missing var, 66=bad directory

2. **File system validation** (exit codes 70-75)
   - Required files exist
   - Files have correct permissions
   - Sufficient disk space
   - Exit codes: 70=missing file, 71=bad permissions, 72=no space

3. **Network validation** (exit codes 76-79)
   - Required hosts reachable
   - Required ports accessible
   - DNS resolution working
   - Exit codes: 76=host unreachable, 77=port closed, 78=DNS failure

4. **Configuration validation** (exit codes 80-85)
   - Config files parseable
   - Config values within valid ranges
   - No conflicting settings
   - Exit codes: 80=parse error, 81=invalid value, 82=conflict

5. **Dependency validation** (exit codes 86-89)
   - Service dependencies available
   - Version requirements met
   - Compatible versions
   - Exit codes: 86=service down, 87=wrong version, 88=incompatible

**Features:**
- Run all checks or specific categories
- Stop on first failure or continue to collect all errors
- Detailed reporting with actionable suggestions
- Machine-readable output (JSON option)
- Dry-run mode (check without actions)
- Fix suggestions with auto-fix option
- Comprehensive logging
- Performance timing
### Expected Output Example:
```bash
./validate.sh --all
```
```
╔════════════════════════════════════════════════════════════════╗
║              SYSTEM VALIDATION SCRIPT                          ║
║              Running all validation checks                     ║
╚════════════════════════════════════════════════════════════════╝

[1/5] Environment Validation
────────────────────────────────────────────────────────────────
  ✓ Command 'git' found (/usr/bin/git)
  ✓ Command 'docker' found (/usr/bin/docker)
  ✓ Command 'node' found (/usr/local/bin/node)
  ✓ Environment variable 'HOME' set
  ✓ Environment variable 'USER' set
  ✓ Environment variable 'PATH' set
  ✓ Working directory accessible

  Result: ✓ PASSED (7/7 checks)

[2/5] File System Validation
────────────────────────────────────────────────────────────────
  ✓ File 'config/app.yaml' exists
  ✓ File 'config/app.yaml' is readable
  ✓ File 'scripts/deploy.sh' exists
  ✓ File 'scripts/deploy.sh' is executable
  ✓ Directory 'logs/' exists
  ✓ Directory 'logs/' is writable
  ✓ Disk space sufficient (45% used, 250GB free)

  Result: ✓ PASSED (7/7 checks)

[3/5] Network Validation
────────────────────────────────────────────────────────────────
  ✓ Host 'api.example.com' reachable (ping: 15ms)
  ✓ Port 443 on 'api.example.com' open
  ✓ DNS resolution working (api.example.com → 192.0.2.1)
  ✓ Host 'db.example.com' reachable (ping: 8ms)
  ✓ Port 5432 on 'db.example.com' open

  Result: ✓ PASSED (5/5 checks)

[4/5] Configuration Validation
────────────────────────────────────────────────────────────────
  ✓ config/app.yaml is valid YAML
  ✓ config/database.yaml is valid YAML
  ✓ port setting (8080) within valid range (1024-65535)
  ✓ max_connections (100) within valid range (1-1000)
  ✓ No conflicting settings detected

  Result: ✓ PASSED (5/5 checks)

[5/5] Dependency Validation
────────────────────────────────────────────────────────────────
  ✓ PostgreSQL service running
  ✓ Redis service running
  ✓ Node.js version 18.x.x meets requirement (>=16.0.0)
  ✓ Docker version 24.x.x meets requirement (>=20.0.0)
  ✓ All dependencies compatible

  Result: ✓ PASSED (5/5 checks)

╔════════════════════════════════════════════════════════════════╗
║                   VALIDATION SUMMARY                           ║
╚════════════════════════════════════════════════════════════════╝

Total Checks: 31
Passed: 31 ✓
Failed: 0 ✗
Warnings: 0 ⚠

Validation Time: 2.345 seconds

════════════════════════════════════════════════════════════════
✓ ALL VALIDATIONS PASSED - SYSTEM READY FOR DEPLOYMENT
════════════════════════════════════════════════════════════════

Exit Code: 0 (SUCCESS)
```

```bash
echo $?
# 0
```

**With failures:**

```bash
./validate.sh --all
```
```
╔════════════════════════════════════════════════════════════════╗
║              SYSTEM VALIDATION SCRIPT                          ║
╚════════════════════════════════════════════════════════════════╝

[1/5] Environment Validation
────────────────────────────────────────────────────────────────
  ✓ Command 'git' found
  ✓ Command 'docker' found
  ✗ Command 'kubectl' NOT FOUND
  
  Error Details:
    Exit Code: 64 (MISSING_REQUIRED_COMMAND)
    Missing: kubectl
    Required for: Kubernetes deployment
    
  Suggested Fix:
    # Install kubectl
    curl -LO "https://dl.k8s.io/release/$(curl -L -s \
      https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    chmod +x kubectl
    sudo mv kubectl /usr/local/bin/

  Result: ✗ FAILED (2/3 checks passed)

[2/5] File System Validation
────────────────────────────────────────────────────────────────
  ✓ File 'config/app.yaml' exists
  ✗ File 'scripts/deploy.sh' NOT EXECUTABLE
  
  Error Details:
    Exit Code: 71 (INCORRECT_PERMISSIONS)
    File: scripts/deploy.sh
    Current: rw-r--r-- (644)
    Required: rwxr-xr-x (755)
    
  Suggested Fix:
    chmod +x scripts/deploy.sh
    
  Auto-fix available. Apply? (y/n): 

  Result: ✗ FAILED (1/2 checks passed)

[3/5] Network Validation
────────────────────────────────────────────────────────────────
  ✗ Host 'api.example.com' UNREACHABLE
  
  Error Details:
    Exit Code: 76 (HOST_UNREACHABLE)
    Host: api.example.com
    Timeout after: 5 seconds
    
  Troubleshooting:
    • Check network connectivity: ping 8.8.8.8
    • Verify DNS: nslookup api.example.com
    • Check firewall rules
    • Verify VPN connection if required

  Result: ✗ FAILED (0/1 checks passed)

[4/5] Configuration Validation
────────────────────────────────────────────────────────────────
  ✗ config/app.yaml PARSE ERROR
  
  Error Details:
    Exit Code: 80 (CONFIG_PARSE_ERROR)
    File: config/app.yaml
    Line: 15
    Error: mapping values are not allowed here
    
  File excerpt (lines 13-17):
    13 | database:
    14 |   host: localhost
    15 |   port: 5432:
    16 |   name: mydb
    17 |   user: admin
    
  Issue: Extra colon on line 15 after '5432'
  
  Suggested Fix:
    Edit config/app.yaml and remove trailing colon on line 15
    Change: "port: 5432:" to "port: 5432"

  Result: ✗ FAILED (0/1 checks passed)

[5/5] Dependency Validation
────────────────────────────────────────────────────────────────
  ✗ Redis service NOT RUNNING
  
  Error Details:
    Exit Code: 86 (SERVICE_NOT_AVAILABLE)
    Service: redis
    Status: inactive (dead)
    
  Suggested Fix:
    sudo systemctl start redis
    sudo systemctl enable redis  # Start on boot

  Result: ✗ FAILED (0/1 checks passed)

╔════════════════════════════════════════════════════════════════╗
║                   VALIDATION SUMMARY                           ║
╚════════════════════════════════════════════════════════════════╝

Total Checks: 8
Passed: 3 ✓
Failed: 5 ✗
Warnings: 0 ⚠

Failed Checks by Category:
  Environment: 1 (missing kubectl)
  File System: 1 (wrong permissions)
  Network: 1 (host unreachable)
  Configuration: 1 (parse error)
  Dependencies: 1 (service down)

════════════════════════════════════════════════════════════════
✗ VALIDATION FAILED - SYSTEM NOT READY FOR DEPLOYMENT
════════════════════════════════════════════════════════════════

First Failure: MISSING_REQUIRED_COMMAND (exit code 64)
Most Critical: HOST_UNREACHABLE (exit code 76)

To see detailed error report:
  ./validate.sh --report

To attempt auto-fix:
  ./validate.sh --all --fix

Exit Code: 64 (first failure encountered)
```

```bash
echo $?
# 64
```

**Category-specific validation:**
```bash
./validate.sh --category network
```
```
╔════════════════════════════════════════════════════════════════╗
║           VALIDATION - Network Category Only                   ║
╚════════════════════════════════════════════════════════════════╝

Running network validation checks...

Checking connectivity to required hosts...
  • api.example.com:443 ... ✓ Reachable (142ms)
  • db.example.com:5432 ... ✓ Reachable (38ms)
  • cache.example.com:6379 ... ✓ Reachable (25ms)

Checking DNS resolution...
  • api.example.com ... ✓ Resolved to 192.0.2.1
  • db.example.com ... ✓ Resolved to 192.0.2.2
  • cache.example.com ... ✓ Resolved to 192.0.2.3

Testing bandwidth...
  • Download speed: 95.2 Mbps ✓
  • Upload speed: 45.3 Mbps ✓
  • Latency: 15ms ✓

════════════════════════════════════════════════════════════════
✓ NETWORK VALIDATION PASSED
════════════════════════════════════════════════════════════════

Exit Code: 0
```
### Bonus Challenges:
**Level 1 (Intermediate):**
- Add custom validation plugins
- Support validation profiles (dev/staging/prod)
- Create validation reports (HTML/PDF)
- Add compliance checking (security standards)
- Implement validation scheduling (cron)
- Support remote validation (SSH)
- Add rollback validation (pre/post deployment)
- Create validation dashboard

**Level 2 (Advanced):**
- Machine learning for failure prediction
- Automated remediation workflows
- Integration with monitoring systems
- Performance regression detection
- Security vulnerability scanning
- Cost optimization checks
- Capacity planning validation
- Multi-environment orchestration

**Level 3 (Expert):**
- Continuous validation pipeline
- Policy-as-code enforcement
- Chaos engineering integration
- Self-healing automation
- Distributed validation across clusters
- Real-time compliance monitoring
- Predictive failure analysis
- Full CI/CD integration
