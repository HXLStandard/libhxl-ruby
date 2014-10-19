require 'spec_helper'

describe HXLReader::HXLColumn do

  it "creates a basic hxl column" do
    ln = 'fr'
    tag = '#sector_date'
    column = HXLReader::HXLColumn.new tag, ln

    expect(column.hxl_tag).to eq(tag)
    expect(column.language_code).to eq(ln)
    expect(column.header_text).to eq('SECTOR')
  end

end

