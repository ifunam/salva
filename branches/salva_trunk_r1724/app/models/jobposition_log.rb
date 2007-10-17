class JobpositionLog < ActiveRecord::Base
validates_presence_of :worker_key, :years
end
