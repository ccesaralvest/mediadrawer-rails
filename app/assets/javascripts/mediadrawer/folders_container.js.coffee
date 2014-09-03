class Mediadrawer.FoldersContainer extends Mediadrawer.Container
  @resourcePath: 'folders'

  constructor: (@$container, @mediadrawer)->
    super(@$container, @mediadrawer)
    @root = new Mediadrawer.RootFolder(this)
    @setActive(@root)
  
  addFolder: ->
    folder_name = prompt 'Nome da pasta'
    if !folder_name
      return
    url = "#{@mediadrawer.path}/#{@constructor.resourcePath}"
    $.post url, name: folder_name, (json)=>
      @append @constructor.obj(json, @)

  @obj: (json, container)->
    new Mediadrawer.Folder(json, container)

  beforeLoad: ->
    @append @root
    @setActive(@root)

  endAppend: ->

      