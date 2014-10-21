libhxl-ruby
=============

Ruby support library for the Humanitarian Exchange Language (HXL) data standard.

# Installation

`gem install hxl`

# Usage

Read a HXL file from a csv, row by row:

```
require 'hxl'

HXL.foreach('path/to/csv').foreach do |row|
  p "Row " + str(row.row_number)
  row.each do |key, value|
    p "#{key} = #{value}"
  end
end
```
