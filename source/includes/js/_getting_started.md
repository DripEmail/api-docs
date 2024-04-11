# Getting Started

The Drip client library has a number of API methods for performing tasks right from your website, such as manually subscribing users and tracking conversions. This document details everything you can do via our JavaScript API.

## Installing Your JavaScript Snippet

> The snippet for your site generally looks something like this:

```html
<!-- Drip -->
<script type="text/javascript">
  var _dcq = _dcq || [];
  var _dcs = _dcs || {};
  _dcs.account = `your account id`;
  // _dcs.cookiePath = '/en'; // If you want to limit the cookie to a specific path.

  (function() {
    var dc = document.createElement('script');
    dc.type = 'text/javascript'; dc.async = true;
    dc.src = '//tag.getdrip.com/`your account id`.js';
    var s = document.getElementsByTagName('script')[0];
    s.parentNode.insertBefore(dc, s);
  })();
</script>
<!-- end Drip -->
```

To interact with the JavaScript API, you'll need to have your Drip snippet installed on your website. Each Drip account has a unique snippet that can be found under Settings → Account → Site Setup.

## How to Send a JS API Request

```javascript
_dcq.push(["methodName", { key: "value", ... }]);
```

All requests follow the same conventions. If you've ever worked with the Google Analytics API, the semantics should look familiar. This is the basic structure of an API request.

API requests are executed asynchronously, so you may safely place them anywhere on the page (even above the Drip snippet).
