# frozen_string_literal: true

module VerifiedMe
  module Exceptions
    class MissingConfiguration < StandardError
      attr_accessor :message, :key

      def initialize(opts = {})
        self.message = opts.fetch(:message)
        self.key = opts.fetch(:key)
      end

      def to_s
        message
      end
    end
  end
end
