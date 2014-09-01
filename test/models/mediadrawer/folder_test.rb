require 'test_helper'

module Mediadrawer
  class FolderTest < ActiveSupport::TestCase
    # test "the truth" do
    #   assert true
    # end
  
    test "should create root_path if not exists" do
      folder = Folder.root
      assert folder.name == 'root_path'
    end

    test "should auto set root_path for new folders" do
      root = Folder.root
      new_folder = Folder.new
      assert new_folder.parent == root
    end
  end
end
