# dashing.js is located in the dashing framework
# It includes jquery & batman for you.
#= require dashing.js

#= require_directory .
#= require_tree ../../widgets

console.log("Yeah! The dashboard has started!")

convertCurrency = (currency, value) ->
  # Assume currency is "GBP" for now
  if Dashing.currentCurrency == "EUR"
    value * 1.21365
  else if Dashing.currentCurrency == "USD"
    value * 1.67459
  else
    value

currencySymbol = (currency) ->
  switch(currency)
    when "GBP"
      "£"
    when "EUR"
      "€"
    when "USD"
      "$"

Dashing.on 'ready', ->
  Dashing.widget_margins ||= [5, 5]
  Dashing.widget_base_dimensions ||= [300, 360]
  Dashing.numColumns ||= 4
  Dashing.currentCurrency ||= "GBP"

  contentWidth = (Dashing.widget_base_dimensions[0] + Dashing.widget_margins[0] * 2) * Dashing.numColumns

  Batman.setImmediate ->
    $('.gridster').width(contentWidth)
    $('.gridster ul:first').gridster
      widget_margins: Dashing.widget_margins
      widget_base_dimensions: Dashing.widget_base_dimensions
      avoid_overlapped_widgets: !Dashing.customGridsterLayout
      draggable:
        stop: Dashing.showGridsterInstructions
        start: -> Dashing.currentWidgetPositions = Dashing.getWidgetPositions()


  # Let's replace shortenedNumber
  # Dashing's version has bad negative number handling
  # and shoves the prefix in front of the minus sign
  Batman.Filters.numberWithCurrency = (num, currency) ->
    return num if isNaN(num)
    if currency
      num = convertCurrency(currency, num)
    num = num.toPrecision(3)
    negative = num < 0.0
    num = Math.abs(num)
    if num >= 1000000000
      num = (num / 1000000000) + 'B'
    else if num >= 1000000
      num = (num / 1000000) + 'M'
    else if num >= 1000
      num = (num / 1000) + 'K'
    if negative
      str = "-"
    else
      str = ""
    if currency
      str += currencySymbol Dashing.currentCurrency
    str += num
    str

Dashing.setSize = (rows, cols) ->
  Dashing.widget_margins = [5, 5]
  Dashing.numColumns = cols
  total_width = 1280 - (Dashing.widget_margins[0] * 2 * Dashing.numColumns)
  total_height = 720.0 - 86.0 #header height
  Dashing.widget_base_dimensions ||= [total_width/cols, total_height/rows]

Dashing.setCurrency = (currency) ->
  Dashing.currentCurrency = currency
  Dashing.refreshAllWidgets()

Dashing.refreshAllWidgets = () ->
  keys = Object.keys(Dashing.widgets)
  for key in keys
    Dashing.widgets[key][0]._rendered = false
    Dashing.widgets[key][0].render()
