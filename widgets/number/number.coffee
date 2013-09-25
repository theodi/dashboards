class Dashing.Number extends Dashing.Widget
  @accessor 'current', Dashing.AnimatedValue

  @accessor 'difference', ->
    if @get('last')
      last = parseInt(@get('last'))
      current = parseInt(@get('current'))
      if last != 0
        diff = Math.abs(Math.round((current - last) / last * 100))
        if diff > 0
          "#{diff}%"
        else
          ""
    else
      ""

  @accessor 'arrow', ->
    if @get('last')
      if parseInt(@get('current')) == parseInt(@get('last')) 
        ''
      else if parseInt(@get('current')) > parseInt(@get('last')) 
        'icon-arrow-up'
      else
        'icon-arrow-down'
    else
      $(@node).find(".change-rate").addClass('hidden')

  onData: (data) ->
    if data.status
      # clear existing "status-*" classes
      $(@get('node')).attr 'class', (i,c) ->
        c.replace /\bstatus-\S+/g, ''
      # add new class
      $(@get('node')).addClass "status-#{data.status}"
