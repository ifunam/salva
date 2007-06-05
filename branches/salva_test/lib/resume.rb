require 'navigator_tree'
class Resume
  include NavigatorTree

  def initialize(user)
    @user = user
    @data = []
  end

  def build_data
    tree = tree_loader('resume')
    @data = navigator(tree)
  end

  def navigator(tree)
    data = []
    tree.children.each { |child|
      if child.has_children?
        if child.data == "general"
          data << {:label => child.data,  :level => child.path.size}
          get_general.each { |child_data|  data <<  child_data }
          next
        else
          data << {:label => child.data,  :level => child.path.size}
          navigator(child).each { |child_data|  data <<  child_data }
        end
      else
        data << {:label => child.data,  :level => child.path.size}
      end
    }
    data
  end

  def get_general
     [ {:label => 'person',  :level => 3},
       get_person,
       {:label => 'address',  :level => 3},
       get_address ]
  end

  def  get_person
    [ ['fullname', @user.person.fullname],
      ['dateofbirth',  @user.person.dateofbirth],
      ['maritalstatus', @user.person.maritalstatus.name]
    ]
  end

  def get_address
    [['address', @user.addresses.first.as_text],
    ['phone', @user.addresses.first.phone],
    ['fax', @user.addresses.first.fax],
    ['movil', @user.addresses.first.movil],
    ['email', @user.addresses.first.email]]
  end

  def collection_as_vancouver(collection)
    collection.collect { |record| record.as_vancouver }
  end
end
