class InstitutiontypesController < SuperScaffoldController

   def initialize 
     @model = Institutiontype
     super
     @find_options = { :order => 'name ASC' }
   end
end