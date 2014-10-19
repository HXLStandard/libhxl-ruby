Gem::Specification.new do |s|
  s.name        = 'libhxl-ruby'
  s.version     = '0.0.1'
  s.date        = '2014-10-19'
  s.summary     = "A HXL parser for ruby"
  s.description = "A simple gem to parse your HXL files"
  s.authors     = ["Ben Rudolph"]
  s.email       = 'rudolphben@gmail.com'
  s.files       = ["lib/libhxl-ruby.rb",
                   "lib/libhxl-ruby/hxl_column.rb",
                   "lib/libhxl-ruby/hxl_col_spec.rb",
                   "lib/libhxl-ruby/hxl_row.rb",
                   "lib/libhxl-ruby/hxl_table_spec.rb",
                   "lib/libhxl-ruby/hxl_format_error.rb",
                   "lib/libhxl-ruby/hxl_value.rb",
                  ]

  s.add_development_dependency "rspec", '~> 3.1'
  s.homepage    =
    'https://github.com/benrudolph/libhxl-ruby'
  s.license       = 'MIT'
end
