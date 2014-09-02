class @MediaContainer
  @clear: ->
    $(@selector).empty()

  @setSelector: (selector)->
    @selector = selector

  @appendMedia: (json) ->
    if /image/.exec(json.mime_type)
      file = new MediaContainer.image(json)
    else
      file = new MediaContainer.file(json)
    
    $(@selector).append file.toHTML()

  @endAppend: ->
    if $(@selector).children().length == 0
      $(@selector).append('<em>Nenhum arquivo encontrado</em>')

  @load: ->
    $.get "/mediadrawer/api/media", path: FoldersContainer.getActive().path(), (files) ->
      MediaContainer.clear()
      for file in files
        MediaContainer.appendMedia file
      MediaContainer.endAppend()

  @setActive: (file) ->
    @active = file

  @getActive: ->
    @active

  class @image
    constructor: (@json)->
      @element = this.toHTML()
      this.bindEvents()
    bindEvents: ->
      $(@element).click =>
        MediaContainer.setActive(this)
        #Sidebar.open(this)

    toHTML: ->
      if @element
        @element
      else
        $("<li><img src='#{@json.thumbnail}' alt='#{@json.alt}' /></li>")

  class @file
    constructor: (@json)->
      @element = this.toHTML()
      this.bindEvents()

    bindEvents: ->
      $(@element).click =>
        MediaContainer.setActive(this)

    toHTML: ->
      if @element
        @element
      else
       $("<li><img src='' alt='#{@json.alt}' /></li>")

      