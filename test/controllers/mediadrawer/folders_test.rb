require 'test_helper'

module Mediadrawer
  class FoldersControllerTest < ActionController::TestCase
    test 'request a folder succesfully' do
      folder = Folder.new
      medias = [ Media.new(id: 1), Media.new(id: 2) ]
      Folder.expects(:find).with(1).returns(folder)
      folder.expects(:media_files).returns(medias)

      get :show, id: 1, use_route: :mediadrawer, format: :json

      assert_response(200)
      ids = JSON.parse(response.body).map { |file| file["id"] }
      assert_equal([1, 2], ids)
    end
  end
end
