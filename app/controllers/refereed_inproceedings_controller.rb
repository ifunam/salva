class RefereedInproceedingsController < PublicationController
  defaults :resource_class => Inproceeding, :collection_name => 'inproceedings', :instance_name => 'inproceeding',
           :resource_class_scope => :refereed,
           :user_role_class => :user_inproceedings

  def create
    super
    resource.proceeding.update_attribute(:isrefereed, true)
  end


  def update
    resource.proceeding.isrefereed = true
    super
  end
end