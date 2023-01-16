class Jobpositioncategory < ActiveRecord::Base
  # attr_accessor :jobpositiontype_id, :roleinjobposition_id, :jobpositionlevel_id, :administrative_key
  validates_presence_of :jobpositiontype_id, :roleinjobposition_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :jobpositiontype_id, :roleinjobposition_id, :greater_than => 0, :only_integer => true
  validates_numericality_of :jobpositionlevel_id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :jobpositiontype_id, :scope =>[:jobpositionlevel_id, :roleinjobposition_id]

  belongs_to :jobpositiontype
  belongs_to :roleinjobposition
  belongs_to :jobpositionlevel

  validates_associated :jobpositiontype
  validates_associated :roleinjobposition
  validates_associated :jobpositionlevel

  default_scope -> { includes(:roleinjobposition, :jobpositionlevel).order('roleinjobpositions.name ASC, jobpositionlevels.name ASC') }
  scope :for_researching, -> { where("(jobpositioncategories.jobpositiontype_id = 1 
                                  AND roleinjobpositions.name NOT LIKE '%yudante%'
                                  AND jobpositionlevels.name NOT LIKE '%M.T.%'
                                 )
                                  OR roleinjobpositions.name LIKE '%vestigador%isitante%'
                                  OR roleinjobpositions.name LIKE '%vestigador%sdoctoral%'
                                  OR roleinjobpositions.name LIKE '%vestigador%rito%'
                                  OR roleinjobpositions.name LIKE '%tedra%CONAC%T'
                                ") }

  def name
    unless self.new_record?
      [(roleinjobposition.nil? ? nil : roleinjobposition.name), (self.jobpositionlevel_id.nil? ? nil : jobpositionlevel.name) ].compact.join(' ')
    else
      ""
    end
  end

  def self.grouped_researchers(type)#,categ
    @base_types=['Asociado A', 'Asociado B', 'Asociado C', 'Titular A', 'Titular B', 'Titular C']
    @categories={'technician'=>@base_types,
                 'researcher'=>['Visitantes','Cátedras CONACyT','posdoc']+@base_types+['Eméritos']}
    @position={'technician'=>{'Asociado A'=>[25,28,69,72],'Asociado B'=>[26,29,70,73],'Asociado C'=>[27,30,71,74],
                              'Titular A'=>[31,34,75,78],'Titular B'=>[33,35,76,79],'Titular C'=>[33,36,77,80]},
               'researcher'=>{'Asociado A'=>[1,4],'Asociado B'=>[2,5],'Asociado C'=>[3,6],
                              'Titular A'=>[7,10],'Titular B'=>[8,11],'Titular C'=>[9,12],
                              'Cátedras CONACyT'=>185,'posdoc'=>38,'Eméritos'=>37}}
    #'Visitantes'=>182
    @result = Hash.new
    @cad = Jobposition.most_recent_jp_join
    @categories[type].each do |categ|
      query = "SELECT distinct(users.id) FROM user_adscriptions
              JOIN users ON users.id = user_adscriptions.user_id"+ @cad +"WHERE users.userstatus_id=2 
                     AND jobpositions.jobpositioncategory_id in (?)", @position[type][categ]
      tot = find_by_sql(query).length
      @result[categ]=tot if tot!=0
    end
    @result
  end

end
