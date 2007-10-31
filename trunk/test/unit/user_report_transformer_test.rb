require File.dirname(__FILE__) + '/../test_helper'
require 'user_report_transformer'
class UserReportTransformerTest < Test::Unit::TestCase
  def setup
    @t = UserReportTransformer.new()
    @data =[
            { :title=>"general",
              :data=> [
                       ["fullname", "Maltiempo Juana"],
                       ["dateofbirth", "17/03/1977"],
                       ["placeofbirth", "Culiacán, Sinaloa, México"],
                       ["author_name", "Maltiempo J."],
                       ["total_cites", 100],
                       ["address", "Domicilio profesional, Instituto de Física, Edificio principal, Cubículo 254, Circuito de la Investigación Científica S/N, Ciudad Universitaria, Delegación Coyoacán, 2376, Ciudad de México, Distrito Federal, México"],
                       ["phone", nil],
                       ["fax", nil],
                       ["email", "alex@fisica.unam.mx"],
                       ["citizens_and_identifications", "Mexicana, CURP, CURP7701219812921"],
                       ["most_recent_jobposition_at_institution", "Personal académico para investigación, Ayudante de investigador, Asoc. A  M.T., Instituto de Fisica, 2001"],
                       ["most_recent_user_adscription", "Citogenética ambiental"]
                      ],
              :level=>1 },
            { :title=>"profile", :level=>1 },
            { :title=>"jobposition", :level=>2 },
            { :title=>"jobposition_internal", :level=>3 },
            { :title=>"jobposition_at_institution",
              :data=> ["Personal académico para docencia, Técnico académico, Asoc. A  M.T., Instituto de Fisica, 1998, 2000",
                       "Personal académico para investigación, Ayudante de investigador, Asoc. A  M.T., Instituto de Fisica, 2001"],
              :level=>4 },
            { :title=>"jobposition_external",
              :data=> ["Personal académico para investigación, Ayudante de investigador, Asoc. A  M.T., Centro de Ciencias de la Atmósfera, 2003",
                       "Personal académico para investigación, Investigador, Asoc. A  M.T., Centro de Ciencias de la Atmósfera, 2002, 2001"],
              :level=>3}
           ]
  end

  def test_as_html
    assert_equal '', @t.as_html(@data)
  end

end
