module VerifiedMe
  module Type
    module LicenseRequest
      class Response < Base
        include Mixin::Type

        required :request_id
        required :request_enc_key
        required :app_link

        coerce(
          app_link: ->(v) { URI.parse(v) }
        )
      end
    end
  end
end
