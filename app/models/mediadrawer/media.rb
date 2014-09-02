module Mediadrawer
  class Media < ActiveRecord::Base
    belongs_to :folder
    after_initialize :set_defaults

    def set_defaults
      self.folder ||= Folder.root
    end

    def upload(content='')
      mime_type = FileMagic.new(FileMagic::MAGIC_MIME).buffer(content).to_s
      self.mime_type = mime_type
      s3 = S3.new
      s3.create name, content
      obj = s3[name]
      if obj.exists?
        self.url = obj.public_url.to_s
        obj
      else
        false
      end
    end
  end
end
