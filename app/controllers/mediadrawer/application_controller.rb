module Mediadrawer
  class ApplicationController < ActionController::Base
    def index
      render :layout => false, format: :html
    end
  end
end
