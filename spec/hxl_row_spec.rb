require 'spec_helper'

describe HXL::HXLRow do

  it "creates a basic hxl row" do
    ln = 'fr'
    tag = '#sector_date'
    tag2 = '#injured'

    column = HXL::HXLColumn.new tag, ln
    column2 = HXL::HXLColumn.new tag2

    value = 100
    value2 = 'hi'

    headers = [column.hxl_tag, column2.hxl_tag]

    fields = [value, value2]

    hxl_row = HXL::HXLRow.new(headers, fields, false, 10, 11)

    expect(hxl_row.row_number).to eq(10)
    expect(hxl_row.source_row_number).to eq(11)

    expect(hxl_row[0]).to eq(100)
    expect(hxl_row[1]).to eq('hi')

    expect(hxl_row['#sector_date']).to eq(100)
    expect(hxl_row['#injured']).to eq('hi')
  end

end


