# Email Series Campaigns

> Email Series Campaigns are represented as follows:

```json
{
  "id": "123456",
  "status": "active",
  "name": "SEO Email Course",
  "from_name": "John Doe",
  "from_email": "john@example.com",
  "postal_address": "123 Anywhere St\nFresno, CA 99999",
  "minutes_from_midnight": 440,
  "localize_sending_time": true,
  "days_of_the_week_mask": "0111110",
  "start_immediately": true,
  "double_optin": true,
  "send_to_confirmation_page": false,
  "use_custom_confirmation_page": false,
  "confirmation_url": null,
  "notify_subscribe_email": "derrick@getdrip.com",
  "notify_unsubscribe_email": "derrick@getdrip.com",
  "bcc": null,
  "email_count": 10,
  "active_subscriber_count": 320,
  "unsubscribed_subscriber_count": 5,
  "created_at": "2013-06-21T10:31:58Z",
  "href": "https://api.getdrip.com/v2/9999999/campaigns/123456",
  "links": {
    "account": "9999999",
    "forms": ["888"]
  }
}
```

> All responses containing Email Series Campaign data also include the following top-level link data:

```json
{
  "links": {
    "campaigns.account": "https://api.getdrip.com/v2/accounts/{campaigns.account}",
    "campaigns.form": "https://api.getdrip.com/v2/{campaigns.account}/forms/{campaigns.forms}",
    "campaigns.subscribers": "https://api.getdrip.com/v2/{campaigns.account}/campaigns/{campaigns.id}/subscribers"
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
      <td>A read-only Drip generated unique id used to identify each Email Series Campaign record.</td>
    </tr>
    <tr>
      <td><code>status</code></td>
      <td>Returns whether the Email Series Campaign is active, paused or in draft.</td>
    </tr>
    <tr>
      <td><code>name</code></td>
      <td>The private name given to the Email Series Campaign.</td>
    </tr>
    <tr>
      <td><code>from_name</code></td>
      <td>A "from name" that appears in your sent emails. This setting overrides the account's default from name.</td>
    </tr>
    <tr>
      <td><code>from_email</code></td>
      <td>A "from email" that appears in your sent emails. This setting overrides the account's default from email.</td>
    </tr>
    <tr>
      <td><code>postal_address</code></td>
      <td>As required by the <a href="http://1.usa.gov/YgrzFP" target="_blank">CAN-SPAM Act</a>, this is a postal address used for all sent emails.</td>
    </tr>
    <tr>
      <td><code>minutes_from_midnight</code></td>
      <td>The number of minutes after midnight for the time of day set for email sending.</td>
    </tr>
    <tr>
      <td><code>localize_sending_time</code></td>
      <td>The scheduled send_at time if set to be sent in the subscriber's time zone.</td>
    </tr>
    <tr>
      <td><code>days_of_the_week_mask</code></td>
      <td>A representation of the days of week when emails are set to be sent. For example, <code>1111100</code> represents sending enabled only for Mondays to Fridays while <code>1111111</code> represents sending enabled for all days of the week.</td>
    </tr>
    <tr>
      <td><code>start_immediately</code></td>
      <td>Returns true if the first email in the Email Series Campaign is set to be delivered immediately after a Email Series Campaign subscription.</td>
    </tr>
    <tr>
      <td><code>double_optin</code></td>
      <td>Returns true if double opt-in is enabled for the Email Series Campaign.</td>
    </tr>
    <tr>
      <td><code>send_to_confirmation_page</code></td>
      <td>Deprecated</td>
    </tr>
    <tr>
      <td><code>use_custom_confirmation_page</code></td>
      <td>Deprecated</td>
    </tr>
    <tr>
      <td><code>post_confirmation_url</code></td>
      <td>Deprecated</td>
    </tr>
    <tr>
      <td><code>notify_subscribe_email</code></td>
      <td>An email address set that receives a notification whenever a subscriber subscribes via a form submission.</td>
    </tr>
    <tr>
      <td><code>notify_unsubscribe_email</code></td>
      <td>An email address set that receives a notification whenever a subscriber unsubscribes via their subscription management page.</td>
    </tr>
    <tr>
      <td><code>bcc</code></td>
      <td>A blind copy email address set for all Email Series Campaign email deliveries.</td>
    </tr>
    <tr>
      <td><code>email_count</code></td>
      <td>Returns a count of all emails associated with the Email Series Campaign. Includes all email statuses.</td>
    </tr>
    <tr>
      <td><code>active_subscriber_count</code></td>
      <td>Returns a count of all subscribers who are actively subscribed to the Email Series Campaign.</td>
    </tr>
    <tr>
      <td><code>unsubscribed_subscriber_count</code></td>
      <td>Returns a count of all subscribers who unsubscribed from the Email Series Campaign via a delivered email.</td>
    </tr>
    <tr>
      <td><code>created_at</code></td>
      <td>A timestamp representing when the Email Series Campaign was first created.</td>
    </tr>
    <tr>
      <td><code>href</code></td>
      <td>The url designated for retrieving the Email Series Campaign record via the REST API.</td>
    </tr>
    <tr>
      <td><code>links</code></td>
      <td>An object containing the REST API URL for the account, any associated Email Series Campaign forms and subscribers subscribed to the Email Series Campaign.</td>
    </tr>
    <tr>
      <td><code>forms</code></td>
      <td>An object containing the associated form created for the Email Series Campaign. This is only populated if a form is created for the Email Series Campaign. <a href="#forms">Refer to Forms</a> for an overview of the properties returned here.</td>
    </tr>
  </tbody>
</table>

## List all Email Series Campaigns

> To list all Email Series Campaigns:

```shell
curl "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/campaigns" \
  -H 'User-Agent: Your App Name (www.yourapp.com)' \
  -u YOUR_API_KEY:
```

```ruby
require 'drip'

client = Drip::Client.new do |c|
  c.api_key = "YOUR API KEY"
  c.account_id = "YOUR_ACCOUNT_ID"
end

response = client.campaigns

if response.success?
  puts response.body["campaigns"]
end
```

```javascript
// npm install drip-nodejs --save

const client = require('drip-nodejs')({ token: YOUR_API_KEY, accountId: YOUR_ACCOUNT_ID });
const options = { status: "active" };

client.listCampaigns(options)
  .then((response) => {
    // Handle `response.body`
  })
  .catch((error) => {
    // Handle errors
  });
```

> The response looks like this:

```json
# The campaigns property is an array of campaign objects.
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
  "campaigns": [ ... ]
}
```

### HTTP Endpoint

`GET /v2/:account_id/campaigns`

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
      <td>Optional. Filter by one of the following statuses: <code>draft</code>, <code>active</code>, or <code>paused</code>. Defaults to <code>all</code>.</td>
    </tr>
    <tr>
      <td><code>sort</code></td>
      <td>Optional. Sort results by one of these fields: <code>created_at</code> or <code>name</code>. Defaults to <code>created_at</code>.</td>
    </tr>
    <tr>
      <td><code>direction</code></td>
      <td>Optional. Filter sort direction with: <code>asc</code> or <code>desc</code>. Defaults to <code>asc</code>.</td>
    </tr>
  </tbody>
</table>

## Fetch an Email Series Campaign

> To fetch a specific Email Series Campaign:

```shell
curl "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/campaigns/CAMPAIGN_ID" \
  -H 'User-Agent: Your App Name (www.yourapp.com)' \
  -u YOUR_API_KEY:
```

```ruby
require 'drip'

client = Drip::Client.new do |c|
  c.api_key = "YOUR API KEY"
  c.account_id = "YOUR_ACCOUNT_ID"
end

campaign_id = 9999999
response = client.campaign(campaign_id)

if response.success?
  puts response.body
end
```

```javascript
// npm install drip-nodejs --save

const client = require('drip-nodejs')({ token: YOUR_API_KEY, accountId: YOUR_ACCOUNT_ID });
const campaignId = 9998888;

client.fetchCampaign(campaignId)
  .then((response) => {
    // Handle `response.body`
  })
  .catch((error) => {
    // Handle errors
  });
```

> The response looks like this:

```json
# The campaigns property is an array of campaign objects.
# The forms property is an array of forms that feed directly into to the campaign.
{
  "links": { ... },
  "campaigns": [{ ... }],
  "linked": {
    "forms": [{ ... }]
  }
}
```

### HTTP Endpoint

`GET /v2/:account_id/campaigns/:campaign_id`

### Arguments

None.

## Activate an Email Series Campaign

> To activate an Email Series Campaign:

```shell
curl -X POST "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/campaigns/CAMPAIGN_ID/activate" \
  -H 'User-Agent: Your App Name (www.yourapp.com)' \
  -u YOUR_API_KEY:
```

```ruby
require 'drip'

client = Drip::Client.new do |c|
  c.api_key = "YOUR API KEY"
  c.account_id = "YOUR_ACCOUNT_ID"
end

campaign_id = 9999999
response = client.activate_campaign(campaign_id)

if response.success?
  puts response.body
end
```

```javascript
// npm install drip-nodejs --save

const client = require('drip-nodejs')({ token: YOUR_API_KEY, accountId: YOUR_ACCOUNT_ID });
const campaignId = 9998888;

client.activateCampaign(campaignId)
  .then((response) => {
    // Handle `response.body`
  })
  .catch((error) => {
    // Handle errors
  });
```

> Responds with a `204 No Content` if successful. If the Email Series Campaign cannot be activated, returns a `422 Unprocessable Entity`.

### HTTP Endpoint

`POST /v2/:account_id/campaigns/:campaign_id/activate`

### Arguments

None.

## Pause an Email Series Campaign

> To pause an Email Series Campaign:

```shell
curl -X POST "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/campaigns/CAMPAIGN_ID/pause" \
  -H 'User-Agent: Your App Name (www.yourapp.com)' \
  -u YOUR_API_KEY:
```

```ruby
require 'drip'

client = Drip::Client.new do |c|
  c.api_key = "YOUR API KEY"
  c.account_id = "YOUR_ACCOUNT_ID"
end

campaign_id = 9999999
response = client.pause_campaign(campaign_id)

if response.success?
  puts response.body
end
```

```javascript
// npm install drip-nodejs --save

const client = require('drip-nodejs')({ token: YOUR_API_KEY, accountId: YOUR_ACCOUNT_ID });
const campaignId = 9998888;

client.pauseCampaign(campaignId)
  .then((response) => {
    // Handle `response.body`
  })
  .catch((error) => {
    // Handle errors
  });
```

> Responds with a `204 No Content` if successful. If the Email Series Campaign cannot be paused, returns a `422 Unprocessable Entity`.

### HTTP Endpoint

`POST /v2/:account_id/campaigns/:campaign_id/pause`

### Arguments

None.

## List all subscribers subscribed to an Email Series Campaign

> To list subscribers on an Email Series Campaign:

```shell
curl "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/campaigns/CAMPAIGN_ID/subscribers" \
  -H 'User-Agent: Your App Name (www.yourapp.com)' \
  -u YOUR_API_KEY:
```

```ruby
require 'drip'

client = Drip::Client.new do |c|
  c.api_key = "YOUR API KEY"
  c.account_id = "YOUR_ACCOUNT_ID"
end

campaign_id = 9999999
response = client.campaign_subscribers(campaign_id)

if response.success?
  puts response.body["subscribers]
end
```

```javascript
// npm install drip-nodejs --save

const client = require('drip-nodejs')({ token: YOUR_API_KEY, accountId: YOUR_ACCOUNT_ID });
const campaignId = 9998888;

client.listAllSubscribesToCampaign(campaignId)
  .then((response) => {
    // Handle `response.body`
  })
  .catch((error) => {
    // Handle errors
  });
```

> The response looks like this:

```json
# The subscribers property is an array of subscriber objects.
{
  "links": { ... },
  "meta": {
    "page": 1,
    "direction": "desc",
    "count": 20,
    "total_pages": 1,
    "total_count": 20
  },
  "subscribers": [ ... ]
}
```

### HTTP Endpoint

`GET /v2/:account_id/campaigns/:campaign_id/subscribers`

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
      <td>Optional. The status to filter by: <code>active</code>, <code>unsubscribed</code>, or <code>removed</code>. Defaults to <code>active</code>.</td>
    </tr>
    <tr>
      <td><code>page</code></td>
      <td>Optional. The page number. Defaults to <code>1</code>.</td>
    </tr>
    <tr>
      <td><code>direction</code></td>
      <td>Optional. The direction to sort the results for <code>created_at</code>: <code>asc</code> or <code>desc</code>. Defaults to <code>desc</code>.</td>
    </tr>
    <tr>
      <td><code>per_page</code></td>
      <td>Optional. The number of records to be returned on each page. Defaults to <code>100</code>. Maximum <code>1000</code>.</td>
    </tr>
  </tbody>
</table>

## Subscribe someone to an Email Series Campaign

> To start a subscriber on an Email Series Campaign:

```shell
curl -X POST "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/campaigns/CAMPAIGN_ID/subscribers" \
  -H "Content-Type: application/json" \
  -H 'User-Agent: Your App Name (www.yourapp.com)' \
  -u YOUR_API_KEY: \
  -d @- << EOF
  {
    "subscribers": [{
      "email": "john@acme.com",
      "utc_offset": 660,
      "double_optin": true,
      "starting_email_index": 0,
      "reactivate_if_removed": true,
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

campaign_id = 9999999
email = "someone@example.com"
options = {
  time_zone: "America/Los_Angeles",
  custom_fields: {
    name: "Jane Doe"
  }
}

response = client.subscribe(email, campaign_id, options)

if response.success?
  # ...
end
```

```javascript
// npm install drip-nodejs --save

const client = require('drip-nodejs')({ token: YOUR_API_KEY, accountId: YOUR_ACCOUNT_ID });
const campaignId = 9998888;
const payload = {
  subscribers: [{
    email: "someone@example.com",
    time_zone: "Asia/Kuala_Lumpur",
    custom_fields: {
      name: "Jane Doe"
    }
  }]
}

client.subscribeToCampaign(campaignId, payload)
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

`POST /v2/:account_id/campaigns/:campaign_id/subscribers`

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
      <td>Required. The subscriber's email address.</td>
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
      <td><code>double_optin</code></td>
      <td>Optional. If <code>true</code>, the double opt-in confirmation email is sent; if <code>false</code>, the confirmation email is skipped. Defaults to the value set on the Email Series Campaign.</td>
    </tr>
    <tr>
      <td><code>starting_email_index</code></td>
      <td>Optional. The index (zero-based) of the email to send first. Defaults to <code>0</code>.</td>
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
      <td><code>reactivate_if_removed</code></td>
      <td>Optional. If <code>true</code>, re-subscribe the subscriber to the Email Series Campaign if there is a removed subscriber in Drip with the same email address; otherwise, respond with <code>422 Unprocessable Entity</code>. Defaults to <code>true</code>.</td>
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
  </tbody>
</table>

## List all of a subscriber's Email Series Campaign subscriptions

> To list Email Series Campaign subscriptions for a subscriber:

```shell
curl "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/subscribers/SUBSCRIBER_ID/campaign_subscription" \
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

subscriber_id = "bihfwo84teh35dgt99"

response = client.campaign_subscriptions(subscriber_id)

if response.success?
  puts response.body["campaign_subscriptions"]
end
```

```javascript
// npm install drip-nodejs --save

const client = require('drip-nodejs')({ token: YOUR_API_KEY, accountId: YOUR_ACCOUNT_ID });
const subscriberId = "iuyfgfweufgr9hvrugegff";

client.subscriberCampaignSubscriptions(subscriberId)
  .then((response) => {
    // Handle `response.body`
  })
  .catch((error) => {
    // Handle errors
  });
```

> The response looks like this:

```json
# The Email Series Campaign subscriptions property is an array of campaign subscription objects.
{
  "links": {
    "campaign_subscriptions.account": "https://api.getdrip.com/v2/accounts/{campaign_subscriptions.account}",
    "campaign_subscriptions.subscriber": "https://api.getdrip.com/v2/subscribers/{campaign_subscriptions.subscriber}"
  },
  "meta": {
    "page": 1,
    "count": 5,
    "total_pages": 1,
    "total_count": 5
  },
  "campaign_subscriptions": [{
    "id": "123456",
    "campaign_id": "999999",
    "status": "active",
    "is_complete": false,
    "lap": 1,
    "last_sent_email_index": 0,
    "last_sent_email_at": "2016-03-25T11:00:00Z",
    "links": {
      "account": "9999999",
      "subscriber": "z1togz2hcjrkpp5treip"
    }
  }]
}
```

### HTTP Endpoint

`GET /v2/:account_id/subscribers/:subscriber_id/campaign_subscriptions`

### Arguments

None.
