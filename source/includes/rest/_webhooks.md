# Webhooks

> Webhooks are represented as follows:

```json
{
  "id": "77777",
  "href": "https://api.getdrip.com/v2/9999999/webhooks/77777",
  "post_url": "http://www.mysite.com/my-webhook-endpoint",
  "version": "1",
  "include_received_email": false,
  "events": [
    "subscriber.created",
    "subscriber.subscribed_to_campaign"
  ],
  "created_at": "2013-06-21T10:31:58Z",
  "links": {
    "account": "9999999",
  }
}
```

> All responses containing webhook data also include the following top-level link data:

```json
{
  "links": {
    "webhooks.account": "https://api.getdrip.com/v2/accounts/{webhooks.account}"
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
      <td>A read-only Drip generated unique id used to identify each webhook record.</td>
    </tr>
    <tr>
      <td><code>href</code></td>
      <td>The url designated for retrieving the webhook record via the REST API.</td>
    </tr>
    <tr>
      <td><code>post_url</code></td>
      <td>The url that the webhook will post to.</td>
    </tr>
    <tr>
      <td><code>version</code></td>
      <td>The webhook version. The current stable version is 2.</td>
    </tr>
    <tr>
      <td><code>include_received_email</code></td>
      <td>Returns true if a notification is sent whenever a subscriber receives an email.</td>
    </tr>
    <tr>
      <td><code>created_at</code></td>
      <td>A timestamp representing when the webhook record was first created.</td>
    </tr>
     <tr>
      <td><code>events</code></td>
      <td>An array specifying which events are enabled for webhook notifications.</td>
    </tr>
     <tr>
      <td><code>links</code></td>
      <td>An object containing the REST API URL for the account.</td>
    </tr>
  </tbody>
</table>

## List all webhooks

> To list all webhooks in an account:

```shell
curl "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/webhooks" \
  -H 'User-Agent: Your App Name (www.yourapp.com)' \
  -u YOUR_API_KEY:
```

```ruby
require 'drip'

client = Drip::Client.new do |c|
  c.api_key = "YOUR API KEY"
  c.account_id = "YOUR_ACCOUNT_ID"
end

response = client.webhooks

if response.success?
  puts response.body["webhooks"]
end
```

```javascript
// npm install drip-nodejs --save

const client = require('drip-nodejs')({ token: YOUR_API_KEY, accountId: YOUR_ACCOUNT_ID });

client.listWebhooks()
  .then((response) => {
    // Handle `response.body`
  })
  .catch((error) => {
    // Handle errors
  });
```

> The response looks like this:

```json
# The webhooks property is an array of webhook objects.
{
  "links": { ... },
  "webhooks": [ ... ]
}
```

### HTTP Endpoint

`GET /v2/:account_id/webhooks`

### Arguments

None.

## Fetch a webhook

> To fetch a specific webhook:

```shell
curl "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/webhooks/WEBHOOK_ID" \
  -H 'User-Agent: Your App Name (www.yourapp.com)' \
  -u YOUR_API_KEY:
```

```ruby
require 'drip'

client = Drip::Client.new do |c|
  c.api_key = "YOUR API KEY"
  c.account_id = "YOUR_ACCOUNT_ID"
end

webhook_id = 999999
response = client.webhook(webhook_id)

if response.success?
  puts response.body["webhooks"]
end
```

```javascript
// npm install drip-nodejs --save

const client = require('drip-nodejs')({ token: YOUR_API_KEY, accountId: YOUR_ACCOUNT_ID });
const webhookId = 111222;

client.fetchWebhook(webhookId)
  .then((response) => {
    // Handle `response.body`
  })
  .catch((error) => {
    // Handle errors
  });
```

> The response looks like this:

```json
# The webhooks property is an array of one webhook object.
{
  "links": { ... },
  "webhooks": [{ ... }]
}
```

### HTTP Endpoint

`GET /v2/:account_id/webhooks/:webhook_id`

### Arguments

None.

## Create a new webhook

> To create a webhook:

```shell
curl -X POST "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/webhooks" \
  -H 'User-Agent: Your App Name (www.yourapp.com)' \
  -u YOUR_API_KEY: \
  -d @- << EOF
  {
    "webhooks": [{
      "post_url": "http://www.mysite.com/my-webhook-endpoint",
      "events": [
        "subscriber.created",
        "subscriber.subscribed_to_campaign"
      ]
    }]
  }
EOF
```

```ruby
require 'drip'

client = Drip::Client.new do |c|
  c.api_key = "YOUR API KEY"
  c.account_id = "YOUR_ACCOUNT_ID"
end

pot_url = "https://www.mylistener.com/receieve"
include_received_email = false
events = [
  "subscriber.created",
  "subscriber.subscribed_to_campaign"
]

response = client.create_webhook(post_url, include_received_email, events)

if response.success?
  puts response.body["webhooks"]
end
```

```javascript
// npm install drip-nodejs --save

const client = require('drip-nodejs')({ token: YOUR_API_KEY, accountId: YOUR_ACCOUNT_ID });
const payload = {
  webhooks: [{
    post_url: "http://www.mysite.com/my-webhook-endpoint",
    events: [
      "subscriber.created",
      "subscriber.subscribed_to_campaign"
    ]
  }]
}

client.createWebhook(payload)
  .then((response) => {
    // Handle `response.body`
  })
  .catch((error) => {
    // Handle errors
  });
```

> Responds with a `201 Created` like this:

```json
{
  "links": { ... },
  "webhooks": [{
    "id": "77777",
    "href": "https://api.getdrip.com/v2/9999999/webhooks/77777",
    "post_url": "http://www.example.com/api/v2/form",
    "version": "1",
    "include_received_email": false,
    "events": [
      "subscriber.created",
      "subscriber.subscribed_to_campaign"
    ],
    "created_at": "2013-06-21T10:31:58Z",
    "links": {
      "account": "9999999",
    }
  }]
}
```

### HTTP Endpoint

`POST /v2/:account_id/webhooks`

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
      <td><code>post_url</code></td>
      <td>The url that the webhook will post to.</td>
    </tr>
    <tr>
      <td><code>include_received_email</code></td>
      <td>Optional. A Boolean specifying whether we should send a notification whenever a subscriber receives an email. Defaults to <code>false</code>.</td>
    </tr>
    <tr>
      <td><code>events</code></td>
      <td>Optional. An Array specifiying which events we should send notifications for. Eligible events can be found in the <a href="#webhook-events">webhooks documentation</a>. By default, we will send notifications for all events except <code>subscrber.received_email</code>.</td>
    </tr>
  </tbody>
</table>

## Destroy a webhook

> To destroy an existing webhook:

```shell
curl -X DELETE "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/webhooks/WEBHOOK_ID" \
  -H 'User-Agent: Your App Name (www.yourapp.com)' \
  -u YOUR_API_KEY:
```

```ruby
require 'drip'

client = Drip::Client.new do |c|
  c.api_key = "YOUR API KEY"
  c.account_id = "YOUR_ACCOUNT_ID"
end

webhook_id = 999999
response = client.delete_webhook(webhook_id)

if response.success?
  # ...
end
```

```javascript
// npm install drip-nodejs --save

const client = require('drip-nodejs')({ token: YOUR_API_KEY, accountId: YOUR_ACCOUNT_ID });
const webhookId = 111222;

client.destroyWebhook(webhookId)
  .then((response) => {
    // Handle `response.body`
  })
  .catch((error) => {
    // Handle errors
  });
```

> Responds with a `204 No Content` if successful.

### HTTP Endpoint

`DELETE /v2/:account_id/webhooks/:webhook_id`

### Arguments

None.
