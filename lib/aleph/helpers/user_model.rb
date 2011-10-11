module Aleph
  module Helpers  
    module UserModel
      def aleph_enabled?
        File.exist? File.join(Rails.root.to_s, 'config', 'aleph.yml')
      end
    end
  end
end