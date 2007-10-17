require File.dirname(__FILE__) + '/../test_helper'
require 'select_helper'
class SelectHelperTest < Test::Unit::TestCase
  include SelectHelper
  fixtures :userstatuses, :users, :maritalstatuses, :countries, :states, :cities, 
    :people, :addresstypes, :addresses, :languages, :languagelevels, :mediatypes,
    :publishers, :journals, :articlestatuses, :articles, :user_articles, :roleintheses,
    :conferencetypes, :conferencescopes, :conferences, :proceedings, :migratorystatuses,
    :citizenmodalities, :citizens, :idtypes, :identifications, :jobpositionlevels, 
    :roleinjobpositions, :jobpositiontypes, :jobpositioncategories, :institutiontitles, 
    :institutiontypes, :institutions
    
  def test_should_selectize_id_from_object
    record = Person.find_by_firstname('Juana')
    selected_id = selectize_id(record, 'country_id')
    assert_equal 484, selected_id
  end

  def test_should_set_default_value_for_fieldid_in_a_new_object
    record = Person.new
    record.country_id = selectize_id(record, 'country_id', 500)
    assert_equal 500, record.country_id
  end

  def test_not_should_set_default_value_for_unexistent_fieldid_from_object
    record = Person.new
    record.country_id = selectize_id(record, 'country_id2')
    assert_equal nil, record.country_id
  end

  def test_should_selectize_id_from_filter
    record = Person.find_by_firstname('Juana')
    assert_equal 25, record.state_id
    filter = { 'state_id' => 19}
    record.state_id = selectize_id(record, 'state_id', 9, filter)
    assert_equal 19, record.state_id
  end
  
  def test_finder_id
    assert_equal [['México', 484]], finder_id(Country, 484)
    assert_equal [['Sinaloa', 25]], finder_id(State, 25)
    assert_equal [['Mexicana', 484]], finder_id(Country, 484, 'citizen')
    assert_equal [["Operacion del Radiotelescopio de Centelleo Interplanetario, CONOZCA MAS",1]], finder_id(UserArticle, 1, [['article', 'title', ['journal', 'name']]])
  end

  def test_simple_select
    @edit  = UserLanguage.new
    assert_equal "<select id=\"edit_language_id\" name=\"edit[language_id]\" tabindex=\"1\"><option value=\"\">-- Seleccionar --</option>\n<option value=\"5\">Alemán</option>\n<option value=\"1\">Español</option>\n<option value=\"2\">Inglés</option>\n<option value=\"3\">Portugués</option></select>", simple_select('edit', Language, 1)
    assert_equal "<select id=\"edit_language_id\" name=\"edit[language_id]\" tabindex=\"1\"><option value=\"5\">Alemán</option>\n<option value=\"1\" selected=\"selected\">Español</option>\n<option value=\"2\">Inglés</option>\n<option value=\"3\">Portugués</option></select>", simple_select('edit', Language, 1, :selected => 1)
    assert_equal "<select id=\"edit_spoken_languagelevel_id\" name=\"edit[spoken_languagelevel_id]\" tabindex=\"2\"><option value=\"\">-- Seleccionar --</option>\n<option value=\"3\">Avanzado</option>\n<option value=\"1\">Basico</option>\n<option value=\"2\">Intermedio</option></select>", simple_select('edit', Languagelevel, 2, :prefix => 'spoken')
    assert_equal "<select id=\"edit_spoken_languagelevel_id\" name=\"edit[spoken_languagelevel_id]\" tabindex=\"2\"><option value=\"3\" selected=\"selected\">Avanzado</option>\n<option value=\"1\">Basico</option>\n<option value=\"2\">Intermedio</option></select>", simple_select('edit', Languagelevel, 2, :prefix => 'spoken', :selected => 3)
    assert_equal "<select id=\"edit_written_languagelevel_id\" name=\"edit[written_languagelevel_id]\" tabindex=\"3\"><option value=\"\">-- Seleccionar --</option>\n<option value=\"3\">Avanzado</option>\n<option value=\"1\">Basico</option>\n<option value=\"2\">Intermedio</option></select>", simple_select('edit', Languagelevel, 3, :prefix => 'written')
    assert_equal "<select id=\"edit_written_languagelevel_id\" name=\"edit[written_languagelevel_id]\" tabindex=\"3\"><option value=\"3\" selected=\"selected\">Avanzado</option>\n<option value=\"1\">Basico</option>\n<option value=\"2\">Intermedio</option></select>", simple_select('edit', Languagelevel, 3, :prefix => 'written', :selected => 3)

    @edit = Citizen.new
    assert_equal "<select id=\"edit_citizen_country_id\" name=\"edit[citizen_country_id]\" tabindex=\"2\"><option value=\"\">-- Seleccionar --</option>\n<option value=\"392\">Japonesa</option>\n<option value=\"484\">Mexicana</option>\n<option value=\"666\">Norteamericano</option>\n<option value=\"804\">Ucraniana</option></select>", simple_select('edit', Country, 2, :prefix => 'citizen', :column => 'citizen')
    assert_equal "<select id=\"edit_citizen_country_id\" name=\"edit[citizen_country_id]\" tabindex=\"2\"><option value=\"392\">Japonesa</option>\n<option value=\"484\" selected=\"selected\">Mexicana</option>\n<option value=\"666\">Norteamericano</option>\n<option value=\"804\">Ucraniana</option></select>", simple_select('edit', Country, 2, :prefix => 'citizen', :column => 'citizen', :selected => 484)
  end
  
  def test_select_conditions
    @edit = Address.new
    assert_equal "<select id=\"edit_addresstype_id\" name=\"edit[addresstype_id]\" tabindex=\"1\"><option value=\"\">-- Seleccionar --</option>\n<option value=\"1\">Domicilio profesional</option>\n<option value=\"3\">Domicilio temporal</option></select>", select_conditions('edit', Addresstype,  1, :conditions => "addresstypes.id NOT IN (SELECT addresstypes.id FROM addresstypes, addresses WHERE addresses.addresstype_id = addresstypes.id AND addresses.user_id = 2)")
    assert_equal "<select id=\"edit_addresstype_id\" name=\"edit[addresstype_id]\" tabindex=\"1\"><option value=\"\">-- Seleccionar --</option>\n<option value=\"1\">Domicilio profesional</option>\n<option value=\"3\">Domicilio temporal</option></select>", select_conditions('edit', Addresstype, 1, :conditions => "addresstypes.id NOT IN (SELECT addresstypes.id FROM addresstypes, addresses WHERE addresses.addresstype_id = addresstypes.id AND addresses.user_id = 2)")

    @edit = UserThesis.new
    assert_equal "<select id=\"edit_roleinthesis_id\" name=\"edit[roleinthesis_id]\" tabindex=\"2\"><option value=\"\">-- Seleccionar --</option>\n<option value=\"2\">Director</option>\n<option value=\"3\">Asesor</option></select>", select_conditions('edit', Roleinthesis, 2, :attributes => %w(name),  :conditions => "name = 'Director' OR name = 'Asesor' OR name = 'Lector'")
    
    @edit = UserProceeding.new
    assert_equal "<select id=\"edit_proceeding_id\" name=\"edit[proceeding_id]\" tabindex=\"1\"><option value=\"\">-- Seleccionar --</option>\n<option value=\"2\">Coloquio de Artes Manuales y otras habilidades</option>\n<option value=\"1\">Characterización of position-sensitive photomultiplier tubesfor microPET, detection modules</option></select>", select_conditions('edit', Proceeding,  1, :attributes => %w(title year), :conditions => "isrefereed = 'f'")
    
    @edit = Jobposition.new
    assert_equal "<select id=\"edit_jobpositioncategory_id\" name=\"edit[jobpositioncategory_id]\" tabindex=\"1\"><option value=\"\">-- Seleccionar --</option>\n<option value=\"1\">Asoc. A  M.T., Técnico académico</option></select>", select_conditions('edit', Jobpositioncategory, 1, :attributes => [ 'roleinjobposition', 'jobpositionlevel'] , :conditions => "jobpositiontype_id = 2")

    @edit = Institutioncareer.new
    assert_equal "<select id=\"edit_institution_id\" name=\"edit[institution_id]\" tabindex=\"1\"><option value=\"\">-- Seleccionar --</option>\n<option value=\"96\">Dirección General de Asuntos del Personal Académico</option>\n<option value=\"57\">Centro de Ciencias de la Atmósfera</option>\n<option value=\"1\">UNAM, Universidad Nacional Autónoma de México</option>\n<option value=\"71\">Centro de Enseñanza de Lenguas Extranjeras</option>\n<option value=\"5588\">SEP, Secretaría de Educación Pública</option>\n<option value=\"3\">, Programa Universitario de Estudios de Género</option></select>", select_conditions('edit', Institution, 1, :attributes => ['name', ['institution', 'abbrev']]) 
    # assert_equal '',  select_conditions('edit', Institution, 1, :attributes => ['name', ['institution', 'abbrev']],:conditions => "institutions.institution_id = 1)
  end
end
