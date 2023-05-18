# Events

## Record an event

> To create or update a subscriber:

```shell
curl -X POST "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/events" \
  -H "Content-Type: application/json" \
  -H 'User-Agent: Your App Name (www.yourapp.com)' \
  -u YOUR_API_KEY: \
  -d @- << EOF
  {
    "email": "john@acme.com",
    "action": "Logged in",
    "properties": {
      "affiliate_code": "XYZ"
    },
    "occurred_at": "2014-03-22T03:00:00Z"
  }
EOF
```

```ruby
require 'drip'

client = Drip::Client.new do |c|
  c.api_key = "YOUR API KEY"
  c.account_id = "YOUR_ACCOUNT_ID"
end

email = "someone@example.com"
action = "Docked with space station"
properties = {
  station: "Mars Endeavor"
}

response = client.track_event(email, action, properties)

if response.success?
  # ...
end
```

```javascript
// npm install drip-nodejs --save

const client = require('drip-nodejs')({ token: YOUR_API_KEY, accountId: YOUR_ACCOUNT_ID });
const payload = {
  email: "john@acme.com",
  action: "Logged in",
  properties: {
    affiliate_code: "XYZ"
  }
};

client.recordEvent(payload)
  .then((response) => {
    // Handle `response.body`
  })
  .catch((error) => {
    // Handle errors
  });
```

> Responds with a `204 No Content` if successful.

If you need to create or update a collection of events at once, use the Batch API instead.

### HTTP Endpoint

`POST /v2/:account_id/events`

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
      <td><code>email</code></td>
      <td>Optional. The subscriber's email address. Either <code>email</code> or <code>id</code> must be included.</td>
    </tr>
    <tr>
      <td><code>id</code></td>
      <td>Optional. The subscriber's Drip <code>id</code>. Either <code>email</code> or <code>id</code> must be included.</td>
    </tr>
    <tr>
      <td><code>action</code></td>
      <td>Required. The name of the action taken. E.g. "Logged in"</td>
    </tr>
    <tr>
      <td><code>prospect</code></td>
      <td>Optional. A Boolean specifiying whether we should attach a lead score to the subscriber (when lead scoring is enabled). Defaults to <code>true</code>.
        <strong>Note:</strong> This flag used to be called <code>potential_lead</code>, which we will continue to accept for backwards compatibility.</td>
    </tr>
    <tr>
      <td><code>properties</code></td>
      <td>Optional. An Object containing custom event properties. If this event is a conversion, include the value (in cents) in the in the properties with a <code>value</code> key.
      Conversion values must be less than 2,147,483,647.
      </td>
    </tr>
    <tr>
      <td><code>occurred_at</code></td>
      <td>Optional. The String time at which the event occurred in <a href="http://en.wikipedia.org/wiki/ISO_8601">ISO-8601</a> format. Defaults to the current time.</td>
    </tr>
  </tbody>
</table>

## List all custom events actions used in an account

> To list custom event actions:

```shell
curl "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/event_actions" \
  -H 'User-Agent: Your App Name (www.yourapp.com)' \
  -u YOUR_API_KEY:
```

```ruby
require 'drip'

client = Drip::Client.new do |c|
  c.api_key = "YOUR API KEY"
  c.account_id = "YOUR_ACCOUNT_ID"
end

response = client.event_actions

if response.success?
  puts response["event_actions"]
end
```

```javascript
// npm install drip-nodejs --save

const client = require('drip-nodejs')({ token: YOUR_API_KEY, accountId: YOUR_ACCOUNT_ID });
const options = { per_page: 200 };

client.listEventActions(options)
  .then((response) => {
    // Handle `response.body`
  })
  .catch((error) => {
    // Handle errors
  });
```

> The response looks like this:

```json
{
  "meta": {
    "count": 2,
    "page": 1,
    "total_count": 2,
    "total_pages": 1
  },
  "event_actions": [
    "Ate a sandwich",
    "Started a trial"
  ]
}
```

### HTTP Endpoint

`GET /v2/:account_id/event_actions`

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
      <td>Optional. The page number. Defaults to <code>1</code>.</td>
    </tr>

    <tr>
      <td><code>per_page</code></td>
      <td>Optional. The number of records to be returned on each page. Defaults to <code>100</code>. Maximum <code>1000</code>.</td>
    </tr>
  </tbody>
</table>
