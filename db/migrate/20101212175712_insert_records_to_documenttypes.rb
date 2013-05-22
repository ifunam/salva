class InsertRecordsToDocumenttypes < ActiveRecord::Migration
  def self.up

    @dt1 = Documenttype.new(:name => 'Informe anual de actividades - 2010', :year => 2010,
                           :start_date => '2010-12-13', :end_date => '2011-01-14')
    @dt1.save

    @dt2 = Documenttype.new(:name => 'Plan de trabajo - 2010', :year => 2010,
                            :start_date => '2010-12-13', :end_date => '2011-01-14')
    @dt2.save
  end

  def self.down
  end
end
