# Identifying Visitors

## Attach Identifying Data to Visitors

> Example identify request with a success callback

```javascript
_dcq.push(["identify", {
  email: "john@acme.com",
  first_name: "John",
  tags: ["Customer"],
  success: function(response) {
    // Call a method with the response object
    // Success callback is optional
  }
}]);
```

The `identify` method pushes subscriber data into Drip. If the subscriber is not yet in your account, we will create a new record for them; otherwise, we update their record with the information you pass in. To update a subscriber's email address, use the `new_email` property.

### Properties

The following are treated as special properties. All other data passed in will be added to the subscriber's custom fields. Keys should be lowercase, with words separated by underscores.

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
      <td>Optional. The subscriber's email address.</td>
    </tr>
    <tr>
      <td><code>new_email</code></td>
      <td>Optional. Use this to update an existing subscriber's email address</td>
    </tr>
    <tr>
      <td><code>user_id</code></td>
      <td>Optional. A unique identifier for the user in your database, such as a primary key.</td>
    </tr>
    <tr>
      <td><code>tags</code></td>
      <td>Optional. An Array of tags to apply.</td>
    </tr>
    <tr>
      <td><code>remove_tags</code></td>
      <td>Optional. An Array of tags to remove.</td>
    </tr>
    <tr>
      <td><code>prospect</code></td>
      <td>Optional. A Boolean specifiying whether we should attach a lead score to the subscriber (when lead scoring is enabled). Defaults to <code>true</code>. <strong>Note</strong>: This flag used to be called <code>potential_lead</code>, which we will continue to accept for backwards compatibility.</td>
    </tr>
    <tr>
      <td><code>success</code></td>
      <td>Optional. A callback function that is executed upon successful completion of the request.</td>
    </tr>
    <tr>
      <td><code>failure</code></td>
      <td>Optional. A callback function that is executed if the request fails.</td>
    </tr>
  </tbody>
</table>

### Response

> Example response

```json
{
  success: true,
  visitor_uuid: "f627ee608adb01315d1022000ab2058a",
  anonymous: false,
  email: "john@acme.com",
  custom_fields: { "name": "John" },
  tags: ["Customer"],
  lead_score: 35
}
```

The identify request will pass a response object to the <code>success</code> or <code>failure</code> callback functions (if provided) once the call completes.

<table>
  <thead>
    <tr>
      <th>Key</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>success</code></td>
      <td>Boolean. True if the call to Drip succeeded.</td>
    </tr>
    <tr>
      <td><code>visitor_uuid</code></td>
      <td>The unique id for the visitor identified.</td>
    </tr>
    <tr>
      <td><code>anonymous</code></td>
      <td>Boolean. False if the visitor is associated with a subscriber.</td>
    </tr>
    <tr>
      <td><code>email</code></td>
      <td>Included only if the visitor is not anonymous. The associated subscriber's email address.</td>
    </tr>
    <tr>
      <td><code>custom_fields</code></td>
      <td>An Object containing custom fields that are marked as public in your settings (see Subscribers > Custom Fields). Custom fields containing sensitive information should not be marked as public, for security purposes.</td>
    </tr>
    <tr>
      <td><code>tags</code></td>
      <td>An array of the subscriber's tags.</td>
    </tr>
    <tr>
      <td><code>lead_score</code></td>
      <td>Included if the subscriber is a prospect.</td>
    </tr>
    <tr>
      <td><code>error</code></td>
      <td>String. Contains an error message if the request failed.</td>
    </tr>
  </tbody>
</table>