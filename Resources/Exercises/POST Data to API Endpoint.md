### Goal:
Create a script named `api_post.sh` that sends POST requests to APIs with various data formats and authentication methods.
### Requirements:
- Send JSON data via POST
- Support form data
- Handle file uploads
- Various authentication methods
- Parse response
- Error handling
- Retry logic
- Request/response logging
### Expected Output Example:
```bash
./api_post.sh --url https://api.example.com/users --data '{"name":"Alice","email":"alice@example.com"}'
```
```
╔════════════════════════════════════════════════════════════════╗
║              API POST REQUEST                                  ║
╚════════════════════════════════════════════════════════════════╝

Request Configuration:
────────────────────────────────────────────────────────────────
Method:          POST
URL:             https://api.example.com/users
Content-Type:    application/json
Authentication:  None

Request Body:
────────────────────────────────────────────────────────────────
{
  "name": "Alice",
  "email": "alice@example.com"
}

[INFO] Sending request...

Request Details:
────────────────────────────────────────────────────────────────
curl -X POST \
  https://api.example.com/users \
  -H "Content-Type: application/json" \
  -d '{"name":"Alice","email":"alice@example.com"}'

[INFO] Response received ✓

Response:
════════════════════════════════════════════════════════════════

Status Code: 201 Created
Response Time: 234ms

Response Headers:
────────────────────────────────────────────────────────────────
Content-Type: application/json
Location: https://api.example.com/users/12345
X-Request-ID: abc123def456

Response Body:
────────────────────────────────────────────────────────────────
{
  "id": 12345,
  "name": "Alice",
  "email": "alice@example.com",
  "created_at": "2025-10-20T00:21:00Z",
  "status": "active"
}

╔════════════════════════════════════════════════════════════════╗
║              REQUEST SUCCESSFUL                                ║
╚════════════════════════════════════════════════════════════════╝

Summary:
────────────────────────────────────────────────────────────────
✓ User created successfully
✓ User ID: 12345
✓ Location: https://api.example.com/users/12345

Request logged to: logs/api_requests.log
```

```bash
./api_post.sh --url https://api.example.com/upload --file document.pdf --auth-token ABC123
```
```
╔════════════════════════════════════════════════════════════════╗
║              FILE UPLOAD REQUEST                               ║
╚════════════════════════════════════════════════════════════════╝

Upload Configuration:
────────────────────────────────────────────────────────────────
File:            document.pdf
Size:            2.3 MB
URL:             https://api.example.com/upload
Authentication:  Bearer Token (provided)

[INFO] Validating file...
✓ File exists
✓ File readable
✓ File size acceptable

[INFO] Uploading file...

Upload Progress:
████████████████████████████████████████ 100% (2.3 MB / 2.3 MB)

[INFO] Upload complete ✓

Response:
════════════════════════════════════════════════════════════════

Status Code: 200 OK
Upload Time: 3.2 seconds
Speed: 718 KB/s

Response Body:
────────────────────────────────────────────────────────────────
{
  "file_id": "file_abc123",
  "filename": "document.pdf",
  "size": 2415919,
  "mime_type": "application/pdf",
  "uploaded_at": "2025-10-20T00:21:15Z",
  "url": "https://cdn.example.com/files/file_abc123"
}

✓ File uploaded successfully
✓ File ID: file_abc123
✓ Access URL: https://cdn.example.com/files/file_abc123
```

### Bonus Challenge:
- Add multipart form data support
- Implement request signing
- Support OAuth authentication
- Add request templating
- Create request builder
- Support webhooks
- Add response validation
- Implement request mocking

***
