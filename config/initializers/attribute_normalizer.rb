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

end
