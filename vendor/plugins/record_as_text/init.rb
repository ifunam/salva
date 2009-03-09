require File.dirname(__FILE__) + "/lib/record_as_text"
ActiveRecord::Base.send(:include, RecordAsText)
