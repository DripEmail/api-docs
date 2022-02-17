# Errors

> If you are authenticated but attempt to access a resource for which you do not have sufficient permissions, you will receive a `403 Forbidden` response.

```json
{
  "errors": [{
    "code": "authorization_error",
    "message": "You are not authorized to access this resource"
  }]
}
```

> If the resource is not found, you will receive a `404 Not Found` response.

```json
{
  "errors": [{
    "code": "not_found_error",
    "message": "The resource you requested was not found"
  }]
}
```

Drip responds to invalid requests in a number of different ways. Exceptions to these rules will be noted for any applicable endpoints. Assume authentication is required on all endpoints unless otherwise noted.

If you attempt to anonymously access a resource that requires authentication, you will receive a `401 Unauthorized` response.

## Validation Errors

> An example response:

```json
{
  "errors": [
    {
      "code": "presence_error",
      "attribute": "email",
      "message": "Email is required"
    },
    {
      "code": "length_error",
      "attribute": "name",
      "message": "Name must be between 2 and 20 characters"
    }
  ]
}
```

If validation errors occur while attempting to create or update a resource, you will receive a `422 Unprocessable Entity` response with an errors object detailing which attributes are invalid. One of the following codes will assigned to each error object:

<table>
  <thead>
    <tr>
      <th>Code</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>presence_error</code></td>
      <td>The attribute is required.</td>
    </tr>
    <tr>
      <td><code>length_error</code></td>
      <td>The length of the attribute is out of bounds.</td>
    </tr>
    <tr>
      <td><code>uniqueness_error</code></td>
      <td>The attribute must be unique.</td>
    </tr>
    <tr>
      <td><code>email_error</code></td>
      <td>The attribute must be a valid email address.</td>
    </tr>
    <tr>
      <td><code>sms_error</code></td>
      <td>The attribute must be a valid US mobile number with E.164 formatting. E.g. <code>"+16125551212"</code>.</td>
    </tr>
    <tr>
      <td><code>url_error</code></td>
      <td>The attribute must be a valid URL.</td>
    </tr>
    <tr>
      <td><code>domain_error</code></td>
      <td>The attribute must be a valid domain name.</td>
    </tr>
    <tr>
      <td><code>time_error</code></td>
      <td>The attribute must be a valid time in ISO-8601 format.</td>
    </tr>
    <tr>
      <td><code>email_address_list_error</code></td>
      <td>The attribute must be a valid comma-separated list of email addresses.</td>
    </tr>
    <tr>
      <td><code>days_of_the_week_error</code></td>
      <td>The attribute must be a valid days of the week mask of the format <br><code>/\A(0|1){7}\z/</code> (excluding <code>0000000</code>).</td>
    </tr>
    <tr>
      <td><code>unavailable_error</code></td>
      <td>A resource has been disabled or deleted.</td>
    </tr>
    <tr>
      <td><code>format_error</code></td>
      <td>A resource identifier or object is not formatted correctly.</td>
    </tr>
    <tr>
      <td><code>range_error</code></td>
      <td>A numeric value is out of range.</td>
    </tr>
  </tbody>
</table>

## Transition Errors

> An example response:

```json
{
  "errors": [
    {
      "code": "no_postal_address_error"
    }
  ]
}
```

State transition endpoints will respond with a `403 Forbidden` and an errors object if the transition is not allowed.
