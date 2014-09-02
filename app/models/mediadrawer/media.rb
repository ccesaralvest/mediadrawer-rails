module Mediadrawer
  class Media < ActiveRecord::Base
    include Magick
    belongs_to :folder
    after_initialize :set_defaults

    def set_defaults
      if self.name
        self.name = I18n.transliterate(name.gsub(' ', ''))
      end
      self.folder ||= Folder.root
    end

    def path
      "#{self.folder.path}/#{name}"
    end

    def url_for(size)
      s3 = S3.new
      unless mime_type =~ /image/
        s3[path].public_url.to_s
      else
        remote_file_path = "#{self.folder.path}/#{size.to_s}/#{name}"
        s3[remote_file_path].public_url.to_s
      end
    end

    def upload(content='')
      unless content.kind_of? Tempfile
        file = Tempfile.new(self.name)
        file.binmode
        file.write content
        file.close
      else
        file = content
      end

      mime_type = FileMagic.new(FileMagic::MAGIC_MIME).file(file.path).to_s

      self.mime_type = mime_type
      s3 = S3.new
      
      unless mime_type =~ /image/
        s3.create file.path, file
        obj = s3[file.path]
        self.url = obj.public_url.to_s
        return obj
      end
      Mediadrawer.config['sizes'].each do |size_name, size|
        remote_file_path = "#{self.folder.path}/#{size_name}/#{name}"
        if size_name == 'original'
          s3.create remote_file_path, file
          obj = s3[remote_file_path]
          self.url = obj.public_url.to_s
        else
          size = size.split 'x'
          if size.count == 2
            img = Magick::Image.read(file.path).first
            img.resize_to_fit!(size[0].to_i, size[1].to_i)
            img.write file.path
          end
          s3.create remote_file_path, file
        end
      end
    end
  end
end
