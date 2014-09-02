module Mediadrawer
  class FoldersController < ApplicationController
    respond_to :json

    def index
      path = params[:path] || '/'
      @recursive = params[:recursive] || '0'
      @folder = Folder.discover(path)
      unless @folder
        head 404
      end
    end
  end
end
