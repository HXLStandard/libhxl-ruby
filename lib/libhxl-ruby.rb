class HXLReader

  def initialize

  end

  def self.foreach(path, &block)

    table_spec = nil
    prev_row = nil

    source_row_number = -1
    row_number = -1
    disaggregation_position = 0

    CSV.foreach(path) do |row|

      source_row_number += 1

      # If we don't have a table_spec yet (row of HXL tags), scan for one
      if table_spec.nil?

        table_spec = self.parse_hashtag_row(row, prev_row)

        next if table_spec

      end
      prev_row = row
      next if table_spec.nil?



      disaggregation_position = 0

      loop do
        # Next logical row
        row_number += 1

        hxl_row, disaggregation_position = parse_row(row,
                                                     table_spec,
                                                     disaggregation_position,
                                                     row_number,
                                                     source_row_number)
        yield hxl_row

        break unless disaggregation_position < table_spec.get_disaggregation_count
      end


    end

    raise HXLFormatError.new('HXL hashtag row not found') if table_spec.nil?
  end

  def self.parse_row(row, table_spec, disaggregation_position, row_number, source_row_number)

    hxl_fields = []
    col_num = -1

    seen_fixed = false
    row.each_with_index do |value, source_col_number|

      col_spec = table_spec.col_specs[source_col_number]

      # Only parse HXL columns
      next if col_spec.column.hxl_tag.nil?

      if col_spec.fixed_column
        # Looking at disaggregation

        if !seen_fixed
          col_num += 1
          raw_position = table_spec.get_raw_position(disaggregation_position)

          hxl_fields.push HXLValue.new(table_spec.col_specs[raw_position].fixed_column,
                                table_spec.col_specs[raw_position].fixed_value,
                                col_num,
                                source_col_number)

          col_num += 1
          hxl_fields.push HXLValue.new(table_spec.col_specs[raw_position].column,
                                row[raw_position],
                                col_num,
                                source_col_number)

          seen_fixed = true
          disaggregation_position += 1

        end
      else
        # Regular column
        col_num += 1
        hxl_fields.push HXLValue.new(table_spec.col_specs[source_col_number].column,
                              value,
                              col_num,
                              source_col_number)


      end
    end

    hxl_row = HXLRow.new(
      table_spec.hxl_headers,
      hxl_fields,
      false,
      row_number,
      source_row_number)

    return hxl_row, disaggregation_position
  end

  def self.parse_hashtag_row(row, prev_row)

    # Try parsing the current raw CSV data row as a HXL hashtag row.
    # Returns a HXLTableSpec on success, or None on failure

    seen_header = false
    table_spec = HXLTableSpec.new

    row.each_with_index do |value, col_num|
      value = value.strip if value
      col_spec = nil

      if !value.nil? && !value.empty?
        col_spec = self.parse_hashtag(col_num, value)
        return nil if col_spec.nil?

        seen_header = true

        if col_spec.fixed_column
          col_spec.fixed_value = prev_row[col_num]
        end

      else
        col_spec = HXLColSpec.new col_num, HXLColumn.new
      end

      table_spec.push col_spec
    end

    return table_spec if seen_header

    nil
  end

  def self.parse_hashtag(source_col_number, value)

    # Pattern for a single tag
    tag_regex = /(#[\w]+)(?:\/([[:alpha:]]{2}))?/

    # Pattern for full tag spec (optional second tag following '+')
    full_regex = /^\s*#{tag_regex}(?:\s*\+\s*#{tag_regex})?$/

    result = full_regex.match value
    col_spec = nil

    if result
      col1 = nil
      col2 = nil

      if result[3]
        # There were two tags
        col1 = HXLColumn.new result[1], result[2]
        col2 = HXLColumn.new result[3], result[4]
        col_spec = HXLColSpec.new source_col_number, col2, col1

      else
        col1 = HXLColumn.new result[1], result[2]
        col_spec = HXLColSpec.new source_col_number, col1
      end
    end

    col_spec
  end

  def self.parse_table_spec(row, prev_row)
    # Search for the HXL hashtag row
    # Returns a HXLTableSpec on success. Throws an exception on failure.

    raw = self.parse_source_row
  end

  def self.parse_source_row
  end

end

require 'libhxl-ruby/hxl_format_error'
require 'libhxl-ruby/hxl_table_spec'
require 'libhxl-ruby/hxl_row'
require 'libhxl-ruby/hxl_value'
require 'libhxl-ruby/hxl_column'
require 'libhxl-ruby/hxl_col_spec'
