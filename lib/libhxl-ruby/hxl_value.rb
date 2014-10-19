class HXLReader::HXLValue
  # A single HXL value at the intersection of a row and column
  attr_reader :column, :value, :col_num, :source_col_num

  def initialize(column, value, col_num, source_col_num)
    @column = column
    @value = value
    @col_num = col_num
    @source_col_num = source_col_num
  end

end
