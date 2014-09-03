module Mediadrawer
  class FoldersController < ApplicationController
    respond_to :json

    def index
      path = params[:path] || ''
      @recursive = params[:recursive] || '0'
      @folder = Folder.discover(path)
      unless @folder
        head 404
      end
    end

    def update
      @folder = Folder.find params[:id]
      @folder.name = params[:name]
      if @folder.save
        render partial: 'item', locals: { item: @folder }
      else
        head 422
      end
    end

    def destroy
      Folder.find(params[:id]).destroy
    end

    def create
      @folder = Folder.new
      @folder.name = params[:name]
      if @folder.save
        render partial: 'item', locals: { item: @folder }
      else
        head 422
      end
    end
  end
end
