class ImpactFactor < ActiveRecord::Base
  belongs_to :journal, :inverse_of => :impact_factors
  validates_presence_of :journal_id, :year, :value
  # attr_accessor :journal_id, :year, :value

  def journal_name
    journal.name
  end

  def save(*args)
    super
  rescue ActiveRecord::RecordNotUnique => error
    errors[:base] << "Ya existe un factor de impacto para la revista en ese año"
    false
  end

end
