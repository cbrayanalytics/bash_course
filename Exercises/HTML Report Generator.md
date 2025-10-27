### Goal:
Build a comprehensive HTML report generator named `report_generator.sh` that creates professional HTML reports using here documents with variable substitution and data visualization.
### Requirements:
**Core Features:**
- Generate multi-page HTML reports
- Include charts and graphs (using Chart.js or similar)
- Support various data sources (CSV, JSON, database)
- Dynamic content with variable substitution
- Responsive design
- Interactive elements
- Export to PDF
- Email reports
- Schedule report generation

**Report Types:**
- System status reports
- Performance reports
- Analytics dashboards
- Error reports
- User activity reports
- Financial reports
- Custom reports from templates

**Visual Elements:**
- Tables with sorting/filtering
- Line charts, bar charts, pie charts
- Progress bars
- Status indicators
- Alerts/notifications
- Responsive layout
- Print-friendly styles
### Expected Output Example:
```bash
./report_generator.sh --type system-status --period daily
```

```
╔════════════════════════════════════════════════════════════════╗
║            HTML REPORT GENERATOR                               ║
╚════════════════════════════════════════════════════════════════╝

Report Configuration:
────────────────────────────────────────────────────────────────
Type: System Status Report
Period: Daily
Date: 2025-10-20
Output: reports/system_status_20251020.html

Collecting data...
────────────────────────────────────────────────────────────────
[1/5] System metrics... ✓ (234 data points)
[2/5] Service status... ✓ (12 services)
[3/5] Performance data... ✓ (1,247 records)
[4/5] Error logs... ✓ (45 errors found)
[5/5] Resource usage... ✓ (CPU, Memory, Disk)

Processing data...
████████████████████████████████████████ 100%

Generating HTML report...
────────────────────────────────────────────────────────────────
✓ HTML structure created
✓ CSS styles embedded
✓ JavaScript charts generated
✓ Data tables populated
✓ Charts rendered
✓ Summary section created

Report Statistics:
────────────────────────────────────────────────────────────────
Pages: 1
Sections: 6
Tables: 3
Charts: 5
Total size: 456 KB (with embedded assets)

╔════════════════════════════════════════════════════════════════╗
║                REPORT GENERATED                                ║
╚════════════════════════════════════════════════════════════════╝

Output file: reports/system_status_20251020.html

Preview report:
  file://reports/system_status_20251020.html

Open in browser? [y/n]: y
```

**Generated HTML Report Preview:**
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>System Status Report - October 20, 2025</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Arial, sans-serif;
            line-height: 1.6;
            color: #333;
            background: #f5f5f5;
        }
        .container { max-width: 1200px; margin: 0 auto; padding: 20px; }
        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 40px 20px;
            border-radius: 10px;
            margin-bottom: 30px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        .header h1 { font-size: 2.5em; margin-bottom: 10px; }
        .header p { font-size: 1.1em; opacity: 0.9; }
        
        .summary {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        .summary-card {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            border-left: 4px solid #667eea;
        }
        .summary-card h3 { color: #666; font-size: 0.9em; margin-bottom: 10px; }
        .summary-card .value {
            font-size: 2.5em;
            font-weight: bold;
            color: #333;
        }
        .summary-card .status { margin-top: 10px; font-size: 0.9em; }
        .status.good { color: #4CAF50; }
        .status.warning { color: #FF9800; }
        .status.error { color: #F44336; }
        
        .section {
            background: white;
            padding: 30px;
            border-radius: 10px;
            margin-bottom: 30px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .section h2 {
            font-size: 1.8em;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #667eea;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background: #f8f9fa;
            font-weight: 600;
            color: #667eea;
        }
        tr:hover { background: #f8f9fa; }
        
        .chart-container {
            position: relative;
            height: 400px;
            margin: 20px 0;
        }
        
        .badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.85em;
            font-weight: 600;
        }
        .badge.success { background: #e8f5e9; color: #2e7d32; }
        .badge.warning { background: #fff3e0; color: #f57c00; }
        .badge.error { background: #ffebee; color: #c62828; }
        
        .footer {
            text-align: center;
            padding: 20px;
            color: #666;
            font-size: 0.9em;
        }
        
        @media print {
            body { background: white; }
            .section { page-break-inside: avoid; }
        }
    </style>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.9.1/dist/chart.min.js"></script>
</head>
<body>
    <div class="container">
        <!-- Header -->
        <div class="header">
            <h1>System Status Report</h1>
            <p>Daily Report for October 20, 2025</p>
            <p>Generated at: 00:06:15 MDT</p>
        </div>
        
        <!-- Summary Cards -->
        <div class="summary">
            <div class="summary-card">
                <h3>System Health</h3>
                <div class="value">95%</div>
                <div class="status good">✓ Healthy</div>
            </div>
            <div class="summary-card">
                <h3>Services Running</h3>
                <div class="value">11/12</div>
                <div class="status warning">⚠ 1 Down</div>
            </div>
            <div class="summary-card">
                <h3>CPU Usage</h3>
                <div class="value">34%</div>
                <div class="status good">✓ Normal</div>
            </div>
            <div class="summary-card">
                <h3>Errors Today</h3>
                <div class="value">45</div>
                <div class="status warning">⚠ Above Average</div>
            </div>
        </div>
        
        <!-- Services Status -->
        <div class="section">
            <h2>Service Status</h2>
            <table>
                <thead>
                    <tr>
                        <th>Service</th>
                        <th>Status</th>
                        <th>Uptime</th>
                        <th>CPU</th>
                        <th>Memory</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Web Server (nginx)</td>
                        <td><span class="badge success">Running</span></td>
                        <td>15d 8h 23m</td>
                        <td>5.2%</td>
                        <td>234 MB</td>
                    </tr>
                    <tr>
                        <td>Database (PostgreSQL)</td>
                        <td><span class="badge success">Running</span></td>
                        <td>15d 8h 23m</td>
                        <td>8.7%</td>
                        <td>1.2 GB</td>
                    </tr>
                    <tr>
                        <td>Cache (Redis)</td>
                        <td><span class="badge success">Running</span></td>
                        <td>15d 8h 23m</td>
                        <td>2.1%</td>
                        <td>512 MB</td>
                    </tr>
                    <tr>
                        <td>Worker Queue</td>
                        <td><span class="badge error">Stopped</span></td>
                        <td>0h 0m</td>
                        <td>0%</td>
                        <td>0 MB</td>
                    </tr>
                </tbody>
            </table>
        </div>
        
        <!-- CPU Usage Chart -->
        <div class="section">
            <h2>CPU Usage (Last 24 Hours)</h2>
            <div class="chart-container">
                <canvas id="cpuChart"></canvas>
            </div>
        </div>
        
        <!-- Memory Usage Chart -->
        <div class="section">
            <h2>Memory Usage</h2>
            <div class="chart-container">
                <canvas id="memoryChart"></canvas>
            </div>
        </div>
        
        <!-- Error Summary -->
        <div class="section">
            <h2>Error Summary</h2>
            <table>
                <thead>
                    <tr>
                        <th>Time</th>
                        <th>Severity</th>
                        <th>Service</th>
                        <th>Message</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>00:05:23</td>
                        <td><span class="badge error">ERROR</span></td>
                        <td>worker</td>
                        <td>Connection timeout to external API</td>
                    </tr>
                    <tr>
                        <td>00:03:15</td>
                        <td><span class="badge warning">WARNING</span></td>
                        <td>database</td>
                        <td>Slow query detected (2.3s)</td>
                    </tr>
                    <tr>
                        <td>23:58:42</td>
                        <td><span class="badge error">ERROR</span></td>
                        <td>web</td>
                        <td>404: /api/deprecated endpoint</td>
                    </tr>
                </tbody>
            </table>
        </div>
        
        <!-- Footer -->
        <div class="footer">
            <p>Report generated by System Monitor v1.0</p>
            <p>&copy; 2025 MyCompany. All rights reserved.</p>
        </div>
    </div>
    
    <script>
        // CPU Usage Chart
        const cpuCtx = document.getElementById('cpuChart').getContext('2d');
        new Chart(cpuCtx, {
            type: 'line',
             {
                labels: ['00:00', '04:00', '08:00', '12:00', '16:00', '20:00', '24:00'],
                datasets: [{
                    label: 'CPU Usage (%)',
                     [25, 30, 45, 52, 38, 42, 34],
                    borderColor: 'rgb(102, 126, 234)',
                    backgroundColor: 'rgba(102, 126, 234, 0.1)',
                    tension: 0.4,
                    fill: true
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { display: true }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        max: 100
                    }
                }
            }
        });
        
        // Memory Usage Chart
        const memCtx = document.getElementById('memoryChart').getContext('2d');
        new Chart(memCtx, {
            type: 'doughnut',
             {
                labels: ['Used', 'Cached', 'Free'],
                datasets: [{
                     [8500, 3000, 4500],
                    backgroundColor: [
                        'rgb(102, 126, 234)',
                        'rgb(118, 75, 162)',
                        'rgb(200, 200, 200)'
                    ]
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'bottom'
                    }
                }
            }
        });
    </script>
</body>
</html>
```
