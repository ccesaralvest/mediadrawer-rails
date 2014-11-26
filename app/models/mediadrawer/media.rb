module Mediadrawer
  class Media < ActiveRecord::Base
    include Magick
    belongs_to :folder, touch: true
    after_initialize :set_defaults

    after_destroy :delete_file

    def delete_file
      s3 = S3.new
      unless is_image?
        s3.delete path
      else
        Mediadrawer.config['sizes'].each do |size_name, size|
          s3.delete self.path(size_name)
        end
      end
    end

    def type
      unless is_image?
        'file'
      else
        'image'
      end
    end

    def is_image?
      mime_type =~ /image/
    end

    def set_defaults
      self.folder ||= Folder.root
    end

    def name=(v)
      v = v.to_s
      extension = v.split('.').last
      name = v.split('.')[0...-1].join '.'
      write_attribute :name, "#{name.parameterize}.#{extension}"
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
      ::Rails.cache.fetch "#{self.id}:#{self.updated_at}:#{size}" do
        s3 = S3.new
        unless mime_type =~ /image/
          s3[path('original')].public_url.to_s
        else
          remote_file_path = self.path(size)
          s3[remote_file_path].public_url.to_s
        end
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
        s3.create self.path('original'), file
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
            img.resize_to_fill!(size[0].to_i, size[1].to_i)
            img.write file.path
          end
          s3.create remote_file_path, file
        end
      end
    end
  end
end
