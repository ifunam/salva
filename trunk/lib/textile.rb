require 'redcloth'
module Textile
  # HTML methods
  def bold_tag(text)
    textile("*#{text}*")
  end

  def header_tag(text,level)
    textile("h" + level.to_s + ". " + text)
  end

  # TEXT methods
  def header_text(text,level)
    tag = "=" * level
    [tag, text, tag].join(' ') + "\n"
  end
end
