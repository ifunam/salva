require 'ipaddr'
class Api::BaseController < ActionController::Base
  include Salva::SiteConfig

  # skip_before_action :authenticate_user!
  before_action :hosts_allow!

  respond_to :xml

  def hosts_allow!
    hosts = Salva::SiteConfig.api('hosts_allow')
    unless hosts.collect {|host|  IPAddr.new(host).include? request.remote_ip }.include? true
       render :text => 'Unauthorized', :status => 401
    end
  end
end
