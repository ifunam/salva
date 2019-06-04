class Department::AnnualPlansController < Department::ApplicationController
  respond_to :html, :js
  layout 'department'

  def index
    if params[:reset] or params[:button]
      params[:search][:name] = nil
      params[:search][:jobposition] = nil
      params[:search][:year] = Time.now.year
    end
    if current_user.admin? then
      @documents = Document.annual_plans.order("users.author_name").paginated_search(params)
      return
    else
      name = params[:search].nil? ? nil : params[:search][:name]
      jobposition = params[:search].nil? ? nil : params[:search][:jobposition]
      year = params[:search].nil? ? Time.now.year : params[:search][:year]
      respond_with(@documents = Document.annual_plans.department_documents(current_user.head_adscription_id,year,name,jobposition).page(params[:page] || 1).per(20))
      return
    end
  end

  def download_pdf
    doc = Document.find(params[:id])
    year = doc.documenttype.year
    user = User.find(doc.user_id)
    if current_user.admin? or user.id == current_user.id or user.user_incharge_id == current_user.id or user.adscription_id == current_user.head_adscription_id
      send_file("#{Rails.root}/app/files/annual_plans/#{year}/#{user.login}.pdf",
              filename: "#{user.login}_#{year}_plan.pdf",
              type: "application/pdf")
      return
    else
      send_data generate_pdf,
              filename: "#{params[:id]}.pdf",
              type: "application/pdf"
      return
    end
    respond_to do |format|
      format.pdf
    end
  end

  def generate_pdf
    Prawn::Document.new do
      text "Forbidden", align: :center
      text "You are not authorized to see the requested document", align: :center
    end.render
  end
end
