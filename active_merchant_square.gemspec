# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_merchant_square/version'

Gem::Specification.new do |spec|
  spec.name          = "active_merchant_square"
  spec.version       = ActiveMerchantSquare::VERSION
  spec.authors       = ["Francisco Rojas"]
  spec.email         = ["frojas@squareup.com"]

  spec.summary       = %q{Framework and tools for dealing with credit card transactions using Square.}
  spec.description   = %q{Active Merchant Square is a Square implementation of the payment abstraction library active_merchant.}
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
