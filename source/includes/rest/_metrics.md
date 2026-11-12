# Metrics

The Metrics API returns aggregate email performance for an account: sends, deliveries, opens,
clicks, bot clicks, unsubscribes, hard and soft bounces, complaints, orders, and revenue.

Results cover Single-Email Campaigns, Email Series Campaigns, and automation emails sent by Workflows.
Confirmation emails (double opt-in) are excluded. Order and revenue values are
reported in cents.

Dates are interpreted in the account owner's time zone.

> Email metrics are represented as follows:

```json
{
  "email_id": 4455661,
  "broadcast_id": "123456",
  "workflow_placement": {
    "workflow_id": "789012",
    "node_id": "SENDEMAILNODE1"
  },
  "campaign_placement": {
    "campaign_id": "345678",
    "position": 2,
    "status": "published",
    "delay": {
      "value": 3,
      "units": "days"
    }
  },
  "title": "December Newsletter",
  "email_metric": { ... }
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
      <td><code>email_id</code></td>
      <td>A read-only Drip generated unique id used to identify each email record.</td>
    </tr>
    <tr>
      <td><code>broadcast_id</code></td>
      <td>The id of the Single-Email Campaign that sent the email. Only present for Single-Email Campaign emails.</td>
    </tr>
    <tr>
      <td><code>workflow_placement</code></td>
      <td>An object containing the <code>workflow_id</code> of the workflow that sends the email and the <code>node_id</code> of the send-email step within it. Only present when the request includes a <code>workflow_ids</code> filter and the email is sent by one of those workflows. <code>node_id</code> holds the same value <a href="#fetch-a-workflow-39-s-details">Fetch a workflow's details</a> returns as a node's <code>id</code>.</td>
    </tr>
    <tr>
      <td><code>campaign_placement</code></td>
      <td>An object describing where the email sits in an Email Series Campaign. Only present when the request includes a <code>campaign_ids</code> filter and the email belongs to one of those campaigns. <code>campaign_id</code> is the campaign's id; <code>position</code> is the email's 1-based order in the series, counting drafts, as shown in the series editor; <code>status</code> is <code>published</code> or <code>draft</code> (only published emails are sent to new subscribers); <code>delay</code> holds the wait after the previous email as a <code>value</code> and <code>units</code> (<code>minutes</code>, <code>hours</code>, or <code>days</code>). The email's metrics are totals for the email, not for its position.</td>
    </tr>
    <tr>
      <td><code>title</code></td>
      <td>The name of the Single-Email Campaign, Email Series Campaign, or automation that sent the email.</td>
    </tr>
    <tr>
      <td><code>email_metric</code></td>
      <td>An object containing the email's metrics.</td>
    </tr>
  </tbody>
</table>

## Email Metrics

> The email metric object structure:

```json
{
  "sends": 1000,
  "deliveries": 970,
  "opens": 420,
  "open_rate": 0.42,
  "clicks": 85,
  "click_rate": 0.085,
  "bot_clicks": 12,
  "bot_click_rate": 0.012,
  "unsubscribes": 7,
  "unsubscribe_rate": 0.007,
  "hard_bounces": 18,
  "hard_bounce_rate": 0.018,
  "soft_bounces": 9,
  "soft_bounce_rate": 0.009,
  "complaints": 2,
  "complaint_rate": 0.002,
  "orders": 24,
  "order_rate": 0.024,
  "revenue_in_cents": 384000,
  "revenue_per_person_in_cents": 384,
  "average_order_value_in_cents": 16000
}
```

Every rate is calculated against `sends` and rounded to four decimal places. The same object is
used for the report `summary` and for each email's `email_metric`.

<table>
  <thead>
    <tr>
      <th>Key</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>sends</code></td>
      <td>The number of emails sent.</td>
    </tr>
    <tr>
      <td><code>deliveries</code></td>
      <td>The number of sent emails accepted by the recipient's mail server.</td>
    </tr>
    <tr>
      <td><code>opens</code></td>
      <td>The number of opens recorded.</td>
    </tr>
    <tr>
      <td><code>open_rate</code></td>
      <td><code>opens</code> divided by <code>sends</code>.</td>
    </tr>
    <tr>
      <td><code>clicks</code></td>
      <td>The number of clicks recorded.</td>
    </tr>
    <tr>
      <td><code>click_rate</code></td>
      <td><code>clicks</code> divided by <code>sends</code>.</td>
    </tr>
    <tr>
      <td><code>bot_clicks</code></td>
      <td>The number of clicks attributed to automated systems rather than people.</td>
    </tr>
    <tr>
      <td><code>bot_click_rate</code></td>
      <td><code>bot_clicks</code> divided by <code>sends</code>.</td>
    </tr>
    <tr>
      <td><code>unsubscribes</code></td>
      <td>The number of unsubscribes.</td>
    </tr>
    <tr>
      <td><code>unsubscribe_rate</code></td>
      <td><code>unsubscribes</code> divided by <code>sends</code>.</td>
    </tr>
    <tr>
      <td><code>hard_bounces</code></td>
      <td>The number of hard bounces.</td>
    </tr>
    <tr>
      <td><code>hard_bounce_rate</code></td>
      <td><code>hard_bounces</code> divided by <code>sends</code>.</td>
    </tr>
    <tr>
      <td><code>soft_bounces</code></td>
      <td>The number of soft bounces.</td>
    </tr>
    <tr>
      <td><code>soft_bounce_rate</code></td>
      <td><code>soft_bounces</code> divided by <code>sends</code>.</td>
    </tr>
    <tr>
      <td><code>complaints</code></td>
      <td>The number of spam complaints.</td>
    </tr>
    <tr>
      <td><code>complaint_rate</code></td>
      <td><code>complaints</code> divided by <code>sends</code>.</td>
    </tr>
    <tr>
      <td><code>orders</code></td>
      <td>The number of orders attributed to the email.</td>
    </tr>
    <tr>
      <td><code>order_rate</code></td>
      <td><code>orders</code> divided by <code>sends</code>.</td>
    </tr>
    <tr>
      <td><code>revenue_in_cents</code></td>
      <td>The revenue attributed to the email, in cents.</td>
    </tr>
    <tr>
      <td><code>revenue_per_person_in_cents</code></td>
      <td><code>revenue_in_cents</code> divided by <code>sends</code>, in cents.</td>
    </tr>
    <tr>
      <td><code>average_order_value_in_cents</code></td>
      <td><code>revenue_in_cents</code> divided by <code>orders</code>, in cents.</td>
    </tr>
  </tbody>
</table>

## Fetch email metrics

> To fetch email metrics:

```shell
curl -g "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/metrics/email?start_date=2026-01-01&end_date=2026-01-31&broadcast_ids[]=BROADCAST_ID&workflow_ids[]=WORKFLOW_ID&campaign_ids[]=CAMPAIGN_ID" \
  -H 'User-Agent: Your App Name (www.yourapp.com)' \
  -u YOUR_API_KEY:
```

```ruby
require "net/http"
require "json"

uri = URI("https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/metrics/email")
uri.query = URI.encode_www_form(
  "start_date" => "2026-01-01",
  "end_date" => "2026-01-31",
  "broadcast_ids[]" => "BROADCAST_ID",
  "workflow_ids[]" => "WORKFLOW_ID",
  "campaign_ids[]" => "CAMPAIGN_ID"
)

request = Net::HTTP::Get.new(uri)
request.basic_auth("YOUR_API_KEY", "")
request["User-Agent"] = "Your App Name (www.yourapp.com)"

response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
  http.request(request)
end

puts response.body
```

```javascript
const params = new URLSearchParams({
  start_date: "2026-01-01",
  end_date: "2026-01-31"
});
params.append("broadcast_ids[]", "BROADCAST_ID");
params.append("workflow_ids[]", "WORKFLOW_ID");
params.append("campaign_ids[]", "CAMPAIGN_ID");

const response = await fetch(
  `https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/metrics/email?${params}`,
  {
    headers: {
      "User-Agent": "Your App Name (www.yourapp.com)",
      "Authorization": "Basic " + Buffer.from("YOUR_API_KEY:").toString("base64")
    }
  }
);

const body = await response.json();
```

> The response looks like this:

```json
# The emails property is an array of email metrics objects.
{
  "summary": { ... },
  "emails_total": 3,
  "emails_truncated": false,
  "emails": [ ... ]
}
```

> If the filters match no emails, the summary is zeroed and no emails are returned:

```json
{
  "summary": {
    "sends": 0,
    "deliveries": 0,
    ...
  },
  "emails_total": 0,
  "emails_truncated": false,
  "emails": []
}
```

> If an argument is invalid or exceeds a limit, responds with a <code>400 Bad Request</code>:

```json
{
  "errors": [{
    "code": "bad_request",
    "message": "Date range cannot exceed 366 days."
  }]
}
```

> If the rate limit is exceeded, responds with a <code>429 Too Many Requests</code> and a
> <code>Retry-After</code> header indicating when the limit resets:

```json
{
  "errors": [{
    "code": "rate_limit_exceeded",
    "message": "Rate limit exceeded: at most 20 requests per account per hour."
  }]
}
```

> If the report cannot be produced in time, responds with a <code>503 Service Unavailable</code>:

```json
{
  "errors": [{
    "code": "unavailable_error",
    "message": "Service temporarily unavailable, try again later"
  }]
}
```

The `summary` totals the report across every email in the range, and `emails` lists up to
`limit` of those emails individually (100 by default). Emails are listed by `sends`, highest
first, with ties broken by `email_id` in ascending order. `emails_total` is the number of emails
that matched, and `emails_truncated` is `true` when that is more than `emails` lists. To list the
rest, call again with `limit` set to `emails_total`, up to 1,000; beyond that the full list isn't
available. This endpoint is not paginated.

Rule- and form-automation emails appear only in unfiltered results. `broadcast_ids` reaches only
Single-Email Campaign emails, `workflow_ids` only Workflow emails, and `campaign_ids` only Email
Series Campaign emails, so no filter can target them.

### Limits

<table>
  <thead>
    <tr>
      <th>Limit</th>
      <th>Applies to</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>366 days</td>
      <td>The date range, after defaults are applied</td>
    </tr>
    <tr>
      <td>25 ids</td>
      <td><code>workflow_ids</code> per request</td>
    </tr>
    <tr>
      <td>25 ids</td>
      <td><code>campaign_ids</code> per request</td>
    </tr>
    <tr>
      <td>1,000 emails</td>
      <td>The emails that <code>broadcast_ids</code>, <code>workflow_ids</code>, and <code>campaign_ids</code> resolve to</td>
    </tr>
    <tr>
      <td>1,000 emails</td>
      <td><code>limit</code></td>
    </tr>
  </tbody>
</table>

Requests that exceed any of these limits are rejected with a `400 Bad Request`.

### Rate limits

This endpoint has its own rate limit, separate from the standard API rate limit. Limits are
applied per account.

<table>
  <thead>
    <tr>
      <th>Limit</th>
      <th>Window</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>20 requests</td>
      <td>Per hour</td>
    </tr>
  </tbody>
</table>

### HTTP Endpoint

`GET /v2/:account_id/metrics/email`

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
      <td><code>start_date</code></td>
      <td>Optional. The first day of the range in <code>YYYY-MM-DD</code> format, inclusive. Defaults to 30 days ago.</td>
    </tr>
    <tr>
      <td><code>end_date</code></td>
      <td>Optional. The last day of the range in <code>YYYY-MM-DD</code> format, inclusive. Defaults to today.</td>
    </tr>
    <tr>
      <td><code>broadcast_ids</code></td>
      <td>Optional. An Array of Single-Email Campaign ids. Limits results to the emails sent by those Single-Email Campaigns.</td>
    </tr>
    <tr>
      <td><code>workflow_ids</code></td>
      <td>Optional. An Array of workflow ids. Limits results to the emails sent by those workflows. May be combined with <code>broadcast_ids</code> and <code>campaign_ids</code>, in which case the results are the union of the filters.</td>
    </tr>
    <tr>
      <td><code>campaign_ids</code></td>
      <td>Optional. An Array of Email Series Campaign ids. Limits results to the emails in those campaigns, drafts included. May be combined with <code>broadcast_ids</code> and <code>workflow_ids</code>, in which case the results are the union of the filters.</td>
    </tr>
    <tr>
      <td><code>limit</code></td>
      <td>Optional. The maximum number of emails to list in <code>emails</code>, a whole number from 1 to 1,000. Defaults to 100. Does not change <code>summary</code> or <code>emails_total</code>.</td>
    </tr>
  </tbody>
</table>
