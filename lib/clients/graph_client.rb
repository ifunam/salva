require 'rest_client'
require 'redis'
require 'yaml'
require Rails.root.join('lib/salva/site_config')
class GraphClient
  include Salva::SiteConfig

  def initialize(params)
    @site =Salva::SiteConfig.misc('schoolar_system_api')
    @api_enabled = Salva::SiteConfig.misc('schoolar_system_api_enabled')
    if params['final'].nil?
      @url_years = "#{@site}/reports/years.json"
      @url_periods = "#{@site}/reports/periods.json"
      @url_adscriptions = "#{@site}/reports/adscriptions.json"
    else
      if params['initial']
        @url_years = "#{@site}/reports/years.json?search[y1]="+params['initial']+"&search[y2]="+params['final']
        @url_periods = "#{@site}/reports/periods.json?search[p1_id]="+params['initial']+"&search[p2_id]="+params['final']
      end
      @url_adscriptions = "#{@site}/reports/adscriptions.json?search[period_id]="+params['final']
    end
    @resource_years = RestClient::Resource.new @url_years
    @resource_periods = RestClient::Resource.new @url_periods
    @resource_adscriptions = RestClient::Resource.new @url_adscriptions
  end

  def get_years_resource
    @resource_years.get {|response, request, result|
      response.code.to_i == 200 ? response : { reports:[] }.to_json
    }
  end

  def get_years_hash
    JSON.parse(get_years_resource).to_hash
  end

  def all_years
    @api_enabled ? get_years_hash['reports'] : []
  end

  def get_periods_resource
    @resource_periods.get {|response, request, result|
      response.code.to_i == 200 ? response : { reports:[] }.to_json
    }
  end

  def get_periods_hash
    JSON.parse(get_periods_resource).to_hash
  end

  def all_periods
    @api_enabled ? get_periods_hash['reports'] : []
  end

  def get_adscriptions_resource
    @resource_adscriptions.get {|response, request, result|
      response.code.to_i == 200 ? response : { reports:[] }.to_json
    }
  end

  def get_adscriptions_hash
    JSON.parse(get_adscriptions_resource).to_hash
  end

  def all_adscriptions
    @api_enabled ? get_adscriptions_hash['reports'] : []
  end

end
