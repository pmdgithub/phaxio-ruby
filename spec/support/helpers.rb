module Phaxio
  module Tests
    module Helpers
      def parse_json(str)
        JSON.parse(str)
      end

      def sample_fax
        File.open('spec/fixtures/test.pdf')
      end

      def set_default_config
        Phaxio.config do |config|
          config.api_key = '12345678910'
          config.api_secret = '10987654321'
          config.callback_token = '1234567890'
        end
      end
    end
  end
end
