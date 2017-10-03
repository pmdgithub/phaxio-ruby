module Phaxio
  module Tests
    module Webmocks
      def stub_send_fax
        stub_request(:post, 'https://api.phaxio.com/v1/send').
          with(body: 'api_key=12345678910&api_secret=10987654321&filename=test.pdf&to=0123456789').
          to_return(
            body: File.open('spec/fixtures/responses/send_success.json'),
            status: 201
        )
      end

      def stub_resend_fax
        stub_request(:post, 'https://api.phaxio.com/v1/resendFax').
          with(body: "api_key=12345678910&api_secret=10987654321&id=12345").
          to_return(
            body: File.open('spec/fixtures/responses/resend_success.json'),
            status: 201
        )
      end

      def stub_test_receive
        stub_request(:post, 'https://api.phaxio.com/v1/testReceive').
          with(body: "api_key=12345678910&api_secret=10987654321&filename=test.pdf").
          to_return(
            body: File.open('spec/fixtures/responses/test_receive_success.json'),
            status: 201
        )
      end

      def stub_provision_number
        stub_request(:post, 'https://api.phaxio.com/v1/provisionNumber').
          with(body: "api_key=12345678910&api_secret=10987654321&area_code=802").
          to_return(
            body: File.open('spec/fixtures/responses/provision_number_success.json'),
            status: 201
        )
      end

      def stub_release_number
        stub_request(:post, 'https://api.phaxio.com/v1/releaseNumber').
          with(body: "api_key=12345678910&api_secret=10987654321&number=8021112222").
          to_return(
            body: File.open('spec/fixtures/responses/release_number_success.json'),
            status: 201
        )
      end

      def stub_list_numbers
        stub_request(:post, 'https://api.phaxio.com/v1/numberList').
          with(body: "api_key=12345678910&api_secret=10987654321&area_code=802").
          to_return(
            body: File.open('spec/fixtures/responses/list_numbers_success.json'),
            status: 201
        )
      end

      def stub_get_fax_file
        stub_request(:post, 'https://api.phaxio.com/v1/faxFile').
          with(body: "api_key=12345678910&api_secret=10987654321&id=12345").
          to_return(
            body: sample_fax.read,
            status: 201
        )
      end

      def stub_list_faxes
        stub_request(:post, 'https://api.phaxio.com/v1/faxList').
          with(body: "api_key=12345678910&api_secret=10987654321&end=1294034400&start=1293861600").
          to_return(
            body: File.open('spec/fixtures/responses/list_faxes_success.json'),
            status: 201
        )
      end

      def stub_get_fax_status
        stub_request(:post, 'https://api.phaxio.com/v1/faxStatus').
          with(body: "api_key=12345678910&api_secret=10987654321&id=123456").
          to_return(
            body: File.open('spec/fixtures/responses/get_fax_status_success.json'),
            status: 201
        )
      end

      def stub_cancel_fax
        stub_request(:post, 'https://api.phaxio.com/v1/faxCancel').
          with(body: "api_key=12345678910&api_secret=10987654321&id=123456").
          to_return(
            body: File.open('spec/fixtures/responses/cancel_fax_success.json'),
            status: 201
        )
      end

      def stub_delete_fax
        stub_request(:post, 'https://api.phaxio.com/v1/deleteFax').
          with(body: "api_key=12345678910&api_secret=10987654321&id=123456").
          to_return(
            body: File.open('spec/fixtures/responses/delete_fax_success.json'),
            status: 201
        )
      end

      def stub_get_account_status
        stub_request(:post, 'https://api.phaxio.com/v1/accountStatus').
          with(body: "api_key=12345678910&api_secret=10987654321").
          to_return(
            body: File.open('spec/fixtures/responses/get_account_status_success.json'),
            status: 201
        )
      end

      def stub_attach_phaxcode_to_pdf
        stub_request(:post, 'https://api.phaxio.com/v1/attachPhaxCodeToPdf').
          with(body: "api_key=12345678910&api_secret=10987654321&filename=test.pdf&x=0&y=100").
          to_return(
            body: sample_fax.read,
            status: 201
        )
      end

      def stub_create_phaxcode
        stub_request(:post, 'https://api.phaxio.com/v1/createPhaxCode').
          with(body: "api_key=12345678910&api_secret=10987654321&metadata=1").
          to_return(
            body: File.open('spec/fixtures/responses/create_phaxcode_success.json'),
            status: 201
        )
      end

      def stub_get_hosted_document
        stub_request(:post, 'https://api.phaxio.com/v1/getHostedDocument').
          with(body: "api_key=12345678910&api_secret=10987654321&name=doc_name").
          to_return(
            body: sample_fax.read,
            status: 201
        )
      end

      def stub_supported_countries
        stub_request(:post, 'https://api.phaxio.com/v1/supportedCountries').
          with(body: "api_key=12345678910&api_secret=10987654321").
          to_return(
            body: File.open('spec/fixtures/responses/supported_countries_success.json'),
            status: 201
        )
      end

      def stub_area_codes
        stub_request(:post, 'https://api.phaxio.com/v1/areaCodes').
          with(body: "api_key=12345678910&api_secret=10987654321&is_toll_free=true&state=IL").
          to_return(
            body: File.open('spec/fixtures/responses/area_codes_success.json'),
            status: 201
        )
      end
    end
  end
end
