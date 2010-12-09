class UserProfile
  def self.find(user_id)
    new(user_id)
  end

  def initialize(user_id)
    @user = User.find(user_id)
  end

  def fullname
    @user.fullname_or_login
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
    @user.address.as_text unless @user.address.nil?
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

  def person_id
    @user.user_identification.descr.upcase unless @user.user_identification.nil?
  end

  def category_name
    @user.category_name
  end

  def adscription_name
    @user.adscription_name
  end

  def worker_id
    @user.jobposition_log.worker_key unless @user.jobposition_log.nil?
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

  def jobposition_period
    start_date = end_date = nil
    unless @user.jobposition.nil?
      start_date =  @user.jobposition.start_date
      end_date = @user.jobposition.end_date
    end
    [start_date, end_date].compact.join('- ')
  end

  def image_path
    image_path = Rails.root.to_s + "/public/images/avatar_missing_icon.png"
    unless @user.person.nil? or @user.person.image.nil?
      file_path = Rails.root.to_s + @user.person.image.file.url(:card)
      image_path = file_path if File.exist? file_path
    end
    image_path
  end
end
