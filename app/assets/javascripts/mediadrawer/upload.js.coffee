$(document).on 'click', '[data-async-submit]', ->
  $form = $(this).closest('form')
  progressFn = Hooks[$(this).data('progress-fn')]
  unless progressFn
    progressFn = ->

  successFn = Hooks[$(this).data('success-fn')]
  unless successFn
    successFn = ->

  formData = new FormData($form[0])
  formData.append 'path', FoldersContainer.getActive().path()
  if(!$form.find('[type=file]').val() && !validateURI($form.find('[type=text]').val()))
    alert 'URL Inválida'
    return false
  $.ajax
    url: $form.attr('action'),
    type: 'POST',
    xhr: =>
      xhr = $.ajaxSettings.xhr()
      if xhr.upload
        xhr.upload.addEventListener 'progress', progressFn, false
      xhr
    success: ->
      $form[0].reset()
      successFn()
    data: formData
    cache: false
    contentType: false
    processData: false
  false


