module ActionDispatch::Routing
  class Mapper
      def super_catalogs_for(*controllers)
        controllers.map!(&:to_sym)
        controllers.each do |resources_name|
          resources resources_name do
            put :move_association, :on => :member
            put :move_associations, :on => :member
            post :destroy_all, :on => :collection
            get :destroy_all_empty_associations, :on => :collection
          end
        end
      end
  end
end