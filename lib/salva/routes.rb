module ActionDispatch::Routing
  class Mapper
      def super_catalog_for(*controllers)
        controllers.map!(&:to_sym)
        controllers.each do |resources_name|
          resources resources_name do
            put  :move_association,  :on => :member
            put  :move_associations, :on => :member
            post :destroy_all,      :on => :collection
            get  :destroy_all_empty_associations, :on => :collection
          end
        end
      end

      def user_resources_for(*controllers)
        controllers.map!(&:to_sym)
        controllers.each do |resources_name|
          resources resources_name do
            get :destroy_all, :on => :collection
          end
        end
      end

      def publication_resources_for(*controllers)
        controllers.map!(&:to_sym)
        controllers.each do |resources_name|
          resources resources_name do
             get :user_list, :on => :member
             get :role_list, :on => :member
             get :add_user,  :on => :member
             get :del_user,  :on => :member
             get :not_mine,  :on => :collection, :as => :not_my
             get :destroy_all, :on => :collection
          end
        end
      end
      
      def catalog_resources_for(*controllers)
        controllers.map!(&:to_sym)
        controllers.each do |resources_name|
          resources resources_name, :only => [:new, :create] do
            get :autocompleted_search, :on => :collection
          end
        end
      end
  end
end
