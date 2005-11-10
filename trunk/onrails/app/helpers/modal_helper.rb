require 'modal'

module ModalHelper
  include Modal

  # Include "ret" in a form, for modal forms.
  def modal_form(id = nil)
    s = '<input type="hidden" name="ret" value="' + return_url(id) + '"'
    s += 'id="L' + id.to_s + '"' if id
    s += '/>'
    s
  end

  # Include "ret" in a link, for modal links.
  def modal_link_to(name, id = nil, options = {}, html_options = nil, *dict_params)
    html_options = {} if not html_options
    html_options['id'] = 'L' + id.to_s if id
    html_options = html_options.stringify_keys
    convert_confirm_option_to_javascript!(html_options)
    if options.is_a?(String)
      l = content_tag "a", name || options, html_options.merge("href" => options)
    else
      s = url_for(options, dict_params)
      s += ('?ret=' + return_url(id))
      l = content_tag("a", (name || url_for(options, dict_params)), html_options.merge("href" => s))
    end
    l
  end
end
