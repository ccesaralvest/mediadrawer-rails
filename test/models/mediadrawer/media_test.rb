require 'test_helper'

module Mediadrawer
  class MediaTest < ActiveSupport::TestCase
    # test "the truth" do
    #   assert true
    # end

    test "set default path" do
      media = Media.new
      assert media.folder.name == 'root_path'
    end

    test "upload" do
      media = Media.new name: "teste-upload.txt"
      assert media.upload("teste-upload") != false
    end

    test "url assign" do
      media = Media.new name: "teste-upload.txt"
      media.upload "teste-upload"

      assert(/teste-upload/.match media.url)
    end

    test "mime type" do
      media = Media.new name: "teste-upload.txt"
      media.upload "teste-upload"

      assert(/text/.match media.mime_type)
    end
  end
end
