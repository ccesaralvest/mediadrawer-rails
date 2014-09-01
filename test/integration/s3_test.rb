require 'test_helper'

module Mediadrawer
  class S3Test < ActiveSupport::TestCase
    test "can connect to s3" do
      assert Mediadrawer::S3.new
    end

    test "can upload a file" do
      s3 = Mediadrawer::S3.new
      s3.create 'file.txt', 'teste'
      obj = s3['file.txt']
      assert obj.read == 'teste'
    end

    test "can get a file" do
      s3 = Mediadrawer::S3.new
      s3.create 'file.txt', 'teste'
      obj = s3['file.txt']
      assert obj.read == 'teste'
    end

    test "can delete a file" do
      s3 = Mediadrawer::S3.new
      s3.delete 'file.txt'
      obj = s3['file.txt']
      assert !obj.exists?
    end
  end
end
