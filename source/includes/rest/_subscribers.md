# Subscribers

> Subscribers are represented as follows:

```json
{
  "id": "z1togz2hcjrkpp5treip",
  "status": "active",
  "email": "john@acme.com",
  "first_name": "John",
  "last_name": "Doe",
  "address1": "123 Main St.",
  "address2": "Suite 200",
  "city": "Los Angeles",
  "state": "CA",
  "zip": "90210",
  "country": "US",
  "phone": "555-555-5555",
  "sms_phone_number": "+16125551212",
  "sms_consent": true,
  "eu_consent": "granted",
  "time_zone": "America/Los_Angeles",
  "utc_offset": -440,
  "visitor_uuid": "sa8f7sdf78sdsdahf788d7asf8sd",
  "custom_fields": {
    "shirt_size": "Medium"
  },
  "tags": ["Customer", "SEO"],
  "ip_address": "111.111.111.11",
  "user_agent": "Chrome/36.0.1985.143",
  "original_referrer": "http://www.getdrip.com",
  "landing_url": "https://www.getdrip.com/docs/rest-api",
  "prospect": true,
  "lead_score": 72,
  "lifetime_value": 10000,
  "created_at": "2013-06-21T10:31:58Z",
  "href": "https://api.getdrip.com/v2/9999999/subscribers/12345",
  "user_id": "12345",
  "base_lead_score": 30,
  "links": {
    "account": "9999999"
  }
}
```

> All responses containing subscriber data also include the following top-level link data:

```json
{
  "links": {
    "subscribers.account": "https://api.getdrip.com/v2/accounts/{subscribers.account}"
  }
}
```

On January 7, 2019 we renamed Subscribers to People to better represent who you’re talking to. Right now this is a small wording change but represents something bigger in the way we all think about our customers. To keep things simple nothing in the API is changing at the moment. There is no need to update existing integrations, for new ones continue to reference the developer docs as outlined here.

**Note:** All subscriber API endpoints only work with your <a href="https://www.drip.com/learn/docs/manual/people/active" target="_blank">active</a> people. Attempting to modify or delete an <a href="https://www.drip.com/learn/docs/manual/people/inactive" target="_blank">inactive</a> person will result in an error.

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
      <td>A read-only Drip generated unique id used to identify each subscriber record.</td>
    </tr>
    <tr>
      <td><code>status</code></td>
      <td>The subscriber's status whether <code>active</code> or <code>unsubscribed</code>.</td>
    </tr>
    <tr>
      <td><code>initial_status</code></td>
      <td>The subscriber's known status whether <code>active</code> or <code>unsubscribed</code>. To be used instead of <code>status</code> if subscriber's status is unchanged.</td>
    </tr>
    <tr>
      <td><code>email</code></td>
      <td>The subscriber's email address.</td>
    </tr>
    <tr>
      <td><code>first_name</code></td>
      <td>The subscriber's first name.</td>
    </tr>
    <tr>
      <td><code>last_name</code></td>
      <td>The subscriber's last name.</td>
    </tr>
    <tr>
      <td><code>address1</code></td>
      <td>The subscriber's mailing address.</td>
    </tr>
    <tr>
      <td><code>address2</code></td>
      <td>An additional field for the subscriber's mailing address.</td>
    </tr>
    <tr>
      <td><code>city</code></td>
      <td>The city, town, or village in which the subscriber resides.</td>
    </tr>
    <tr>
      <td><code>state</code></td>
      <td>The region in which the subscriber resides. Typically a province, a state, or a prefecture.</td>
    </tr>
    <tr>
      <td><code>zip</code></td>
      <td>The postal code in which the subscriber resides, also known as zip, postcode, Eircode, etc.</td>
    </tr>
    <tr>
      <td><code>country</code></td>
      <td>The country in which the subscriber resides.</td>
    </tr>
    <tr>
      <td><code>phone</code></td>
      <td>The subscriber's primary phone number.</td>
    </tr>
    <tr>
      <td><code>sms_phone_number</code></td>
      <td>The subscriber's mobile phone number in E.164 formatting.</td>
    </tr>
    <tr>
      <td><code>sms_consent</code></td>
      <td>A boolean describing whether the person has granted consent to receive marketing and other communication via SMS.</td>
    </tr>
    <tr>
      <td><code>eu_consent</code></td>
      <td>A string describing whether the subscriber GDPR consent is <code>granted</code>, <code>denied</code>, or <code>unknown</code>.</td>
    </tr>
    <tr>
      <td><code>time_zone</code></td>
      <td>The subscriber's time zone (in Olson format).</td>
    </tr>
    <tr>
      <td><code>utc_offset</code></td>
      <td>The UTC offset in minutes relative to UTC/GMT.</td>
    </tr>
    <tr>
      <td><code>visitor_uuid</code></td>
      <td>A read-only Drip generated unique id used to identify each subscriber's visitor record if available.</td>
    </tr>
    <tr>
      <td><code>custom_fields</code></td>
      <td>An Object containing custom field data. E.g. <code>{ "shirt_size": "Medium" }</code>.</td>
    </tr>
    <tr>
      <td><code>tags</code></td>
      <td>An Array containing one or more tags. E.g. <code>["Customer", "SEO"]</code>.</td>
    </tr>
    <tr>
      <td><code>ip_address</code></td>
      <td>The subscriber's IP address if available.</td>
    </tr>
    <tr>
      <td><code>user_agent</code></td>
      <td>The subscriber's browser User Agent if available.</td>
    </tr>
    <tr>
      <td><code>original_referrer</code></td>
      <td>The initial referral URL when the subscriber first visited your site if available.</td>
    </tr>
    <tr>
      <td><code>landing_url</code></td>
      <td>The first page visited by the subscriber if available.</td>
    </tr>
    <tr>
      <td><code>prospect</code></td>
      <td>Returns true if the subscriber is marked as a lead.</td>
    </tr>
    <tr>
      <td><code>lead_score</code></td>
      <td>The subscriber's lead score.</td>
    </tr>
    <tr>
      <td><code>lifetime_value</code></td>
      <td>The subscriber's lifetime value in cents.</td>
    </tr>
    <tr>
      <td><code>created_at</code></td>
      <td>A timestamp representing when the subscriber record was first created.</td>
    </tr>
    <tr>
      <td><code>href</code></td>
      <td>The url designated for retrieving the subscriber record via the REST API.</td>
    </tr>
    <tr>
      <td><code>user_id</code></td>
      <td>A unique identifier for the user in your database, such as a primary key.</td>
    </tr>
    <tr>
      <td><code>base_lead_score</code></td>
      <td>An Integer specifying the starting value for lead score calculation for this subscriber. Defaults to <code>30</code>.</td>
    </tr>
    <tr>
      <td><code>links</code></td>
      <td>An object containing the REST API URL for the account.</td>
    </tr>
  </tbody>
</table>


## Create or update a subscriber

> To create or update a subscriber:

```shell
curl -X POST "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/subscribers" \
-H 'User-Agent: Your App Name (www.yourapp.com)' \
-H 'Content-Type: application/json' \
-u YOUR_API_KEY: \
-d @- << EOF
{
  "subscribers": [{
    "email": "john@acme.com",
    "time_zone": "America/Los_Angeles",
    "custom_fields": {
      "shirt_size": "Medium"
    }
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
options = {
  time_zone: "America/Los_Angeles",
  custom_fields: {
    shirt_size: "Medium"
  }
}

response = client.create_or_update_subscriber(subscriber_email, options)

if response.success?
  puts response.body["subscribers"]
end
```

```javascript
// npm install drip-nodejs --save

const client = require('drip-nodejs')({ token: YOUR_API_KEY, accountId: YOUR_ACCOUNT_ID });
const payload = {
  subscribers: [{
    email: "john@acme.com",
    time_zone: "America/Los_Angeles",
    custom_fields: {
      shirt_size: "Medium"
    }
  }]
};

client.createUpdateSubscriber(payload)
  .then((response) => {
    // Handle `response.body`
  })
  .catch((error) => {
    // Handle errors
  });
```

> The response looks like this:

```json
# The subscribers property is an array of one object.
{
  "links": { ... },
  "subscribers": [{ ... }]
}
```

### HTTP Endpoint

`POST /v2/:account_id/subscribers`

If you need to create or update a collection of subscribers at once, use our [batch API](/) instead.

**Note:** Concurrently updating the same subscriber via multiple API calls is not supported and will fail with a rate limit error and the message "Too many concurrent requests for the same subscriber". You should retry the call after a short wait period to let the other requests to the same subscriber complete. Triggering this rate limit does not mean you've consumed your overall API rate limited capacity.

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
      <td>Optional. The subscriber's email address. Either <code>email</code> or <code>id</code> or <code>visitor_uuid</code> must be included.</td>
    </tr>
    <tr>
      <td><code>id</code></td>
      <td>Optional. The subscriber's Drip <code>id</code>. Either <code>email</code> or <code>id</code> or <code>visitor_uuid</code> must be included.</td>
    </tr>
    <tr>
      <td><code>visitor_uuid</code></td>
      <td>Optional. The <code>uuid</code> for a subscriber's visitor record. Either <code>email</code> or <code>id</code> or <code>visitor_uuid</code> must be included.</td>
    </tr>
    <tr>
      <td><code>new_email</code></td>
      <td>Optional. A new email address for the subscriber. If provided and a subscriber with the <code>email</code> above does not exist, this address will be used to create a new subscriber.</td>
    </tr>
    <tr>
      <td><code>first_name</code></td>
      <td>Optional. The subscriber's first name.</td>
    </tr>
    <tr>
      <td><code>last_name</code></td>
      <td>Optional. The subscriber's last name.</td>
    </tr>
    <tr>
      <td><code>address1</code></td>
      <td>Optional. The subscriber's mailing address.</td>
    </tr>
    <tr>
      <td><code>address2</code></td>
      <td>Optional. An additional field for the subscriber's mailing address.</td>
    </tr>
    <tr>
      <td><code>city</code></td>
      <td>Optional. The city, town, or village in which the subscriber resides.</td>
    </tr>
    <tr>
      <td><code>state</code></td>
      <td>Optional. The region in which the subscriber resides. Typically a province, a state, or a prefecture.</td>
    </tr>
    <tr>
      <td><code>zip</code></td>
      <td>Optional. The postal code in which the subscriber resides, also known as zip, postcode, Eircode, etc.</td>
    </tr>
    <tr>
      <td><code>country</code></td>
      <td>Optional. The country in which the subscriber resides.</td>
    </tr>
    <tr>
      <td><code>phone</code></td>
      <td>Optional. The subscriber's primary phone number.</td>
    </tr>
    <tr>
      <td><code>sms_phone_number</code></td>
      <td>Optional. String. The subscriber's mobile phone number in E.164 formatting. E.g. <code>"+16125551212"</code>. Only US-based numbers are supported at this time.</td>
    </tr>
    <tr>
      <td><code>sms_consent</code></td>
      <td>Optional. Boolean. Required if <code>sms_phone_number</code> is not <code>nil</code>. <code>true</code> if the person has granted consent to receive marketing and other communication via SMS; <code>false</code> otherwise. If you’re unsure whether or not you have gained legal SMS consent, check out our <a href="https://my.drip.com/docs/manual/sms/compliance-manage-sms-compliance">TCPA requirements article</a>.</td>
    </tr>
    <tr>
      <td><code>user_id</code></td>
      <td>Optional. A unique identifier for the user in your database, such as a primary key.</td>
    </tr>
    <tr>
      <td><code>time_zone</code></td>
      <td>Optional. The subscriber's time zone (in Olson format). Defaults to <code>Etc/UTC</code></td>
    </tr>
    <tr>
      <td><code>lifetime_value</code></td>
      <td>Optional. The lifetime value of the subscriber (in cents).</td>
    </tr>
    <tr>
      <td><code>ip_address</code></td>
      <td>Optional. The subscriber's ip address E.g. <code>"111.111.111.11"</code></td>
    </tr>
    <tr>
      <td><code>custom_fields</code></td>
      <td>Optional. An Object containing custom field data. E.g. <code>{ "shirt_size": "Medium" }</code>.</td>
    </tr>
    <tr>
      <td><code>tags</code></td>
      <td>Optional. An Array containing one or more tags. E.g. <code>["Customer", "SEO"]</code>.</td>
    </tr>
    <tr>
      <td><code>remove_tags</code></td>
      <td>Optional. An Array containing one or more tags to be removed from the subscriber. E.g. <code>["Customer", "SEO"]</code>.</td>
    </tr>
    <tr>
      <td><code>prospect</code></td>
      <td>Optional. A Boolean specifiying whether we should attach a lead score to the subscriber (when lead scoring is enabled). Defaults to <code>true</code>.
        <strong>Note:</strong> This flag used to be called <code>potential_lead</code>, which we will continue to accept for backwards compatibility.</td>
    </tr>
    <tr>
      <td><code>base_lead_score</code></td>
      <td>Optional. An Integer specifying the starting value for lead score calculation for this subscriber. Defaults to <code>30</code>.</td>
    </tr>
    <tr>
      <td><code>eu_consent</code></td>
      <td>Optional. A String specifying whether the subscriber <code>granted</code> or <code>denied</code> GDPR consent.</td>
    </tr>
    <tr>
      <td><code>eu_consent_message</code></td>
      <td>Optional. A String containing the message the subscriber granted or denied their consent to.</td>
    </tr>
    <tr>
      <td><code>status</code></td>
      <td>Optional. A String specifying the subscriber's status: either <code>active</code> or <code>unsubscribed</code>.</td>
    </tr>
    <tr>
      <td><code>initial_status</code></td>
      <td>Optional. A String specifying the subscriber's known status: either <code>active</code> or <code>unsubscribed</code>. To be used if subscriber's status is unchanged.</td>
    </tr>
  </tbody>
</table>


## List all subscribers

> To list subscribers:

```shell
curl "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/subscribers" \
  -H 'User-Agent: Your App Name (www.yourapp.com)' \
  -u YOUR_API_KEY:
```

```ruby
require 'drip'

client = Drip::Client.new do |c|
  c.api_key = "YOUR API KEY"
  c.account_id = "YOUR_ACCOUNT_ID"
end

response = client.subscribers

if response.success?
  puts response.body["subscribers"]
end
```

```javascript
// npm install drip-nodejs --save

const client = require('drip-nodejs')({ token: YOUR_API_KEY, accountId: YOUR_ACCOUNT_ID });
const options = { status: "active", subscribed_before: "2017-01-01T00:00:00Z" };

client.listSubscribers(options)
  .then((response) => {
    // Handle `response.body`
  })
  .catch((error) => {
    // Handle errors
  });
```

> The response looks like this:

```json
# The subscribers property is an array subscriber objects.
# The meta property contains pagination information.
{
  "links": { ... },
  "meta": {
    "page": 1,
    "count": 5,
    "total_pages": 1,
    "total_count": 5
  },
  "subscribers": [{ ... }]
}
```

### HTTP Endpoint

`GET /v2/:account_id/subscribers`

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
      <td><code>status</code></td>
      <td>Optional. Filter by one of the following statuses: <code>all</code>, <code>active</code>, <code>unsubscribed</code>, <code>active_or_unsubscribed</code> or <code>undeliverable</code>. Defaults to <code>active</code>.</td>
    </tr>

    <tr>
      <td><code>tags</code></td>
      <td>Optional. A comma separated list of tags. When included, returns only subscribers who have at least one of the listed tags.</td>
    </tr>

    <tr>
      <td><code>subscribed_before</code></td>
      <td>Optional. A <a href="http://en.wikipedia.org/wiki/ISO_8601">ISO-8601</a> datetime. When included, returns only subscribers who were created before the date. Eg. <code>"2017-01-01T00:00:00Z"</code></td>
    </tr>

    <tr>
      <td><code>subscribed_after</code></td>
      <td>Optional. A <a href="http://en.wikipedia.org/wiki/ISO_8601">ISO-8601</a> datetime. When included, returns only subscribers who were created after the date. Eg. <code>"2016-01-01T00:00:00Z"</code></td>
    </tr>

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

## Fetch a subscriber

> To fetch a subscriber:

```shell
curl "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/subscribers/ID_OR_EMAIL_OR_VISITOR_UUID" \
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

response = client.subscriber(subscriber_email)

if response.success?
  puts response.body["subscribers"]
end
```

```javascript
// npm install drip-nodejs --save

const client = require('drip-nodejs')({ token: YOUR_API_KEY, accountId: YOUR_ACCOUNT_ID });
const idOrEmail = "someone@example.com";

client.fetchSubscriber(idOrEmail)
  .then((response) => {
    // Handle `response.body`
  })
  .catch((error) => {
    // Handle errors
  });
```

> The response looks like this:

```json
# The subscribers property is an array of one object.
{
  "links": { ... },
  "subscribers": [{ ... }]
}
```

### HTTP Endpoint

`GET /v2/:account_id/subscribers/:id_or_email_or_visitor_uuid`

### Arguments

None.

## Remove a subscriber from one or all Email Series Campaigns

> To remove a subscriber from all Email Series s:

```shell
curl -X POST "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/subscribers/ID_OR_EMAIL/remove" \
  -H 'User-Agent: Your App Name (www.yourapp.com)' \
  -u YOUR_API_KEY:
```

```ruby
##
# To remove a subscriber from all Email Series Campaigns:
##

require 'drip'

client = Drip::Client.new do |c|
  c.api_key = "YOUR API KEY"
  c.account_id = "YOUR_ACCOUNT_ID"
end

subscriber_email = "john@acme.com"
response = client.unsubscribe(subscriber_email)

if response.success?
  puts response.body["subscribers"]
end

##
# To remove a subscriber from a specific campaign:
##

subscriber_email = "john@acme.com"
options = {
  campaign_id: 9999999
}

response = client.unsubscribe(subscriber_email, options)

if response.success?
  puts response.body["subscribers"]
end
```

```javascript
// npm install drip-nodejs --save

const client = require('drip-nodejs')({ token: YOUR_API_KEY, accountId: YOUR_ACCOUNT_ID });
const idOrEmail = "someone@example.com";
const campaignId = 9998888;

client.unsubscribeFromCampaign(idOrEmail, campaignId)
  .then((response) => {
    // Handle `response.body`
  })
  .catch((error) => {
    // Handle errors
  });
```

> To remove a subscriber from a specific campaign:

```shell
curl -X POST "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/subscribers/ID_OR_EMAIL/remove?campaign_id=CAMPAIGN_ID" \
  -H 'User-Agent: Your App Name (www.yourapp.com)' \
  -u YOUR_API_KEY:
```

> The response looks like this:

```json
# The subscribers property is an array of one object.
{
  "links": { ... },
  "subscribers": [{ ... }]
}
```

### HTTP Endpoint

`POST /v2/:account_id/subscribers/:id_or_email/remove`

This endpoint was previously labeled `unsubscribe`.

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
      <td><code>campaign_id</code></td>
      <td>Optional. The Email Series Campaign from which to remove the subscriber. Defaults to all.</td>
    </tr>
  </tbody>
</table>

## Unsubscribe from all mailings

> To unsubscribe a subscriber from all mailings:

```shell
curl -X POST "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/subscribers/ID_OR_EMAIL/unsubscribe_all" \
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
response = client.unsubscribe_from_all(subscriber_email)

if response.success?
  puts response.body["subscribers"]
end
```

```javascript
// npm install drip-nodejs --save

const client = require('drip-nodejs')({ token: YOUR_API_KEY, accountId: YOUR_ACCOUNT_ID });
const idOrEmail = "someone@example.com";

client.unsubscribeFromAllMailings(idOrEmail)
  .then((response) => {
    // Handle `response.body`
  })
  .catch((error) => {
    // Handle errors
  });
```

> The response looks like this:

```json
# The subscribers property is an array of one object.
{
  "links": { ... },
  "subscribers": [{ ... }]
}
```

### HTTP Endpoint

`POST /v2/:account_id/subscribers/:id_or_email/unsubscribe_all`

### Arguments

None.

## Delete a subscriber

> To delete a subscriber:

```shell
curl -X DELETE "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/subscribers/ID_OR_EMAIL" \
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
response = client.delete_subscriber(subscriber_email)

if response.success?
  # ...
end
```

```javascript
// npm install drip-nodejs --save

const client = require('drip-nodejs')({ token: YOUR_API_KEY, accountId: YOUR_ACCOUNT_ID });
const idOrEmail = "someone@example.com";

client.deleteSubscriber(idOrEmail)
  .then((response) => {
    // Handle `response.body`
  })
  .catch((error) => {
    // Handle errors
  });
```

> Responds with `204 No Content` if successful.

### HTTP Endpoint

`DELETE /:account_id/subscribers/:id_or_email`

### Arguments

None.
