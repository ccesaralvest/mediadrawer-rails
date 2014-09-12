  class ContainerObj
    constructor: (@json, @container)->
      @node = @asJquery()
      @bindEvents()

    id: ->
      @json.id

    getNode: ->
      @node

    bindEvents: ->
      $(@node).click =>
        @container.setActive(this)
        @onClick()
        false

    onClick: ->


  class Mediadrawer.Image extends ContainerObj
    asJquery: ->
      $("<li class='col-xs-3'><img class='img-responsive img-thumbnail' src='#{@json.thumbnail}' alt='#{@json.alt}' /></li>")


  class Mediadrawer.File extends ContainerObj
    asJquery: ->
       $("<li><img src='' alt='#{@json.alt}' /></li>")


  class Mediadrawer.Folder extends ContainerObj
    path: ->
      @json.path

    onClick: ->
      @container.mediadrawer.mediaContainer.load()

    asJquery: ->
        $("<li><i class='fa fa-folder-o'><a href='#'>#{@json.name}</a></i></li>")


  class Mediadrawer.RootFolder extends Mediadrawer.Folder
    constructor: (@container)->
      @json =
        path: '',
        name: 'Home'
      super(@json, @container)


