class Dashing.Image extends Dashing.Widget

  ready: ->
    set_background_image(@node, @image)

  onData: (data) ->
    set_background_image(@node, @image)
    
  set_background_image = (node, image) ->
    node.children[0].style.backgroundImage = "url(#{image})"