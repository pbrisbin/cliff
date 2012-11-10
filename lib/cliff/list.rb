module Cliff
  class List < Option
    def value
      @value ||= []
    end

    def parser_block
      lambda { |b| self.value << b }
    end
  end
end
