describe SimpleCsvCreator::Column do
  let(:column_name) { :name }
  let(:csv_column) { SimpleCsvCreator::Column.new(column_name) }

  describe '#human_name' do
    context 'column_name symbol' do
      it { expect(csv_column.human_name).to eq('Name') }
    end
    context 'column_name string' do
      let(:column_name) { 'name me' }
      it { expect(csv_column.human_name).to eq('name me') }
    end
  end

  describe '#value' do
    let(:name) { 'test' }
    let(:resource_struct) { Struct.new(:name) }
    let(:resource) { resource_struct.new(name) }
    context 'block given' do
      let(:csv_column) { SimpleCsvCreator::Column.new(column_name){ |r| r.name + '2'} }
      it { expect(csv_column.value(resource)).to eq(name + '2') }
    end

    context 'block not given' do
      it { expect(csv_column.value(resource)).to eq(name) }
    end
  end
end
