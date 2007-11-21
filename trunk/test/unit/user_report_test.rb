require File.dirname(__FILE__) + '/../test_helper'
require 'user_report'
class UserReportTest < Test::Unit::TestCase
  fixtures :userstatuses, :users, :countries, :states, :cities, :maritalstatuses, :people,
      :user_cites,:addresstypes, :addresses, :idtypes, :identifications, :people_identifications,
      :institutiontitles, :institutiontypes, :institutions, :jobpositionlevels, :roleinjobpositions,
      :jobpositiontypes, :jobpositioncategories, :jobpositions, :adscriptions, :user_adscriptions,
   :indivadvicetargets, :indivadvices, :userroles, :genericworkstatuses, :genericworkgroups, :genericworktypes, :genericworks, :user_genericworks

  def setup
    @juana = User.find_by_login('juana')
    @juana_report = UserReport.new(@juana.id)
    @juana_report.report_path = RAILS_ROOT + '/test/fixtures/'

    @panchito = User.find_by_login('panchito')
    @panchito_report = UserReport.new(@panchito.id)
    @panchito_report.report_path = RAILS_ROOT + '/test/fixtures/'
  
    @admin = User.find_by_login('admin')
    @admin_report = UserReport.new(@admin.id)
    @admin_report.report_path = RAILS_ROOT + '/test/fixtures/'
  end

  def test_build_profile_for_juana
    assert_instance_of Array, @juana_report.build_profile
    assert_equal [["fullname", "Maltiempo Juana"],
                  ["gender", "Femenino"],
                  ["dateofbirth", "17/03/1977"],
                  ["placeofbirth", "Culiacán, Sinaloa, México"],
                  ["author_name", "Maltiempo J."],
                  ["total_cites", 100],
                  ["address","Domicilio profesional, Instituto de Física, Edificio principal, Cubículo 254, Circuito de la Investigación Científica S/N, Ciudad Universitaria, Delegación Coyoacán, 2376, Ciudad de México, Distrito Federal, México"],
                  ["phone", nil],
                  ["fax", nil],
                  ["email", "alex@fisica.unam.mx"],
                  ["citizens_and_identifications", "Mexicana, CURP, CURP7701219812921"],
                  ["most_recent_jobposition_at_institution","Personal académico para investigación, Ayudante de investigador, Asoc. A  M.T., Instituto de Fisica, 2001"],
                  ["most_recent_user_adscription", "Citogenética ambiental"]],@juana_report.build_profile
  end


  def test_build_profile_for_panchito
    assert_instance_of Array, @panchito_report.build_profile
    assert_equal [["fullname", "Buentiempo Francisco"],
                  ["gender", "Masculino"],
                  ["dateofbirth", "07/02/1986"],
                  ["placeofbirth", "Monterrey, Nuevo León, México"],
                  ["author_name", "Buentiempo F."],
                  ["total_cites", 250],
                  ["address", "Domicilio profesional, Instituto de Física, Edificio principal, Cubículo 254, Circuito de la Investigación Científica S/N, Ciudad Universitaria, Delegación Coyoacán, 2376, Ciudad de México, Distrito Federal, México"],
                  ["phone", "56225001"],
                  ["fax", nil],
                  ["email", "alexjr85@gmail.com"],
                  ["citizens_and_identifications", "Mexicana, RFC, BUEN770317B10\nMexicana, CURP, BUEN770317B10-121-B20"],
                  ["most_recent_jobposition_at_institution", "Personal académico para investigación, Ayudante de investigador, Asoc. A  M.T., Centro de Ciencias de la Atmósfera, 2003"],
                  ["most_recent_user_adscription", "Aerosoles atmosféricos"]], @panchito_report.build_profile
  end

  def test_build_profile_with_some_empty_data_for_admin
      assert_instance_of Array, @admin_report.build_profile
      assert_equal [["fullname", nil],
                    ["gender", nil],
                    ["dateofbirth", nil],
                    ["placeofbirth", nil],
                    ["author_name", "Alba Andrade Fernando"],
                    ["total_cites", 1],
                    ["address", nil],
                    ["phone", nil],
                    ["fax", nil],
                    ["email", "alex@bsdcoders.org"],
                    ["citizens_and_identifications", "Ucraniana, Pasaporte, Pasaporte Ucraniano"],
                    ["most_recent_jobposition_at_institution", nil],
                    ["most_recent_user_adscription", nil]], @admin_report.build_profile
  end
  
  def test_load_yml
    data_from_yaml = @juana_report.load_yml('user_annual_report.yml')
    assert_instance_of Array, data_from_yaml
    tree = Tree.new(data_from_yaml)
    assert_instance_of Tree, tree
  end

  def test_build_section
    data_from_yaml = @juana_report.load_yml('user_annual_report.yml')
    assert_instance_of Array, data_from_yaml
    tree = Tree.new(data_from_yaml)
    assert_instance_of Tree, tree
    section = @juana_report.build_section(tree)
    assert_instance_of Array, section
  
  end

  def test_build_report
    assert_equal [{:level=>1, :title=>"profile"},
                  {:level=>2, :title=>"jobposition"},
                  {:level=>3, :title=>"jobposition_internal"},
                  {:level=>4,
                    :data=>
                    ["Personal académico para docencia, Técnico académico, Asoc. A  M.T., Instituto de Fisica, 1998, 2000",
                     "Personal académico para investigación, Ayudante de investigador, Asoc. A  M.T., Instituto de Fisica, 2001"],
                    :title=>"jobposition_at_institution"},
                  {:level=>3,
                    :data=>
                    ["Personal académico para investigación, Investigador, Asoc. A  M.T., Centro de Ciencias de la Atmósfera, 2002, 2001",
                     "Personal académico para investigación, Ayudante de investigador, Asoc. A  M.T., Centro de Ciencias de la Atmósfera, 2003"],
                    :title=>"jobposition_external"}], @juana_report.build_report
  end

  #def test_as_html
  #  assert_instance_of Array, @juana_report.as_html
   # assert_equal [], @juana_report.as_html
  #end
  def test_profile_as_html
    assert_instance_of Array, @juana_report.profile_as_html
   assert_equal [], @juana_report.profile_as_html
  end
  
    def test_as_pdf
      file_content = File.new File.join(RAILS_ROOT, 'test/fixtures', 'transformer_output.pdf'), 'w'
      file_content.write @juana_report.as_pdf
      file_content.close
    end
  
end
