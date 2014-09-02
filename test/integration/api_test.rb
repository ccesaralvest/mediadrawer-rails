require 'test_helper'
 
module Mediadrawer
  class APITest < ActionDispatch::IntegrationTest
    test 'get all media' do
      media1 = Media.create name: 'teste.txt'
      Media.create name: 'teste2.txt'

      folder1 = Folder.create name: 'folder1'
      media3 = Media.create name: 'teste3.txt', folder: folder1

      get '/mediadrawer/api/media'
      assert_response :success
      assert response.body.include? '['
      assert response.body.include? 'teste.txt'
      assert response.body.include? 'teste2.txt'
      assert response.body.include? "/media/#{media1.id}"

      get '/mediadrawer/api/media?path=/folder1'
      assert_response :success
      assert response.body.include? 'teste3.txt'
      assert response.body.include? "/media/#{media3.id}"
    end

    test 'get one media' do
      media1 = Media.create name: 'teste.txt'
      media2 = Media.create name: 'teste2.txt'

      get "/mediadrawer/api/media/#{media1.id}"
      assert_response :success
      assert response.body.include? 'teste.txt'

      get "/mediadrawer/api/media/#{media2.id}"
      assert_response :success
      assert response.body.include? 'teste2.txt'
    end

    test 'get all folders' do
      folder1 = Folder.create name: 'folder1'
      Folder.create name: 'folder2'
      Folder.create name: 'subfolder1', parent: folder1

      get '/mediadrawer/api/folders'
      assert_response :success
      assert response.body.include? 'folder1'
      assert response.body.include? 'folder2'
      assert response.body.include? '[]'
      assert !(response.body.include? 'subfolder1')

      get '/mediadrawer/api/folders?recursive=1'
      assert_response :success
      assert response.body.include? 'folder1'
      assert response.body.include? 'folder2'
      assert response.body.include? 'subfolder1'

      get '/mediadrawer/api/folders?path=/'
      assert_response :success
      assert response.body.include? 'folder1'
      assert response.body.include? 'folder2'
      assert !(response.body.include? 'subfolder1')

      get '/mediadrawer/api/folders?path=/folder1'
      assert_response :success
      assert !(response.body.include? '"folder1"')
      assert !(response.body.include? 'folder2')
      assert response.body.include? 'subfolder1'
    end
  end
end