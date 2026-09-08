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
      <td>A read-only Drip generated unique id used to identify each workflow record.</td>
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

```ruby
require 'drip'

client = Drip::Client.new do |c|
  c.api_key = "YOUR API KEY"
  c.account_id = "YOUR_ACCOUNT_ID"
end

response = client.workflows

if response.success?
  puts response.body["workflows"]
end
```

```javascript
// npm install drip-nodejs --save

const client = require('drip-nodejs')({ token: YOUR_API_KEY, accountId: YOUR_ACCOUNT_ID });
const options = { status: "active" };

client.listAllWorkflows(options)
  .then((response) => {
    // Handle `response.body`
  })
  .catch((error) => {
    // Handle errors
  });
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

`GET /v2/:account_id/workflows`

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

## Fetch a workflow

> To fetch a workflow:

```shell
curl "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/workflows/WORKFLOW_ID" \
  -H 'User-Agent: Your App Name (www.yourapp.com)' \
  -u YOUR_API_KEY:
```

```ruby
require 'drip'

client = Drip::Client.new do |c|
  c.api_key = "YOUR API KEY"
  c.account_id = "YOUR_ACCOUNT_ID"
end

workflow_id = 9999999
response = client.workflow(workflow_id)

if response.success?
  puts response.body["workflows"]
end
```

```javascript
// npm install drip-nodejs --save

const client = require('drip-nodejs')({ token: YOUR_API_KEY, accountId: YOUR_ACCOUNT_ID });
const workflowId = 222333;

client.fetchWorkflow(workflowId)
  .then((response) => {
    // Handle `response.body`
  })
  .catch((error) => {
    // Handle errors
  });
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

`GET /v2/:account_id/workflows/:workflow_id`

### Arguments

None.

## Fetch a workflow's details

The details endpoint returns the structure of a single workflow: its entry triggers, its ordered
steps, and everything nested beneath its decisions, goals, forks, and split tests. It is read-only.

Workflows in every visible status are returned, including drafts.

> To fetch a workflow's details:

```shell
curl "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/workflows/WORKFLOW_ID/details" \
  -H 'User-Agent: Your App Name (www.yourapp.com)' \
  -u YOUR_API_KEY:
```

```ruby
require "net/http"
require "json"

uri = URI("https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/workflows/WORKFLOW_ID/details")

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
  "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/workflows/WORKFLOW_ID/details",
  {
    headers: {
      "User-Agent": "Your App Name (www.yourapp.com)",
      "Authorization": "Basic " + Buffer.from("YOUR_API_KEY:").toString("base64")
    }
  }
);

const body = await response.json();
```

> The response looks like this (abridged):

```json
# The workflows property is an array of one workflow object.
{
  "links": {
    "workflows.account": "https://api.getdrip.com/v2/accounts/{workflows.account}"
  },
  "workflows": [
    {
      "id": "12345",
      "href": "https://api.getdrip.com/v2/9999999/workflows/12345",
      "name": "Welcome series",
      "description": "Onboarding for new trial signups",
      "status": "active",
      "created_at": "2026-01-04T17:22:03Z",
      "updated_at": "2026-07-28T14:02:11Z",
      "node_count": 9,
      "details": {
        "id": "root_1",
        "type": "path",
        "triggers": [
          {
            "id": "0a1b2c3d",
            "type": "trigger",
            "trigger_type": "submitted_form",
            "provider_id": "drip",
            "entry_point": true,
            "status": "active",
            "properties": { "form_id": "185216953", "source": "drip" },
            "incomplete": false,
            "actions_required": [],
            "derived": {
              "type_name": "Submitted a form or Onsite campaign.",
              "summary": "Submitted the \"Trial signup\" form",
              "type_description": "This event is fired when the person submits a form or Onsite campaign.",
              "segment_description": "people who are tagged with \"trial\""
            }
          }
        ],
        "steps": [
          {
            "id": "4e5f6a7b",
            "type": "action",
            "action_type": "send_email",
            "provider_id": "drip",
            "status": "active",
            "properties": { "automation_email_id": "957660884" },
            "incomplete": false,
            "actions_required": [],
            "derived": {
              "type_name": "Send an email to a person",
              "summary": "Send \"Welcome!\"",
              "email_title": "Welcome!"
            }
          },
          {
            "id": "8c9d0e1f",
            "type": "delay",
            "delay_type": "wait_for_relative_date",
            "properties": {
              "duration": 2,
              "units": "days",
              "days_of_the_week_mask": "0111110",
              "minutes_from_midnight": 540,
              "time_zone": "owner"
            },
            "incomplete": false,
            "derived": { "summary": "Wait 2 days, then resume on the next weekday at 9:00 am" }
          },
          {
            "id": "2a3b4c5d",
            "type": "decision",
            "true_path": {
              "id": "6e7f8a9b",
              "type": "path",
              "triggers": [],
              "steps": [
                {
                  "id": "0c1d2e3f",
                  "type": "action",
                  "action_type": "apply_tag",
                  "provider_id": "drip",
                  "status": "active",
                  "properties": { "tag": "vip" },
                  "incomplete": false,
                  "actions_required": [],
                  "derived": { "type_name": "Apply a tag", "summary": "Apply the \"vip\" tag" }
                }
              ]
            },
            "false_path": { "id": "4a5b6c7d", "type": "path", "triggers": [], "steps": [] },
            "incomplete": false,
            "actions_required": [],
            "derived": { "summary": "Person is tagged \"engaged\"?" }
          },
          {
            "id": "8e9f0a1b",
            "type": "interrupt",
            "triggers": [ { "id": "2c3d4e5f", "type": "trigger", "...": "..." } ],
            "derived": { "summary": "Waiting for goals" }
          },
          {
            "id": "6a7b8c9d",
            "type": "split_test",
            "properties": { "workflow_split_test_id": "9z8y7x6w" },
            "paths": [
              { "id": "0e1f2a3b", "type": "split_test_path", "triggers": [], "steps": [] },
              { "id": "4c5d6e7f", "type": "split_test_path", "triggers": [], "steps": [] }
            ],
            "derived": { "summary": "Began a split test" }
          },
          {
            "id": "3c4d5e6f",
            "type": "exit",
            "derived": { "summary": "Exit the workflow" }
          }
        ]
      },
      "links": { "account": "9999999" }
    }
  ]
}
```

**Properties**

In addition to the properties every workflow record carries, the details payload includes:

<table>
  <thead>
    <tr>
      <th>Property</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>description</code></td>
      <td>The description assigned to the workflow. May be empty.</td>
    </tr>
    <tr>
      <td><code>node_count</code></td>
      <td>The number of nodes in the workflow, counting containers.</td>
    </tr>
    <tr>
      <td><code>details</code></td>
      <td>The root <code>path</code> node, holding the workflow's entry <code>triggers</code> and its ordered <code>steps</code>.</td>
    </tr>
  </tbody>
</table>

### Nodes

Every node in the tree carries an `id` and a `type`, so one key tells you how to read the rest of
the node. Container nodes hold their children under `triggers`, `steps`, `paths`, `true_path`, or
`false_path`, depending on their type. Branches are objects rather than bare arrays, so an empty
branch still has an id.

<table>
  <thead>
    <tr>
      <th>Node <code>type</code></th>
      <th>Fields</th>
      <th><code>derived</code> keys</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>path</code>, <code>split_test_path</code></td>
      <td><code>id</code>, <code>type</code>, <code>triggers</code>, <code>steps</code></td>
      <td>None</td>
    </tr>
    <tr>
      <td><code>trigger</code></td>
      <td><code>id</code>, <code>type</code>, <code>trigger_type</code>, <code>provider_id</code>, <code>entry_point</code>, <code>status</code>, <code>properties</code>, <code>incomplete</code>, <code>actions_required</code></td>
      <td><code>type_name</code>, <code>summary</code>, <code>type_description</code>, <code>segment_description</code></td>
    </tr>
    <tr>
      <td><code>action</code></td>
      <td><code>id</code>, <code>type</code>, <code>action_type</code>, <code>provider_id</code>, <code>status</code>, <code>properties</code>, <code>incomplete</code>, <code>actions_required</code></td>
      <td><code>type_name</code>, <code>summary</code>, <code>email_title</code></td>
    </tr>
    <tr>
      <td><code>delay</code></td>
      <td><code>id</code>, <code>type</code>, <code>delay_type</code>, <code>properties</code>, <code>incomplete</code></td>
      <td><code>summary</code></td>
    </tr>
    <tr>
      <td><code>decision</code></td>
      <td><code>id</code>, <code>type</code>, <code>true_path</code>, <code>false_path</code>, <code>incomplete</code>, <code>actions_required</code></td>
      <td><code>summary</code></td>
    </tr>
    <tr>
      <td><code>fork</code></td>
      <td><code>id</code>, <code>type</code>, <code>paths</code></td>
      <td>None</td>
    </tr>
    <tr>
      <td><code>interrupt</code></td>
      <td><code>id</code>, <code>type</code>, <code>triggers</code></td>
      <td><code>summary</code></td>
    </tr>
    <tr>
      <td><code>split_test</code></td>
      <td><code>id</code>, <code>type</code>, <code>properties</code>, <code>paths</code></td>
      <td><code>summary</code></td>
    </tr>
    <tr>
      <td><code>exit</code></td>
      <td><code>id</code>, <code>type</code></td>
      <td><code>summary</code></td>
    </tr>
  </tbody>
</table>

An `interrupt` node is a goal: the triggers beneath it are goal triggers rather than entry
triggers, and they carry `entry_point: false`. A node's `status` is `active` or `draft`.

New fields may be added to any node at any time. Ignore fields you do not recognize.

### Node configuration

`properties` is the node's configuration as stored, and it is present on every `trigger`, `action`,
`delay`, and `split_test` node. Trigger properties are the same object
[List all workflow triggers](#list-all-workflow-triggers) returns for the same trigger.

An empty `properties` object does not mean the node is unconfigured; `incomplete` answers that.
Several action types, such as `activate_person` and `subscribe`, store no fields even when fully
configured.

`incomplete` is `true` whenever a node is not fully configured, whether because no type has been
chosen, because the node is blocked, or because it carries any `actions_required`. A decision whose
criteria have not been set is incomplete in the same way. `actions_required` lists what is missing,
as an array of `{ "code": ..., "message": ... }` objects, in the same shape
[List all workflow triggers](#list-all-workflow-triggers) returns.

Some configuration is never published. A `drip/http_post` action responds with an empty
`properties` object and no `derived.summary`, because its endpoint URL and request headers are
credentials; only `derived.type_name` survives. Raw segmentation criteria, provider credentials,
and editor layout data are not published on any node.

### Derived text

Human-readable text lives in a `derived` object, separate from `properties`. Everything in
`derived` is generated when the response is built and is not part of the workflow's stored
definition.

<table>
  <thead>
    <tr>
      <th>Key</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>summary</code></td>
      <td>What this particular node does. E.g. <code>Send "Welcome!"</code>.</td>
    </tr>
    <tr>
      <td><code>type_name</code></td>
      <td>The display name of the node's type. Triggers and actions only.</td>
    </tr>
    <tr>
      <td><code>type_description</code></td>
      <td>What the node's type means in general. Triggers only.</td>
    </tr>
    <tr>
      <td><code>segment_description</code></td>
      <td>The humanized entry criteria for the trigger. Triggers only.</td>
    </tr>
    <tr>
      <td><code>email_title</code></td>
      <td>The title of the email the node sends. <code>send_email</code> actions only.</td>
    </tr>
  </tbody>
</table>

Any key is omitted when it has no value, and a node with no text at all carries no `derived`
object. Because these strings are built from the records the node refers to, a `derived` value can
change when some other record is renamed, with no edit to the workflow itself. Use `properties` and
the type fields for anything you parse.

### Joining to email metrics

A node's `id` holds the same value the [Metrics](#metrics) endpoint returns as
`workflow_placement.node_id`, so joining `details` node `id` to `workflow_placement.node_id` lines
the structure up with per-email performance. The two endpoints spell the field differently; the
values are identical.

A node id is stable for the life of the workflow record. Copying a workflow regenerates every node
id, so ids do not carry across a copy.

### Caching

> If the response has not changed, responds with a `304 Not Modified` and an empty body:

```shell
curl "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/workflows/WORKFLOW_ID/details" \
  -H 'User-Agent: Your App Name (www.yourapp.com)' \
  -H 'If-None-Match: "a1b2c3d4e5f6"' \
  -u YOUR_API_KEY:
```

Responses carry an `ETag` covering every field of the response. Send it back as `If-None-Match` to
get a `304 Not Modified` when none of those fields has changed.

The `ETag` describes this view of the workflow rather than the workflow's stored definition, so it
is a cache validator only. Two workflows that differ solely in fields this endpoint withholds share
an `ETag`, and a change confined to a withheld field does not invalidate one.

### HTTP Endpoint

`GET /v2/:account_id/workflows/:workflow_id/details`

### Arguments

None.

## Activate a workflow

> To activate a workflow:

```shell
curl -X POST "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/workflows/WORKFLOW_ID/activate" \
  -H 'User-Agent: Your App Name (www.yourapp.com)' \
  -u YOUR_API_KEY:
```

```ruby
require 'drip'

client = Drip::Client.new do |c|
  c.api_key = "YOUR API KEY"
  c.account_id = "YOUR_ACCOUNT_ID"
end

workflow_id = 9999999
response = client.activate_workflow(workflow_id)

if response.success?
  # ...
end
```

```javascript
// npm install drip-nodejs --save

const client = require('drip-nodejs')({ token: YOUR_API_KEY, accountId: YOUR_ACCOUNT_ID });
const workflowId = 222333;

client.activateWorkflow(workflowId)
  .then((response) => {
    // Handle `response.body`
  })
  .catch((error) => {
    // Handle errors
  });
```

> Responds with a `204 No Content` if successful.

### HTTP Endpoint

`POST /v2/:account_id/workflows/:workflow_id/activate`

### Arguments

None.

## Pause a workflow

> To pause a workflow:

```shell
curl -X POST "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/workflows/WORKFLOW_ID/pause" \
  -H 'User-Agent: Your App Name (www.yourapp.com)' \
  -u YOUR_API_KEY:
```

```ruby
require 'drip'

client = Drip::Client.new do |c|
  c.api_key = "YOUR API KEY"
  c.account_id = "YOUR_ACCOUNT_ID"
end

workflow_id = 9999999
response = client.pause_workflow(workflow_id)

if response.success?
  # ...
end
```

```javascript
// npm install drip-nodejs --save

const client = require('drip-nodejs')({ token: YOUR_API_KEY, accountId: YOUR_ACCOUNT_ID });
const workflowId = 222333;

client.pauseWorkflow(workflowId)
  .then((response) => {
    // Handle `response.body`
  })
  .catch((error) => {
    // Handle errors
  });
```

> Responds with a `204 No Content` if successful.

### HTTP Endpoint

`POST /v2/:account_id/workflows/:workflow_id/pause`

### Arguments

None.

## Start someone on a workflow

> To start a someone on a workflow:

```shell
curl -X POST "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/workflows/WORKFLOW_ID/subscribers" \
  -H "Content-Type: application/json" \
  -H 'User-Agent: Your App Name (www.yourapp.com)' \
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

workflow_id = 9999999
options = {
  email: "john@acme.com",
  time_zone: "America/Los_Angeles",
  custom_fields: {
    shirt_size: "Medium"
  }
}
response = client.start_subscriber_workflow(workflow_id, options)

if response.success?
  puts response.body["subscribers"]
end
```

```javascript
// npm install drip-nodejs --save

const client = require('drip-nodejs')({ token: YOUR_API_KEY, accountId: YOUR_ACCOUNT_ID });
const workflowId = 222333;
const payload = {
  subscribers: [{
    email: "john@acme.com",
    time_zone: "America/Los_Angeles",
    custom_fields: {
      shirt_size: "Medium"
    }
  }]
}

client.startOnWorkflow(workflowId, payload)
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

If the workflow is not active, the subscriber will not be added to the workflow.

### HTTP Endpoint

`POST /v2/:account_id/workflows/:workflow_id/subscribers`

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
      <td><code>user_id</code></td>
      <td>Optional. A unique identifier for the user in your database, such as a primary key.</td>
    </tr>
    <tr>
      <td><code>time_zone</code></td>
      <td>Optional. The subscriber's time zone (in Olson format). Defaults to <code>Etc/UTC</code></td>
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
      <td><code>prospect</code></td>
      <td>Optional. A Boolean specifiying whether we should attach a lead score to the subscriber (when lead scoring is enabled). Defaults to <code>true</code>.
        <strong>Note:</strong> This flag used to be called <code>potential_lead</code>, which we will continue to accept for backwards compatibility.</td>
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

## Remove a subscriber from a workflow

> To remove someone from a workflow:

```shell
curl -X DELETE "https://v2/api.getdrip.com/v2/YOUR_ACCOUNT_ID/workflows/WORKFLOW_ID/subscribers/ID_OR_EMAIL" \
  -H 'User-Agent: Your App Name (www.yourapp.com)' \
  -u YOUR_API_KEY:
```

```ruby
require 'drip'

client = Drip::Client.new do |c|
  c.api_key = "YOUR API KEY"
  c.account_id = "YOUR_ACCOUNT_ID"
end

workflow_id = 9999999
subscriber_email = "john@acme.com"

response = client.remove_subscriber_workflow(workflow_id, subscriber_email)

if response.success?
  # ...
end
```

```javascript
// npm install drip-nodejs --save

const client = require('drip-nodejs')({ token: YOUR_API_KEY, accountId: YOUR_ACCOUNT_ID });
const workflowId = 222333;
const idOrEmail = "someone@example.com"

client.removeFromWorkflow(workflowId, idOrEmail)
  .then((response) => {
    // Handle `response.body`
  })
  .catch((error) => {
    // Handle errors
  });
```

> Responds with a `204 No Content` if successful.

If the subscriber is not already on the workflow, nothing will happen.

### HTTP Endpoint

`DELETE /v2/:account_id/workflows/:workflow_id/subscribers/:id_or_email`

### Arguments

None.

## List all workflow triggers

> To list all triggers on a workflow:

```shell
curl "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/workflows/WORKFLOW_ID/triggers" \
  -H 'User-Agent: Your App Name (www.yourapp.com)' \
  -u YOUR_API_KEY:
```

```ruby
require 'drip'

client = Drip::Client.new do |c|
  c.api_key = "YOUR API KEY"
  c.account_id = "YOUR_ACCOUNT_ID"
end

workflow_id = 9999999
response = client.workflow_triggers(workflow_id)

if response.success?
  puts response.body["triggers"]
end
```

```javascript
// npm install drip-nodejs --save

const client = require('drip-nodejs')({ token: YOUR_API_KEY, accountId: YOUR_ACCOUNT_ID });
const workflowId = 222333;

client.listTriggers(workflowId)
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

`GET /v2/:account_id/workflows/:workflow_id/triggers`

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

```ruby
require 'drip'

client = Drip::Client.new do |c|
  c.api_key = "YOUR API KEY"
  c.account_id = "YOUR_ACCOUNT_ID"
end

workflow_id = 9999999
options = {
  provider: "leadpages",
  trigger_type: "submitted_landing_page",
  properties: {
    landing_page: "My Landing Page"
  }
}
response = client.create_workflow_trigger(workflow_id, options)

if response.success?
  puts response.body["triggers"]
end
```

```javascript
// npm install drip-nodejs --save

const client = require('drip-nodejs')({ token: YOUR_API_KEY, accountId: YOUR_ACCOUNT_ID });
const workflowId = 222333;
const payload = {
  provider: "leadpages",
  trigger_type: "submitted_landing_page",
  properties: {
    landing_page: "My Landing Page"
  }
}

client.createTrigger(workflowId, payload)
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

`POST /v2/:account_id/workflows/:workflow_id/triggers`

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

```ruby
require 'drip'

client = Drip::Client.new do |c|
  c.api_key = "YOUR API KEY"
  c.account_id = "YOUR_ACCOUNT_ID"
end

workflow_id = 9999999
options = {
  provider: "leadpages",
  trigger_type: "submitted_landing_page",
  properties: {
    landing_page: "My Landing Page"
  }
}
response = client.update_workflow_trigger(workflow_id, options)

if response.success?
  puts response.body["triggers"]
end
```

```javascript
// npm install drip-nodejs --save

const client = require('drip-nodejs')({ token: YOUR_API_KEY, accountId: YOUR_ACCOUNT_ID });
const workflowId = 222333;
const triggerId = "abc123";
const payload = {
  provider: "leadpages",
  trigger_type: "submitted_landing_page",
  properties: {
    landing_page: "My Landing Page"
  }
}

client.updateTrigger(workflowId, triggerId, payload)
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

`PUT /v2/:account_id/workflows/:workflow_id/triggers/:trigger_id`

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
