class Mediadrawer.Container
  @obj: (json)->
    console.error('Not implemented @obj')

  constructor: (@$container, @mediadrawer) ->
    @objs = []

  append: (obj) ->
    @$container.append obj.getNode()
    @objs.push obj

  setActive: (obj) ->
    @active = obj
    @$container.find('.active').removeClass('active')
    obj.getNode().addClass('active')

  getActive: ->
    @active

  clear: ->
    @$container.empty()
    @objs.forEach (obj)->
      obj.getNode().remove()
    @objs = []

  endAppend: ->
    if @objs.length == 0
      @$container.append('<em>Nenhum arquivo encontrado</em>')

  loadParams: ->
    {}

  beforeLoad: ->

  load: ->
    @$container = $(@$container.selector)
    $.get "#{@mediadrawer.path}/#{@constructor.resourcePath}", @loadParams(), (objs)=>
      @clear()
      @beforeLoad()
      for obj in objs
        obj = new @constructor.obj(obj, this)
        @append(obj)
      @endAppend()