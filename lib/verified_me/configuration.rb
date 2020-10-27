module VerifiedMe
  class Configuration
    REQUIRED_PARAMETERS = %i[
      api_key
      host
    ].freeze
    OPTIONAL_PARAMETERS = %i[
      open_timeout
      read_timeout
      user_agent
    ].freeze

    attr_accessor(*(REQUIRED_PARAMETERS | OPTIONAL_PARAMETERS))

    def fetch(key, default = nil)
      if default
        public_send(key) || default
      else
        public_send(key) || missing!(key)
      end
    end

    def validate_parameters!
      REQUIRED_PARAMETERS.each do |param|
        fetch(param)
      end
    end

    def open_timeout
      @open_timeout ||= 5
    end

    def read_timeout
      @read_timeout ||= 10
    end

    def user_agent
      @user_agent ||= "verified_me/#{VerifiedMe::VERSION}"
    end

    private

    def missing!(key)
      raise Exception::MissingConfiguration.new(
        key: key,
        message: "configuration key #{key} is nil"
      )
    end
  end
end
