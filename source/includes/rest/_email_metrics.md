# Email Metrics

## Fetch aggregate email performance metrics

> To fetch email metrics for a date range:

```shell
curl "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/metrics/email?start_date=2026-06-01&end_date=2026-06-30" \
  -H 'User-Agent: Your App Name (www.yourapp.com)' \
  -u YOUR_API_KEY:
```

> The response looks like this:

```json
{
  "summary": {
    "sends": 1000,
    "deliveries": 980,
    "opens": 450,
    "open_rate": 0.4592,
    "clicks": 120,
    "click_rate": 0.1224,
    "bot_clicks": 5,
    "bot_click_rate": 0.0051,
    "unsubscribes": 8,
    "unsubscribe_rate": 0.0082,
    "hard_bounces": 4,
    "hard_bounce_rate": 0.0041,
    "complaints": 1,
    "complaint_rate": 0.001,
    "orders": 30,
    "order_rate": 0.0306,
    "revenue_in_cents": 450000,
    "revenue_per_person_in_cents": 459,
    "average_order_value_in_cents": 15000
  },
  "emails": [
    {
      "email_id": 12345,
      "broadcast_id": "abc123",
      "title": "June Newsletter",
      "email_metric": {
        "sends": 1000,
        "deliveries": 980,
        "opens": 450,
        "open_rate": 0.4592,
        "clicks": 120,
        "click_rate": 0.1224,
        "bot_clicks": 5,
        "bot_click_rate": 0.0051,
        "unsubscribes": 8,
        "unsubscribe_rate": 0.0082,
        "hard_bounces": 4,
        "hard_bounce_rate": 0.0041,
        "complaints": 1,
        "complaint_rate": 0.001,
        "orders": 30,
        "order_rate": 0.0306,
        "revenue_in_cents": 450000,
        "revenue_per_person_in_cents": 459,
        "average_order_value_in_cents": 15000
      }
    }
  ]
}
```

Returns aggregate email performance metrics for the account — opens, clicks, bounces,
unsubscribes, complaints, orders, and revenue — as a `summary` across the date range plus
a per-email breakdown in `emails`. Rates (e.g. `open_rate`, `click_rate`) are fractions
rounded to four decimal places. Revenue and order values are reported in the smallest
currency unit (cents). Order and revenue figures are **email-attributed**, not store-wide.

Each entry in `emails` carries a numeric `email_id`, the email `title`, and its own
`email_metric` object with the same fields as `summary`. The `broadcast_id` (the broadcast's
public ID) is present only for emails sent as broadcasts.

The `emails` list returns up to the 10 most recent sends in the date range; the `summary`
totals always reflect **all** matching email sends across the range, not just those 10.

The endpoint is optimized for bounded date ranges; very wide windows (e.g. a full year) are
heavier. It is rate limited to **20 requests per account per hour** (separate from the
standard API rate limit); overage returns `429` with a `Retry-After` header.

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
      <td>Optional. Start date (<code>YYYY-MM-DD</code>), inclusive. Defaults to 30 days ago.</td>
    </tr>
    <tr>
      <td><code>end_date</code></td>
      <td>Optional. End date (<code>YYYY-MM-DD</code>), inclusive. Defaults to today.</td>
    </tr>
    <tr>
      <td><code>broadcast_ids</code></td>
      <td>Optional. An array of broadcast public IDs to limit metrics to specific broadcasts. Omit to aggregate across all email sends in the date range.</td>
    </tr>
  </tbody>
</table>
