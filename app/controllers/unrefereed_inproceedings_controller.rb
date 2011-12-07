class UnrefereedInproceedingsController < PublicationController
  defaults :resource_class => Inproceeding, :collection_name => 'inproceedings', :instance_name => 'inproceeding',
           :resource_class_scope => :unrefereed,
           :user_role_class => :user_inproceedings

  def create
    super
    resource.proceeding.update_attribute(:isrefereed, false)
  end


  def update
    resource.proceeding.isrefereed = false
    super
  end
end