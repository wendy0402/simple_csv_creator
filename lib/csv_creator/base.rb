class CsvCreator::Base
  attr_reader :columns

  def initialize(resources)
    @resources = resources
    @columns = []
  end

  def column(column_name, &block)
    human_name ||= column_name.to_s
    column = ::CsvCreator::Column.new(column_name, &block)
    @columns.push(column)
  end

  def generate
    CSV.generate do |csv|
      csv << column_human_names
      @resources.each do |resource|
        csv << columns.map { |column| column.exec_column(resource) }
      end
    end
  end

  def column_human_names
    @columns.map(&:human_name)
  end
end
