# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_merchant_square/version'

Gem::Specification.new do |spec|
  spec.name          = "active_merchant_square"
  spec.version       = ActiveMerchantSquare::VERSION
  spec.authors       = ["Francisco Rojas"]
  spec.email         = ["frojas@squareup.com"]

  spec.summary       = %q{Active Merchant Square is a Square enhancement of the payment abstraction library active_merchant to  support for Square's e-commerce API.}
  spec.description   = %q{Use this gem instead of ActiveMerchant gem if you want to use Square's e-commerce APIs (https://squareup.com/developers) with ActiveMerchant. The official ActiveMerchant gem does not support Square because Square shields raw credit card numbers from developers to make PCI compliance easier. This has all ActiveMerchant functionality, plus support of Square's card nonces in the iframe API.}
  spec.homepage      = "https://github.com/square/active_merchant_square"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"

  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "test-unit", "~> 3"
  spec.add_development_dependency 'mocha', '~> 1'

  spec.add_dependency 'activemerchant', "~> 1.66"
end
