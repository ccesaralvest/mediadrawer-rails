  class ContainerObj
    constructor: (@json, @container)->
      @node = @asJquery()
      @bindEvents()

    getNode: ->
      @node

    bindEvents: ->
      $(@node).click =>
        @container.setActive(this)
        @onClick()

    onClick: ->


  class Mediadrawer.Image extends ContainerObj
    asJquery: ->
      $("<li><img src='#{@json.thumbnail}' alt='#{@json.alt}' /></li>")


  class Mediadrawer.File extends ContainerObj
    asJquery: ->
       $("<li><img src='' alt='#{@json.alt}' /></li>")


  class Mediadrawer.Folder extends ContainerObj
    path: ->
      @json.path

    onClick: ->
      @container.mediadrawer.mediaContainer.load()

    asJquery: ->
        $("<li><a href='#'>#{@json.name}</a></li>")


  class Mediadrawer.RootFolder extends Mediadrawer.Folder
    constructor: (@container)->
      @json =
        path: '',
        name: 'Home'
      super(@json, @container)


