# Wootric Ruby API Client

A Ruby toolkit for [Wootric](https://www.wootric.com/) API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'wootric-ruby'
```
And then execute:

		$ bundle

Or install it yourself as:

    $ gem install wootric-ruby

## Usage

Calls for Wootric API v1 are relative to the base url ``https://api.wootric.com/v1/``

API actions are available as methods on the client object. Currently, the Wootric client has the following methods:

| Action 																	 | Method             					                           |
|:-----------------------------------------|:--------------------------------------------------------|
| **End User**                             |                   					                             |
| Return a collection of all users        | `#end_users(options = {})`           																 |
| Return a specific user         	       | `#find_end_user(user_id)`                               |
| Create an end user 			    	           | `#create_end_user(email, options={})`                   |
| Update an end user                       | `#edit_end_user(user_id, options={})`                   |
|	Delete a specific end user 							 | `#delete_end_user(user_id)`										         |
| **End User Settings**                    |                   					                             |
| Return a specific end user's settings    | `#end_user_settings(end_user_id)`                       |
| Update and return updated settings       | `#update_user_settings(end_user_id, nps_email)`         |
| **Decline**                              |                   					                             |
| Return declines for a user               | `#declines(options={})`                                 |
| Return all declines for an end user      | `#end_user_declines(end_user_id, options={})`			     |
| Return a specific decline                | `#find_decline(end_user_id, decline_id)`                |
| Delete a decline for an end user         | `#delete_decline(end_user_id, decline_id)` 						 |
| Create a new decline for an end user 		 | `#create_decline(end_user_id, options={})`              |
| **Response**															 |                      																	 |
| Return responses for a user              | `#responses(options={})`                					       |
| Return responses for an end user         | `#end_user_responses(end_user_id, options={})`          |
| Return Promoter responses for end user   | `#end_user_promoters_responses(end_user_id, options={})`|
| Return Passive responses for end user    | `#end_user_passives_responses(end_user_id, options={})` |
| Return Detractor responses for end user  | `#end_user_detractors_responses(end_user_id, options={})`|
| Return a specific response 							 | `#find_response(end_user_id, response_id)`              |
| Delete a response for an end user        | `#delete_response(end_user_id, response_id)`            |
| Create a new response for an end user    | `#create_response(end_user_id, response_id)`            |

## Usage Examples

### Authentication

Authenticate the client and start exporting data from your account. Get your account `client_id` and `client_secret` from your [Wootric API settings page](https://app.wootric.com/account_settings/edit#!/api).

```ruby
require "wootric"

client = Wootric::Client.new(<client_id>, <client_secret>)

client.auth_token
#=> "<Wootric Access Token>"
```

Here are some common use cases for the Wootric v1 API client.

### You can list all end users for a specific account, and get the details about each end user.

```ruby
client.end_users

#=>
[
  {
    "id": 1,
    "created_at" : "2014-12-01 18:36:59",
    "updated_at" : "2014-12-01 18:36:59",
    "email": "nps@example.com",
    "last_surveyed": null,
    "external_created_at": null,
    "user_id": 16,
    "page_views_count" : 1,
    "properties": {"plan": "Small Business", "product": "Example"}
  },
  {
    "id": 2,
    "created_at" : "2014-12-01 18:36:59",
    "updated_at" : "2014-12-04 12:43:44",
    "email": "nps2@example.com",
    "last_surveyed": null,
    "external_created_at": null,
    "user_id": 16,
    "page_views_count" : 3,
    "properties": {"plan": "Enterprise", "product": "The Company"}
  }
]
```

You can specify the scope parameters as an argument to the `#end_users` method, like

```ruby
client.end_users(email: 'nps@example.com', created: { lt: 1482427321 }, sort_order: 'desc')

#=>
[
  {
    "id": 1,
    "created_at" : "2014-12-01 18:36:59",
    "updated_at" : "2014-12-01 18:36:59",
    "email": "nps@example.com",
    "last_surveyed": null,
    "external_created_at": null,
    "user_id": 16,
    "page_views_count" : 1,
    "properties": {"plan": "Small Business", "product": "Example"}
  }
]
```

Here you can find the list of all available scope parameters - http://docs.wootric.com/api/#get-all-end-users

### You can find specific end user by their user_id.

```ruby
client.find_end_user(2)

#=>
{
  "id": 2,
  "created_at" : "2014-12-01 18:36:59",
  "updated_at" : "2014-12-04 12:43:44",
  "email": "nps2@example.com",
  "last_surveyed": null,
  "external_created_at": null,
  "user_id": 16,
  "page_views_count" : 3,
  "properties": {"plan": "Enterprise", "product": "The Company"}
}
```

### You can list all responses.

```ruby
client.responses(page: 5, per_page: 10, sort_order: 'desc')

#=>
[
  {
    "id": 1,
    "created_at" : "2014-12-01 18:36:59",
    "updated_at" : "2014-12-01 18:36:59",
    "score": 10,
    "text": "Great Service",
    "ip_address": "192.168.0.1",
    "origin_url" : "http://www.great-service.com",
    "end_user_id": 1,
    "user_id": 16
  },
  {
    "id": 2,
    "created_at" : "2014-11-01 17:38:50",
    "updated_at" : "2014-11-01 17:38:50",
    "score": 0,
    "text": "Please fix those bugs",
    "ip_address": "127.0.0.1",
    "origin_url" : "http://www.fix-bugs.com",
    "end_user_id": 2,
    "user_id": 16
  }
]
```

### You can list all declines.

```ruby
client.declines(page: 5, per_page: 10)

#=>

[
  {
    "id": 1,
    "end_user_id": 1,
    "created_at":  "2014-11-01 17:38:50",
    "updated_at":  "2014-11-01 17:38:50",
    "user_id": 1,
    "survey_id": 1
  },
  {
    "id": 2,
    "end_user_id": 2,
    "created_at":  "2014-11-01 17:38:50",
    "updated_at":  "2014-11-01 17:38:50",
    "user_id": 1,
    "survey_id": 2
  }
]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hookengine/wootric-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
