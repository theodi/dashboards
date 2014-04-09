class Dashing.NumberWithTarget extends Dashing.Widget
  @accessor 'current', Dashing.AnimatedValue
  @accessor 'annual_target', Dashing.AnimatedValue
  @accessor 'ytd_target', Dashing.AnimatedValue

  @accessor 'ytd_percent', ->
    ytd = parseInt(@get('ytd_target'))
    annual = parseInt(@get('annual_target'))
    diff = ytd / annual * 100
    if diff < 100
      "width: #{diff}%"
    else
      "width: 100%"

  @accessor 'value_percent', ->
    current = parseInt(@get('current'))
    annual = parseInt(@get('annual_target'))
    diff = current / annual * 100
    if diff < 100
      "width: #{diff}%"
    else
      "width: 100%"

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
