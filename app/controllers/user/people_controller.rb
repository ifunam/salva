class PeopleController < RecordController
  def initialize
    @model = Person
    super
    @columns = %w(firstname lastname1 lastname2 gender dateofbirth country state city)
  end
end

