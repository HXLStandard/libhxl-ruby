Gem::Specification.new do |s|
  s.name        = 'libhxl-ruby'
  s.version     = '0.0.1'
  s.date        = '2014-10-19'
  s.summary     = "A HXL parser for ruby"
  s.description = "A simple gem to parse your HXL files"
  s.authors     = ["Ben Rudolph"]
  s.email       = 'rudolphben@gmail.com'
  s.files       = ["lib/libhxl-ruby.rb",
                   "lib/libhxl-ruby/parser.rb"]

  s.add_development_dependency "rspec"
  s.homepage    =
    'http://rubygems.org/gems/libhxl-ruby.rb'
  s.license       = 'MIT'
end
