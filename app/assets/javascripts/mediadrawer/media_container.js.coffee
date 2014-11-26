class Mediadrawer.MediaContainer extends Mediadrawer.Container
  @resourcePath: 'media'

  @obj: (json, container)->
    if /image/.exec(json.mime_type)
      new Mediadrawer.Image(json, container)
    else
      new Mediadrawer.File(json, container)

  afterLoad: (objs)->
    super
    if objs.length == 0
      @page = null

  page: 1

  load: (clear=true)->
    if clear
      @page = 1
    if @page != null
      super

  nextPage: ->
    if @page
      @page += 1

  loadParams: (params={})->
    newParams = { path: @mediadrawer.foldersContainer.getActive().path(), page: @page }
    for k of newParams
      params[k] = newParams[k]
    params
