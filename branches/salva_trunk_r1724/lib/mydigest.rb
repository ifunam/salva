require 'digest/sha2'
module Mydigest
  # Hash a given password with the salt. This method localizes the encryption
  # function so that it can be easily changed.
  def encrypt(passwd, mysalt)
    Digest::SHA512.hexdigest(passwd + mysalt)
  end

  # Create a string used for the salted password.
  def salted
    token_string(40)
  end

  # Create a security token for use in logging in a user who has forgotten
  # his password or has just created his login.
  def token_string(n)
    s = ""
    char64 = (('a'..'z').collect + ('A'..'Z').collect + ('0'..'9').collect + ['.','/']).freeze
    n.times { s << char64[(Time.now.tv_usec * rand) % 64] }
    s
  end
end
