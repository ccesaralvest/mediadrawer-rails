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
        $('#mediadrawer .info-panel')
          .html(HandlebarsTemplates['panel'](@json))
        $('#mediadrawer #md-files').addClass('open-panel')
        false

    onClick: ->

    asJquery: ->
      $(@asHTML())

    asHTML: ->
      HandlebarsTemplates[@template_type](@json)

  class Mediadrawer.Image extends ContainerObj
    template_type: 'img'

    onClick: ->

  class Mediadrawer.File extends ContainerObj
    template_type: 'file'

  class Mediadrawer.Folder extends ContainerObj
    path: ->
      @json.path

    onClick: ->
      @container.mediadrawer.mediaContainer.load()

    template_type: 'folder'

  class Mediadrawer.RootFolder extends Mediadrawer.Folder
    constructor: (@container)->
      @json =
        path: '',
        name: 'Home'
      super(@json, @container)


