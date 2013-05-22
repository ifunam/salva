# encoding: utf-8
class SeedThesismodalities < ActiveRecord::Migration
  def up
    @degree = Degree.find_by_name('Licenciatura')
    unless @degree.nil?
      Thesismodality.all.each do |record|
        record.update_attribute(:degree_id, @degree.id)
      end
      Thesismodality.create(:name => 'Otra modalidad', :degree_id => @degree.id)
    end

    unless @degree.nil?
      @degree = Degree.find_by_name('Maestría')
      ['Tesis', 'Por artículo de investigación', 'Por proyecto de investigación', 'Otra modalidad'].each do |name|
        Thesismodality.create(:name => name, :degree_id => 5)
      end
    end

    @degree = Degree.find_by_name('Doctorado')
    unless @degree.nil?
      ['Obtención de grado', 'Candidatura a grado de doctor', 'Otra modalidad'].each do |name|
        Thesismodality.create(:name => name, :degree_id => @degree.id)
      end
    end

  end

  def down
  end
end
