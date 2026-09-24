# Segments

Segments are saved groups of people, built in the Drip app from a set of rules. This API is
read-only: segments are created and edited in the app, and read here so you can find one by
name and point a Single-Email Campaign at it.

The `id` returned here is the value the Single-Email Campaigns API takes as `segment_id` when
setting an audience.

Only active, permanent segments are returned. A deleted, expired, or temporary segment is
treated as though it does not exist.

## List all segments

> To list all segments:

```shell
curl "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/segments" \
  -H 'User-Agent: Your App Name (www.yourapp.com)' \
  -u YOUR_API_KEY:
```

```ruby
require "net/http"

uri = URI("https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/segments")

request = Net::HTTP::Get.new(uri)
request.basic_auth("YOUR_API_KEY", "")
request["User-Agent"] = "Your App Name (www.yourapp.com)"

response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
  http.request(request)
end

puts response.body
```

```javascript
const response = await fetch(
  "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/segments",
  {
    headers: {
      "User-Agent": "Your App Name (www.yourapp.com)",
      "Authorization": "Basic " + Buffer.from("YOUR_API_KEY:").toString("base64")
    }
  }
);

const body = await response.json();
```

> Responds with a <code>200 OK</code>:

```json
{
  "links": { ... },
  "meta": {
    "page": 1,
    "count": 2,
    "total_count": 2,
    "per_page": 100,
    "total_pages": 1
  },
  "segments": [{
    "id": "4815162",
    "href": "https://api.getdrip.com/v2/9999999/segments/4815162",
    "name": "VIP customers",
    "created_at": "2026-01-14T09:22:41Z",
    "updated_at": "2026-08-02T17:05:03Z",
    "links": { "account": "9999999" }
  }]
}
```

Results come back in a stable but unspecified order. Ordering is not part of the contract yet.

### HTTP Endpoint

`GET /v2/:account_id/segments`

### Arguments

| Argument | Description |
|----------|-------------|
| page | Optional. The page number. Defaults to `1`. |
| per_page | Optional. The number of segments per page. Defaults to `100`, maximum `100`. |
| q | Optional. Case-insensitive substring match on the segment's name. |

## Fetch a segment

> To fetch a segment:

```shell
curl "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/segments/SEGMENT_ID" \
  -H 'User-Agent: Your App Name (www.yourapp.com)' \
  -u YOUR_API_KEY:
```

```ruby
require "net/http"

uri = URI("https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/segments/SEGMENT_ID")

request = Net::HTTP::Get.new(uri)
request.basic_auth("YOUR_API_KEY", "")
request["User-Agent"] = "Your App Name (www.yourapp.com)"

response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
  http.request(request)
end

puts response.body
```

```javascript
const response = await fetch(
  "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/segments/SEGMENT_ID",
  {
    headers: {
      "User-Agent": "Your App Name (www.yourapp.com)",
      "Authorization": "Basic " + Buffer.from("YOUR_API_KEY:").toString("base64")
    }
  }
);

const body = await response.json();
```

> Responds with a <code>200 OK</code>:

```json
{
  "links": { ... },
  "segments": [{
    "id": "4815162",
    "href": "https://api.getdrip.com/v2/9999999/segments/4815162",
    "name": "VIP customers",
    "created_at": "2026-01-14T09:22:41Z",
    "updated_at": "2026-08-02T17:05:03Z",
    "derived": {
      "summary": "People who are tagged with \"vip\" and have ordered in the last 90 days"
    },
    "links": { "account": "9999999" }
  }]
}
```

`derived.summary` is a plain-English description of the segment's rules, generated when you
read it. It is display text: do not parse it, and expect the wording to change. It is returned
here only, not in the list, because generating it walks the segment's rules.

### HTTP Endpoint

`GET /v2/:account_id/segments/:segment_id`

### Arguments

None.
