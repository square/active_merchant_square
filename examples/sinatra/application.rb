require 'sinatra/base'
require 'sprockets'
require 'sprockets-helpers'
require 'json'
require 'active_merchant_square'
require 'dotenv'

Dotenv.load

APPLICATION_ID = ENV['SQUARE_APPLICATION_ID']
ACCESS_TOKEN = ENV['SQUARE_ACCESS_TOKEN']
LOCATION_ID = ENV['SQUARE_LOCATION_ID']

PRODUCT_COST = {
  "001" => 100,
  "002" => 4900,
  "003" => 500000
}

class Application < Sinatra::Base
  set :assets, Sprockets::Environment.new(root)

  configure do
    assets.append_path File.join(root, 'assets', 'stylesheets')
    assets.append_path File.join(root, 'assets', 'javascripts')

    Sprockets::Helpers.configure do |config|
      config.environment = assets
      config.prefix      = '/assets'
      config.digest      = true
    end
  end

  helpers do
    include Sprockets::Helpers
  end

  before do
    cache_control :public, :must_revalidate, :max_age => 60
  end

  get '/' do
    erb :index, :locals => {application_id: APPLICATION_ID}
  end

  post '/charges' do
    content_type :json

    if !PRODUCT_COST.has_key? params[:product_id]
      return {:status => 400, :errors => [{"detail": "Product unavailable"}]}.to_json
    end

    amount = PRODUCT_COST[params[:product_id]]
    card_nonce = params[:nonce]

    response = gateway.purchase(amount, card_nonce)

    if response.success?
      {status: 200}.to_json
    else
      {status: 400, error_type: response.error_code, error_message: response.message}.to_json
    end
  end

  def gateway
    credentials = {
      login: APPLICATION_ID,
      password: ACCESS_TOKEN,
      location_id: LOCATION_ID,
      test: false
    }
    ActiveMerchant::Billing::SquareGateway.new(credentials)
  end
end