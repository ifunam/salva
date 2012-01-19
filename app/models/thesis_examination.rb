class ThesisExamination < Thesis
  has_many :thesis_jurors, :foreign_key => 'thesis_id'
  has_many :users, :through => :thesis_jurors
  accepts_nested_attributes_for :thesis_jurors
  user_association_methods_for :thesis_jurors

  has_paper_trail

  # TODO: Verify if our scopes are working
  # scopes.delete :user_id_eq
  # scopes.delete :user_id_not_eq

  scope :user_id_eq, lambda { |user_id| joins(:thesis_jurors).where(:thesis_jurors => { :user_id => user_id }) }
  scope :user_id_not_eq, lambda { |user_id|  where("theses.id IN (#{ThesisJuror.select('DISTINCT(thesis_id) as thesis_id').where(["thesis_jurors.user_id !=  ?", user_id]).to_sql}) AND theses.id  NOT IN (#{ThesisJuror.select('DISTINCT(thesis_id) as thesis_id').where(["thesis_jurors.user_id =  ?", user_id]).to_sql})") }
  scope :roleinjury_id_eq, lambda { |roleinjury_id| joins(:thesis_jurors).where(:thesis_jurors => { :roleinjury_id => roleinjury_id }) }
  search_methods :user_id_eq, :user_id_not_eq, :roleinjury_id_eq

  def as_text
    [users_and_roles, title, career.as_text, date, "#{authors} (estudiante)"].compact.join(', ')
  end

  def users_and_roles
    thesis_jurors.collect {|record| record.as_text }.join(', ')
  end

  def date
    thesisstatus_id == 3 ? end_date : [start_date, end_date].join(', ')
  end
end
