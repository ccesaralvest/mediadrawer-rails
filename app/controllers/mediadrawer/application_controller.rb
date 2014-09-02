module Mediadrawer
  class ApplicationController < ActionController::Base
    def index
      @directories = Folder.all
    end
  end
end
