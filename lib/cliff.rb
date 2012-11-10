require "cliff/version"
require 'yaml'

module Cliff
  class Base

    def self.option(key, type, default)
      case type
      when :bool
        class_eval <<-EOC
          def self.#{key}?
            config['#{key}'] || #{default.inspect}
          end
        EOC
      when :string
        class_eval <<-EOC
          def self.#{key}
            config['#{key}'] || #{default.inspect}
          end
        EOC
      end
    end

    def self.load(str)
      @config = @config.merge(YAML::load(str))
    end

    def self.config
      @config ||= {}
    end

  end
end
