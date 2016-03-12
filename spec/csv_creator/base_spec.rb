describe CsvCreator do
  let(:resource_class) do
    Class.new do
      attr_reader :name, :email, :age
      def initialize(params = {})
        @name = params[:name]
        @age = params[:age]
        @email = params[:email]
      end
    end
  end

  let(:resource1) { resource_class.new(name: 'turbo', email: 'test@example.com', age: 20) }
  let(:resource2) { resource_class.new(name: 'pato', email: 'pato@example.com', age: 10) }
  let(:resources) { [resource1, resource2] }
  let(:csv_creator) { CsvCreator::Base.new(resources) }

  describe '#column' do
    context 'put new column without human_name' do
      before do
        csv_creator.column('email')
      end

      it { expect(csv_creator.columns.map(&:column_name)).to match_array(['email'])}

      it 'use the given column name' do
        expect(csv_creator.columns[0].human_name).to eq('email')
      end
    end

    context 'put more than one column' do
      before do
        csv_creator.column(:email)
        csv_creator.column(:age)
      end

      it { expect(csv_creator.columns.map(&:column_name)).to eq([:email, :age]) }
    end

    context 'using block' do
      before do
        csv_creator.column('Emailsss'){ |resource| resource.email }
        csv_creator.column(:age)
      end

      it { expect(csv_creator.columns[0].column_name).to eq('Emailsss') }
      it { expect(csv_creator.columns[0].block).to be_present }
    end
  end

  describe '#generate' do
    before do
      csv_creator.column(:email)
      csv_creator.column(:age)
    end
    let(:result) { csv_creator.generate }
    let(:csv_result) { CSV.parse(result) }

    context 'columns present' do
      it 'generate the csv' do
        expect(csv_result.to_a).to eq([["Email", "Age"], [resource1.email, resource1.age.to_s], [resource2.email, resource2.age.to_s]])
      end
    end

    context 'no columns present' do
      let(:resources) { [] }
      it 'only have the headers' do
        expect(csv_result.to_a).to eq([["Email", "Age"]])
      end
    end

    context 'use block' do
      before do
        csv_creator.column('Short Name') { |resource| resource.name}
      end

      it 'headers use the human name' do
        expect(csv_result.to_a[0]).to eq(["Email", "Age", "Short Name"])
      end

      it 'return name' do
        expect(csv_result[1][2]).to eq(resource1.name)
      end
    end

    context 'use symbol and block' do
      before do
        csv_creator.column(:name) { |resource| resource.name + '2' }
      end

      it 'get the column value using block instead call method based on column_name' do
        expect(csv_result[1][2]).to eq(resource1.name + '2')
      end

      it 'column name use titleize column_name' do
        expect(csv_result.to_a[0][2]).to eq("Name")
      end
    end
  end
end
