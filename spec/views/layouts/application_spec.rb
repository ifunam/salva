require File.dirname(__FILE__) + '/../../views_spec_helper'

describe ActionView::Layouts::Application do
   it "should render application layout" do
     html = '<html><body><div id="header"><h1>SALVA - Plataforma de Información Curricular</h1></div><div id="topbar"></div><div id="navbar"></div><div id="main_container"></div><div id="footer"></div></body></html>'
     view.render(:file => 'layouts/application').should == html
   end
end