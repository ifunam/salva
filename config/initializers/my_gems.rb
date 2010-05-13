require 'will_paginate'
# Fix It: Delete the following 4 lines when will_paginate railtie and rails3 work without problems.
require 'will_paginate/finders/active_record'
WillPaginate::Finders::ActiveRecord.enable!
require 'will_paginate/view_helpers/action_view'
ActionView::Base.send(:include, WillPaginate::ViewHelpers::ActionView)
require 'RMagick'
require 'acts-as-taggable-on'
require 'inherited_resources'
# Required by tsearch plugin
require 'texticle'
require 'texticle/full_text_index'
require 'texticle/parser'
ActiveRecord::Base.extend(Texticle)
