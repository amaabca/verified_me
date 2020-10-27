module VerifiedMe
  class License
    class << self
      def request(opts = {})
        client = Client.new({ resource_path: '/dac/licenseRequest' }.merge(opts))
        Type::LicenseRequest::Response.shrink_wrap(client.execute!.parse)
      end

      def use(opts = {})
        client = Client.new({ resource_path: '/dac/useLicense' }.merge(opts))
        Type::UseLicense::Response.shrink_wrap(client.execute!.parse)
      end
    end
  end
end
