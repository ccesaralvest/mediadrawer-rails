$('[data-async-submit]').click ->
  $form = $(this).closest('form')
  progressFn = window[$(this).data('progress-fn')]
  unless progressFn
    progressFn = ->

  successFn = window[$(this).data('success-fn')]
  unless successFn
    successFn = ->

  formData = new FormData($form[0])
  $.ajax
    url: $form.attr('action'),
    type: 'POST',
    xhr: =>
      xhr = $.ajaxSettings.xhr()
      if xhr.upload
        xhr.upload.addEventListener 'progress', progressFn, false
      xhr
    success: successFn
    data: formData
    cache: false
    contentType: false
    processData: false