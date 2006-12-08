class Report
  attr_accessor :model
  attr_accessor :columns
  attr_accessor :rows
  
  class << self
    def find(model, columns, *options)
      report = self.new
      report.model = model
      report.columns = columns
      report.rows = model.find(*options)
      report
    end
  end
  
  def as(style)
    #...
  end

  module Styles
    #...
  end
end
