# Rate Limiting

> All API requests subject to rate limiting contain information regarding your current rate limit status in the response headers:

```text
HTTP/1.1 200 OK
Status: 200 OK
X-RateLimit-Limit: 3600
X-RateLimit-Remaining: 3597
```

> If you exceed your rate limit, the API will returns a 429 status:

```text
HTTP/1.1 429 Too Many Requests
Content-Type: application/json

{
  "message": "API rate limit exceeded. Please try again in an hour.",
  "documentation": "https://www.getdrip.com/docs/rest-api#rate-limting"
}
```

You can make up to 50 requests per hour for batch endpoints and 3,600 individual requests per hour for other API endpoints. Each batch request accommodates up to 1,000 records in the payload for a total of 50,000 updates per hour.

[Fetch a workflow's details](#fetch-a-workflow-39-s-details) also has its own limit of 2,000 requests per account per hour. Past that, it responds with a `429 Too Many Requests` and a `Retry-After` header giving the number of seconds to wait.

To minimize your API requests, use the [Batch API](#batch-api).
