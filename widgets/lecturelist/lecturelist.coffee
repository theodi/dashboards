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
        $(@node).find(".progress span:last-child").removeClass('active')
        $(@node).find(".progress span:nth-child(#{@currentIndex})").removeClass('active')
        @currentIndex = (@currentIndex + 1) % items.length
        if @currentIndex == 0
          $(@node).find(".progress span:last-child").addClass('active')
        else
          $(@node).find(".progress span:nth-child(#{@currentIndex})").addClass('active')
        $(items[@currentIndex]).fadeIn()
        
    