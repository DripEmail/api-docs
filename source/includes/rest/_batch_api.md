# Batch API

## Create or update a batch of subscribers

> To create or update a batch of subscribers:

```shell
curl -X POST "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/subscribers/batches" \
  -H "Content-Type: application/json" \
  -H 'User-Agent: Your App Name (www.yourapp.com)' \
  -u YOUR_API_KEY: \
  -d @- << EOF
  {
    "batches": [{
      "subscribers": [
        {
          "email": "john@acme.com",
          "time_zone": "America/Los_Angeles",
          "tags": ["Customer", "SEO"],
          "custom_fields": {
            "shirt_size": "Medium"
          }
        },
        {
          "email": "joe@acme.com",
          "time_zone": "America/Los_Angeles",
          "tags": ["Prospect"],
          "custom_fields": {
            "shirt_size": "Medium"
          }
        }
      ]
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

# An array of subscribers
subscribers = [
  {
    "email": "john@acme.com"
  },
  {
    "email": "jane@acme.com"
  }
  # ...
]

response = client.create_or_update_subscribers(subscribers)

if response.success?
  # ...
end
```

```javascript
// npm install drip-nodejs --save

const client = require('drip-nodejs')({ token: YOUR_API_KEY, accountId: YOUR_ACCOUNT_ID });
const batch = {
  "batches": [{
    "subscribers": [
      {
        "email": "john@acme.com",
        "tags": "Dog Person"
      },
      {
        "email": "jane@acme.com",
        "tags": "Cat Person"
      }
      // Lots more subscribers...
    ]
  }]
};

client.updateBatchSubscribers(batch, (errors, responses, bodies) => {
  // Do stuff
  }
);
```

> Responds with a `201 Created` response and an empty JSON response if successful:

```json
{}
```

We recommend using this API endpoint when you need to create or update a collection of subscribers at once.

Note: Since our batch APIs process requests in the background, there may be a delay between the time you submit your
request and the time your data appears in the user interface.

### HTTP Endpoint

`POST /v2/:account_id/subscribers/batches`

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
      <td><code>subscribers</code></td>
      <td>Required. An Array with between 1 and 1000 objects containing subscriber data.</td>
    </tr>
  </tbody>
</table>

## Unsubscribe a batch of subscribers

> To globally unsubscribe a batch of subscribers:

```shell
curl -X POST "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/unsubscribes/batches" \
  -H "Content-Type: application/json" \
  -H 'User-Agent: Your App Name (www.yourapp.com)' \
  -u YOUR_API_KEY: \
  -d @- << EOF
  {
    "batches": [{
      "subscribers": [
        {
          "email": "john@acme.com"
        },
        {
          "email": "jane@acme.com"
        }
      ]
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

# An array of subscribers
subscribers = [
  {
    "email": "john@acme.com"
  },
  {
    "email": "jane@acme.com"
  }
  # ...
]

response = client.unsubscribe_subscribers(subscribers)

if response.success?
  # ...
end
```

```javascript
// npm install drip-nodejs --save

const client = require('drip-nodejs')({ token: YOUR_API_KEY, accountId: YOUR_ACCOUNT_ID });
const payload = {
  batches:
  [
    {
      subscribers: [
        {
          email: "someone@example.com"
        }
      ]
    }
  ]
};

client.unsubscribeBatchSubscribers(payload)
  .then((response) => {
    // Handle `response.body`
  })
  .catch((error) => {
    // Handle errors
  });
```

> Responds with a `204 No Content` response if successful.

### HTTP Endpoint

`POST /v2/:account_id/unsubscribes/batches`

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
      <td><code>subscribers</code></td>
      <td>Required. An Array with between 1 and 1000 objects containing subscriber data.</td>
    </tr>
  </tbody>
</table>

## Record a batch of events

> To record a batch of events:

```shell
curl -X POST "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/subscribers/batches" \
  -H "Content-Type: application/json" \
  -H 'User-Agent: Your App Name (www.yourapp.com)' \
  -u YOUR_API_KEY: \
  -d @- << EOF
  {
    "batches": [{
      "events": [
        {
          "email": "john@acme.com",
          "action": "Opened a door"
        },
        {
          "email": "joe@acme.com",
          "action": "Closed a door"
        }
      ]
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

# An array of events
events = [
  {
    "email": "john@acme.com",
    "action": "Opened a door"
  },
  {
    "email": "joe@acme.com",
    "action": "Closed a door"
  }
  # ...
]

response = client.track_events(events)
```

```javascript
// npm install drip-nodejs --save

const client = require('drip-nodejs')({ token: YOUR_API_KEY, accountId: YOUR_ACCOUNT_ID });
const payload = {
  batches: [{
    events: [
      {
        email: "john@acme.com",
        action: "Opened a door"
      },
      {
        email: "joe@acme.com",
        action: "Closed a door"
      }
    ]
  }]
};

client.recordBatchEvents(payload)
  .then((response) => {
    // Handle `response.body`
  })
  .catch((error) => {
    // Handle errors
  });
```

> Responds with a `201 Created` response and an empty JSON response if successful:

```json
{}
```

We recommend using this API endpoint when you need to record a collection of events at once that will likely exceed the regular rate limit of 3,600 requests per hour.

Note: Since our batch APIs process requests in the background, there may be a delay between the time you submit your
request and the time your data appears in the user interface.

### HTTP Endpoint

`POST /v2/:account_id/events/batches`

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
      <td><code>events</code></td>
      <td>Required. An Array with between 1 and 1000 objects containing event data.</td>
    </tr>
  </tbody>
</table>

## Create or update a batch of carts

> To create or update a batch of carts:

```shell
curl -X POST "https://api.getdrip.com/v3/YOUR_ACCOUNT_ID/shopper_activity/cart/batch" \
  -H "Content-Type: application/json" \
  -H 'User-Agent: Your App Name (www.yourapp.com)' \
  -u YOUR_API_KEY: \
  -d @- << EOF
  {
    "carts": [
      {
        "provider": "my_custom_platform",
        "email": "user@gmail.com",
        "action": "created",
        "cart_id": "456445746",
        "occurred_at": "2019-01-17T20:50:00Z",
        "cart_public_id": "#5",
        "grand_total": 16.99,
        "total_discounts": 5.34,
        "currency": "USD",
        "cart_url": "https://mysuperstore.com/cart/456445746",
        "items": [
          {
            "product_id": "B01J4SWO1G",
            "product_variant_id": "B01J4SWO1G-CW-BOTT",
            "sku": "XHB-1234",
            "name": "The Coolest Water Bottle",
            "brand": "Drip",
            "categories": [
              "Accessories"
            ],
            "price": 11.16,
            "quantity": 2,
            "discounts": 5.34,
            "total": 16.99,
            "product_url": "https://mysuperstore.com/dp/B01J4SWO1G",
            "image_url": "https://www.getdrip.com/images/example_products/water_bottle.png",
            "product_tag": "Best Seller"
          }
        ]
      },
      {
        "provider": "my_custom_platform",
        "email": "john@acme.com",
        "action": "created",
        "occurred_at": "2019-03-12T15:31:58Z",
        "cart_id": "63754763",
        "cart_public_id": "#4",
        "grand_total": 54.00,
        "total_discounts": 1.00,
        "currency": "USD",
        "order_url": "http://myorders.com/orders/4",
        "items": [{
          "product_id": "B01F9AQ99M",
          "product_variant_id": "B01F9AQ99M-YEL-BT",
          "sku": "JDT-4321",
          "name": "Yellow Boots of Might",
          "brand": "Drip",
          "categories": [
            "Of Might",
            "Outdoors"
          ],
          "price": 55.00,
          "quantity": 1,
          "discounts": 1.00,
          "total": 54.00,
          "color": "black",
          "product_url": "https://mysuperstore.com/dp/B01F9AQ99M",
          "image_url": "https://www.getdrip.com/images/example_products/boots.png"
        }]
      }
    ]
  }
EOF
```

> Responds with a <code>202 Accepted</code> if successful. That means the server accepted the request and queued it for processing. The response includes a list of unique request_ids that can be used to check the status of the request later on:

```json
{
  "request_ids": [
    "db8a7b16-32dd-4863-8b6e-818e3eaab99a",
    "002048e9-3692-4f0a-8bbf-80a077acf642"
  ]
}
```
</aside>

We recommend using this API endpoint when you need to import a collection of carts that will likely exceed the regular rate limit of 3,600 requests per hour.

Note: Since our batch APIs process requests in the background, there may be a delay between the time you submit your
request and the time your data appears in the user interface.

### HTTP Endpoint

`POST /v3/:account_id/shopper_activity/cart/batch`

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
      <td><code>carts</code></td>
      <td>Required. An Array with between 1 and 1000 objects containing <a href="#cart-activity">cart activity</a>.</td>
    </tr>
  </tbody>
</table>

## Create or update a batch of orders (Legacy)

> To create or update a batch of orders:

```shell
curl -X POST "https://api.getdrip.com/v2/YOUR_ACCOUNT_ID/orders/batches" \
  -H "Content-Type: application/json" \
  -H 'User-Agent: Your App Name (www.yourapp.com)' \
  -u YOUR_API_KEY: \
  -d @- << EOF
  {
    "batches": [{
      "orders": [
        {
          "email": "john@acme.com",
          "provider": "shopify",
          "upstream_id": "abcdef",
          "identifier": "Order_123456",
          "amount": 4900,
          "tax": 100,
          "fees": 0,
          "discount": 0,
          "permalink": "http://myorders.com/orders/123456",
          "currency_code": "USD",
          "properties": {
            "shirt_size": "Medium",
            "color": "red"
          },
          "occurred_at": "2013-06-21T10:31:58Z",
          "closed_at": "2013-06-21T10:35:58Z",
          "cancelled_at": null,
          "financial_state": "paid",
          "fulfillment_state": "fulfilled",
          "billing_address": {
            "name": "Bill Billington",
            "first_name": "Bill",
            "last_name": "Billington",
            "company": "Bills R US",
            "address_1": "123 Bill St.",
            "address_2": "Apt. B",
            "city": "Billtown",
            "state": "CA",
            "zip": "01234",
            "country": "United States",
            "phone": "555-555-5555",
            "email": "bill@bills.com"
          },
          "shipping_address": {
            "name": "Ship Shippington",
            "first_name": "Ship",
            "last_name": "Shipington",
            "company": "Shipping 4 Less",
            "address_1": "123 Ship St.",
            "address_2": "null",
            "city": "Shipville",
            "state": "CA",
            "zip": "01234",
            "country": "United States",
            "phone": "555-555-5555",
            "email": "ship@shipping.com"
          },
          "items": [{
            "id": "8888888",
            "product_id": "765432",
            "sku": "4444",
            "amount": 4900,
            "name": "Canoe",
            "quantity": 1,
            "upstream_id": "hijkl",
            "upstream_product_id": "opqrs",
            "upstream_product_variant_id": "zyxwv",
            "price": 4900,
            "tax": 100,
            "fees": 0,
            "discount": 100,
            "taxable": true,
            "properties": {
              "color": "black"
            }
          }]
        },
        {
          "email": "joe@acme.com",
          "provider": "shopify",
          "upstream_id": "fedcba",
          "identifier": "Order_654321",
          "amount": 4900,
          "tax": 100,
          "fees": 0,
          "discount": 0,
          "permalink": "http://myorders.com/orders/654321",
          "currency_code": "USD",
          "properties": {
            "size": "small",
            "color": "blue"
          },
          "occurred_at": "2013-05-18T10:31:58Z",
          "closed_at": "2013-05-18T10:35:58Z",
          "cancelled_at": null,
          "financial_state": "paid",
          "fulfillment_state": "fulfilled",
          "billing_address": {
            "name": "Bill Billington",
            "first_name": "Bill",
            "last_name": "Billington",
            "company": "Bills R US",
            "address_1": "123 Bill St.",
            "address_2": "Apt. B",
            "city": "Billtown",
            "state": "CA",
            "zip": "01234",
            "country": "United States",
            "phone": "555-555-5555",
            "email": "bill@bills.com"
          },
          "shipping_address": {
            "name": "Ship Shippington",
            "first_name": "Ship",
            "last_name": "Shipington",
            "company": "Shipping 4 Less",
            "address_1": "123 Ship St.",
            "address_2": "null",
            "city": "Shipville",
            "state": "CA",
            "zip": "01234",
            "country": "United States",
            "phone": "555-555-5555",
            "email": "ship@shipping.com"
          },
          "items": [{
            "id": "8888888",
            "product_id": "765432",
            "sku": "4444",
            "amount": 4900,
            "name": "Canoe",
            "quantity": 1,
            "upstream_id": "hijkl",
            "upstream_product_id": "opqrs",
            "upstream_product_variant_id": "zyxwv",
            "price": 4900,
            "tax": 100,
            "fees": 0,
            "discount": 100,
            "taxable": true,
            "properties": {
              "color": "black"
            }
          }]
        }
      ]
    }]
  }
EOF
```

> Responds with a `202 Accepted` response and an empty JSON response:

```json
{}
```
<aside class="notice color-notice">
We’ve released a new and improved batch endpoint for Orders functionality! Check it out <a href="#create-or-update-a-batch-of-orders">here</a>.

<br>
<br>
Note that the legacy Orders endpoint will continue to function. We will give fair notice before we retire it in the future.
</aside>

We recommend using this API endpoint when you need to create a collection of orders and subscribers at once that will likely exceed the regular rate limit of 3,600 requests per hour.

Note: Since our batch APIs process requests in the background, there may be a delay between the time you submit your
request and the time your data appears in the user interface.

### HTTP Endpoint

`POST /v2/:account_id/orders/batches`

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
      <td><code>orders</code></td>
      <td>Required. An Array with between 1 and 1000 objects containing <a href="#orders">order data</a>.</td>
    </tr>
  </tbody>
</table>

## Create or update a batch of orders

> To create or update a batch of orders:

```shell
curl -X POST "https://api.getdrip.com/v3/YOUR_ACCOUNT_ID/shopper_activity/order/batch" \
  -H "Content-Type: application/json" \
  -H 'User-Agent: Your App Name (www.yourapp.com)' \
  -u YOUR_API_KEY: \
  -d @- << EOF
  {
    "orders": [
      {
        "provider": "my_custom_platform",
        "email": "john@acme.com",
        "action": "placed",
        "occurred_at": "2019-03-12T15:31:58Z",
        "order_id": "63754763",
        "order_public_id": "#4",
        "grand_total": 54.00,
        "total_discounts": 1.00,
        "total_taxes": 1.00,
        "total_fees": 0,
        "total_shipping": 5.00,
        "currency": "USD",
        "order_url": "http://myorders.com/orders/4",
        "items": [{
          "product_id": "B01F9AQ99M",
          "product_variant_id": "B01F9AQ99M-YEL-BT",
          "sku": "JDT-4321",
          "name": "Yellow Boots of Might",
          "brand": "Drip",
          "categories": [
            "Of Might",
            "Outdoors"
          ],
          "price": 49.00,
          "quantity": 1,
          "discounts": 1.00,
          "taxes": 1.00,
          "fees": 0,
          "shipping": 5.00,
          "total": 54.00,
          "color": "black",
          "product_url": "https://mysuperstore.com/dp/B01F9AQ99M",
          "image_url": "https://www.getdrip.com/images/example_products/boots.png"
        }],
        "billing_address": {
          "label": "Primary Billing",
          "first_name": "Bill",
          "last_name": "Billington",
          "company": "Bills R US",
          "address_1": "123 Bill St.",
          "address_2": "Apt. B",
          "city": "Billtown",
          "state": "CA",
          "postal_code": "01234",
          "country": "United States",
          "phone": "555-555-5555"
        },
        "shipping_address": {
          "label": "Downtown Office",
          "first_name": "Ship",
          "last_name": "Shipington",
          "company": "Shipping 4 Less",
          "address_1": "123 Ship St.",
          "address_2": "null",
          "city": "Shipville",
          "state": "CA",
          "postal_code": "01234",
          "country": "United States",
          "phone": "555-555-5555"
        }
      },
      {
        "provider": "my_custom_platform",
        "email": "user@gmail.com",
        "action": "updated",
        "occurred_at": "2019-03-12T15:27:16Z",
        "order_id": "456445746",
        "order_public_id": "#5",
        "grand_total": 21.48,
        "total_discounts": 5.34,
        "total_taxes": 1.00,
        "total_fees": 2.00,
        "total_shipping": 5.00,
        "currency": "USD",
        "order_url": "https://mysuperstore.com/order/5",
        "items": [
          {
            "product_id": "B01J4SWO1G",
            "product_variant_id": "B01J4SWO1G-CW-BOTT",
            "sku": "XHB-1234",
            "name": "The Coolest Water Bottle",
            "brand": "Drip",
            "categories": [
              "Accessories"
            ],
            "price": 11.16,
            "sale_price": 10.16,
            "quantity": 2,
            "discounts": 5.34,
            "taxes": 1.00,
            "fees": 0.50,
            "shipping": 5.00,
            "total": 21.48,
            "product_url": "https://mysuperstore.com/dp/B01J4SWO1G",
            "image_url": "https://www.getdrip.com/images/example_products/water_bottle.png",
            "product_tag": "Best Seller"
          }
        ],
        "billing_address": {
          "label": "Primary Billing",
          "first_name": "Bill",
          "last_name": "Billington",
          "company": "Bills R US",
          "address_1": "123 Bill St.",
          "address_2": "Apt. B",
          "city": "Billtown",
          "state": "CA",
          "postal_code": "01234",
          "country": "United States",
          "phone": "555-555-5555"
        },
        "shipping_address": {
          "label": "Downtown Office",
          "first_name": "Ship",
          "last_name": "Shipington",
          "company": "Shipping 4 Less",
          "address_1": "123 Ship St.",
          "city": "Shipville",
          "state": "CA",
          "postal_code": "01234",
          "country": "United States",
          "phone": "555-555-5555"
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

response = client.create_order_activity_events(
  [
    {
      provider: "my_custom_platform",
      email: "john@acme.com",
      action: "placed",
      occurred_at: "2019-03-12T15:31:58Z",
      order_id: "63754763",
      order_public_id: "#4",
      grand_total: 54.00,
      total_discounts: 1.00,
      total_taxes: 1.00,
      total_fees: 0,
      total_shipping: 5.00,
      currency: "USD",
      order_url: "http://myorders.com/orders/4",
      items: [{
        product_id: "B01F9AQ99M",
        product_variant_id: "B01F9AQ99M-YEL-BT",
        sku: "JDT-4321",
        name: "Yellow Boots of Might",
        brand: "Drip",
        categories: [
          "Of Might",
          "Outdoors"
        ],
        price: 49.00,
        quantity: 1,
        discounts: 1.00,
        taxes: 1.00,
        fees: 0,
        shipping: 5.00,
        total: 54.00,
        color: "black",
        product_url: "https://mysuperstore.com/dp/B01F9AQ99M",
        image_url: "https://www.getdrip.com/images/example_products/boots.png"
      }],
      billing_address: {
        label: "Primary Billing",
        first_name: "Bill",
        last_name: "Billington",
        company: "Bills R US",
        address_1: "123 Bill St.",
        address_2: "Apt. B",
        city: "Billtown",
        state: "CA",
        postal_code: "01234",
        country: "United States",
        phone: "555-555-5555"
      },
      shipping_address: {
        label: "Downtown Office",
        first_name: "Ship",
        last_name: "Shipington",
        company: "Shipping 4 Less",
        address_1: "123 Ship St.",
        address_2: "null",
        city: "Shipville",
        state: "CA",
        postal_code: "01234",
        country: "United States",
        phone: "555-555-5555"
      }
    },
    {
      provider: "my_custom_platform",
      email: "user@gmail.com",
      action: "updated",
      occurred_at: "2019-03-12T15:27:16Z",
      order_id: "456445746",
      order_public_id: "#5",
      grand_total: 21.48,
      total_discounts: 5.34,
      total_taxes: 1.00,
      total_fees: 2.00,
      total_shipping: 5.00,
      currency: "USD",
      order_url: "https://mysuperstore.com/order/5",
      items: [
        {
          product_id: "B01J4SWO1G",
          product_variant_id: "B01J4SWO1G-CW-BOTT",
          sku: "XHB-1234",
          name: "The Coolest Water Bottle",
          brand: "Drip",
          categories: [
            "Accessories"
          ],
          price: 11.16,
          sale_price: 10.16,
          quantity: 2,
          discounts: 5.34,
          taxes: 1.00,
          fees: 0.50,
          shipping: 5.00,
          total: 21.48,
          product_url: "https://mysuperstore.com/dp/B01J4SWO1G",
          image_url: "https://www.getdrip.com/images/example_products/water_bottle.png",
          product_tag: "Best Seller"
        }
      ],
      billing_address: {
        label: "Primary Billing",
        first_name: "Bill",
        last_name: "Billington",
        company: "Bills R US",
        address_1: "123 Bill St.",
        address_2: "Apt. B",
        city: "Billtown",
        state: "CA",
        postal_code: "01234",
        country: "United States",
        phone: "555-555-5555"
      },
      shipping_address: {
        label: "Downtown Office",
        first_name: "Ship",
        last_name: "Shipington",
        company: "Shipping 4 Less",
        address_1: "123 Ship St.",
        city: "Shipville",
        state: "CA",
        postal_code: "01234",
        country: "United States",
        phone: "555-555-5555"
      }
    }
  ]
)

if response.success?
  puts "Request accepted"
else
  puts "Error occurred"
end
```

> Responds with a <code>202 Accepted</code> if successful. That means the server accepted the request and queued it for processing. The response includes a list of unique request_ids that can be used to check the status of the request later on:

```json
{
  "request_ids": [
    "db8a7b16-32dd-4863-8b6e-818e3eaab99a",
    "002048e9-3692-4f0a-8bbf-80a077acf642"
  ]
}
```
</aside>

We recommend using this API endpoint when you need to import a collection of orders that will likely exceed the regular rate limit of 3,600 requests per hour.

Note: Since our batch APIs process requests in the background, there may be a delay between the time you submit your
request and the time your data appears in the user interface.

### HTTP Endpoint

`POST /v3/:account_id/shopper_activity/order/batch`

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
      <td><code>orders</code></td>
      <td>Required. An Array with between 1 and 1000 objects containing <a href="#order-activity">order activity</a>.</td>
    </tr>
  </tbody>
</table>

## Create or update a batch of products

> To create or update a batch of products:

```shell
curl -X POST "https://api.getdrip.com/v3/YOUR_ACCOUNT_ID/shopper_activity/product/batch" \
  -H "Content-Type: application/json" \
  -H 'User-Agent: Your App Name (www.yourapp.com)' \
  -u YOUR_API_KEY: \
  -d @- << EOF
  {
    "products": [
      {
        "provider": "my_custom_platform",
        "action": "created",
        "occurred_at": "2019-01-28T12:15:23Z",
        "product_id": "B01J4SWO1G",
        "product_variant_id": "B01J4SWO1G-CW-BOTT",
        "sku": "XHB-1234",
        "name": "The Coolest Water Bottle",
        "brand": "Drip",
        "categories": [
          "Accessories"
        ],
        "price": 11.16,
        "inventory": 42,
        "product_url": "https://mysuperstore.com/dp/B01J4SWO1G",
        "image_url": "https://www.getdrip.com/images/example_products/water_bottle.png"
      },
      {
        "provider": "my_custom_platform",
        "action": "created",
        "occurred_at": "2019-01-28T12:15:23Z",
        "product_id": "B01J4SWO1G2",
        "product_variant_id": "B01J4SWO1G-CW-BOTT2",
        "sku": "XHB-1235",
        "name": "The Coolest Water Bottle",
        "brand": "Drip",
        "categories": [
          "Accessories"
        ],
        "price": 11.16,
        "inventory": 42,
        "product_url": "https://mysuperstore.com/dp/B01J4SWO1G2",
        "image_url": "https://www.getdrip.com/images/example_products/water_bottle.png"
      },
      {
        "provider": "my_custom_platform",
        "action": "created",
        "occurred_at": "2019-01-28T12:15:23Z",
        "product_id": "B01J4SWO1G3",
        "product_variant_id": "B01J4SWO1G-CW-BOTT3",
        "sku": "XHB-1236",
        "name": "The Coolest Water Bottle",
        "brand": "Drip",
        "categories": [
          "Accessories"
        ],
        "price": 11.16,
        "inventory": 42,
        "product_url": "https://mysuperstore.com/dp/B01J4SWO1G3",
        "image_url": "https://www.getdrip.com/images/example_products/water_bottle.png"
      }
    ]
  }
EOF
```

> Responds with a <code>202 Accepted</code> if successful. That means the server accepted the request and queued it for processing. The response includes a list of unique request_ids that can be used to check the status of the request later on:

```json
{
  "request_ids": [
    "db8a7b16-32dd-4863-8b6e-818e3eaab99a",
    "002048e9-3692-4f0a-8bbf-80a077acf642"
  ]
}
```
</aside>

We recommend using this API endpoint when you need to import a collection of products that will likely exceed the regular rate limit of 3,600 requests per hour.

Note: Since our batch APIs process requests in the background, there may be a delay between the time you submit your
request and the time your data appears in the user interface.

### HTTP Endpoint

`POST /v3/:account_id/shopper_activity/product/batch`

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
      <td><code>products</code></td>
      <td>Required. An Array with between 1 and 1000 products containing <a href="#product-activity">product activity</a>.</td>
    </tr>
  </tbody>
</table>
