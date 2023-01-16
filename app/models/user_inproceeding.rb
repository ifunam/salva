class UserInproceeding < ActiveRecord::Base
  # attr_accessor  :user_id, :ismainauthor, :inproceeding_id
  #validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  #validates_inclusion_of :ismainauthor, :in => [true, false]
  #validates_uniqueness_of :inproceeding_id, :scope => [:user_id]

  belongs_to :inproceeding
  belongs_to :user

  scope :year_eq, lambda { |year| joins(:inproceeding => :proceeding).where('proceedings.year = ?', year) }
  scope :refereed, -> { joins(:inproceeding => :proceeding).where("proceedings.isrefereed = 't' AND inproceedings.proceeding_id = proceedings.id") }
  scope :unrefereed, -> { joins(:inproceeding => :proceeding).where("proceedings.isrefereed = 'f' AND inproceedings.proceeding_id = proceedings.id") }
  scope :conferencescope_id, lambda { |id| joins(:inproceeding => {:proceeding => :conference}).where('conferences.conferencescope_id = ?', id) }
  scope :adscription_id, lambda { |id| joins(:user => :user_adscription).where(:user => { :user_adscription => { :adscription_id => id} }) }

  # search_methods :year_eq, :conferencescope_id, :adscription_id

  def self.valid_years
    find_by_sql('SELECT DISTINCT(year) FROM proceedings WHERE year IS NOT null AND year/1000>0 ORDER BY year').map(&:year)
  end

  def self.grouped_refereed_proceedings(year,refereed)
    @adscriptions=UserAdscription.all_adscriptions.map(&:name)
    @result = Hash.new
    @adscriptions.each do |adsc|
      query = "SELECT DISTINCT(user_inproceedings.id)
             FROM user_inproceedings 
             JOIN inproceedings ON inproceedings.id = user_inproceedings.inproceeding_id
             JOIN proceedings ON proceedings.id = inproceedings.proceeding_id 
             JOIN users ON users.id = user_inproceedings.user_id 
             JOIN user_adscriptions ON users.id = user_adscriptions.user_id 
             JOIN adscriptions ON user_adscriptions.adscription_id = adscriptions.id 
             WHERE proceedings.isrefereed = ? AND adscriptions.name=? AND proceedings.year=?",refereed,adsc,year
      tot = find_by_sql(query).length
      @result[adsc]=tot if tot!=0
    end
    @result
  end

end
