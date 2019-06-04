class FillTableUserAdscriptionRecords2017 < ActiveRecord::Migration
  def up
    year = 2017
    user_ids = User.activated.map{|u| u.id}
    user_ids.each do |u_id|
      jp = Jobposition.most_recent_jp u_id
      unless jp == nil
        ua = UserAdscription.most_recent_adscription u_id
        a_id = ua.adscription_id
        j_id = ua.jobposition_id
        puts "Insertando en el historial: #{u_id}, #{a_id}, #{j_id}, #{year}"
        execute "INSERT INTO user_adscription_records ( user_id, adscription_id, jobposition_id, year ) 
                 VALUES ( #{u_id}, #{a_id}, #{j_id}, #{year} )"
      else
        puts "Usuario: #{u_id}, no se pudo insertar #{year}"
      end
    end
  end

  def down
  end
end
