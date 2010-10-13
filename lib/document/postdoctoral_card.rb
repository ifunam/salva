class PostdoctoralCard 
  def initialize(user)
    @pdf = Prawn::Document.new(:template => Rails.root.to_s + '/app/views/academic_secretary/users/postdoctoral_card_template.pdf')
    @user = user
  end

  def to_pdf
    @pdf.draw_text @user.person.firstname_and_lastname.upcase, :at => [18,330]
    @pdf.draw_text @user.user_identification.descr.upcase, :at => [400,330]
    @pdf.draw_text "Del #{@user.jobposition_as_postdoctoral.start_date} al #{@user.jobposition_as_postdoctoral.end_date}", :at => [18,205]
    @pdf.draw_text Date.today.to_s, :at => [60,155]
    @pdf.render
  end
end
