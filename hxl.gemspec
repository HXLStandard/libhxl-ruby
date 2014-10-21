Gem::Specification.new do |s|
  s.name        = 'hxl'
  s.version     = '0.0.1'
  s.date        = '2014-10-19'
  s.summary     = "A HXL parser for ruby"
  s.description = "A simple gem to parse your HXL files"
  s.authors     = ["Ben Rudolph"]
  s.email       = 'rudolphben@gmail.com'
  s.files       = ["lib/hxl.rb",
                   "lib/hxl/hxl_column.rb",
                   "lib/hxl/hxl_col_spec.rb",
                   "lib/hxl/hxl_row.rb",
                   "lib/hxl/hxl_table_spec.rb",
                   "lib/hxl/hxl_format_error.rb",
                  ]

  s.add_development_dependency "rspec", '~> 3.1'
  s.add_development_dependency "rake", '~> 10.3.2'
  s.homepage    =
    'https://github.com/benrudolph/libhxl-ruby'
  s.license       = 'MIT'
end
