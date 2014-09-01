require 'aws-sdk'
AWS.config(region: 'sa-east-1', :http_wire_trace => true)
module Mediadrawer
  class S3
    
    def load_config
      @config = YAML.load_file("#{::Rails.root}/config/mediadrawer.yml")
    end
    
    def initialize
      load_config
      @s3 = ::AWS::S3.new
      @bucket = @s3.buckets[@config['bucket']]
      unless @bucket.exists?
        @bucket = @s3.buckets.create Mediadrawer.config.bucket, acl: :public_read
      end
    end

    def [](key)
      @bucket.objects[key]
    end

    def create(key, content)
      @bucket.objects.create key, content
    end

    def delete(key)
      file = self[key]
      file.delete
    end
  end
end