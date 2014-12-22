class Dashing.Travis extends Dashing.Widget

  ready: ->

  onData: (data) ->
    @data = data
    console.log data

  @accessor 'buildStatus', ->
    "build-#{@data.state}ed"
