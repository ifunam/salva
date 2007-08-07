require 'navigator_tree'
require 'labels'
require 'transformer'
class Resume
  include NavigatorTree
  include Labels

  def initialize(user_id)
    @user =  User.find(user_id)
    @data = finder(tree_loader('resume'))
    @transformer = Transformer.new
  end

  def finder(tree)
    data = []
    tree.children.each do |child|
      next if child.data == 'user_reports'
      data << section_tags(child.data, child.path.size)
      if child.has_children?
        data +=  tags_for_items(general_info) and next  if child.data == "general"
        data += finder(child)
      else
        collection = Inflector.pluralize(child.data)
        data << get_collection(@user.send(collection)) if @user.respond_to? collection
      end
    end
    data
  end

  def as_html
    @transformer.as_html(@data)
  end

  def as_text
    @transformer.as_text(@data)
  end

  def as_pdf
    @transformer.as_pdf(@data)
  end

  private
  def section_tags(string, level)
    {:label => get_label(string),  :level => level.to_i - 1 }
  end

  def tags_for_items(collection)
    collection.collect { |item|
      item and next if item.is_a? Hash
      item.collect {|a| ( a.is_a? Array)  ? [ get_label(a[0]),  a[1].to_s ] :  a.to_s }
    }
  end

  def get_collection(collection)
    collection.collect { |record|
      if record.respond_to? 'as_text'
        record.as_text
      elsif record.respond_to? 'name'
        record.name
      elsif record.respond_to? 'title'
        record.title
      else
      end
    }
  end

  def  general_info
    [ section_tags('person', 3),
      [ ['fullname', @user.person.fullname],
        ['dateofbirth',  @user.person.dateofbirth],
        ['maritalstatus_id', @user.person.maritalstatus.name]
      ],
      section_tags('address', 3),
      [['address', @user.addresses.first.as_text],
       ['phone', @user.addresses.first.phone],
       ['fax', @user.addresses.first.fax],
       ['movil', @user.addresses.first.movil],
       ['email', @user.email]
      ]
     ]
  end
end
