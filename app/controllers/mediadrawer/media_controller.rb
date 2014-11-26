module Mediadrawer
  class MediaController < ApplicationController
    respond_to :json

    def create
      @media = Media.new
      @media.folder = Folder.discover(params[:path])
      if params[:file]
        file = params[:file]
        @media.mime_type = file.content_type
        @media.name = file.original_filename
        @media.upload(file.tempfile)
      elsif params[:link]
        link = params[:link]
        @media.name = File.basename(link)
        response = open(link, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE)
        @media.mime_type = response.content_type
        @media.upload response.read
      end
      @media.save
      render :show
    end

    def destroy
      Media.find(params[:id]).destroy
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
      @folder = Folder.discover(params[:path])
      @media_files = @folder.media_files
      if params[:type]
        @media_files = @media_files.where('mime_type like ?', ["%#{params[:type]}%"])
      end
      @media_files = @media_files.page(params[:page]).per(params[:per])
      @folder.media_files
    end
  end
end
