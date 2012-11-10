require 'cliff/option'
require 'cliff/options'
require 'cliff/flag'
require 'cliff/list'

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
        options.load_from_argv!(argv)
      end

      def load_from_yaml(str)
        options.load_from_yaml!(str)
      end

      def method_missing(key, *args, &block)
        options.detect { |o| o.key == key }.value
      end

      private

      def options
        @options ||= Options.new
      end
    end
  end
end
