describe SimpleCsvCreator do
  let(:resource_class) do
    Class.new do
      attr_reader :name, :email, :age, :join_at
      def initialize(params = {})
        @name = params[:name]
        @age = params[:age]
        @email = params[:email]
        @join_at = params[:join_at]
      end
    end
  end

  let(:resource1) { resource_class.new(name: 'jack', email: 'jack@example.com', age: 20, join_at: Time.now) }
  let(:resource2) { resource_class.new(name: 'daniel', email: 'daniel@example.com', age: 10, join_at: Time.now - 3600) }
  let(:resources) { [resource1, resource2] }

  describe '.schema' do
    let(:csv_creator) {
      SimpleCsvCreator.schema do
        column :email
        column :name
      end
    }
    let(:csv_result) { CSV.parse(csv_creator.simple_generate(resources)) }

    it { expect(csv_result.to_a).to eq([['Email', 'Name'], [resource1.email, resource1.name], [resource2.email, resource2.name]]) }

    context 'any block' do
      let(:csv_creator) {
        SimpleCsvCreator.schema do
          column :email
          column(:name) { |resource| resource.name + '2' }
        end
      }

      it { expect(csv_result.to_a).to eq([['Email', 'Name'], [resource1.email, resource1.name + '2'], [resource2.email, resource2.name + '2']]) }
    end
  end
end
