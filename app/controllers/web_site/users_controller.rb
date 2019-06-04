class WebSite::UsersController < WebSite::ApplicationController
  respond_to :js

  def index
    unless request.remote_ip.to_s.match(/132.248.(209|7).\d+/).nil?
      subset = [:id, :search, :lgid, :kfid, :cat, :letra]
      if subset.any? {|k| params.key?(k)}
        if params[:id] # sólo un académico
          @collection = User.activated.find params[:id]
        elsif params[:search] # búsqueda de académicos
          @collection = User.all_except([1,2,397,573,609,648,475,497,615]).fullname_like(params[:search]).sort_by_author
        elsif params[:lgid] # académicos de un laboratorio o grupo
          lgs = UserLabOrGroup.where(:lab_or_group_id=>params[:lgid])
          users = []
          lgs.each{ |lg| users << User.all_except([1,2,397,573,609,648,475,497,615]).find(lg.user_id) }
          @collection = User.where('id in (?)',users)
        elsif params[:kfid] # académicos de un campo del conocimiento
          kas = KnowledgeArea.where(:knowledge_field_id=>params[:kfid])
          users = []
          kas.each{ |ka|
            ukas = UserKnowledgeArea.where(:knowledge_area_id=>ka.id)
            ukas.each{ |uka| users << User.all_except([1,2,397,573,609,648,475,497,615]).find(uka.user_id) }
          }
          @collection = User.where('id in (?)',users)
        elsif params[:cat] # académicos por categoría & letra
          cat = params[:cat]
          id = params[:letra].nil? ? '' : params[:letra].upcase
          if cat == 'ta'
            @collection = User.all_except([1,2,397,573,609,648,475,497,615]).academic_technicians.where("author_name like '#{id}%'").sort_by_author
          elsif cat == 'posdoc'
            @collection = User.all_except([1,2,397,573,609,648,475,497,615]).posdoctorals.where("author_name like '#{id}%'").sort_by_author
          else
            @collection = User.all_except([1,2,397,573,609,648,475,497,615]).researchers.where("author_name like '#{id}%'").sort_by_author
          end
        elsif params[:letra] # académicos por letra
          id = params[:letra].upcase
          @collection = User.all_except([1,2,397,573,609,648,475,497,615]).where("author_name like '#{id}%'").sort_by_author
        end
        respond_to do |format|
            format.json {
                render :json => { :types=>{:Persona=>{:pluralLabel=>:Personas}},
                        :properties=>{:url=>{:valueType=>:url}, :photo=>{:valueType=>:url}}, 
                        :items=>@collection.to_json }
            }
          end
      else # default: todos
        @collection = User.all_except([1,2,397,573,609,648,475,497,615]).sort_by_author
        respond_to do |format|
          format.json {
              render :json => { :types=>{:Persona=>{:pluralLabel=>:Personas}},
                      :properties=>{:url=>{:valueType=>:url}, :photo=>{:valueType=>:url}}, 
                      :items=>@collection.as_json }
          }
        end
      end
    else
      render :text => 'Not Found', :status => '404'
    end
  end
end
