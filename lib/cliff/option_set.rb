require 'optparse'
require 'yaml'

module Cliff
  class OptionSet
    attr_reader :options

    def initialize(options)
      @options = options
    end

    def load_from_argv(argv)
      OptionParser.new do |p|
        options.each do |o|
          p.on(*o.parser_args, &o.parser_block)
        end
      end.parse!(argv)

      argv
    end

    def load_from_yaml(str)
      hsh = YAML.load(str)

      options.each do |o|
        if v = hsh[o.key.to_s]
          o.value = v
        end
      end
    end
  end
end
