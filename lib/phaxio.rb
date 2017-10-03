require 'typhoeus'

require 'phaxio/version'
require 'phaxio/config'
require 'phaxio/client'

module Phaxio
  # Public: Configure Phaxio with your api_key, api_secret, and the callback
  #         token provided in your Phaxio account (to verify that requests are
  #         coming from Phaxio).
  #
  # Examples
  #
  #   Phaxio.config do |config|
  #      config.api_key = '12345678910'
  #      config.api_secret = '10987654321'
  #      config.callback_token = '32935829'
  #    end
  #
  # Returns nothing.
  def self.config
    yield(self)
  end

  extend Client
  extend Config
end
