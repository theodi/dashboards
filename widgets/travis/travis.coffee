class Dashing.Travis extends Dashing.Widget

  ready: ->

  onData: (data) ->
    if data.failboat.length == 0
      @set 'failboatempty', true
