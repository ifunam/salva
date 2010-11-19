AttributeNormalizer.configure do |config|
  config.normalizers[:currency] = lambda do |value, options|
    value.is_a?(String) ? value.gsub(/[^0-9\.]+/, '') : value
  end

  config.normalizers[:truncate] = lambda do |text, options|
    if text.is_a?(String)
      options.reverse_merge!(:length => 30, :omission => "...")
      l = options[:length] - options[:omission].mb_chars.length
      chars = text.mb_chars
      (chars.length > options[:length] ? chars[0...l] + options[:omission] : text).to_s
    else
      text
    end
  end

  config.normalizers[:text_line] = lambda do |value, options|
    value.is_a?(String) ? value.tr("\n",'').tr("\r",'').sub(/^('|"|`|\s)+/, '').sub(/('|"|`|\s|\.|,|;)+$/, '').sub(/\s{1}+/, ' ') : value
  end

  config.normalizers[:paragraph] = lambda do |value, options|
    value.is_a?(String) ? value.sub(/\n{1}+/,"\n").sub(/\r{1}+/,"\r").sub(/^('|"|`|\s)+/, '').sub(/('|"|`|\s|,|;)+$/, '').sub(/\s{1}+/, ' ') : value
  end

  config.default_normalizers = :text_line, :strip, :blank

  config.default_attributes = :name, :title, :abbrev, :authors, :pages, :vol, :num
  config.add_default_attribute :description, :with => :paragraph
  config.add_default_attribute :descr, :with => :paragraph
end
