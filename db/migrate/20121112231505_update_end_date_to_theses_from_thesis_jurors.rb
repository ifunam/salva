class UpdateEndDateToThesesFromThesisJurors < ActiveRecord::Migration
  def up
    ThesisJuror.all.each do |record|
      if record.year.to_i > 0
        m = record.month.to_i == 0 ? 1 : record.month.to_i
        d = Date.new(record.year.to_i, m, 1)
        record.thesis.update_attribute(:end_date, d)
      end
    end
  end

  def down
  end
end
