$:.unshift "/usr/local/lib/ruby/gems/1.8/gems/net-ssh-1.0.9/lib"
$:.unshift "/usr/local/lib/ruby/gems/1.8/gems/needle-1.3.0/lib"
require 'net/ssh'

def ssh_session(host,user,passwd)
    begin
      if Net::SSH.start(host, user, passwd)
        return true
      end
    rescue StandardError => bang
    end
end
