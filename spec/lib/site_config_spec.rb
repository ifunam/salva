require_relative '../lib_spec_helper'

describe Salva::SiteConfig do
  context "Loading configuration file" do
    it "Should load config/site.yml" do
      @config_file = Salva::SiteConfig.send :load_config, 'site.yml'
      @config_file.should be_a_kind_of Hash
    end

    it "Should raise error when you try to use an unexistent file" do
      lambda { Salva::SiteConfig.send :load_config, 'unexistent.yml' }.should raise_error Errno::ENOENT
    end
  end

  context "Using configuration sections as methods" do
    it "Should return the institution name string" do
      Salva::SiteConfig.institution('name').should == "Instituto de Física - UNAM"
    end

    it "Should return the technical support engineer string" do
      Salva::SiteConfig.technical_support('engineer').should == "Alejandro Juárez Robles"
    end

    it "Should return nil for undefined methods (sections)" do
      lambda { Salva::SiteConfig.undefined_section('name') }.should raise_error NoMethodError
    end
  end
end
