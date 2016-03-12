class CsvCreator::Column
  attr_reader :column_name, :block
  def initialize(column_name, &block)
    @column_name = column_name
    @block = block
  end

  def human_name
    column_name.is_a?(Symbol) ? column_name.to_s.titleize : column_name
  end

  def exec_column(resource)
    if block.present?
      block.call(resource)
    else
      resource.public_send(column_name)
    end
  end
end
