require "csv_creator/version"
require "csv_creator/column"
require "csv_creator/generator"
require "csv"
# CsvCreator has DSL to build the csv
# it's inspired by activeadmin csv
# example:
# class User
#   attr_reader :name, :age, :gender
#   def initialize(name, age, gender)
#     @name = name
#     @age = age
#     @gender = gender
#   end
# end
#
# user1 = User.new('test', 20, 'female')
# user2 = User.new('mobile', 13, 'male')
# csv_creator = CsvCreator.schema do
#   column(:name) # if without block then it will run the name given(user.name), header name will be titleize of name
#   column(:age) { |r| r.age + ' years' } # if with block will run the block
#   column('User Gender') { |r| r.gender } # if want to use custom title need to give the block
# end
# result = CsvCreator.simple_generate([user1, user2])
# csv_parse = CSV.parse(result)
# csv_parse:
# [
#   ['Name', 'Age', 'User Gender'],
#   ['test', '20 years', 'female'],
#   ['mobile', '13 years', 'male']
# ]
#
# Sometimes you want to do lazy fetch e.g: `find_each` method in ActiveRecord.
# If you use simple_generate you won't be able to use this kind of method because simple_generate
# need the array with all of its elements. To handle it you can use `generate_using` method
# e.g:
# generator = Proc.new do |&block|
#   resources.each do |resource|
#     block.call(resource)
#   end
# end
# result = CsvCreator.generate_using(generator)
# end
module CsvCreator
  def self.schema(&block)
    csv_creator = CsvCreator::Generator.new
    csv_creator.instance_eval(&block)
    csv_creator
  end
end
