class @FoldersContainer
  @clear: ->
    $(@selector).empty()

  @setSelector: (selector)->
    @selector = selector

  @appendFolder: (json) ->
    folder = new FoldersContainer.folder(json)
    $(@selector).append folder.toHTML()

  @append: (cls) ->
    $(@selector).append cls.toHTML()

  @setActive: (folder) ->
    @active = folder

  @getActive: ->
    @active

  @load: ->
    $.get "mediadrawer/api/folders", (folders)->
      FoldersContainer.clear()

      FoldersContainer.append(new FoldersContainer.rootFolder())
      for folder in folders
        FoldersContainer.appendFolder folder

  class @folder
    constructor: (@json)->
      @element = this.toHTML()
      this.bindEvents()

    bindEvents: ->
      $(@element).click =>
        FoldersContainer.setActive this
        MediaContainer.load()

    path: ->
      @json.path

    toHTML: ->
      if @element
        @element
      else
        $("<li><a href='#'>#{@json.name}</a></li>")

  class @rootFolder extends @folder
    constructor: ->
      @json =
        path: '',
        name: 'Home'
      super(@json)

    toHTML: ->
      if @element
        @element
      else
        $("<li><a href='#'><strong>#{@json.name}</strong></a></li>")
root = new FoldersContainer.rootFolder()
FoldersContainer.append root
FoldersContainer.setActive root
      