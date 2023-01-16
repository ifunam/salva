class Video < ActiveRecord::Base
  # attr_accessor :user_id, :name, :url, :start_year, :start_month
  belongs_to :user
  default_scope -> { order(start_year: :desc, start_month: :desc) }
  validates :name, :presence => true
  validates :url, :presence => true, :uniqueness => true
  scope :year_eq, lambda { |year| where('year = ?', year) }
  # search_methods :year_eq
  validates_length_of :name, :maximum => 256

  def to_s
    [name, url, date].compact.join(', ').sub(/;,/, ';')
  end

  def date
    meses = ['enero','febreo','marzo','abril','mayo','junio','julio','agosto','septiembre','octubre','noviembre','diciembre']
    meses[start_month-1] + ' de ' + start_year.to_s
  end

end
