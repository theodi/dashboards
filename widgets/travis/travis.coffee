class Dashing.Travis extends Dashing.Widget

  ready: ->

  onData: (data) ->
    @data = data

  @accessor 'buildStatus', ->
    "build-#{@data.state}ed"
