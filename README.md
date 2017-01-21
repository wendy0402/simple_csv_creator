# SimpleCsvCreator

SimpleCsvCreator has DSL to build the csv. It's inspired by activeadmin csv

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'simple_csv_creator'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install csv_creator

## Usage

SimpleCsvCreator has DSL to build the csv
it's inspired by activeadmin csv
example:

```ruby
class User
  attr_reader :name, :age, :gender
  def initialize(name, age, gender)
    @name = name
    @age = age
    @gender = gender
  end
end

user1 = User.new('test', 20, 'female')
user2 = User.new('mobile', 13, 'male')
csv_creator = SimpleCsvCreator.schema do
  column(:name) # if without block then it will run the name given(user.name), header name will be titleize of name
  column(:age) { |r| r.age + ' years' } # if with block will run the block
  column('User Gender') { |r| r.gender } # if want to use custom title need to give the block
end
result = SimpleCsvCreator.simple_generate([user1, user2])
csv_parse = CSV.parse(result)
csv_parse:
[
  ['Name', 'Age', 'User Gender'],
  ['test', '20 years', 'female'],
  ['mobile', '13 years', 'male']
]
```

Sometimes you want to do lazy fetch e.g: `find_each` method in ActiveRecord.
If you use simple_generate you won't be able to use this kind of method because simple_generate
need the array with all of its elements. To handle it you can use `generate_using` method

e.g:
```ruby
generator = Proc.new do |&block|
  resources.each do |resource|
    block.call(resource)
  end
end
result = SimpleCsvCreator.generate_using(generator)
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/csv_creator. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
