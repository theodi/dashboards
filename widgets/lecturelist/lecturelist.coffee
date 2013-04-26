class Dashing.Lecturelist extends Dashing.Widget
  
  ready: ->
    @currentIndex = 0
    @items = $(@node).find('li')
    @items.hide()
    @nextItem()
    @startCarousel()

  onData: (data) ->
    @currentIndex = 0
    i = 0
    if data.items.length == 0
      @set 'empty', true
  
  startCarousel: ->
    setInterval(@nextItem, 10000)
  
  nextItem: =>
    items = @get('items')
    if items
      $(items[@currentIndex]).fadeOut =>
        @currentIndex = (@currentIndex + 1) % items.length
        $(items[@currentIndex]).fadeIn()
    