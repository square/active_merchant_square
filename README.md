# Active Merchant Square

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'active_merchant_square'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install active_merchant_square

## Usage

This simple example demonstrates how a purchase can be made after getting [a card nonce](https://docs.connect.squareup.com/articles/processing-payment-rest#chargingcardnonce)

```ruby
require 'active_merchant_square'

# Get your login and password by going to: https://connect.squareup.com/apps
credentials = {
  login: 'sandbox-sq0idp-APPLICATION_ID',
  password: 'sandbox-sq0atb-APPLICATION_SECRET',
  # How to get your location ID, see: https://docs.connect.squareup.com/articles/faq-lookup-my-location-id
  location_id: 'LOCATION_ID',
}

amount = 1000  # $10.00

gateway = ActiveMerchant::Billing::SquareGateway.new(credentials)
response = gateway.purchase(amount, card_nonce)

if response.success?
   puts "Successfully charged $#{sprintf("%.2f", amount / 100)}"
else
   raise StandardError, response.message
end

```

For more in-depth documentation and tutorials, see [Square Documentation site](https://docs.connect.squareup.com/)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test-unit` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/frojasg/active_merchant_square.
