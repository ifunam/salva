class Menu < ActiveRecord::Base
  set_table_name 'trees'
  acts_as_nested_set
end
