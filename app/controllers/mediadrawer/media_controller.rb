module Mediadrawer
  class MediaController < ApplicationController
    before_action :index_defaults, only: [:index, :upload]
    respond_to :json
    
    def upload
    end

    def show
    end

    def index
      @media_files = @current_folder.media_files
    end

    def index_defaults
      @current_folder = Folder.discover(params[:path])
    end
  end
end
