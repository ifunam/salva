module Salva::MetaUserAssociation

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def user_association_methods_for(association_name)
      if (self.reflect_on_all_associations(:has_many).collect(&:name) & [association_name.to_sym, :users]).size == 2 
        self.class_eval do
          define_method 'has_users?' do 
            users.size > 0
          end
          define_method 'has_user_id?' do |user_id|
             !send("#{association_name.to_sym}").where(:user_id => user_id).first.nil?
          end
        end
      else
        warn "You must define has_many relation for :#{association_name} and has_many :users, :through => :#{association_name}"
      end
    end
  end
end
ActiveRecord::Base.send :include, Salva::MetaUserAssociation