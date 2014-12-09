class @Mediadrawer
  constructor: (@path='/mediadrawer/api')->
    if window.mediadrawer instanceof Mediadrawer
      return window.mediadrawer
    else
      @mediaContainer = new Mediadrawer.MediaContainer($('[data-image-container] ul'), this)
      @foldersContainer = new Mediadrawer.FoldersContainer($('[data-folder-menu] ul'), this)
  load: ->
    if !this.loaded
      this.loaded=true
      $.get @path, (data)=>
        $data = $('<div>'+data+'</div>')
        if $('#mediadrawer').length > 0
          $('#mediadrawer').remove()

        $('body').append $data
        $('#mediadrawer').modal()
        $("#mediadrawer").on "hidden.bs.modal", (e) ->
          window.mediadrawer.loaded=false
          return
        @bindEvents $('#mediadrawer')
        @foldersContainer.load()
        @mediaContainer.load()

  close: ->
    this.loaded=false
    $('#mediadrawer').modal('hide')

  fileSelected: (file)->
    console.log(file)

  bindEvents: ($data) ->
    mediadrawer = this
    $data.on 'click', '[data-add-folder]', =>
      @foldersContainer.addFolder()

    $data.on 'click', '[data-mediadrawer-select]', =>
      @fileSelected this.mediaContainer.getActive()
      @close()

    $data.find('#md-files > .container').bind 'scroll', ->
      unless mediadrawer.mediaContainer.locked
        if ($(this).scrollTop() + $(this).innerHeight()) >= this.scrollHeight
          mediadrawer.mediaContainer.nextPage()
          mediadrawer.mediaContainer.load(false)

    $data.on 'click', '[filter]', ->
      mediadrawer.mediaContainer.load(true, {type: $(this).attr('filter')})

    $data.on 'click', '[data-async-submit]', ->
      $form = $(this).closest('form')
      progressFn = Hooks[$(this).data('progress-fn')]
      unless progressFn
        progressFn = ->

      successFn = Hooks[$(this).data('success-fn')]
      unless successFn
        successFn = ->

      formData = new FormData($form[0])
      formData.append 'path', mediadrawer.foldersContainer.getActive().path()
      if(!$form.find('[type=file]').val() && !validateURI($form.find('[type=url]').val()))
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
          mediadrawer.mediaContainer.load()
          successFn()
        data: formData
        cache: false
        contentType: false
        processData: false
      false
