# make sure Yaffle's eventsource goes in first
#= require eventsource.js


# dashing.js is located in the dashing framework
# It includes jquery & batman for you.
#= require dashing.js

#= require_directory .
#= require_tree ../../widgets

if window.console
  console.log("Yeah! The dashboard has started!")

convertCurrency = (currency, value) ->
  # Assume currency is "GBP" for now
  if Dashing.currentCurrency == "EUR"
    value * 1.39986
  else if Dashing.currentCurrency == "USD"
    value * 1.55911
  else if Dashing.currentCurrency == "JPY"
    value * 187.274
  else if Dashing.currentCurrency == "KRW"
    value * 1710.25
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
    when "JPY"
      "¥"
    when "KRW"
      "₩"

Dashing.on 'ready', ->
  Dashing.currentCurrency ||= "GBP"

  $(window).bind 'resize', (event) =>
    Dashing.resize()

  Dashing.resize()

Dashing.resize = () ->
  grid_height = window.innerHeight - $('#company-header').height()
  $('ul.grid').height(grid_height)

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

Dashing.setCurrency = (currency) ->
  Dashing.currentCurrency = currency
  Dashing.refreshAllWidgets()

Dashing.refreshAllWidgets = () ->
  keys = Object.keys(Dashing.widgets)
  for key in keys
    Dashing.widgets[key][0]._rendered = false
    Dashing.widgets[key][0].render()
