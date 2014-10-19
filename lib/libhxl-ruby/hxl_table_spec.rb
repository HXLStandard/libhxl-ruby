class HXLReader::HXLTableSpec

  attr_reader :col_specs

  # Table metadata for parsing a HXL dataset

  def initialize
    @col_specs = []
  end

  def push(col_spec)
    @col_specs.push col_spec
  end

  def hxl_headers
    headers = []
    seen_fixed = false
    @col_specs.each do |spec|
      if spec.fixed_column && !seen_fixed
        headers.push spec.fixed_column.hxl_tag
        headers.push spec.column.hxl_tag unless spec.column.hxl_tag.nil?
        seen_fixed = true
      elsif !spec.fixed_column
        headers.push spec.column.hxl_tag unless spec.column.hxl_tag.nil?
      end
    end

    headers
  end

  def get_disaggregation_count
    (@col_specs.select { |col_spec| col_spec.fixed_column }).length
  end

  def get_raw_position(disaggregation_position)
    @col_specs.each_with_index do |col_spec, i|
      disaggregation_position -= 1 if col_spec.fixed_column

      return i if disaggregation_position < 0
    end

    return -1
  end

end
