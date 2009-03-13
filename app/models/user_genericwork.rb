class UserGenericwork  < ActiveRecord::Base
  validates_presence_of :userrole_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :user_id, :userrole_id, :greater_than => 0, :only_integer => true

  belongs_to :genericwork
  belongs_to :userrole
  belongs_to :user

  named_scope :popularscienceworks, :joins => %Q( 
  INNER JOIN genericworkgroups ON genericworkgroups.name = 'Productos de divulgación'  
  INNER JOIN genericworktypes ON genericworktypes.genericworkgroup_id = genericworkgroups.id 
  INNER JOIN genericworks ON genericworks.id = user_genericworks.genericwork_id 
  AND genericworks.genericworktype_id = genericworktypes.id
  )

  named_scope :find_popularscienceworks_by_year, lambda { |y| 
    {
      :joins => %Q( 
      INNER JOIN genericworkgroups ON genericworkgroups.name = 'Productos de divulgación'  
      INNER JOIN genericworktypes ON genericworktypes.genericworkgroup_id = genericworkgroups.id 
      INNER JOIN genericworks ON genericworks.id = user_genericworks.genericwork_id 
      AND genericworks.genericworktype_id = genericworktypes.id AND genericworks.year = #{y}
      )
    }
  }

  named_scope :techreports, :joins => %Q(
  INNER JOIN genericworks ON genericworks.id = user_genericworks.genericwork_id
  AND genericworks.genericworktype_id = 7
  )

  named_scope :find_techreports_by_year,  lambda { |y|
    {
      :joins => %Q(
      INNER JOIN genericworks ON genericworks.id = user_genericworks.genericwork_id
      AND genericworks.genericworktype_id = 7 AND genericworks.year = #{y}
      )
    }
  }



  def as_text
    institution_name = genericwork.institution.nil? ? nil : genericwork.institution.name
    publisher_name =  genericwork.publisher.nil? ? nil :  genericwork.publisher.name
    as_text_line([ genericwork.authors, genericwork.title, institution_name, genericwork.genericworktype.name, publisher_name,
      genericwork.reference, genericwork.year, genericwork.vol, genericwork.pages, label_for(genericwork.genericworkstatus.name, 'Estado')])
    end
  end
