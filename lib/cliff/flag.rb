module Cliff
  class Flag < Option
    def parser_args
      [ "--[no-]#{key}", description ]
    end
  end
end
