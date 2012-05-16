require "digest/sha2"
module Devise
  module Encryptable
    module Encryptors
      # = SalvaSha512
      # Simulates Authlogic's default encryption mechanism.
      # Warning: it uses Devise's stretches configuration to port Salva's one. Should be set to 40 in the initializer to simulate
      #  the default behavior.
      class SalvaSha512 < Base
       # Generates a default password digest based on salt, pepper and the
       # incoming password.
       def self.digest(password, stretches, salt, pepper)
          Digest::SHA512.hexdigest(password + salt)
       end
      end
    end
  end
end
