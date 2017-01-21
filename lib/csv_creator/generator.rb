module CsvCreator
  class Generator
    attr_reader :columns

    def initialize
      @columns = []
    end

    def column(column_name, &block)
      column = ::CsvCreator::Column.new(column_name, &block)
      @columns.push(column)
    end

    def simple_generate(resources)
      generate do |csv, columns|
        resources.each do |resource|
          csv << columns.map { |column| column.value(resource) }
        end
      end
    end

    def generate_using(generator)
      generate do |csv, columns|
        generator.call do |resource|
          csv << columns.map { |column| column.value(resource) }
        end
      end
    end


    private
    def generate
      CSV.generate do |csv|
        csv << column_human_names
        yield(csv, columns)
      end
    end

    def column_human_names
      @columns.map(&:human_name)
    end
  end
end
