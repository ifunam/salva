class AddUniversityAndCountryToOtherModels < ActiveRecord::Migration
  def change
    #Lista con las tablas en las que se agregan las columnas de institution_id university_id country_id degree_id
    tables = [:academicprograms,:theses,:tutorial_committees,:educations]
    tables.each do |table|
      add_column table, :institution_id, :integer
      add_column table, :university_id, :integer
      add_column table, :country_id, :integer
      add_column table, :degree_id, :integer
    end
    #Lista con las tablas en las que se agregan las columnas de institution_id university_id country_id
    tables = [:indivadvices,:careers]
    #:careers #No sé si es necesario
    tables.each do |table|
      add_column table, :university_id, :integer
      add_column table, :country_id, :integer
    end
  end
end
