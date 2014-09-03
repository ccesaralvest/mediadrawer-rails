class Mediadrawer.MediaContainer extends Mediadrawer.Container
  @resourcePath: 'media'

  @obj: (json, container)->
    if /image/.exec(json.mime_type)
      new Mediadrawer.Image(json, container)
    else
      new Mediadrawer.File(json, container)

  loadParams: ->
    { path: @mediadrawer.foldersContainer.getActive().path() }