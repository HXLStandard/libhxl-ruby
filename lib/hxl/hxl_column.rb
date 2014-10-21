class HXLReader::HXLColumn

  attr_reader :hxl_tag, :language_code, :header_text

  def initialize(hxl_tag = nil, language_code = nil)
    @hxl_tag = hxl_tag
    @language_code = language_code
    @header_text = self.pretty_tag
  end

  def pretty_tag
    return '' unless @hxl_tag

    @hxl_tag
      .gsub(/^#/, '')
      .gsub(/_(date|deg|id|link|num)$/, '')
      .gsub('_', ' ')
      .upcase
  end
end
