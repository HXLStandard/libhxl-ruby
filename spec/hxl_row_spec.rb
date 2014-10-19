require 'spec_helper'

describe HXLReader::HXLRow do

  it "creates a basic hxl row" do
    ln = 'fr'
    tag = '#sector_date'
    tag2 = '#injured'

    column = HXLReader::HXLColumn.new tag, ln
    column2 = HXLReader::HXLColumn.new tag2

    value = HXLReader::HXLValue.new column, 100, 0, 0
    value2 = HXLReader::HXLValue.new column2, 'hi', 1, 2

    headers = [column.hxl_tag, column2.hxl_tag]

    fields = [value, value2]

    hxl_row = HXLReader::HXLRow.new(headers, fields, false, 10, 11)

    expect(hxl_row.row_number).to eq(10)
    expect(hxl_row.source_row_number).to eq(11)

    expect(hxl_row[0].value).to eq(100)
    expect(hxl_row[1].value).to eq('hi')

    expect(hxl_row['#sector_date'].value).to eq(100)
    expect(hxl_row['#injured'].value).to eq('hi')
  end

end


