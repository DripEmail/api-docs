# Workflows

> Workflows are represented as follows:

```json
{
  "id": "123456",
  "href": "https://api.getdrip.com/v2/9999999/workflows/123456",
  "name": "Main Funnel",
  "status": "active",
  "created_at": "2016-07-01T10:00:00Z",
  "links": {
    "account": "9999999"
  }
}
```

> All responses containing workflow data also include the following top-level link data:

```json
{
  "links": {
    "workflows.account": "https://api.getdrip.com/v2/accounts/{workflows.account}"
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
      <td>The currently authenticated user's email address.</td>
    </tr>
    <tr>
      <td><code>href</code></td>
      <td>The url designated for retrieving the workflow record via the REST API.</td>
    </tr>
    <tr>
      <td><code>name</code></td>
      <td>The name assigned to the workflow.</td>
    </tr>
    <tr>
      <td><code>status</code></td>
      <td>The workflow's status whether <code>draft</code>, <code>active</code>, or <code>paused</code>.</td>
    </tr>
    <tr>
      <td><code>created_at</code></td>
      <td>A timestamp representing when the workflow record was first created.</td>
    </tr>
    <tr>
      <td><code>links</code></td>
      <td>An object containing the REST API URL for the account.</td>
    </tr>
  </tbody>
</table>

## List all workflows

> To list all workflows:

```shell
curl "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/workflows" \
  -H 'User-Agent: Your App Name (www.yourapp.com)' \
  -u YOUR_API_KEY:
```

> The response looks like this:

```json
# The workflows property is an array of workflow objects.
{
  "links": { ... },
  "meta": {
    "page": 1,
    "sort": "sort_order",
    "direction": "desc",
    "count": 5,
    "total_pages": 1,
    "total_count": 5,
    "status": "all"
  },
  "workflows": [ ... ]
}
```

### HTTP Endpoint

`GET /:account_id/workflows`

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
  </tbody>
</table>

## Fetch a workflow

> To fetch a workflow:

```shell
curl "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/workflows/WORKFLOW_ID" \
  -H 'User-Agent: Your App Name (www.yourapp.com)' \
  -u YOUR_API_KEY:
```

> The response looks like this:

```json
# The workflows property is an array of one workflow object.
{
  "links": { ... },
  "workflows": [{ ... }]
}
```

### HTTP Endpoint

`GET /:account_id/workflows/:workflow_id`

### Arguments

None.

## Activate a workflow

> To activate a workflow:

```shell
curl -X POST "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/workflows/WORKFLOW_ID/activate" \
  -H 'User-Agent: Your App Name (www.yourapp.com)' \
  -u YOUR_API_KEY:
```

> Responds with a `204 No Content` if successful.

### HTTP Endpoint

`POST /:account_id/workflows/:workflow_id/activate`

### Arguments

None.

## Pause a workflow

> To pause a workflow:

```shell
curl -X POST "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/workflows/WORKFLOW_ID/pause" \
  -H 'User-Agent: Your App Name (www.yourapp.com)' \
  -u YOUR_API_KEY:
```

> Responds with a `204 No Content` if successful.

### HTTP Endpoint

`POST /:account_id/workflows/:workflow_id/pause`

### Arguments

None.

## Start someone on a workflow

> To start a someone on a workflow:

```shell
curl -X POST "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/workflows/WORKFLOW_ID/subscribers" \
  -H 'User-Agent: Your App Name (www.yourapp.com)' \
  -u YOUR_API_KEY: \
  -d @- << EOF
  {
    "subscribers": [{
      "email": "john@acme.com",
      "time_zone": "America/Los_Angeles",
      "custom_fields": {
        "name": "John Doe"
      }
    }]
  }
  EOF
```

> The response looks like this:

```json
# The subscribers property is an array of one object.
{
  "links": { ... },
  "subscribers": [{ ... }]
}
```

If the workflow is not active, the subscriber will not be added to the workflow.

### HTTP Endpoint

`POST /:account_id/workflows/:workflow_id/subscribers`

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
      <td><code>user_id</code></td>
      <td>Optional. A unique identifier for the user in your database, such as a primary key.</td>
    </tr>
    <tr>
      <td><code>time_zone</code></td>
      <td>Optional. The subscriber's time zone (in Olson format). Defaults to <code>Etc/UTC</code></td>
    </tr>
    <tr>
      <td><code>custom_fields</code></td>
      <td>Optional. An Object containing custom field data. E.g. <code>{ "name": "John Doe" }</code>.</td>
    </tr>
    <tr>
      <td><code>tags</code></td>
      <td>Optional. An Array containing one or more tags. E.g. <code>["Customer", "SEO"]</code>.</td>
    </tr>
    <tr>
      <td><code>prospect</code></td>
      <td>Optional. A Boolean specifiying whether we should attach a lead score to the subscriber (when lead scoring is enabled). Defaults to <code>true</code>.
        <strong>Note:</strong> This flag used to be called <code>potential_lead</code>, which we will continue to accept for backwards compatibility.</td>
    </tr>
  </tbody>
</table>

## Remove a subscriber from a workflow

> To remove someone from a workflow:

```shell
curl -X DELETE "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/workflows/WORKFLOW_ID/subscribers/ID_OR_EMAIL" \
  -H 'User-Agent: Your App Name (www.yourapp.com)' \
  -u YOUR_API_KEY:
```

> Responds with a `204 No Content` if successful.

If the subscriber is not already on the workflow, nothing will happen.

### HTTP Endpoint

`DELETE /:account_id/workflows/:workflow_id/subscribers/:id_or_email`

### Arguments

None.

## List all workflow triggers

> To list all triggers on a workflow:

```shell
curl "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/workflows/WORKFLOW_ID/triggers" \
  -H 'User-Agent: Your App Name (www.yourapp.com)' \
  -u YOUR_API_KEY:
```

> The response looks like this:

```json
{
  "triggers": [
    {
      "id": "f7gysdf7gyd7",
      "type": "trigger",
      "trigger_type": "submitted_landing_page",
      "provider": "leadpages",
      "properties": {
        "landing_page": "My Landing Page"
      },
      "actions_required": [
        {
          "code": "configure_provider",
          "message": "Configure your LeadPages connection"
        }
      ]
    }
  ]
}
```

### HTTP Endpoint

`GET /:account_id/workflows/:workflow_id/triggers`

### Arguments

None.

## Create a workflow trigger

> To create a workflow trigger:

```shell
curl -X POST "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/workflows/WORKFLOW_ID/triggers" \
  -H 'User-Agent: Your App Name (www.yourapp.com)' \
  -u YOUR_API_KEY: \
  -d @- << EOF
  {
    "triggers": [
      {
        "provider": "leadpages",
        "trigger_type": "submitted_landing_page",
        "properties": {
          "landing_page": "My Landing Page"
        }
      }
    ]
  }
  EOF
```

> The response looks like this:

```json
{
  "triggers": [
    {
      "id": "f7gysdf7gyd7",
      "type": "trigger",
      "provider": "leadpages",
      "trigger_type": "submitted_landing_page",
      "properties": {
        "landing_page": "My Landing Page"
      },
      "actions_required": [
        {
          "code": "configure_provider",
          "message": "Configure your LeadPages connection"
        }
      ]
    }
  ]
}
```

### HTTP Endpoint

`POST /:account_id/workflows/:workflow_id/triggers`

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
      <td><code>provider</code></td>
      <td>Required. A String indicating a provider.</td>
    </tr>
    <tr>
      <td><code>trigger_type</code></td>
      <td>Required. A String indicating the automation trigger type.</td>
    </tr>
    <tr>
      <td><code>properties</code></td>
      <td>Optional. An Object containing properties for the given trigger.</td>
    </tr>
  </tbody>
</table>

## Update a workflow trigger

> To update a workflow trigger:

```shell
curl -X PUT "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/workflows/WORKFLOW_ID/triggers/TRIGGER_ID" \
  -H 'User-Agent: Your App Name (www.yourapp.com)' \
  -u YOUR_API_KEY: \
  -d @- << EOF
  {
    "triggers": [
      {
        "provider": "leadpages",
        "trigger_type": "submitted_landing_page",
        "properties": {
          "landing_page": "My Landing Page"
        }
      }
    ]
  }
  EOF
```

> The response looks like this:

```json
{
  "triggers": [
    {
      "id": "f7gysdf7gyd7",
      "type": "trigger",
      "provider": "leadpages",
      "trigger_type": "submitted_landing_page",
      "properties": {
        "landing_page": "My Landing Page"
      },
      "actions_required": [
        {
          "code": "configure_provider",
          "message": "Configure your LeadPages connection"
        }
      ]
    }
  ]
}
```

### HTTP Endpoint

`PUT /:account_id/workflows/:workflow_id/triggers/:trigger_id`

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
      <td><code>provider</code></td>
      <td>Required. A String indicating a provider.</td>
    </tr>
    <tr>
      <td><code>trigger_type</code></td>
      <td>Required. A String indicating the automation trigger type.</td>
    </tr>
    <tr>
      <td><code>properties</code></td>
      <td>Optional. An Object containing properties for the given trigger.</td>
    </tr>
  </tbody>
</table>
