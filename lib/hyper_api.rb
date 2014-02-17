require 'nokogiri'
require 'hyper_api/version'

module HyperAPI

  def self.new_class(&block)
    klass = Class.new(Base)
    klass.class_eval(&block) if block_given?
    klass
  end

  class Base
    class << self
      KNOWN_ATTRIBUTE_TYPES = %w(string integer float)

      def known_attributes
        @known_attributes ||= {}
      end

      KNOWN_ATTRIBUTE_TYPES.each do |attr_type|
        # def string(name, path, &block)
        #   known_attributes[name] = ['string', path, block]
        # end
        class_eval <<-EOV, __FILE__, __LINE__ + 1
          def #{attr_type}(attribute, &block)
            name, path = attribute.to_a.flatten
            known_attributes[name] = ['#{attr_type}', path, block]
          end
        EOV
      end
    end

    def initialize(html_string)
      html = ::Nokogiri::HTML(html_string)
      load_attributes(html)
    end

    def load_attributes(html)
      known_attributes.each do |attr, options|
        type, path, block = options

        unless (value = html.css(path)).empty?
          value = block ? value.instance_eval(&block) : value.text
          value = value.send("to_#{type[0]}")
        end

        instance_variable_set("@#{attr}", value)

        self.class.send :define_method, attr do
          instance_variable_get("@#{attr}")
        end
      end
    end

    def known_attributes
      self.class.known_attributes
    end

  end
end
