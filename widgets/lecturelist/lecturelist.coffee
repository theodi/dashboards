class Dashing.Lecturelist extends Dashing.Widget
  
  ready: ->
    @currentIndex = 0
    @items = $(@node).find('li')
    @nextItem()
    @startCarousel()

  onData: (data) ->
    @currentIndex = 0
    i = 0
    if data.items.length == 0
      @set 'empty', true
    while i < data.items.length
      capacity = data.items[i].capacity
      tickets = data.items[i].tickets
      people = ""
      x = capacity - tickets
      while x--
        people += "<span class='icon-user'></span>"
      while tickets--
        people += "<span class='icon-user available'></span>"
      data.items[i].people = people
      
      i++
  
  startCarousel: ->
    @items.hide()
    setInterval(@nextItem, 10000)
  
  nextItem: =>
    items = @get('items')
    if items
      console.log(items[@currentIndex])
      $(items[@currentIndex]).fadeOut =>
        @currentIndex = (@currentIndex + 1) % items.length
        $(items[@currentIndex]).fadeIn()
    