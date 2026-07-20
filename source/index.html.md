---
title: Drip API Reference

language_tabs: # must be one of https://git.io/vQNgJ
  - shell: cURL
  - ruby: Ruby
  - javascript: JavaScript

toc_footers:
  - <a href='https://www.drip.com/pricing' target='_blank'>Need a Drip Account? Sign Up</a>

includes_rest_api:
  - rest/authentication
  - rest/rate_limiting
  - rest/batch_api
  - rest/pagination
  - rest/errors
  - rest/accounts
  - rest/broadcasts
  - rest/campaigns
  - rest/email_metrics
  - rest/custom_fields
  - rest/conversions
  - rest/events
  - rest/forms
  - rest/orders
  - rest/subscribers
  - rest/tags
  - rest/users
  - rest/workflows
  - rest/webhooks
  - rest/webhook_events

includes_js_api:
  - js/getting_started
  - js/identify
  - js/track
  - js/product_views
  - js/tagging
  - js/campaign_subscriptions
  - js/forms

includes_cdc:
  - cdc/custom_dynamic_content
  - cdc/api_requirements
  - cdc/preview
  - cdc/example

includes_shopper_activity:
  - shopper_activity/overview
  - shopper_activity/cart_activity
  - shopper_activity/order_activity
  - shopper_activity/product_activity

search: true
---

# Introduction

Welcome to the Drip API! The REST API communicates exclusively in JSON over SSL (HTTPS).
All endpoint URLs begin with `https://api.getdrip.com/`. Additionally, the REST API requires the use of a client which supports [SNI](https://en.wikipedia.org/wiki/Server_Name_Indication).

Parameters must be serialized in JSON and passed in the request body (not in the query string or form parameters). You should use the media type designation of `application/json`.
