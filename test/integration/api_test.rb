require 'test_helper'
 
module Mediadrawer
  class APITest < ActionDispatch::IntegrationTest
    test 'get all media' do
      media1 = Media.create name: 'teste.txt'
      Media.create name: 'teste2.txt'
      get '/media'
      assert_response :success
      assert response.body.include? '['
      assert response.body.include? 'teste.txt'
      assert response.body.include? 'teste2.txt'
      assert response.body.include? "/media/#{media1.id}"
    end
  end
end