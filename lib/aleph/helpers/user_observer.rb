module Aleph
  module Helpers  
    module UserObserver
      def create_or_update_aleph_account(user)
         aleph_profile = aleph_profile_for(user)
         @aleph_user = Aleph::User.find(aleph_profile[:key])
         unless @aleph_user.nil?
           aleph_profile.delete :key
           @aleph_user.attributes = aleph_profile
         else
           @aleph_user = Aleph::User.new(aleph_profile_for(user))
         end
         if @aleph_user.save
           aleph_notification(user)
         else
           Notifier.aleph_errors_to_library_admin(user.id).deliver
         end
       end

       def aleph_notification(user)
         if user.category_name == 'Investigador posdoctoral'
           Notifier.notification_card_for_postdoctoral(user.id).deliver
         elsif user.category_name == 'Cátedra CONACYT'
           Notifier.notification_card_for_conacyt(user.id).deliver
         else
           Notifier.aleph_notification_for_academic(user.id).deliver
         end
         Notifier.notification_for_library_admin(user.id).deliver
       end
       
       def destroy_aleph_user(user)
         @user_profile = UserProfile.find(user.id)
         @aleph_user = Aleph::User.find(@user_profile.worker_key)
         unless @aleph_user.nil?
           @aleph_user.destroy
           Notifier.notification_of_deleted_user_for_library_admin(user).deliver
         end
      end

       def aleph_profile_for(user)
         @user_profile = UserProfile.find(user.id)
         { :key => @user_profile.worker_key, :firstname => @user_profile.firstname,
           :lastname => @user_profile.lastname, :unit => @user_profile.adscription_name,
           :academic_level => @user_profile.category_name,
           :location => @user_profile.address_location, :country => @user_profile.address_country_name,
           :city => @user_profile.address_city_name, :state => @user_profile.address_state_name,
           :zipcode => @user_profile.address_zipcode, :phone => @user_profile.phone,
           :email => @user_profile.email, :expiry_date => @user_profile.jobposition_end_date,
           :type => 'AC', :image => File.new(@user_profile.image_path)
         }
       end
    end
  end
end
