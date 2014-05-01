class Dashing.Travis extends Dashing.Widget

  ready: ->

  @accessor 'buildStatus', ->
    if @failboatempty == true
      "build-passed"
    else
      "build-failed"

  onData: (data) ->
    if data.failboat.length == 0
      @set 'failboatempty', true
