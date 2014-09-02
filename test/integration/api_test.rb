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

    #test 'get all folders' do
    #  media1 = Media.create name: 'teste.txt'
    #  media2 = Media.create name: 'teste2.txt'

    #  get "/mediadrawer/api/media/#{media1.id}"
    #  assert_response :success
    #  assert response.body.include? 'teste.txt'
    #  assert response.body.include? "/media/#{media1.id}"

    #  get "/mediadrawer/api/media/#{media2.id}"
    #  assert_response :success
    #  assert response.body.include? "/media/#{media2.id}"
    #  assert response.body.include? 'teste2.txt'
      
    #end
  end
end