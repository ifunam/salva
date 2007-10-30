require File.dirname(__FILE__) + '/../test_helper'
require 'user_report'
class UserReportTest < Test::Unit::TestCase
  fixtures :userstatuses, :users, :countries, :states, :cities, :maritalstatuses, :people, 
      :user_cites,:addresstypes, :addresses, :idtypes, :identifications, :people_identifications,
      :institutiontitles, :institutiontypes, :institutions, :jobpositionlevels, :roleinjobpositions, 
      :jobpositiontypes, :jobpositioncategories, :jobpositions, :adscriptions, :user_adscriptions

  def setup
    @juana = User.find_by_login('juana')
    @juana_report = UserReport.new(@juana.id)
    @juana_report.report_path = RAILS_ROOT + '/test/fixtures/'

    @panchito = User.find_by_login('panchito')
    @panchito_report = UserReport.new(@panchito.id)
    @panchito_report.report_path = RAILS_ROOT + '/test/fixtures/'
  end

  def test_build_profile_for_juana
    assert_instance_of Hash, @juana_report.build_profile
    profile = @juana_report.build_profile
    assert_equal 'Maltiempo Juana', profile['fullname']
    assert_equal '17/03/1977', profile['dateofbirth'].to_s
    assert_equal 'Culiacán, Sinaloa, México', profile['placeofbirth']
    assert_equal 'Maltiempo J.', profile['author_name']
    assert_equal 100, profile['total_cites']
    assert_equal "Domicilio profesional, Instituto de Física, Edificio principal, Cubículo 254, Circuito de la Investigación Científica S/N, Ciudad Universitaria, Delegación Coyoacán, 2376, Ciudad de México, Distrito Federal, México", profile['address']
    assert_nil profile['phone']
    assert_nil profile['fax']
    assert_equal 'alex@fisica.unam.mx', profile['email']
    assert_equal "Mexicana, CURP, CURP7701219812921", profile['citizens_and_identifications']
    assert_equal "Personal académico para investigación, Ayudante de investigador, Asoc. A  M.T., Instituto de Fisica, 2001", profile['most_recent_jobposition_at_institution']
    assert_equal "Citogenética ambiental", profile['most_recent_user_adscription']
  end

  def test_build_profile_for_panchito
    assert_instance_of Hash, @panchito_report.build_profile
    profile = @panchito_report.build_profile
    assert_equal 'Buentiempo Francisco', profile['fullname']
    assert_equal '07/02/1986', profile['dateofbirth'].to_s
    assert_equal 'Monterrey, Nuevo León, México', profile['placeofbirth']
    assert_equal 'Buentiempo F.', profile['author_name']
    assert_equal 250, profile['total_cites']
    assert_equal "Domicilio profesional, Instituto de Física, Edificio principal, Cubículo 254, Circuito de la Investigación Científica S/N, Ciudad Universitaria, Delegación Coyoacán, 2376, Ciudad de México, Distrito Federal, México", profile['address']
    assert_equal "56225001", profile['phone']
    assert_nil profile['fax']
    assert_equal 'alexjr85@gmail.com', profile['email']
    assert_equal "Mexicana, RFC, BUEN770317B10\nMexicana, CURP, BUEN770317B10-121-B20", profile['citizens_and_identifications']
    assert_equal "Personal académico para investigación, Ayudante de investigador, Asoc. A  M.T., Centro de Ciencias de la Atmósfera, 2003", profile['most_recent_jobposition_at_institution']
    assert_equal "Aerosoles atmosféricos", profile['most_recent_user_adscription']
  end
  
#  def test_build_annual_report_for_juana
#    @juana_report.build_report
#  end
  
  def test_build_section
    @juana_report.report_path = RAILS_ROOT + '/test/fixtures/'
    data_from_yaml = @juana_report.load_yml('user_annual_report.yml') 
    assert_instance_of Array, data_from_yaml
    tree = Tree.new(data_from_yaml)
    assert_instance_of Tree, tree
    section = @juana_report.build_section(tree)
    assert_instance_of Array, section
   end
end