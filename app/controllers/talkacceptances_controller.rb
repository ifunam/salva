class TalkacceptancesController < SuperScaffoldController

   def initialize 
     @model = Talkacceptance
     super
     @find_options = { :order => 'name ASC' }
   end
end