class Dashing.Linklist extends Dashing.Widget
  
  ready: ->
  
  onData: (data) ->
    if data.items.length == 0
      @set 'empty', true