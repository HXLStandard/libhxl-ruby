require 'csv'

class HXLReader::HXLRow < CSV::Row
  # An iterable row of HXL value objects

  attr_reader :row_number, :source_row_number


  def initialize(headers, fields, header_row = false, row_number = nil, source_row_number = nil)
    super headers, fields, header_row
    @row_number = row_number
    @source_row_number = source_row_number

  end

  def to_s
    s = '<HXLRow';
    s += "\n  rowNumber: " + @row_number.to_s
    s += "\n  sourceRowNumber: " + @sourceRowNumber.to_s
    s += "\n"
    s += @row.map(&:to_s).join('\n ')
    s += "\n>"

    s
  end

end
