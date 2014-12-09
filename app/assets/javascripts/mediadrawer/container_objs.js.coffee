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

    asJquery: ->
      $(@asHTML())

    asHTML: ->
      HandlebarsTemplates[@template_type](@json)


  class Mediadrawer.Image extends ContainerObj
    template_type: 'img'

    onClick: ->
      $panel = $(HandlebarsTemplates['panel'](@json))
      $panel.on 'change', '.alt', (e)=>
        $.ajax
          url: @json.resource_url,
          data: { alt: $(e.target).val() },
          method: 'PATCH'
      $('#mediadrawer .info-panel')
        .html($panel)
      $('#mediadrawer #md-files').addClass('open-panel')


  class Mediadrawer.File extends ContainerObj
    template_type: 'file'

    onClick: ->
      $panel = $(HandlebarsTemplates['panel'](@json))
      $('#mediadrawer .info-panel')
        .html($panel)
      $('#mediadrawer #md-files').addClass('open-panel')


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


