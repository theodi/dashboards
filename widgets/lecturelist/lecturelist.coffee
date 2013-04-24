class Dashing.Lecturelist extends Dashing.Widget
  
  ready: ->

  onData: (data) ->
    i = 0
    node = $(@get('node'))
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
    