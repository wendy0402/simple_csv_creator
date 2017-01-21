# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simple_csv_creator/version'

Gem::Specification.new do |spec|
  spec.name          = "simple_csv_creator"
  spec.version       = SimpleCsvCreator::VERSION
  spec.authors       = ["wendy0402"]
  spec.email         = ["wendykurniawan92@gmail.com"]

  spec.summary       = "DSL for creating csv file"
  spec.description   = "DSL for creating csv file inspired by activeadmin csv"
  spec.homepage      = "https://github.com/wendy0402/csv_creator"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
