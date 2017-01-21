module CsvCreator
  class Column
    attr_reader :column_name, :block
    def initialize(column_name, &block)
      @column_name = column_name
      @block = block
    end

    def human_name
      column_name.is_a?(Symbol) ? titleize(column_name.to_s) : column_name
    end

    def value(resource)
      if block
        block.call(resource)
      else
        resource.public_send(column_name)
      end
    end

    private
    def titleize(word)
      word.split("_").map{ |chunk| chunk.capitalize}.join(" ")
    end
  end
end
