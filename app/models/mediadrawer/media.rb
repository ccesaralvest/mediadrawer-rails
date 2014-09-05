module Mediadrawer
  class Media < ActiveRecord::Base
    include Magick
    belongs_to :folder, :dependent=>:destroy
    after_initialize :set_defaults
    after_initialize :parameterize

    after_destroy :delete_file
    before_save :parameterize

    def delete_file
      s3 = S3.new
      unless mime_type =~ /image/
        s3.delete path
      else
        Mediadrawer.config['sizes'].each do |size_name, size|
          s3.delete self.path(size_name)
        end
      end
    end

    def set_defaults
      self.folder ||= Folder.root
    end

    def parameterize
      if self.name
        self.name = I18n.transliterate(name.gsub(' ', ''))
      end
    end

    def path(size=nil)
      file_path_part = size ? "#{size}/#{name}" : name
      if self.folder.path.empty?
        file_path_part
      else
        "#{self.folder.path}/#{file_path_part}"
      end
    end

    def url_for(size=nil)
      s3 = S3.new
      unless mime_type =~ /image/
        s3[path('original')].public_url.to_s
      else
        remote_file_path = self.path(size)
        s3[remote_file_path].public_url.to_s
      end
    end

    def upload(content)
      unless content.kind_of? Tempfile
        file = Tempfile.new(self.name)
        file.binmode
        file.write content
        file.close
      else
        file = content
      end

      s3 = S3.new
      
      unless mime_type =~ /image/
        s3.create self.path, file
        obj = s3[self.path('original')]
        self.url = obj.public_url.to_s
        return obj
      end

      Mediadrawer.config['sizes'].each do |size_name, size|
        remote_file_path = self.path(size_name)
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
