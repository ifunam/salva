class PublishedArticle < Article
  validates_presence_of :pages, :num, :month
 #validates_numericality_of :articlestatus_id, :equal_to => Articlestatus.find_by_name('Publicado').id, :only_integer => true
end
