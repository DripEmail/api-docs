# Tags

## List all tags used in an account

> To list all tags:

```shell
curl "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/tags" \
  -H 'User-Agent: Your App Name (www.yourapp.com)' \
  -u YOUR_API_KEY:
```

```ruby
require 'drip'

client = Drip::Client.new do |c|
  c.api_key = "YOUR API KEY"
  c.account_id = "YOUR_ACCOUNT_ID"
end

response = client.tags

if response.success?
  puts response.body["tags"]
end
```

```javascript
// npm install drip-nodejs --save

const client = require('drip-nodejs')({ token: YOUR_API_KEY, accountId: YOUR_ACCOUNT_ID });

client.listAllTags()
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
  "tags": [
    "Customer",
    "SEO"
  ]
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
      <td><code>email</code></td>
      <td>The subscriber's email address.</td>
    </tr>
    <tr>
      <td><code>tag</code></td>
      <td>The String tag to apply. E.g. "Customer".</td>
    </tr>
  </tbody>
</table>

### HTTP Endpoint

`GET /v2/:account_id/tags`

### Arguments

None.

## Apply a tag to a subscriber

> To apply a tag to a specific subscriber:

```shell
curl -X POST "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/tags" \
  -H "Content-Type: application/json" \
  -H 'User-Agent: Your App Name (www.yourapp.com)' \
  -u YOUR_API_KEY: \
  -d @- << EOF
  {
    "tags": [{
      "email": "john@acme.com",
      "tag": "Customer"
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

subscriber_email = "john@acme.com"
tag = "Customer"

response = client.apply_tag(subscriber_email, tag)

if response.success?
  # ...
end
```

```javascript
// npm install drip-nodejs --save

const client = require('drip-nodejs')({ token: YOUR_API_KEY, accountId: YOUR_ACCOUNT_ID });
const payload = {
  tags: [{
    email: "john@acme.com",
    tag: "Customer"
  }]
};

client.tagSubscriber(payload)
  .then((response) => {
    // Handle `response.body`
  })
  .catch((error) => {
    // Handle errors
  });
```

> Responds with a `201 Created` and an empty JSON response:

```json
{}
```

### HTTP Endpoint

`POST /v2/:account_id/tags`

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
      <td>The subscriber's email address.</td>
    </tr>
    <tr>
      <td><code>tag</code></td>
      <td>The String tag to apply. E.g. "Customer"</td>
    </tr>
  </tbody>
</table>

## Remove a tag from a subscriber

> To apply a tag to a specific subscriber:

```shell
curl -X DELETE "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/subscribers/ID_OR_EMAIL/tags/TAG" \
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

subscriber_email = "john@acme.com"
tag = "Customer"

response = client.remove_tag(subscriber_email, tag)

if response.success?
  # ...
end
```

```javascript
// npm install drip-nodejs --save

const client = require('drip-nodejs')({ token: YOUR_API_KEY, accountId: YOUR_ACCOUNT_ID });
const email = "john@acme.com";
const tag = "Customer";

client.removeSubscriberTag(email, tag)
  .then((response) => {
    // Handle `response.body`
  })
  .catch((error) => {
    // Handle errors
  });
```

> Responds with a `204 No Content` if successful.

### HTTP Endpoint

`DELETE /:account_id/subscribers/:email/tags/:tag`

### Arguments

None.
