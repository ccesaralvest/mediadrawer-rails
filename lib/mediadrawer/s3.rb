require 'aws-sdk'
AWS.config(region: ENV['S3_REGION'],
  :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
  :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'])
module Mediadrawer
  class S3
    def initialize
      @s3 = ::AWS::S3.new
      @bucket = @s3.buckets[ENV['S3_BUCKET']]
      unless @bucket.exists?
        @bucket = @s3.buckets.create ENV['S3_REGION']
      end
    end

    def [](key)
      @bucket.objects[key]
    end

    def create(key, file)
      if file.kind_of? Tempfile
        @bucket.objects[key].write file: file.path, :acl=>:public_read
      else
        @bucket.objects[key].write file, :acl=>:public_read
      end
    end

    def delete(key)
      file = self[key]
      file.delete
    end
  end
end
