require_relative 'spec_helper'

describe Phaxio do
  before do
    set_default_config
  end

  describe 'send_fax' do
    let(:phaxio) { Phaxio.send_fax(to: '0123456789', filename: 'test.pdf') }
    let(:attrs) { parse_json(phaxio.body) }

    before do
      stub_send_fax
    end

    describe 'success' do
      it 'has a 201 status code' do
        expect(phaxio.code).to eq(201)
      end

      it 'has a message' do
        expect(attrs['message']).to eq('Fax queued for sending')
      end

      it 'has a faxId' do
        expect(attrs['faxId']).to eq(1234)
      end
    end
  end

  describe 'resend_fax' do
    let(:phaxio) { Phaxio.resend_fax(id: 12345) }
    let(:attrs) { parse_json(phaxio.body) }

    before do
      stub_resend_fax
    end

    describe 'success' do
      it 'has a 201 status code' do
        expect(phaxio.code).to eq(201)
      end

      it 'has a message' do
        expect(attrs['message']).to eq('Fax queued for resend')
      end

      it 'has a faxId' do
        expect(attrs['data']['faxId']).to eq(1234)
      end
    end
  end

  describe 'test_receive' do
    let(:phaxio) { Phaxio.test_receive(filename: 'test.pdf') }
    let(:attrs) { parse_json(phaxio.body) }

    before do
      stub_test_receive
    end

    it 'is a success' do
      expect(attrs['success']).to be_truthy
    end

    it 'has a message' do
      expect(attrs['message']).to eq('Test fax received from 234567890. Calling back now...')
    end
  end

  describe 'provision_number' do
    let(:phaxio) { Phaxio.provision_number(area_code: '802') }
    let(:attrs) { parse_json(phaxio.body) }

    before do
      stub_provision_number
    end

    it 'is a success' do
      expect(attrs['success']).to be_truthy
    end

    it 'has a message' do
      expect(attrs['message']).to eq('Number provisioned successfully!')
    end

    it 'has a state' do
      expect(attrs['data']['state']).to eq('Vermont')
    end
  end

  describe 'release_number' do
    let(:phaxio) { Phaxio.release_number(number: '8021112222') }
    let(:attrs) { parse_json(phaxio.body) }

    before do
      stub_release_number
    end

    it 'is a success' do
      expect(attrs['success']).to be_truthy
    end

    it 'has a message' do
      expect(attrs['message']).to eq('Number released successfully!')
    end
  end

  describe 'list_numbers' do
    let(:phaxio) { Phaxio.list_numbers(area_code: '802') }
    let(:attrs) { parse_json(phaxio.body) }

    before do
      stub_list_numbers
    end

    it 'is a success' do
      expect(attrs['success']).to be_truthy
    end

    it 'has a message' do
      expect(attrs['message']).to eq('Retrieved user phone numbers successfully')
    end
  end

  describe 'get_fax_file' do
    let(:phaxio) { Phaxio.get_fax_file(id: 12345) }
    let(:attrs) { phaxio.body }

    before do
      stub_get_fax_file
    end

    it 'has a pdf stream' do
      expect(attrs.size).to eq(6725)
    end
  end

  describe 'list_faxes' do
    let(:phaxio) { Phaxio.list_faxes(start: 1293861600, end: 1294034400) }
    let(:attrs) { parse_json(phaxio.body) }

    before do
      stub_list_faxes
    end

    it 'is a success' do
      expect(attrs['success']).to be_truthy
    end

    it 'has a message' do
      expect(attrs['message']).to eq('Retrieved faxes successfully')
    end

    it 'has faxes' do
      expect(attrs['data'].size).to eq(3)
    end
  end

  describe 'get_fax_status' do
    let(:phaxio) { Phaxio.get_fax_status(id: 123456) }
    let(:attrs) { parse_json(phaxio.body) }

    before do
      stub_get_fax_status
    end

    describe 'success' do
      it 'has a 201 status code' do
        expect(phaxio.code).to eq(201)
      end

      it 'has a message' do
        expect(attrs['message']).to eq('Retrieved fax successfully')
      end

      it 'has a faxId' do
        expect(attrs['data']['id']).to eq(123456)
      end
    end
  end

  describe 'cancel_fax' do
    let(:phaxio) { Phaxio.cancel_fax(id: 123456) }
    let(:attrs) { parse_json(phaxio.body) }

    before do
      stub_cancel_fax
    end

    describe 'success' do
      it 'has a 201 status code' do
        expect(phaxio.code).to eq(201)
      end

      it 'has a message' do
        expect(attrs['message']).to eq('Fax canceled successfully.')
      end
    end
  end

  describe 'delete_fax' do
    let(:phaxio) { Phaxio.delete_fax(id: 123456) }
    let(:attrs) { parse_json(phaxio.body) }

    before do
      stub_delete_fax
    end

    describe 'success' do
      it 'has a 201 status code' do
        expect(phaxio.code).to eq(201)
      end

      it 'has a message' do
        expect(attrs['message']).to eq('Deleted fax successfully!')
      end
    end
  end

  describe 'get_account_status' do
    let(:phaxio) { Phaxio.get_account_status }
    let(:attrs) { parse_json(phaxio.body) }

    before do
      stub_get_account_status
    end

    describe 'success' do
      it 'has a 201 status code' do
        expect(phaxio.code).to eq(201)
      end

      it 'has a message' do
        expect(attrs['message']).to eq('Account status retrieved successfully')
      end

      it 'has a account status' do
        expect(attrs['data']['faxes_sent_this_month']).to eq(120)
        expect(attrs['data']['faxes_sent_today']).to eq(10)
        expect(attrs['data']['balance']).to eq(3000)
      end
    end
  end

  describe 'attach_phaxcode_to_pdf' do
    let(:phaxio) { Phaxio.attach_phaxcode_to_pdf(x: 0, y: 100, filename: 'test.pdf') }
    let(:attrs) { phaxio.body }

    before do
      stub_attach_phaxcode_to_pdf
    end

    describe 'success' do
      it 'attaches phax code to pdf' do
        expect(attrs.size).to eq(6725)
      end
    end
  end

  describe 'create_phaxcode' do
    let(:phaxio) { Phaxio.create_phaxcode(metadata: '1') }
    let(:attrs) { parse_json(phaxio.body) }

    before do
      stub_create_phaxcode
    end

    describe 'success' do
      it 'has a 201 status code' do
        expect(phaxio.code).to eq(201)
      end

      it 'has a message' do
        expect(attrs['message']).to eq('success')
      end

      it 'has a url for the phax code' do
        expect(attrs['data']['url']).to eq('https://api.phaxio.com/v1/renderPhaxCode/3184mp')
      end
    end
  end

  describe 'get_hosted_document' do
    let(:phaxio) { Phaxio.get_hosted_document(name: 'doc_name') }
    let(:attrs) { phaxio.body }

    before do
      stub_get_hosted_document
    end

    describe 'success' do
      it 'returns the hosted document' do
        expect(attrs.size).to eq(6725)
      end
    end
  end

  describe 'supported_countries' do
    let(:phaxio) { Phaxio.supported_countries }
    let(:attrs) { parse_json(phaxio.body) }

    before do
      stub_supported_countries
    end

    describe 'success' do
      it 'has a 201 status code' do
        expect(phaxio.code).to eq(201)
      end

      it 'has a message' do
        expect(attrs['message']).to eq('Data contains supported countries.')
      end

      it 'has a url for the phax code' do
        expect(attrs['data'].size).to eq(29)
      end
    end
  end

  describe 'area_codes' do
    let(:phaxio) { Phaxio.area_codes(is_toll_free: true, state: 'IL') }
    let(:attrs) { parse_json(phaxio.body) }

    before do
      stub_area_codes
    end

    describe 'success' do
      it 'has a 201 status code' do
        expect(phaxio.code).to eq(201)
      end

      it 'has a message' do
        expect(attrs['message']).to eq('32 area codes available.')
      end

      it 'has a url for the phax code' do
        expect(attrs['data'].size).to eq(32)
      end

      it 'has attributes' do
        area_code = attrs['data']['251']
        expect(area_code['city']).to eq('Mobile')
        expect(area_code['state']).to eq('Alabama')
      end
    end
  end

  describe 'generate_check_signature' do
    let(:callback_attrs) { ['example.com', { test: true }] }
    let(:signature) { Phaxio.generate_check_signature(*callback_attrs) }

    it 'matches signature' do
      expect(signature).to eq('15adeecb7eca79676ece07ee4bc1bbba2c69eddd')
    end
  end

  describe 'valid_callback_signature?' do
    let(:callback_attrs) { ['example.com', { test: true }] }

    it 'matches callback signature' do
      actual = Phaxio.valid_callback_signature?(
        '15adeecb7eca79676ece07ee4bc1bbba2c69eddd', *callback_attrs)
      expect(actual).to be_truthy
    end

    it 'does not match invalid signature' do
      actual = Phaxio.valid_callback_signature?(
        'wrong', *callback_attrs)
      expect(actual).to_not be_truthy
    end
  end
end
