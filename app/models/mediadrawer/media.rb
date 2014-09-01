module Mediadrawer
  class Media < ActiveRecord::Base
    belongs_to :folder
  end
end
