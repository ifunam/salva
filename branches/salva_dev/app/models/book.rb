class Book < ActiveRecord::Base
  validates_presence_of :title, :message => "Proporcione el título"
  validates_presence_of :author, :message => "Proporcione el autor"
end
