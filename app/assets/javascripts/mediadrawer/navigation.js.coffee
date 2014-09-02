$ ->
  $('.directory').click ->
    id = $(this).attr('data-id')
    $.get "/mediadrawer/folders/#{id}", (files) ->
      $('.content').empty()
      for file in files
        $('.content').append "<img src='#{file.url}'/>"
