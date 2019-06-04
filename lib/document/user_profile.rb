class UserProfile

  def self.find(user_id)
    new(user_id)
  end

  def self.find_by_login(login)
    if User.exists?(:login => login)
      new(User.find_by_login(login).id)
    end
  end

  def initialize(user_id)
    @user = User.find(user_id)
  end

  def fullname
    @user.fullname_or_login
  end

  def firstname_and_lastname
    @user.firstname_and_lastname
  end

  def firstname
    @user.person.firstname unless @user.person.nil?
  end

  def lastname
    @user.person.lastname unless @user.person.nil?
  end

  def author_name
    @user.author_name
  end

  def gender
    unless @user.person.nil?
      @user.person.gender == true ? 'Masculino' : 'Femenino'
    end
  end

  def birthdate
    @user.person.dateofbirth unless @user.person.nil?
  end

  def address
    @user.address.to_s unless @user.address.nil?
  end

  def address_location
    @user.address.location unless @user.address.nil?
  end

  def address_state_name
    @user.address.state.name unless @user.address.nil? and @user.address.state.nil?
  end

  def address_country_name
    @user.address.country.name unless @user.address.nil? and @user.address.country.nil?
  end

  def address_city_name
    @user.address.city.name unless @user.address.nil? and @user.address.city.nil?
  end

  def address_zipcode
    @user.address.zipcode
  end

  def phone
    @user.address.phone unless @user.address.nil?
  end

  def fax
    @user.address.fax unless @user.address.nil?
  end

  def email
    @user.email
  end

  def login
    @user.login
  end

  def user_incharge_id
    @user.user_incharge_id
  end

  def person_id
    @user.user_identification.descr.upcase unless @user.user_identification.nil?
  end

  def category_name
    @user.category_name
  end

  def adscription_name
    @user.adscription_name @user.id,Time.now.year
#    @user.adscription_name
  end

  def adscription_id
    @user.adscription_id
  end

  def worker_id
    if @user.category_name == 'Investigador posdoctoral' or @user.category_name == 'Cátedra CONACYT'
      person_id
    else
      @user.jobposition_log.worker_key unless @user.jobposition_log.nil?
    end
  end

  def academic_years
    @user.jobposition_log.academic_years unless @user.jobposition_log.nil?
  end

  def administrative_years
    @user.jobposition_log.administrative_years unless @user.jobposition_log.nil?
  end

  def total_of_cites
    @user.user_cite.total unless @user.user_cite.nil?
  end

  def responsible_academic
    @user.user_incharge.fullname_or_email unless @user.user_incharge_id.nil?
  end


  def responsible_academic_email
    @user.user_incharge.email unless @user.user_incharge_id.nil?
  end

  def jobposition_period
    [jobposition_date_with_format(:start_date, false), jobposition_date_with_format(:end_date, false)].compact.join(' - ')
  end

  def jobposition_start_date
    jobposition_date_with_format(:start_date)
  end

  def jobposition_end_date
    jobposition_date_with_format(:end_date)
  end

  def jobposition_date_with_format(attribute_name,date_format=true)
    unless @user.jobposition.nil?
      date_format == true ? @user.jobposition.attributes_before_type_cast[attribute_name.to_s] : @user.jobposition.send(attribute_name)
    end
  end

  def image_path
    image_path = Rails.root.to_s + "/public/images/avatar_missing_icon.png"
    unless @user.person.nil? or @user.person.image.nil?
      file_path = Rails.root.to_s + @user.person.image.file.url(:card)
      image_path = file_path if File.exist? file_path
    end
    image_path
  end

  def to_xml
     { :id => @user.id,
       :fullname => fullname,
       :adscription => adscription_name,
       :adscription_id => adscription_id,
       :phone => phone,
       :user_incharge_id => user_incharge_id,
       :user_incharge_fullname => responsible_academic,
       :user_incharge_email => responsible_academic_email,
       :email => email,
       :login => login
     }.to_xml(:root => :user)
  end
end
