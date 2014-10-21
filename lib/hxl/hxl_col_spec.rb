class HXLReader::HXLColSpec

  attr_reader :fixed_column, :source_col_number, :column
  attr_accessor :fixed_value

  # Column metadata for parsing a HXL CSV file
  #
  # This class captures the way a column is encoded in the input CSV
  # file, which might be different from the logical structure of the
  # HXL data. Used only during parsing.

  def initialize(source_col_number, column = nil, fixed_column = nil, fixed_value = nil)
    @source_col_number = source_col_number
    @column = column
    @fixed_column = fixed_column
    @fixed_value = fixed_value
  end

end
