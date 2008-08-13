require 'sql'
module List
  include Sql
  def set_conditions_from_search
    session_key = controller_name.to_s + "_list_conditions"
    if params[controller_name]
      session[session_key] = set_conditions_by_ids_and_like(params[controller_name])
    else 
      session[session_key] unless !session[session_key]
    end
  end
  
  def set_per_page
    session_key = controller_name.to_s + "_per_page"
    if params[:per_page] 
      session[session_key] = params[:per_page].to_i
    else
      session[session_key] unless !session[session_key] 
    end
  end
end
