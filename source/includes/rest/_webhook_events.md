# Webhook Events

[Webhooks](http://en.wikipedia.org/wiki/Webhook) allow you to
receive an HTTP POST to the URL(s) of your choosing anytime certain events occur
in your Drip account. All our webhook events contain data serialized as JSON.
If you'd like to be notified (with data) everytime a visitor subscribes,
you'll want to use webhooks.

## Setting Up

Adding a webhook URL is dead simple. Head over the [Webhooks](https://www.getdrip.com/webhooks)
settings page, enter your URL, and hit "Create Webhook". That's it!

Because of the potential for high volume, we will not send notifications for
`subscriber.received_email` events by default. To receive a post every time a subscriber
receives an email, enable these events using the checkbox on the webhook's settings.

Please note that some webhook endpoints may implement rate limiting, especially for entry-level or free accounts.
We will attempt to re-send webhooks for up to 3 days if they are rate limited.
In addition, you will be notified and your webhook will be temporarily disabled if its endpoint generates any other error for 3 days.

## Resources

### Subscriber

```json
{
  "id": "z1togz2hcjrkpp5treip",
  "status": "active",
  "email": "john@acme.com",
  "custom_fields": {
    "shirt_size": "Medium"
  },
  "tags": ["Customer", "SEO"],
  "time_zone": "America/Los_Angeles",
  "utc_offset": -440,
  "created_at": "2013-06-21T10:31:58Z"
  "ip_address": "123.123.123.123",
  "user_agent": "Mozilla/5.0",
  "lifetime_value": 2000,
  "original_referrer": "https://google.com/search",
  "landing_url": "https://www.drip.co/landing",
  "prospect": true,
  "base_lead_score": 30,
  "lead_score": 65,
  "user_id": "123"
}
```

An example of the fields you can expect when you see `"subscriber": { ... }` is on the right. You may also refer to the Subscribers docs <a href="#subscribers">here</a>.

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
      <td><code>event</code></td>
      <td>The webhook notification's event name. For example, <code>subscrber.received_email</code>.</td>
    </tr>
    <tr>
      <td><code>data</code></td>
      <td>An object containing the subscriber's properties. Refer to <a href="#subscribers">Subscribers</a> for what's included in this object.</td>
    </tr>
    <tr>
      <td><code>account_id</code></td>
      <td>The id for the account that sent the notification.</td>
    </tr>
    <tr>
      <td><code>occurred_at</code></td>
      <td>The String time at which the event occurred in <a href="http://en.wikipedia.org/wiki/ISO_8601">ISO-8601</a> format.</td>
    </tr>
  </tbody>
</table>

## subscriber.created

```json
{
  "event": "subscriber.created",
  "data": {
    "account_id": "9999999",
    "subscriber": { ... }
  },
  "occurred_at": "2013-06-21T10:31:58Z"
}
```

This event is triggered when a subscriber is created in your Drip account.

## subscriber.deleted

```json
{
  "event": "subscriber.deleted",
  "data": {
    "account_id": "9999999",
    "subscriber": { ... }
  },
  "occurred_at": "2013-06-21T10:31:58Z"
}
```

This event is triggered when a subscriber is deleted in your Drip account.

## subscriber.marked_as_deliverable

```json
{
  "event": "subscriber.marked_as_deliverable",
  "data": {
    "account_id": "9999999",
    "subscriber": { ... },
    "properties": {
      "source": "drip"
    }
  },
  "occurred_at": "2013-06-21T10:31:58Z"
}
```

This event is triggered when a subscriber transitions from being "undeliverable"
(due to a hard bounce or spam complaint) to being deliverable once again.

## subscriber.marked_as_undeliverable

```json
{
  "event": "subscriber.marked_as_undeliverable",
  "data": {
    "account_id": "9999999",
    "subscriber": { ... },
    "properties": {
      "source": "drip"
    }
  },
  "occurred_at": "2013-06-21T10:31:58Z"
}
```

This event is triggered when a subscriber transitions to being "undeliverable"
due to a hard bounce or spam complaint.

## subscriber.subscribed_to_email_marketing

```json
{
  "event": "subscriber.subscribed_to_email_marketing",
  "data": {
    "account_id": "9999999",
    "subscriber": { ... }
  },
  "occurred_at": "2013-06-21T10:31:58Z"
}
```

This event is triggered when a subscriber subscribes to a email marketing.

## subscriber.subscribed_to_campaign

```json
{
  "event": "subscriber.subscribed_to_campaign",
  "data": {
    "account_id": "9999999",
    "subscriber": { ... },
    "properties": {
      "campaign_id": "9999999",
      "campaign_name": "Email course"
    }
  },
  "occurred_at": "2013-06-21T10:31:58Z"
}
```

This event is triggered when a subscriber subscribes to an Email Series Campaign.

## subscriber.removed_from_campaign

```json
{
  "event": "subscriber.removed_from_campaign",
  "data": {
    "account_id": "9999999",
    "subscriber": { ... },
    "properties": {
      "campaign_id": "9999999",
      "campaign_name": "Email course"
    }
  },
  "occurred_at": "2013-06-21T10:31:58Z"
}
```

This event is triggered when a subscriber is removed from an Email Series Campaign.

## subscriber.unsubscribed_from_campaign

```json
{
  "event": "subscriber.unsubscribed_from_campaign",
  "data": {
    "account_id": "9999999",
    "subscriber": { ... },
    "properties": {
      "campaign_id": "9999999",
      "campaign_name": "Email course"
    }
  },
  "occurred_at": "2013-06-21T10:31:58Z"
}
```

This event is triggered when a subscriber unsubscribes from an Email Series Campaign.

## subscriber.unsubscribed_all

```json
{
  "event": "subscriber.unsubscribed_all",
  "data": {
    "account_id": "9999999",
    "subscriber": { ... },
    "properties": {}
  },
  "occurred_at": "2013-06-21T10:31:58Z"
}
```

This event is triggered when a subscriber is unsubscribed from all mailings.

## subscriber.reactivated

```json
{
  "event": "subscriber.reactivated",
  "data": {
    "account_id": "9999999",
    "subscriber": { ... },
    "properties": {}
  },
  "occurred_at": "2013-06-21T10:31:58Z"
}
```

This event is triggered when a subscription is reactivated.

## subscriber.completed_campaign

```json
{
  "event": "subscriber.completed_campaign",
  "data": {
    "account_id": "9999999",
    "subscriber": { ... },
    "properties": {
      "campaign_id": "9999999",
      "campaign_name": "Email course"
    }
  },
  "occurred_at": "2013-06-21T10:31:58Z"
}
```

This event is triggered when a subscriber completes an Email Series Campaign.

## subscriber.applied_tag

```json
{
  "event": "subscriber.applied_tag",
  "data": {
    "account_id": "9999999",
    "subscriber": { ... },
    "properties": {
      "tag": "Customer"
    }
  },
  "occurred_at": "2013-06-21T10:31:58Z"
}
```

This event is triggered when a subscriber is applied a tag.

## subscriber.removed_tag

```json
{
  "event": "subscriber.removed_tag",
  "data": {
    "account_id": "9999999",
    "subscriber": { ... },
    "properties": {
      "tag": "Customer"
    }
  },
  "occurred_at": "2013-06-21T10:31:58Z"
}
```

This event is triggered when a tag is removed from a subscriber.

## subscriber.updated_custom_field

```json
{
  "event": "subscriber.updated_custom_field",
  "data": {
    "account_id": "9999999",
    "subscriber": { ... },
    "properties": {
      "identifier": "first_name",
      "value": "John",
      "previous_value": "",
      "source": "drip"
    }
  },
  "occurred_at": "2013-06-21T10:31:58Z"
}
```

This event is triggered when a subscriber's custom fields are updated.

## subscriber.updated_email_address

```json
{
  "event": "subscriber.updated_email_address",
  "data": {
    "account_id": "9999999",
    "subscriber": { ... },
    "properties": {
      "value": "jdoe@gmail.com",
      "previous_value": "johndoe@gmail.com",
      "source": "drip"
    }
  },
  "occurred_at": "2013-06-21T10:31:58Z"
}
```

This event is triggered when a subscriber's email address is updated.

## subscriber.updated_lifetime_value

```json
{
  "event": "subscriber.updated_lifetime_value",
  "data": {
    "account_id": "9999999",
    "subscriber": { ... },
    "properties": {
      "value": 10000,
      "previous_value": 9500,
      "source": "drip"
    }
  },
  "occurred_at": "2013-06-21T10:31:58Z"
}
```

This event is triggered when a subscriber's lifetime value is updated.

## subscriber.updated_time_zone

```json
{
  "event": "subscriber.updated_time_zone",
  "data": {
    "account_id": "9999999",
    "subscriber": { ... },
    "properties": {
      "value": "America/Chicago",
      "previous_value": "America/Los_Angeles"
    }
  },
  "occurred_at": "2013-06-21T10:31:58Z"
}
```

This event is triggered when a subscriber's time zone is updated.

## subscriber.received_email

```json
{
  "event": "subscriber.received_email",
  "data": {
    "account_id": "9999999",
    "subscriber": { ... },
    "properties": {
      "delivery_id": "99999",
      "email_id": "88888",
      "email_subject": "Email Course: Day 1"
    }
  },
  "occurred_at": "2013-06-21T10:31:58Z"
}
```

This event is triggered when a subscriber receives an email.

Note that because of their potentially high volume, notifications for this event are optional. See <a href="#setting-up">Setting up</a> above.

## subscriber.opened_email

```json
{
  "event": "subscriber.opened_email",
  "data": {
    "account_id": "9999999",
    "subscriber": { ... },
    "properties": {
      "delivery_id": "99999",
      "email_id": "88888",
      "email_subject": "Email Course: Day 1"
    }
  },
  "occurred_at": "2013-06-21T10:31:58Z"
}
```

This event is triggered when a subscriber opens an email.

## subscriber.clicked_email

```json
{
  "event": "subscriber.clicked_email",
  "data": {
    "account_id": "9999999",
    "subscriber": { ... },
    "properties": {
      "delivery_id": "99999",
      "email_id": "88888",
      "url": "http://www.example.com",
      "user_agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.89 Safari/537.36",
      "ip_address": "111.111.111.11",
      "email_subject": "Email Course: Day 1"
    }
  },
  "occurred_at": "2013-06-21T10:31:58Z"
}
```

This event is triggered when a subscriber clicks a link in an email.

## subscriber.bounced

```json
{
  "event": "subscriber.bounced",
  "data": {
    "account_id": "9999999",
    "subscriber": { ... },
    "properties": {
      "delivery_id": "99999",
      "email_id": "88888",
      "email_subject": "Email Course: Day 1"
    }
  },
  "occurred_at": "2013-06-21T10:31:58Z"
}
```

This event is triggered when an email to a subscriber bounces.

## subscriber.complained

```json
{
  "event": "subscriber.complained",
  "data": {
    "account_id": "9999999",
    "subscriber": { ... },
    "properties": {
      "delivery_id": "99999",
      "email_id": "88888",
      "email_subject": "Email Course: Day 1"
    }
  },
  "occurred_at": "2013-06-21T10:31:58Z"
}
```

This event is triggered when a subscriber issues a spam complaint about an email.

## subscriber.clicked_trigger_link

```json
{
  "event": "subscriber.clicked_trigger_link",
  "data": {
    "subscriber": { ... },
    "properties": {
      "url": "http://example.com",
      "ip_address": "128.1.1.1",
      "trigger_id": 99999999,
      "source": "drip"
    },
    "account_id": "8888888"
  },
  "occurred_at": "2017-03-15T13:52:25Z"
}
```

This event is triggered when a subscriber clicks a tracking link.

## subscriber.visited_page

```json
{
  "event": "subscriber.visited_page",
  "data": {
    "account_id": "9999999",
    "subscriber": { ... },
    "properties": {
      "url": "/blog/1234-hello-world"
    }
  },
  "occurred_at": "2013-06-21T10:31:58Z"
}
```

This event is triggered when a subscriber visits a page that is configured to trigger a rule.

## subscriber.became_lead

```json
{
  "event": "subscriber.became_lead",
  "data": {
    "account_id": "9999999",
    "subscriber": { ... },
    "properties": {
      "lead_score": 68
    }
  },
  "occurred_at": "2013-06-21T10:31:58Z"
}
```

This event is triggered when a subscriber becomes a lead (i.e. when the subscriber's
lead score surpasses the threshold set in your lead settings). <strong>This event
only fires when lead scoring is enabled for your account.</strong>

## subscriber.became_non_prospect

```json
{
  "event": "subscriber.became_non_prospect",
  "data": {
    "account_id": "9999999",
    "subscriber": { ... }
  },
  "occurred_at": "2013-06-21T10:31:58Z"
}
```

This event is triggered when a subscriber becomes a non-prospect (i.e. when
the subscriber is no longer subject to lead scoring). <strong>This event
only fires when lead scoring is enabled for your account.</strong>

## subscriber.updated_lead_score

```json
{
  "event": "subscriber.updated_lead_score",
  "data": {
    "account_id": "9999999",
    "subscriber": { ... },
    "properties": {
      "lead_score": 68,
      "previous_lead_score": 60
    }
  },
  "occurred_at": "2013-06-21T10:31:58Z"
}
```

This event is triggered when a subscriber's lead score is updated. <strong>This event
only fires when lead scoring is enabled for your account.</strong>

## subscriber.performed_custom_event

```json
{
  "event": "subscriber.performed_custom_event",
  "data": {
    "account_id": "9999999",
    "subscriber": { ... },
    "properties": {
      "action": "Signed up for a trial"
      "plan": "rock-star",
      "amount": 2999
    }
  },
  "occurred_at": "2013-06-21T10:31:58Z"
}
```

This event is triggered when a custom event is tracked for a subscriber.

## subscriber.updated_alias

```json
{
  "event": "subscriber.updated_alias",
  "data": {
    "account_id": "9999999",
    "subscriber": { ... },
    "properties": {
      "identifier": "user_id",
      "value": "123",
      "previous_value": "",
      "source": "drip"
    }
  },
  "occurred_at": "2013-06-21T10:31:58Z"
}
```

This event is triggered when a subscriber's aliases are updated. <code>user_id</code> is currently the only natively supported alias.
