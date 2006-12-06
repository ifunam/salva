# $:.unshift "/usr/local/lib/ruby/gems/1.8/gems/net-ssh-1.0.10/lib"
# $:.unshift "/usr/local/lib/ruby/gems/1.8/gems/needle-1.3.0/lib"
require 'net/ssh'
module Ssh
  def ssh_auth(host,user,passwd)
    begin
      return true if Net::SSH::Session.new(host, user, passwd)
    rescue StandardError => bang
      return false
    end
  end
end
