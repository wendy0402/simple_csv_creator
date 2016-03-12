require 'csv'
require "csv_creator/version"

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
# csv_creator = CsvCreator.build([user1, user2]) do
#   column :name # if without block then it will run the name given(user.name), header name will be titleize of name
#   column :age { |r| r.age + ' years' } # if with block will run the block
#   column 'User Gender' { |r| r.gender } # if want to use custom title need to give the block
# end
# result = CsvCreator.generate
# csv_parse = CSV.parse(result)
# csv_parse:
# [
#   ['Name', 'Age', 'User Gender'],
#   ['test', '20 years', 'female'],
#   ['mobile', '13 years', 'male']
# ]
module CsvCreator
  require 'csv_creator/column'
  require 'csv_creator/base'
  def self.build(resources, &block)
    csv_creator = CsvCreator::Base.new(resources)
    csv_creator.instance_eval(&block)
    csv_creator
  end
end
