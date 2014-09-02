module Mediadrawer
  class MediaController < ApplicationController
    before_action :index_defaults, only: [:index, :upload]
    respond_to :json

    def create
      @media = Media.new
      if params[:file]
        file = params[:file]
        @media.name = file.original_name
        @media.upload(file.read)
      elsif params[:link]
        link = params[:link]
        @media.name = File.basename(link)
        @media.upload(URI.parse(link).read)
      end

      render :show
    end

    def update
      @media = Media.find params[:id]
      @media.update alt: params[:alt]
      render :show
    end

    def show
      @media = Media.find params[:id]
    end

    def index
      @media_files = @current_folder.media_files
    end

    private
      def index_defaults
        @current_folder = Folder.discover(params[:path])
      end
  end
end
