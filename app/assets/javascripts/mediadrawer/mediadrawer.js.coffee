class @Mediadrawer
  load = ->
    $.get '/mediadrawer', (data)->
      $('body').append data
      MediaContainer.setSelector '[data-image-container] ul'
      FoldersContainer.setSelector '[data-folder-menu] ul'
      MediaContainer.load()
      FoldersContainer.load()
      $('[data-mediadrawer-select]').click ->
        Mediadrawer.fileSelected(MediaContainer.getActive())

  fileSelected = (file)->