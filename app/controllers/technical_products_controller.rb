class TechnicalProductsController < PublicationController
  defaults :resource_class => Techproduct, :collection_name => 'technical_products', :instance_name => 'technical_product',
           :user_role_class => :user_techproducts, :role_class => :userrole
end
