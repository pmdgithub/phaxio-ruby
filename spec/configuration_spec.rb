require_relative 'spec_helper'

describe Phaxio do
  describe 'configuration' do
    before do
      Phaxio.config do |config|
        config.api_key = '12345678910'
        config.api_secret = '10987654321'
        config.callback_token = '1234567890'
      end
    end

    it 'assigns api key' do
      expect(Phaxio.api_key).to eq('12345678910')
    end

    it 'assigns api secret' do
      expect(Phaxio.api_secret).to eq('10987654321')
    end

    it 'assigns callback token' do
      expect(Phaxio.callback_token).to eq('1234567890')
    end
  end
end
