class @Hooks
  @uploadProgress = (event) ->
    $('progress').show()
    if event.lengthComputable
      $('progress').attr 'max', event.total
      $('progress').attr 'value', event.loaded

  @uploadSuccess = ->
    $('progress').hide()
    $('[href="#md-files"]').tab('show')
