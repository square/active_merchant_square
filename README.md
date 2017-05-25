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
