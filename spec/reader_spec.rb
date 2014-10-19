require 'spec_helper'

describe HXLReader do

  SAMPLE_FILE = 'spec/sample-data/sample.csv'
  SAMPLE_MALFORMATTED_FILE = 'spec/sample-data/sample_bad.csv'
  EXPECTED_ROW_COUNT = 8
  EXPECTED_TAGS = ['#sector', '#subsector', '#org', '#country', '#sex', '#targeted_num', '#adm1'];
  EXPECTED_CONTENT = [
      ['WASH', 'Subsector 1', 'Org 1', 'Country 1', 'Males', '100', 'Region 1'],
      ['WASH', 'Subsector 1', 'Org 1', 'Country 1', 'Females', '100', 'Region 1'],
      ['Health', 'Subsector 2', 'Org 2', 'Country 2', 'Males', nil, 'Region 2'],
      ['Health', 'Subsector 2', 'Org 2', 'Country 2', 'Females', nil, 'Region 2'],
      ['Education', 'Subsector 3', 'Org 3', 'Country 2', 'Males', '250', 'Region 3'],
      ['Education', 'Subsector 3', 'Org 3', 'Country 2', 'Females', '300', 'Region 3'],
      ['WASH', 'Subsector 4', 'Org 1', 'Country 3', 'Males', '80', 'Region 4'],
      ['WASH', 'Subsector 4', 'Org 1', 'Country 3', 'Females', '95', 'Region 4']
  ]


  it "parses a basic CSV file" do
    i = 0
    HXLReader.foreach(SAMPLE_FILE) do |row|
      j = 0
      expect(row.length).to eq(EXPECTED_TAGS.length)

      row.each do |key, value|

        expect(value.column.hxl_tag).to eq(EXPECTED_TAGS[j])
        expect(key).to eq(EXPECTED_TAGS[j])
        expect(value.value).to eq(EXPECTED_CONTENT[i][j])

        j += 1
      end


      i += 1
    end

    expect(i).to eq(EXPECTED_ROW_COUNT)
  end

  it "raises hxlformaterror exception" do
    expect {
      HXLReader.foreach(SAMPLE_MALFORMATTED_FILE) { |row| }
    }.to raise_error(HXLReader::HXLFormatError)

  end

  it "parses a basic hxl tag" do
    tag = '#Sector'

    spec = HXLReader.parse_hashtag(0, tag)

    expect(spec.source_col_number).to eq(0)
    expect(spec.column.hxl_tag).to eq(tag)
    expect(spec.column.language_code).to be_nil
    expect(spec.column.header_text).to eq('SECTOR')
  end

  it "parses hxl tag with language code" do
    hash = '#sector'
    ln = 'fr'
    tag = "#{hash}/#{ln}"

    spec = HXLReader.parse_hashtag(1, tag)

    expect(spec.source_col_number).to eq(1)
    expect(spec.column.hxl_tag).to eq(hash)
    expect(spec.column.language_code).to eq(ln)
    expect(spec.column.header_text).to eq('SECTOR')
  end

  it "parses complex hxl tag with languages codes" do
    hash = '#sector'
    hash2 = '#injured_num'
    ln = 'fr'
    tag = "#{hash}/#{ln} + #{hash2}/#{ln}"

    spec = HXLReader.parse_hashtag(1, tag)

    expect(spec.source_col_number).to eq(1)

    expect(spec.column.hxl_tag).to eq(hash2)
    expect(spec.column.language_code).to eq(ln)
    expect(spec.column.header_text).to eq('INJURED')

    expect(spec.fixed_column.hxl_tag).to eq(hash)
    expect(spec.fixed_column.language_code).to eq(ln)
  end

  it "should not parse malformatted hxl tag" do
    tag = '#sec.tor'

    spec = HXLReader.parse_hashtag(0, tag)

    expect(spec).to be_nil
  end

  it "parses a basic hashtag row" do
    prev_row = ['Sector', 'Injured', 'Weird Column']
    row = ['#sector', '#time_period + #injured_num', '']

    table_spec, hashtag_row = HXLReader.parse_hashtag_row row, prev_row

    expect(table_spec.col_specs.length).to eq(row.length)
    expect(table_spec.get_disaggregation_count).to eq(1)
  end

  it "parses a non hashtag row" do
    prev_row = nil
    row = ['Sector', 'Injured', 'Weird Column']

    table_spec, hashtag_row = HXLReader.parse_hashtag_row row, prev_row

    expect(table_spec).to be_nil

    row = ['Who', 'What', 'Why', 'There']
    row = ['Sector', 'Injured', 'Weird Column']

    table_spec, hashtag_row = HXLReader.parse_hashtag_row row, prev_row

    expect(table_spec).to be_nil
  end

end
