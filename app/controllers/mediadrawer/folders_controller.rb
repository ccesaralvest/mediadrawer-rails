module Mediadrawer
  class FoldersController < ApplicationController
    def show
      @files = Folder.find(params[:id]).files

      respond_to do |format|
        format.json { render json: @files }
      end
    end
  end
end
