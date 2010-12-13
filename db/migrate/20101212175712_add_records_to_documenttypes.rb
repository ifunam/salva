class AddRecordsToDocumenttypes < ActiveRecord::Migration
  def self.up
    Documenttype.create(:name => 'Informe anual de actividades - 2010', :year => 2010, :status => true,
                        :start_date => '2010-12-13', :end_date => '2011-01-14')
    Documenttype.create(:name => 'Plan de trabajo - 2010', :year => 2010, :status => true,
                        :start_date => '2010-12-13', :end_date => '2011-01-14')                        
  end

  def self.down
  end
end
