require 'json'
require 'pathname'
require 'rest_client'
require 'rest_client/jogger'
require 'securerandom'
require 'shrink/wrap'

require_relative 'verified_me/version'
require_relative 'verified_me/exception/missing_configuration'
require_relative 'verified_me/configuration'
require_relative 'verified_me/client'
require_relative 'verified_me/support/inflector'
require_relative 'verified_me/mixin/type'
require_relative 'verified_me/type/base'
require_relative 'verified_me/type/license_request/response'
require_relative 'verified_me/type/use_license/response'
require_relative 'verified_me/license'

module VerifiedMe
  class << self
    attr_writer :configuration

    def gem_path
      @gem_path ||= Pathname.new(Gem.loaded_specs['verified_me'].full_gem_path)
    end

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration).tap { configuration.validate_parameters! }
    end
  end
end
