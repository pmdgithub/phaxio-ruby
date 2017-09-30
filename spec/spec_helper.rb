$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'webmock/rspec'
require 'phaxio'
require 'support/webmocks'
require 'support/helpers'

RSpec.configure do |config|
  config.include Phaxio::Tests::Webmocks
  config.include Phaxio::Tests::Helpers
end
