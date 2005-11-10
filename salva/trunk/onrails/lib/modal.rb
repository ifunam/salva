# Implement modal web pages. When you are done with one of these pages, they
# will redirect you to an internal page anchor within the page that linked to
# them. In other words, you don't just go back to the referring page. You go
# back to the place within the referring page where the link was.
#
# This implementation is in two parts: the library module Modal, and the view
# helper ModalHelper.
#
module Modal

  # This is meant to be called as a before filter by the ApplicationController.
  # It always returns true and thus will not interrupt your action.
  #
  # The link_modal and modal_form methods generate an internal page
  # anchor and a +ret+ parameter that will be passed in a GET or PUT.
  # The anchor refers the location within the calling page to return to
  # after a modal action, and +ret+ encodes the URL of that anchor.
  # store_return retrieves +ret+ from the request and saves it in a
  # return-to address URL in the session. The return-to URL will be used
  # by redirect_back_or_default to return to a location within the calling
  # page that linked to the current page. This is nicer than simply returning
  # to the top of the page, especially when returning to a long page like
  # a list of blog comments, because the reader will probably want to continue
  # reading at that point.
  #
  # If the request does not contain a +ret+ parameter and the return-to
  # address is not set and REFERER is set in the environment, the
  # return-to address is set to REFERER.
  # 
  def modal_setup
    # Set modal return.
    if r = @params['ret']
      logger.info("modal_setup: Save location #{r.sub(/\.L/, '#L')}")
      self.return_location = r.sub(/\.L/, '#L')
  # This results in redirection loops, as currently written.
  # It needs a hueristic to carefully avoid them before we try it again.
  #
  # elsif return_location.nil?
  #   r = @request.env['HTTP_REFERER']
  #   if r
  #     logger.info("modal_setup: Save HTTP Referer #{r}")
  #     self.return_location = @request.env['HTTP_REFERER']
  #   end
    end
    true
  end

  # Get the location to return to after a modal action. The argument should
  # be a string containing a URL.
  def return_location
    session[:return_to]
  end

  # Set the location to return to after a modal action. The return value should
  # be a string containing a URL.
  def return_location= a
    logger.info("return_location= #{a}")
    session[:return_to] = a
  end

  # Store the location to return to after a modal action from the request URI.
  # This is usually called before redirecting to another action.
  def store_location
    uri = @request.request_uri
    logger.info("Store location: #{uri}")
    self.return_location = uri
  end

  # Redirect to the stored return location. If no stored return location
  # is available, redirect to the default action given in the arguments.
  # The arguments are just like those of redirect_to.
  def redirect_back_or_default(attributes = {}, *method_params)
    r = return_location
    if r
      if r == @request.request_uri
        logger.info("redirect_back_or_default: BREAKING REDIRECTION LOOP #{r}.")
      else
        logger.info("redirect_back_or_default: return to #{r}")
        self.return_location = nil
        redirect_to_url r
        return
      end
    end
    logger.info("redirect_back_or_default: go to default #{attributes.inspect}, #{method_params.inspect}")
    redirect_to attributes, method_params
  end

  # Create a URL optionally including an internal anchor. If the +id+ argument
  # is given, that will be used to create the name of the internal anchor. It's
  # generally a number, but anything that will convert to a string that does
  # not contain characters that would have special meaning within a URL, like
  # spaces, will do.
  def return_url(id = nil)
    s = @request.request_uri.sub(/\??ret=[^\&$]*/,'')
    s += '.L' + id.to_s if id
    s
  end

end
