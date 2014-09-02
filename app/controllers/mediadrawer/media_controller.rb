module Mediadrawer
  class MediaController < ApplicationController::Base
    before_action :list_defaults, only: [:index, :upload]

    def upload
    end

    def select
    end

    def index
      @media_files = @current_folder.media_files
    end

    def index_defaults
      @current_folder = Folder.discover(params[:path])
    end
  end
end
