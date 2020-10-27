module VerifiedMe
  module Mixin
    module Type
      def self.included(base)
        base.include(Shrink::Wrap)
        base.include(InstanceMethods)
        base.extend(ClassMethods)
        base.transform(Shrink::Wrap::Transformer::Symbolize)
      end

      module InstanceMethods
        def assign_attributes!(opts = {})
          self.class.attributes.each do |attribute|
            instance_variable_set("@#{attribute}", opts[attribute])
          end
        end
      end

      module ClassMethods
        def required(attribute, opts = {})
          property(attribute, opts.merge(allow_nil: false))
        end

        def optional(attribute, opts = {})
          property(attribute, opts.merge(allow_nil: true))
        end

        def property(attribute, opts = {})
          from = opts.fetch(:from) do
            Support::Inflector.new(attribute)
              .to_camel_case
              .to_sym
          end
          params = { from: from }.merge(opts)

          attr_accessor(attribute)

          mapping[attribute] = from
          translate(attribute => params)
        end

        def attributes
          @attributes ||= mapping.keys
        end

        def mapping
          @mapping ||= {}
        end
      end
    end
  end
end
