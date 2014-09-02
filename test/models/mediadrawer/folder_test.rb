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
      new_folder = Folder.new
      assert new_folder.parent.name == 'root_path'

      root = Folder.root
      new_folder = Folder.new
      assert new_folder.parent == root
    end

    test "parameterize name" do
      folder = Folder.new name: 'Nome da pasta'
      assert folder.name == 'Nome da pasta'.parameterize
    end

    test "discover path" do
      folder1 = Folder.create name: 'folder1'
      folder2 = Folder.create name: 'folder2'
      subfolder1 = Folder.create name: 'subfolder1', parent: folder1
      root = Folder.root

      assert(root == Folder.discover('/'), 'Couldnt discover root path')
      assert(folder1 == Folder.discover('/folder1'), 'Couldnt discover folder1 path')
      assert(folder2 == Folder.discover('/folder2'), 'Couldnt discover folder2 path')
      assert(subfolder1 == Folder.discover('/folder1/subfolder1'), 'Couldnt discover subfolder1 path')
    end

    test "folder path" do
      folder1 = Folder.create name: 'folder1'
      subfolder1 = Folder.create name: 'subfolder1', parent: folder1
      assert Folder.root.path == '', "Returning: #{Folder.root.path}, expected: ''"
      assert folder1.path == 'folder1', "Returning: #{folder1.path}, expected: folder1"
      assert subfolder1.path == 'folder1/subfolder1', "Returning: #{subfolder1.path}, expected: folder1/subfolder1"
    end

    test "folder media" do
      folder1 = Folder.create name: 'folder1'
      media1 = Media.new name: "teste1.txt"
      media2 = Media.new name: "teste2.txt", folder: folder1

      media1.upload('teste1')
      media1.save

      media2.upload('teste2')
      media2.save

      assert Folder.root.media_files.first == media1
      assert folder1.media_files.first == media2
    end
  end
end
