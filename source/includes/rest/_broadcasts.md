# Single-Email Campaigns <br/>(aka Broadcasts)

Single-Email Campaigns (Broadcasts) are one-time emails sent to a segment of your subscribers.
The API allows you to list, fetch, create, update, and delete Single-Email Campaigns, as well as
send test emails.

A Single-Email Campaign's `status` is read-only via the API and is managed through the Drip UI.
Possible statuses are:

<table>
  <thead>
    <tr>
      <th>Status</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>draft</code></td>
      <td>Not yet scheduled. Drafts are the only Single-Email Campaigns that can be edited via the API.</td>
    </tr>
    <tr>
      <td><code>scheduled</code></td>
      <td>Scheduled for a future send. Read-only.</td>
    </tr>
    <tr>
      <td><code>sending</code></td>
      <td>Currently being sent. Read-only and cannot be deleted.</td>
    </tr>
    <tr>
      <td><code>sent</code></td>
      <td>Completed. Read-only.</td>
    </tr>
    <tr>
      <td><code>canceled</code></td>
      <td>Canceled before sending. Read-only.</td>
    </tr>
    <tr>
      <td><code>deleted</code></td>
      <td>Deleted. Hidden from default listings.</td>
    </tr>
  </tbody>
</table>

Scheduling (`send_at`, `localize_sending_time`) and recipient segmentation
are managed through the Drip UI only. These fields are returned as read-only values in API
responses and cannot be set via the API.

> Single-Email Campaigns are represented as follows:

```json
{
  "id": "123456",
  "status": "sent",
  "name": "4 Marketing Automation Trends for 2015",
  "from_name": "John Doe",
  "from_email": "john@example.com",
  "postal_address": "123 Anywhere St\nFresno, CA 99999",
  "localize_sending_time": true,
  "send_at": "2015-07-01T10:00:00Z",
  "bcc": null,
  "created_at": "2015-06-21T10:31:58Z",
  "href": "https://api.getdrip.com/v2/9999999/broadcast/123456",
  "preview_url": "https://www.getdrip.com/broadcasts/123456/2d83a64861f23b1c35a3b8d6ee3b54f7",
  "subject": "4 Marketing Automation Trends for 2015",
  "html_body": "HTML body",
  "text_body": "Text body",
  "links": {
    "account": "9999999"
  }
}
```

> All responses containing Single-Email Campaign data also include the following top-level link data:

```json
{
  "links": {
    "broadcasts.account": "https://api.getdrip.com/v2/accounts/{broadcasts.account}",
  }
}
```

**Properties**

<table>
  <thead>
    <tr>
      <th>Property</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>id</code></td>
      <td>A read-only Drip generated unique id used to identify each Single-Email Campaign record.</td>
    </tr>
    <tr>
      <td><code>status</code></td>
      <td>Returns whether the Single-Email Campaign is draft, canceled, scheduled, sent or sending.</td>
    </tr>
    <tr>
      <td><code>name</code></td>
      <td>The private name given to the Single-Email Campaign.</td>
    </tr>
    <tr>
      <td><code>from_name</code></td>
      <td>A "from name" that appears in your sent emails and can be changed on a per email basis. This setting overrides the account's default from name.</td>
    </tr>
    <tr>
      <td><code>from_email</code></td>
      <td>A "from email" that appears in your sent emails and can be changed on a per email basis. This setting overrides the account's default from email.</td>
    </tr>
    <tr>
      <td><code>postal_address</code></td>
      <td>As required by the <a href="http://1.usa.gov/YgrzFP" target="_blank">CAN-SPAM Act</a>, this is a postal address used for all sent emails and can be changed on a per email basis.</td>
    </tr>
    <tr>
      <td><code>localize_sending_time</code></td>
      <td>The scheduled send_at time if set to be sent in the subscriber's time zone.</td>
    </tr>
    <tr>
      <td><code>send_at</code></td>
      <td>The timestamp representing when the Single-Email Campaign will be delivered.</td>
    </tr>
    <tr>
      <td><code>bcc</code></td>
      <td>A list of emails designated to receive a blind copy of the Single-Email Campaign.</td>
    </tr>
    <tr>
      <td><code>created_at</code></td>
      <td>A read-only Drip generated timestamp for when the Single-Email Campaign was first created.</td>
    </tr>
    <tr>
      <td><code>href</code></td>
      <td>The url designated for retrieving the account record via the REST API.</td>
    </tr>
    <tr>
      <td><code>preview_url</code></td>
      <td>A read-only public URL for previewing the email content. Does not require authentication. Returns <code>null</code> for deleted Single-Email Campaigns.</td>
    </tr>
    <tr>
      <td><code>subject</code></td>
      <td>The Single-Email Campaign's subject.</td>
    </tr>
    <tr>
      <td><code>html_body</code></td>
      <td>The HTML content used in the email's body.</td>
    </tr>
    <tr>
      <td><code>text_body</code></td>
      <td>The plain text content used in the email's body.</td>
    </tr>
    <tr>
      <td><code>links</code></td>
      <td>An object containing the account's REST API URL.</td>
    </tr>
  </tbody>
</table>

## Email Content

> The content object structure:

```json
{
  "content": {
    "html": {
      "type": "document",
      "value": "<html><body><h1>Hello!</h1></body></html>"
    },
    "text": {
      "type": "document",
      "value": "Hello!\n\nWelcome to our newsletter."
    }
  }
}
```

Email content is provided via a `content` object containing content type keys. Each key maps
to an object with a `type` (the content variant) and a `value` (the content itself).

<table>
  <thead>
    <tr>
      <th>Key</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>html</code></td>
      <td>Required when creating. The HTML email content. Currently the only supported <code>type</code> is <code>document</code>: a full HTML document with a complete <code>&lt;html&gt;</code> structure. Supports Liquid templating.</td>
    </tr>
    <tr>
      <td><code>text</code></td>
      <td>Optional. The plain text version of the email. Currently the only supported <code>type</code> is <code>document</code>: a full plain text document. Supports Liquid templating. If omitted, the plain text version is generated automatically from the HTML.</td>
    </tr>
  </tbody>
</table>

HTML content is validated and sanitized for security: JavaScript is not allowed, and dangerous
CSS patterns are blocked.

## List all Single-Email Campaigns

> To list Single-Email Campaigns in an account:

```shell
curl "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/broadcasts" \
  -H "Content-Type: application/json" \
  -H 'User-Agent: Your App Name (www.yourapp.com)' \
  -u YOUR_API_KEY:
```

```ruby
require 'drip'

client = Drip::Client.new do |c|
  c.api_key = "YOUR API KEY"
  c.account_id = "YOUR_ACCOUNT_ID"
end

response = client.broadcasts

if response.success?
  puts response.body["broadcasts"]
end
```

```javascript
// npm install drip-nodejs --save

const client = require('drip-nodejs')({ token: YOUR_API_KEY, accountId: YOUR_ACCOUNT_ID });
const options = { status: "sent" };

client.listBroadcasts(options)
  .then((response) => {
    // Handle `response.body`
  })
  .catch((error) => {
    // Handle errors
  });
```

> The response looks like this:

```json
# The broadcasts property is an array of broadcast objects.
{
  "links": { ... },
  "meta": {
    "page": 1,
    "sort": "created_at",
    "direction": "asc",
    "count": 5,
    "total_pages": 1,
    "total_count": 5,
    "status": "all"
  },
  "broadcasts": [ ... ]
}
```

### HTTP Endpoint

`GET /v2/:account_id/broadcasts`

### Arguments

<table>
  <thead>
    <tr>
      <th>Key</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>page</code></td>
      <td>Optional. The page number (1-indexed). Defaults to <code>1</code>.</td>
    </tr>
    <tr>
      <td><code>per_page</code></td>
      <td>Optional. The number of results per page, up to a maximum of <code>100</code>. Defaults to <code>100</code>.</td>
    </tr>
    <tr>
      <td><code>status</code></td>
      <td>Optional. Filter by one of the following statuses: <code>draft</code>, <code>scheduled</code>, <code>sending</code>, <code>sent</code>, <code>canceled</code>, <code>deleted</code>, or <code>all</code>. By default, deleted Single-Email Campaigns are excluded; use <code>status=deleted</code> or <code>status=all</code> to include them.</td>
    </tr>
    <tr>
      <td><code>sort</code></td>
      <td>Optional. Sort results by one of these fields: <code>created_at</code>, <code>updated_at</code>, <code>send_at</code>, or <code>name</code>. Defaults to <code>created_at</code>.</td>
    </tr>
    <tr>
      <td><code>direction</code></td>
      <td>Optional. Filter sort direction with: <code>asc</code> or <code>desc</code>. Defaults to <code>asc</code>.</td>
    </tr>
  </tbody>
</table>

## Create a Single-Email Campaign

> To create a Single-Email Campaign:

```shell
curl -X POST "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/broadcasts" \
  -H "Content-Type: application/json" \
  -H 'User-Agent: Your App Name (www.yourapp.com)' \
  -u YOUR_API_KEY: \
  -d @- << EOF
  {
    "broadcasts": [{
      "name": "December Newsletter",
      "subject": "Your December Newsletter is here!",
      "preheader": "See what's new this month...",
      "content": {
        "html": {
          "type": "document",
          "value": "<html><body><h1>Hello!</h1></body></html>"
        },
        "text": {
          "type": "document",
          "value": "Hello! Welcome to our newsletter."
        }
      },
      "postal_address": "123 Main St, Minneapolis, MN 55401"
    }]
  }
EOF
```

```ruby
require "net/http"
require "json"

uri = URI("https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/broadcasts")

request = Net::HTTP::Post.new(uri)
request.basic_auth("YOUR_API_KEY", "")
request["User-Agent"] = "Your App Name (www.yourapp.com)"
request["Content-Type"] = "application/json"
request.body = {
  broadcasts: [{
    name: "December Newsletter",
    subject: "Your December Newsletter is here!",
    preheader: "See what's new this month...",
    content: {
      html: {
        type: "document",
        value: "<html><body><h1>Hello!</h1></body></html>"
      },
      text: {
        type: "document",
        value: "Hello! Welcome to our newsletter."
      }
    },
    postal_address: "123 Main St, Minneapolis, MN 55401"
  }]
}.to_json

response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
  http.request(request)
end

puts response.body
```

```javascript
const response = await fetch(
  "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/broadcasts",
  {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      "User-Agent": "Your App Name (www.yourapp.com)",
      "Authorization": "Basic " + Buffer.from("YOUR_API_KEY:").toString("base64")
    },
    body: JSON.stringify({
      broadcasts: [{
        name: "December Newsletter",
        subject: "Your December Newsletter is here!",
        preheader: "See what's new this month...",
        content: {
          html: {
            type: "document",
            value: "<html><body><h1>Hello!</h1></body></html>"
          },
          text: {
            type: "document",
            value: "Hello! Welcome to our newsletter."
          }
        },
        postal_address: "123 Main St, Minneapolis, MN 55401"
      }]
    })
  }
);

const body = await response.json();
```

> Responds with a <code>201 Created</code> and the new Single-Email Campaign if successful.
> The <code>Location</code> header contains the URL of the created record:

```json
{
  "links": { ... },
  "broadcasts": [{ ... }]
}
```

> If the request is invalid, responds with a <code>422 Unprocessable Entity</code>:

```json
{
  "errors": [{
    "code": "validation_error",
    "attribute": "subject",
    "message": "Subject is required"
  }]
}
```

Single-Email Campaigns created via the API start in the `draft` status. Scheduling and
sending are then managed through the Drip UI.

### HTTP Endpoint

`POST /v2/:account_id/broadcasts`

### Arguments

<table>
  <thead>
    <tr>
      <th>Key</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>name</code></td>
      <td>Required. The private name given to the Single-Email Campaign (255 characters maximum).</td>
    </tr>
    <tr>
      <td><code>subject</code></td>
      <td>Required. The email subject line. Supports Liquid templating.</td>
    </tr>
    <tr>
      <td><code>content</code></td>
      <td>Required. An <a href="#email-content">Email Content</a> object. At minimum, include an <code>html</code> key. Optionally include a <code>text</code> key for the plain text version; if omitted, the plain text version is generated from the HTML.</td>
    </tr>
    <tr>
      <td><code>preheader</code></td>
      <td>Optional. Preview text shown in email clients before the email is opened. Supports Liquid templating.</td>
    </tr>
    <tr>
      <td><code>postal_address</code></td>
      <td>Optional. A physical mailing address for CAN-SPAM compliance. Defaults to the account's postal address.</td>
    </tr>
  </tbody>
</table>

## Fetch a Single-Email Campaign

> To fetch a specific Single-Email Campaign:

```shell
curl "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/broadcasts/BROADCAST_ID" \
  -H "Content-Type: application/json" \
  -H 'User-Agent: Your App Name (www.yourapp.com)' \
  -u YOUR_API_KEY:
```

```ruby
require 'drip'

client = Drip::Client.new do |c|
  c.api_key = "YOUR API KEY"
  c.account_id = "YOUR_ACCOUNT_ID"
end

broadcast_id = "BROADCAST_ID"
response = client.broadcast(broadcast_id)

if response.success?
  puts response.body
end
```

```javascript
// npm install drip-nodejs --save

const client = require('drip-nodejs')({ token: YOUR_API_KEY, accountId: YOUR_ACCOUNT_ID });
const broadcastId = "BROADCAST_ID";

client.fetchBroadcast(broadcastId)
  .then((response) => {
    // Handle `response.body`
  })
  .catch((error) => {
    // Handle errors
  });
```

> The response looks like this:

```json
# The broadcasts property is an array of one broadcast object.
{
  "links": { ... },
  "broadcasts": [{ ... }]
}
```

### HTTP Endpoint

`GET /v2/:account_id/broadcasts/:broadcast_id`

### Arguments

None.

## Update a Single-Email Campaign

> To update a Single-Email Campaign:

```shell
curl -X PATCH "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/broadcasts/BROADCAST_ID" \
  -H "Content-Type: application/json" \
  -H 'User-Agent: Your App Name (www.yourapp.com)' \
  -u YOUR_API_KEY: \
  -d @- << EOF
  {
    "broadcasts": [{
      "subject": "Updated: December Newsletter!",
      "preheader": "New content inside...",
      "content": {
        "html": {
          "type": "document",
          "value": "<html><body><h1>Updated content!</h1></body></html>"
        }
      }
    }]
  }
EOF
```

```ruby
require "net/http"
require "json"

uri = URI("https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/broadcasts/BROADCAST_ID")

request = Net::HTTP::Patch.new(uri)
request.basic_auth("YOUR_API_KEY", "")
request["User-Agent"] = "Your App Name (www.yourapp.com)"
request["Content-Type"] = "application/json"
request.body = {
  broadcasts: [{
    subject: "Updated: December Newsletter!",
    preheader: "New content inside...",
    content: {
      html: {
        type: "document",
        value: "<html><body><h1>Updated content!</h1></body></html>"
      }
    }
  }]
}.to_json

response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
  http.request(request)
end

puts response.body
```

```javascript
const response = await fetch(
  "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/broadcasts/BROADCAST_ID",
  {
    method: "PATCH",
    headers: {
      "Content-Type": "application/json",
      "User-Agent": "Your App Name (www.yourapp.com)",
      "Authorization": "Basic " + Buffer.from("YOUR_API_KEY:").toString("base64")
    },
    body: JSON.stringify({
      broadcasts: [{
        subject: "Updated: December Newsletter!",
        preheader: "New content inside...",
        content: {
          html: {
            type: "document",
            value: "<html><body><h1>Updated content!</h1></body></html>"
          }
        }
      }]
    })
  }
);

const body = await response.json();
```

> Responds with a <code>200 OK</code> and the updated Single-Email Campaign if successful:

```json
{
  "links": { ... },
  "broadcasts": [{ ... }]
}
```

> If the Single-Email Campaign is not a draft, responds with a <code>409 Conflict</code>:

```json
{
  "errors": [{
    "code": "conflict_error",
    "message": "Cannot update a broadcast with status 'sent'"
  }]
}
```

Only Single-Email Campaigns in the `draft` status can be updated via the API; all other
statuses are read-only. Updates are partial: only the fields you include are changed.

Status, scheduling (`send_at`, `localize_sending_time`), and recipient segmentation cannot
be updated via the API — they are managed through the Drip UI.

### HTTP Endpoint

`PATCH /v2/:account_id/broadcasts/:broadcast_id`

### Arguments

<table>
  <thead>
    <tr>
      <th>Key</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>name</code></td>
      <td>Optional. The private name given to the Single-Email Campaign.</td>
    </tr>
    <tr>
      <td><code>subject</code></td>
      <td>Optional. The email subject line. Supports Liquid templating.</td>
    </tr>
    <tr>
      <td><code>content</code></td>
      <td>Optional. An <a href="#email-content">Email Content</a> object with <code>html</code> and/or <code>text</code> keys.</td>
    </tr>
    <tr>
      <td><code>preheader</code></td>
      <td>Optional. Preview text shown in email clients before the email is opened. Supports Liquid templating.</td>
    </tr>
    <tr>
      <td><code>postal_address</code></td>
      <td>Optional. A physical mailing address for CAN-SPAM compliance.</td>
    </tr>
  </tbody>
</table>

## Delete a Single-Email Campaign

> To delete a Single-Email Campaign:

```shell
curl -X DELETE "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/broadcasts/BROADCAST_ID" \
  -H "Content-Type: application/json" \
  -H 'User-Agent: Your App Name (www.yourapp.com)' \
  -u YOUR_API_KEY:
```

```ruby
require "net/http"

uri = URI("https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/broadcasts/BROADCAST_ID")

request = Net::HTTP::Delete.new(uri)
request.basic_auth("YOUR_API_KEY", "")
request["User-Agent"] = "Your App Name (www.yourapp.com)"

response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
  http.request(request)
end

puts response.body
```

```javascript
const response = await fetch(
  "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/broadcasts/BROADCAST_ID",
  {
    method: "DELETE",
    headers: {
      "User-Agent": "Your App Name (www.yourapp.com)",
      "Authorization": "Basic " + Buffer.from("YOUR_API_KEY:").toString("base64")
    }
  }
);

const body = await response.json();
```

> Responds with a <code>200 OK</code> and the Single-Email Campaign in the <code>deleted</code> status:

```json
{
  "links": { ... },
  "broadcasts": [{ ... }]
}
```

> If the Single-Email Campaign is currently sending, responds with a <code>409 Conflict</code>:

```json
{
  "errors": [{
    "code": "conflict_error",
    "message": "Cannot delete a broadcast that is currently sending"
  }]
}
```

Deleting is a soft delete: the Single-Email Campaign transitions to the `deleted` status and
is hidden from default listings, but historical data is preserved. Single-Email Campaigns in
the `sending` status cannot be deleted.

### HTTP Endpoint

`DELETE /v2/:account_id/broadcasts/:broadcast_id`

### Arguments

None.

## Send a test email

> To send a test email for a Single-Email Campaign:

```shell
curl -X POST "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/broadcasts/BROADCAST_ID/send_test" \
  -H "Content-Type: application/json" \
  -H 'User-Agent: Your App Name (www.yourapp.com)' \
  -u YOUR_API_KEY: \
  -d @- << EOF
  {
    "to_emails": ["team@yourverifieddomain.com"],
    "preview_as": "subscriber@example.com"
  }
EOF
```

```ruby
require "net/http"
require "json"

uri = URI("https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/broadcasts/BROADCAST_ID/send_test")

request = Net::HTTP::Post.new(uri)
request.basic_auth("YOUR_API_KEY", "")
request["User-Agent"] = "Your App Name (www.yourapp.com)"
request["Content-Type"] = "application/json"
request.body = {
  to_emails: ["team@yourverifieddomain.com"],
  preview_as: "subscriber@example.com"
}.to_json

response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
  http.request(request)
end

puts response.code
```

```javascript
const response = await fetch(
  "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/broadcasts/BROADCAST_ID/send_test",
  {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      "User-Agent": "Your App Name (www.yourapp.com)",
      "Authorization": "Basic " + Buffer.from("YOUR_API_KEY:").toString("base64")
    },
    body: JSON.stringify({
      to_emails: ["team@yourverifieddomain.com"],
      preview_as: "subscriber@example.com"
    })
  }
);

// 204 No Content on success
```

> Responds with a <code>204 No Content</code> if successful.

> If a recipient is not allowed, responds with a <code>422 Unprocessable Entity</code>:

```json
{
  "errors": [{
    "code": "validation_error",
    "attribute": "to_emails",
    "message": "test@unknown-domain.com is not a verified domain or active account member"
  }]
}
```

> If a rate limit is exceeded, responds with a <code>429 Too Many Requests</code> and a
> <code>Retry-After</code> header indicating when the limit resets:

```json
{
  "errors": [{
    "code": "rate_limit_error",
    "message": "Hourly test email limit exceeded. Maximum 20 requests per hour."
  }]
}
```

Sends a test email so you can preview how the Single-Email Campaign will appear to
recipients. Test emails are marked with a "[TEST]" prefix in the from name, and any
links that would trigger automations are stripped for safety. If sending is blocked
on the account (for example, during a trial), tests are only delivered to the
authenticated user.

### Recipient validation

Each recipient email address must satisfy **one** of the following requirements:

1. **Verified domain**: the email's domain is a verified sending domain in the account
   (e.g., if `example.com` is verified, `anyone@example.com` is allowed).
2. **Active account member**: the email belongs to an active member of the account.

Recipients that do not meet either requirement are rejected with a `422` validation error.

### Rate limits

Rate limits are applied per user.

<table>
  <thead>
    <tr>
      <th>Limit</th>
      <th>Window</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>5 recipients</td>
      <td>Per request</td>
    </tr>
    <tr>
      <td>20 requests</td>
      <td>Per hour</td>
    </tr>
    <tr>
      <td>40 requests</td>
      <td>Per day</td>
    </tr>
  </tbody>
</table>

### HTTP Endpoint

`POST /v2/:account_id/broadcasts/:broadcast_id/send_test`

### Arguments

<table>
  <thead>
    <tr>
      <th>Key</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>to_emails</code></td>
      <td>Required. An array of 1 to 5 email addresses to send the test to. See recipient validation above.</td>
    </tr>
    <tr>
      <td><code>preview_as</code></td>
      <td>Optional. The email address of an existing subscriber to use for Liquid template rendering. The test email is personalized as if sent to this subscriber, using their custom fields and tags. If omitted, Liquid variables use placeholder values.</td>
    </tr>
  </tbody>
</table>
