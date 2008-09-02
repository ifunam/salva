class PrizetypesController < SuperScaffoldController

  def initialize
    @model = Prizetype
    super
    @find_options = { :order => 'name ASC' }
  end
end
