module VerifiedMe
  module Type
    module UseLicense
      class Response < Base
        include Mixin::Type

        required :id
        required :state
        required :assets
        optional :service_responses
        optional :auth
      end
    end
  end
end
