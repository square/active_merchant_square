# Payment processing using ActiveMerchantSquare

This sample demonstrates processing card payments with Square Connect API, using the
Active Merchant Square. Take a quick look at [Square APIs: Getting Started](https://docs.connect.squareup.com/articles/getting-started)

## Requirements

Make sure you have Ruby > 1.9, and Bundler  ~> 1.

## Usage

* `bundle install`
* Setup your application credentials by renaming `.env.sample` to `.env` or by adding a `.env` file at the root with following values:

    SQUARE_APPLICATION_ID=your-app-id
    SQUARE_ACCESS_TOKEN=your-access-token

* `bundle exec ruby -S rackup`
* The application runs in `http://localhost:9292/`
* [Testing using the API sandbox](https://docs.connect.squareup.com/articles/using-sandbox)

**Note that if you are _not_ using your sandbox credentials and you enter _real_
credit card information, YOU WILL CHARGE THE CARD.**
