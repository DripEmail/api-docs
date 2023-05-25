# Order Activity

Order Activity will show up on a person's activity timeline as an event. The event is based on the <code>action</code> sent with the order payload. For example, sending <code>placed</code> will result in a "Placed an order" event and sending <code>updated</code> will result in an "Updated an order" event.

Order Activity places special value on <code>action</code> with the <code>placed</code> value. This event will determine when an order is considered to have originated based on the <code>occurred_at</code>. If you send an Order Activity <code>"action": "placed"</code> event without including a valid <code>occurred_at</code> value, the order will be considered to have originated at the current time. If you send Order Activity events without previously sending <code>placed</code>, the order will be considered to have originated at the current time the first event was received.

Drip will keep a person’s Lifetime Value (LTV) up-to-date with their orders. For example, if a customer places an order with a <code>grand_total</code> of $100, their LTV will be incremented by $100. If the order is then updated, paid, or fulfilled with a <code>grand_total</code> value of $105, the customer’s LTV will increase by $5. If the order is then canceled or refunded with a <code>refund_amount</code> of $105, the customer’s LTV will decrease by $105.

<h2 id="sapi-create-or-update-order">Create or update an order</h1>

To update an existing order, include the <code>provider</code> and <code>order_id</code> for that order in the payload.

> To record an order event:

```shell
curl -X POST "https://api.getdrip.com/v3/YOUR_ACCOUNT_ID/shopper_activity/order" \
  -H "Content-Type: application/json" \
  -H 'User-Agent: Your App Name (www.yourapp.com)' \
  -u YOUR_API_KEY: \
  -d @- << EOF
  {
    "provider": "my_custom_platform",
    "email": "user@gmail.com",
    "initial_status": "active",
    "action": "placed",
    "occurred_at": "2019-01-17T20:50:00Z",
    "order_id": "456445746",
    "order_public_id": "#5",
    "grand_total": 22.99,
    "total_discounts": 5.34,
    "total_taxes": 1.00,
    "total_fees": 2.00,
    "total_shipping": 5.00,
    "currency": "USD",
    "order_url": "https://mysuperstore.com/order/456445746",
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
        "total": 23.99,
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
EOF
```

```ruby
require 'drip'

client = Drip::Client.new do |c|
  c.api_key = "YOUR API KEY"
  c.account_id = "YOUR_ACCOUNT_ID"
end

response = client.create_order_activity_event(
  provider: "my_custom_platform",
  email: "user@gmail.com", # or person_id
  initial_status: "active",
  action: "placed",
  occurred_at: "2019-01-17T20:50:00Z",
  order_id: "456445746",
  order_public_id: "#5",
  grand_total: 22.99,
  total_discounts: 5.34,
  total_taxes: 1.00,
  total_fees: 2.00,
  total_shipping: 5.00,
  currency: "USD",
  order_url: "https://mysuperstore.com/order/456445746",
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
      total: 23.99,
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
)

if response.success?
  puts "Request accepted"
else
  puts "Error occurred"
end
```

> Responds with a <code>202 Accepted</code> if successful. That means the server accepted the request and queued it for processing

```json
{
  "request_id": "990c99a7-5cba-42e8-8f36-aec3419186ef"
}
```

### HTTP Endpoint

`POST /v3/:account_id/shopper_activity/order`

### Arguments

<table>
  <thead>
    <tr>
      <th>Property</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>provider</code></td>
      <td>Required. The identifier for the provider from which the order data was received in lower snake cased form. For example, <code>shopify</code> or <code>my_custom_platform</code> or <code>my_store</code>.</td>
    </tr>
    <tr>
      <td><code>person_id</code></td>
      <td>Optional. The unique identifier of a person at Drip. Either <code>person_id</code> or <code>email</code> must be included. If both are included, <code>email</code> is ignored.</td>
    </tr>
    <tr>
      <td><code>email</code></td>
      <td>Optional. The person's email address. Either <code>person_id</code> or <code>email</code> must be included. If both are included, <code>email</code> is ignored.</td>
    </tr>
    <tr>
      <td><code>initial_status</code></td>
      <td>Optional. The person's status whether <code>active</code> or <code>unsubscribed</code>. If this field is not included, the person will become subscribed.
    </tr>
    <tr>
      <td><code>action</code></td>
      <td>Required. The event's action. For Order Activity, this can be either <code>placed</code>, <code>updated</code>, <code>paid</code>, <code>fulfilled</code>, <code>refunded</code>, or <code>canceled</code>. These actions will result in "Placed an order", "Updated an order", "Paid an order", "Fulfilled an order", "Refunded an order", and "Canceled an order" events on the person's timeline, respectively.
    </tr>
    <tr>
      <td><code>occurred_at</code></td>
      <td>Optional. The String time at which the order occurred in <a href="http://en.wikipedia.org/wiki/ISO_8601">ISO 8601</a> format. Defaults to the current time.</td>
    </tr>
    <tr>
      <td><code>order_id</code></td>
      <td>Required. A unique, internal id for the order (generally the primary key generated by the ecommerce platform).</td>
    </tr>
    <tr>
      <td><code>order_public_id</code></td>
      <td>Optional. A public, customer-facing identifier for the order. This will be displayed in the Drip UI and should correspond to the identifier a customer might see in their own order.</td>
    </tr>
    <tr>
      <td><code>grand_total</code></td>
      <td>Optional. The total amount of the order. This should include any applicable discounts. Defaults to 0.</td>
    </tr>
    <tr>
      <td><code>total_discounts</code></td>
      <td>Optional. The discounts on the entire order. Defaults to 0.</td>
    </tr>
    <tr>
      <td><code>total_taxes</code></td>
      <td>Optional. The taxes on the entire order. Defaults to 0.</td>
    </tr>
    <tr>
      <td><code>total_fees</code></td>
      <td>Optional. The fees on the entire order. Defaults to 0.</td>
    </tr>
    <tr>
      <td><code>total_shipping</code></td>
      <td>Optional. The shipping on the entire order. Defaults to 0.</td>
    </tr>
    <tr>
      <td><code>refund_amount</code></td>
      <td>Optional. To adjust a person’s lifetime value for a refund or cancelation, set <code>refund_amount</code> to the amount of the refund and leave <code>grand_total</code> unchanged. Defaults to 0.</td>
    </tr>
    <tr>
      <td><code>currency</code></td>
      <td>Optional. The alphabetic <a href="https://en.wikipedia.org/wiki/ISO_4217">ISO 4217</a> code for the currency of the purchase.</td>
    </tr>
    <tr>
      <td><code>order_url</code></td>
      <td>Optional. A URL that links back to the shopper’s order on your ecommerce platform.</td>
    </tr>
    <tr>
      <td><code>items</code></td>
      <td>
        An Array of objects containing information about specific order items.
        <br><br>
        <table>
          <thead>
            <tr>
              <th>Key</th>
              <th>Description</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td><code>product_id</code></td>
              <td>Optional. A unique identifier for the product from the <code>provider</code>.
              We recommend using this field whenever possible to allow for product level segmentation.
              (Note: This field is used by segmentation.)</td>
            </tr>
            <tr>
              <td><code>product_variant_id</code></td>
              <td>Optional. If applicable, a unique identifier for the specific product variant from the <code>provider</code>. For example, a t-shirt may have one product_id, but several product_variant_ids for sizes and colors. If a product does not have multiple variants and you do not have a variant identifier in your system, repeat the product_id here. (Note: this field is used by segmentation.)</td>
            </tr>
            <tr>
              <td><code>sku</code></td>
              <td>Optional. The product SKU.</td>
            </tr>
            <tr>
              <td><code>name</code></td>
              <td>Required. The product name.</td>
            </tr>
            <tr>
              <td><code>brand</code></td>
              <td>Optional. The product's brand, vendor, or manufacturer.</td>
            </tr>
            <tr>
              <td><code>categories</code></td>
              <td>Optional. An array of categories associated with the product (e.g. shoes, vitamins, books, videos).</td>
            </tr>
            <tr>
              <td><code>price</code></td>
              <td>Optional. The price of a single product. Note that products without prices will be unavailable for segmentation by purchase price.</td>
            </tr>
            <tr>
              <td><code>quantity</code></td>
              <td>Optional. The quantity of the item ordered. Defaults to 1.</td>
            </tr>
            <tr>
              <td><code>discounts</code></td>
              <td>Optional. The discounts on the items, taking quantity into account. For example, a $2.66 discount per item would be $5.34 if that item was of quantity 2. Defaults to 0.</td>
            </tr>
            <tr>
              <td><code>taxes</code></td>
              <td>Optional. The taxes on the items, taking quantity into account. For example, a $0.50 taxes per item would be $1.00 if that item was of quantity 2. Defaults to 0.</td>
            </tr>
            <tr>
              <td><code>fees</code></td>
              <td>Optional. Any additional fees on the items, taking quantity into account. For example, a $0.25 fee per item would be $0.50 if that item was of quantity 2. Defaults to 0.</td>
            </tr>
            <tr>
              <td><code>shipping</code></td>
              <td>Optional. The shipping cost on the items, taking quantity into account. For example, $2.50 fee per item would be $5.00 if that item was of quantity 2. Defaults to 0.</td>
            </tr>
            <tr>
              <td><code>total</code></td>
              <td>Optional. The line item total after quantity, discount, taxes, fees, and shipping. Defaults to 0.</td>
            </tr>
            <tr>
              <td><code>product_url</code></td>
              <td>Optional. A URL to the site containing product details.</td>
            </tr>
            <tr>
              <td><code>image_url</code></td>
              <td>Optional. A direct URL to an image of the  product. We recommend using an image type that is supported by modern email clients (e.g. JPEG, GIF, PNG). For best display results, image size should be consistent across all products.</td>
            </tr>
          </tbody>
        </table>
      </td>
    </tr>
    <tr>
      <td><code>billing_address</code></td>
      <td>
        An object containing billing address information.
        <br><br>
        <table>
          <thead>
            <tr>
              <th>Key</th>
              <th>Description</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td><code>label</code></td>
              <td>Optional. The label describing the billing address.</td>
            </tr>
            <tr>
              <td><code>first_name</code></td>
              <td>Optional. The first name on the billing address.</td>
            </tr>
            <tr>
              <td><code>last_name</code></td>
              <td>Optional. The last name on the billing address.</td>
            </tr>
            <tr>
              <td><code>company</code></td>
              <td>Optional. The company on the billing address.</td>
            </tr>
            <tr>
              <td><code>address_1</code></td>
              <td>Optional. The billing street address.</td>
            </tr>
            <tr>
              <td><code>address_2</code></td>
              <td>Optional. Additional line of the billing street address.</td>
            </tr>
            <tr>
              <td><code>city</code></td>
              <td>Optional. The billing address city.</td>
            </tr>
            <tr>
              <td><code>state</code></td>
              <td>Optional. The billing address state.</td>
            </tr>
            <tr>
              <td><code>postal_code</code></td>
              <td>Optional. The billing address postal code.</td>
            </tr>
            <tr>
              <td><code>country</code></td>
              <td>Optional. The billing address country.</td>
            </tr>
            <tr>
              <td><code>phone</code></td>
              <td>Optional. The phone number associated with the billing address.</td>
            </tr>
          </tbody>
        </table>
      </td>
    </tr>
    <tr>
      <td><code>shipping_address</code></td>
      <td>
        An object containing shipping address information.
        <br><br>
        <table>
          <thead>
            <tr>
              <th>Key</th>
              <th>Description</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td><code>label</code></td>
              <td>Optional. The label describing the shipping address.</td>
            </tr>
            <tr>
              <td><code>first_name</code></td>
              <td>Optional. The first name on the shipping address.</td>
            </tr>
            <tr>
              <td><code>last_name</code></td>
              <td>Optional. The last name on the shipping address.</td>
            </tr>
            <tr>
              <td><code>company</code></td>
              <td>Optional. The company on the shipping address.</td>
            </tr>
            <tr>
              <td><code>address_1</code></td>
              <td>Optional. The shipping street address.</td>
            </tr>
            <tr>
              <td><code>address_2</code></td>
              <td>Optional. Additional line of the shipping street address.</td>
            </tr>
            <tr>
              <td><code>city</code></td>
              <td>Optional. The shipping address city.</td>
            </tr>
            <tr>
              <td><code>state</code></td>
              <td>Optional. The shipping address state.</td>
            </tr>
            <tr>
              <td><code>postal_code</code></td>
              <td>Optional. The shipping address postal code.</td>
            </tr>
            <tr>
              <td><code>country</code></td>
              <td>Optional. The shipping address country.</td>
            </tr>
            <tr>
              <td><code>phone</code></td>
              <td>Optional. The phone number associated with the shipping address.</td>
            </tr>
          </tbody>
        </table>
      </td>
    </tr>
  </tbody>
</table>

The API will also allow custom attributes to be passed in. These will be exposed within Drip just like [event properties](https://help.drip.com/hc/en-us/articles/4424702593037-Event-Properties).

For example, if your platform includes the concept of product tags, you can include a product_tag attribute in the JSON that can be used in a Drip automation or email [via Liquid](https://help.drip.com/hc/en-us/articles/4424710466957-Call-Event-Properties-with-Liquid). You can attach custom attributes either to events or their items.
