require 'spec_helper'

describe HXL::HXLRow do

  it "creates a basic hxl row" do
    ln = 'fr'
    tag = '#sector_date'
    tag2 = '#injured'

    column = HXL::HXLColumn.new tag, ln
    column2 = HXL::HXLColumn.new tag2

    value = HXL::HXLValue.new column, 100, 0, 0
    value2 = HXL::HXLValue.new column2, 'hi', 1, 2

    headers = [column.hxl_tag, column2.hxl_tag]

    fields = [value, value2]

    hxl_row = HXL::HXLRow.new(headers, fields, false, 10, 11)

    expect(hxl_row.row_number).to eq(10)
    expect(hxl_row.source_row_number).to eq(11)

    expect(hxl_row[0].value).to eq(100)
    expect(hxl_row[1].value).to eq('hi')

    expect(hxl_row['#sector_date'].value).to eq(100)
    expect(hxl_row['#injured'].value).to eq('hi')
  end

end


