class ActiveAdminViewsPagesBase < Arbre::HTML::Document

  private

  def build_footer
    render :partial => 'layouts/footer'
  end
end
