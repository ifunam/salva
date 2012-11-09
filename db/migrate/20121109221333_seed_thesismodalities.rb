# encoding: utf-8
class SeedThesismodalities < ActiveRecord::Migration
  def up
    @degree = Degree.find_by_name('Licenciatura')

    Thesismodality.all.each do |record|
      record.update_attribute(:degree_id, @degree.id)
    end
    Thesismodality.create(:name => 'Otra modalidad', :degree_id => @degree.id)

    @degree = Degree.find_by_name('Maestría')
    ['Tesis', 'Por artículo de investigación', 'Por proyecto de investigación', 'Otra modalidad'].each do |name|
      Thesismodality.create(:name => name, :degree_id => @degree.id)
    end

    @degree = Degree.find_by_name('Doctorado')
    ['Tesis', 'Asesoría a estudiante con que obtuvo la candidatura a grado de doctor',].each do |name|
      Thesismodality.create(:name => name, :degree_id => @degree.id)
    end

  end

  def down
  end
end
