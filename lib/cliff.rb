require 'cliff/option'
require 'cliff/flag'
require 'cliff/list'
require 'cliff/option_set'

module Cliff
  class Base
    class << self
      def option(key, description, type = :option)
        options <<
          case type
          when :option
            Option.new(key, description)
          when :flag
            Flag.new(key, description)
          when :list
            List.new(key, description)
          else
            raise 'Invalid option type'
          end
      end

      def load_from_argv(argv)
        set = OptionSet.new(options)
        set.load_from_argv(argv)
      end

      def load_from_yaml(str)
        set = OptionSet.new(options)
        set.load_from_yaml(str)
      end

      def method_missing(key, *args, &block)
        options.detect { |o| o.key == key }.value
      end

      private

      def options
        @options ||= []
      end
    end
  end

end
