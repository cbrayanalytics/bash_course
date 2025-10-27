### Goal:
Create a script named `email_composer.sh` that generates formatted email messages using here documents with variable substitution.
### Requirements:
- Support multiple email templates
- Variable substitution for personalization
- HTML and plain text formats
- Support attachments
- Template validation
- Preview before sending
- Bulk email generation
- Include headers (To, From, Subject, CC, BCC)
- Support email scheduling
- Track sent emails
### Expected Output Example:
```bash
./email_composer.sh --template welcome --to user@example.com --name "Alice Johnson"
```
```
╔════════════════════════════════════════════════════════════════╗
║              EMAIL COMPOSER                                    ║
╚════════════════════════════════════════════════════════════════╝

Email Configuration:
────────────────────────────────────────────────────────────────
Template: welcome
To: user@example.com
Name: Alice Johnson
From: noreply@myapp.com
Subject: Welcome to MyApplication!

Loading template...
✓ Template loaded: templates/welcome.txt

Composing email...

Email Preview (Plain Text):
════════════════════════════════════════════════════════════════

From: MyApplication <noreply@myapp.com>
To: Alice Johnson <user@example.com>
Subject: Welcome to MyApplication!
Date: Mon, 20 Oct 2025 00:06:10 -0600

────────────────────────────────────────────────────────────────

Hello Alice Johnson,

Welcome to MyApplication! We're excited to have you on board.

Your account has been successfully created with the following details:

Account Information:
  • Email: user@example.com
  • Username: alice.johnson
  • Registration Date: October 20, 2025
  • Account Type: Free

Getting Started:
  1. Complete your profile at: https://myapp.com/profile
  2. Explore our features at: https://myapp.com/features
  3. Join our community at: https://myapp.com/community

Need Help?
Our support team is available 24/7:
  • Email: support@myapp.com
  • Phone: 1-800-MYAPP-01
  • Live Chat: https://myapp.com/chat

Thank you for choosing MyApplication!

Best regards,
The MyApplication Team
https://myapp.com

────────────────────────────────────────────────────────────────

Email size: 1.2 KB
Character encoding: UTF-8

═══════════════════════════════════════════════════════════════

Send this email? [y/n/p] (p=preview HTML version): p

HTML Preview:
════════════════════════════════════════════════════════════════

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Welcome to MyApplication</title>
    <style>
        body { font-family: Arial, sans-serif; line-height: 1.6; }
        .header { background: #4CAF50; color: white; padding: 20px; }
        .content { padding: 20px; }
        .footer { background: #f1f1f1; padding: 10px; text-align: center; }
        .button { background: #4CAF50; color: white; padding: 10px 20px;
                  text-decoration: none; display: inline-block; }
    </style>
</head>
<body>
    <div class="header">
        <h1>Welcome to MyApplication!</h1>
    </div>
    
    <div class="content">
        <p>Hello <strong>Alice Johnson</strong>,</p>
        
        <p>Welcome to MyApplication! We're excited to have you on board.</p>
        
        <h2>Your Account Information</h2>
        <ul>
            <li>Email: user@example.com</li>
            <li>Username: alice.johnson</li>
            <li>Registration: October 20, 2025</li>
        </ul>
        
        <h2>Getting Started</h2>
        <p>
            <a href="https://myapp.com/profile" class="button">
                Complete Your Profile
            </a>
        </p>
        
        <p>Need help? Contact us at 
           <a href="mailto:support@myapp.com">support@myapp.com</a>
        </p>
    </div>
    
    <div class="footer">
        <p>&copy; 2025 MyApplication. All rights reserved.</p>
        <p>
            <a href="https://myapp.com/unsubscribe">Unsubscribe</a> |
            <a href="https://myapp.com/privacy">Privacy Policy</a>
        </p>
    </div>
</body>
</html>

════════════════════════════════════════════════════════════════

Send this email? [y/n]: y

Sending email...
✓ Email sent successfully
✓ Message ID: <20251020000610.12345@myapp.com>

Email Log:
────────────────────────────────────────────────────────────────
Timestamp: 2025-10-20 00:06:10
Template: welcome
Recipient: user@example.com
Status: Sent
Message ID: 20251020000610.12345

Log saved to: /var/log/email/sent_20251020.log
```

```bash
./email_composer.sh --template invoice --bulk customers.csv
```
```
╔════════════════════════════════════════════════════════════════╗
║              BULK EMAIL COMPOSER                               ║
╚════════════════════════════════════════════════════════════════╝

Bulk send configuration:
────────────────────────────────────────────────────────────────
Template: invoice
Recipients file: customers.csv
Records: 156

Loading customer data...
✓ 156 records loaded

Sample preview (first recipient):
────────────────────────────────────────────────────────────────

To: john.doe@example.com
Subject: Invoice #INV-2025-001 for John Doe

Dear John Doe,

Your invoice for October 2025 is ready.

Invoice Details:
  Invoice Number: INV-2025-001
  Date: October 20, 2025
  Amount Due: $1,234.56
  Due Date: November 20, 2025

View invoice: https://myapp.com/invoice/INV-2025-001

Thank you for your business!

────────────────────────────────────────────────────────────────

Proceed with bulk send? [y/n]: y

Sending emails...
████████████████████████████████████████ 100% (156/156)

Summary:
────────────────────────────────────────────────────────────────
Total: 156
Sent: 154 ✓
Failed: 2 ✗
Success rate: 98.7%

Failed addresses:
  • invalid@domain (invalid email format)
  • bounce@example.com (mailbox full)

Total time: 2m 34s
Average: 0.98 seconds/email

Report saved to: /var/log/email/bulk_20251020_000610.log
```
### Bonus Challenge:
- Add email templates with loops/conditionals
- Implement email tracking (opens, clicks)
- Support internationalization (i18n)
- Add email preview in browser
- Implement email queuing
- Support email campaigns
- Add A/B testing for emails
- Create email analytics dashboard

***