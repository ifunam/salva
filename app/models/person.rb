class Person < ActiveRecord::Base
  self.primary_key = 'id'

  # attr_acz         :medical_condition, :medical_instruction, :hospital, :insurance


  validates_presence_of :firstname, :lastname1, :dateofbirth, :country_id
  validates_numericality_of :country_id, :greater_than => 0, :only_integer => true
  validates_numericality_of :maritalstatus_id, :city_id, :state_id, :user_id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_inclusion_of :gender, :in => [true, false]
  validates_uniqueness_of :user_id

  normalize_attributes :firstname, :lastname1, :lastname2

  belongs_to :user
  belongs_to :maritalstatus
  belongs_to :country
  belongs_to :state
  belongs_to :city

  has_one :image, :as => :imageable, :dependent => :destroy
  accepts_nested_attributes_for :image, :city

  default_scope -> { order('people.lastname1 ASC, people.lastname2 ASC, people.firstname ASC') }
  scope :find_by_fullname, lambda { |name| name_like(name.downcase) }
  def self.name_like(name)
    vocal = {/([aáÁàÀäÄ])/ =>'[aáàä]',/([eéÉèÈëË])/ =>'[eéèë]',/([iíÍìÌïÏ])/ =>'[iíìï]',/([oóÓòÒöÖ])/ =>'[oóòö]',/(['uúÚùÙüÜ])/=>'[uúùü]'}
    vocal.each_pair{|v, re| name.gsub!(v,re) }
    self.where('firstname ~* ? or lastname1 ~* ? or lastname2 ~*  ?',name, name, name)
  end

  scope :user_id_by_fullname_like, lambda { |fullname| find_by_fullname(fullname).select('user_id') }

  # search_methods :find_by_fullname

  after_save :update_user_author_name

  def self.all_active(exp=0)
    attributes = %w{contact_name_1 contact_phonenumber_1 medical_condition medical_instruction hospital insurance contact_name_2 contact_phonenumber_2 contact_name_3 contact_phonenumber_3}
    cond = nil
    if exp!=0 then
      cond='AND ('
      attributes.each do |att|
        cond += att+' IS NOT NULL OR '
      end
      cond = cond[0..-4]+')'
    end
    query = "SELECT DISTINCT(people.*) FROM people
              JOIN users ON users.id = people.user_id
              WHERE users.userstatus_id = 2 "+ cond.to_s +
              "ORDER BY lastname1 ASC, lastname2 ASC, firstname ASC"
    find_by_sql(query)
  end


  def fullname
    [self.lastname1.strip, (self.lastname2 != nil ? self.lastname2.strip : nil), self.firstname].compact.join(' ')
  end

  def firstname_and_lastname
    [self.firstname, lastname].compact.join(' ')
  end

  def lastname
    [self.lastname1.strip, (self.lastname2 != nil ? self.lastname2.strip : nil)].compact.join(' ')
  end

  def shortname
    [self.lastname1.strip,  self.firstname].compact.join(' ')
  end

  def placeofbirth
    [self.city.name,  self.state.name, self.country.name].compact.join(', ')
  end

  def age
    now = Time.now.utc.to_date
    now.year - dateofbirth.year - (dateofbirth.to_date.change(:year => now.year) > now ? 1 : 0)
  end

  def image_path
    image_path = Rails.root.to_s + "/app/assets/images/avatar_missing_icon.png"
    if !image.nil? and !image.file.nil? and File.exist? image.file.path
      image_path = image.file.path
    end
    image_path
  end

  def update_user_author_name
    user.update_attribute :author_name, fullname
  end

  def self.to_csv(exp=0)
    attributes = %w{fullname contact_name_1 contact_phonenumber_1 medical_condition medical_instruction hospital insurance contact_name_2 contact_phonenumber_2 contact_name_3 contact_phonenumber_3}
    (CSV.generate(headers: true) do |csv|
      csv << attributes
      all_active(exp).each do |person|
        csv << attributes.map{ |attr| person.send(attr) }
      end
    end).encode('WINDOWS-1252', :undef => :replace, :replace => '')
  end

  def self.grouped_researchers(type)#ages
    @period_ini=21.step(100,5).to_a
    @period_fin=25.step(100,5).to_a
    @position={'technician'=>(19..36).to_a+(63..80).to_a,
               'posdoc'=>38,
               'researcher'=>(1..12).to_a+[37,185]}

    @result = Hash.new
    @cad = Jobposition.most_recent_jp_join
    21.step(100,5).each do |ini|
      ini_s,fin_s=ini.to_s,(ini+4).to_s
      query = "SELECT distinct(users.id) FROM people
              JOIN users ON users.id = people.user_id
              JOIN user_adscriptions ON users.id = user_adscriptions.user_id"+ @cad +"WHERE users.userstatus_id=2
                     AND jobpositions.jobpositioncategory_id in (?)
                     AND date_part('year',age(now(),people.dateofbirth)) BETWEEN ? AND ?",@position[type],ini_s,fin_s
      tot = find_by_sql(query).length
      @result[ini_s+'-'+fin_s]=tot if tot!=0
    end
    @result
  end

end
