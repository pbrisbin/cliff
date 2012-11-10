module Cliff
  class Option < Struct.new(:key, :description)
    attr_accessor :value

    def parser_args
      [ "--#{key} VALUE", description ]
    end

    def parser_block
      lambda { |b| self.value = b }
    end
  end
end
