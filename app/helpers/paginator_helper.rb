module PaginatorHelper
  def links_to_perpage(pages)
    i = 10
    limit = 50
    max = ( pages * i if pages < 6) || limit
    interval = 5
    links = []
    while i <= max
      links << link_to(i, { :action => 'list', :per_page => i})
      i += interval
    end
    links.join(' | ')
  end
end
