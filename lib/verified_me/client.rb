module VerifiedMe
  class Client
    ATTRIBUTES = %i[
      headers
      host
      open_timeout
      payload
      raw_response
      read_timeout
      resource_path
      transaction_id
      user_identifier
    ].freeze

    attr_accessor(*ATTRIBUTES)

    def initialize(opts = {})
      self.transaction_id = opts.fetch(:transaction_id) { SecureRandom.uuid }
      self.host = opts.fetch(:host) { VerifiedMe.configuration.host }
      self.open_timeout = opts.fetch(:open_timeout) { VerifiedMe.configuration.open_timeout }
      self.payload = opts.fetch(:payload).to_json
      self.read_timeout = opts.fetch(:read_timeout) { VerifiedMe.configuration.read_timeout }
      self.resource_path = opts.fetch(:resource_path)
      self.user_identifier = opts[:user_identifier] # optional
      self.headers = default_headers.merge(opts.fetch(:headers) { {} })
    end

    def execute!
      request!
      self
    end

    def endpoint_url
      URI.join(host, resource_path).to_s
    end

    def parse
      return unless raw_response
      return if raw_response.body.empty?

      JSON.parse(raw_response.body)
    end

    private

    def request!
      self.raw_response = RestClient::Request.logged_request(params)
    end

    def params
      {
        payload: payload,
        headers: headers,
        method: :post,
        open_timeout: open_timeout,
        read_timeout: read_timeout,
        url: endpoint_url
      }
    end

    def default_headers
      {
        'Accept' => 'application/json',
        'Content-Type' => 'application/json',
        'TransactionId' => transaction_id,
        'User-Agent' => VerifiedMe.configuration.user_agent,
        'X-Api-Key'=> VerifiedMe.configuration.api_key
      }
    end
  end
end
