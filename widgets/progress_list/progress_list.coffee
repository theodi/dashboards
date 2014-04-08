class Dashing.ProgressList extends Dashing.Widget
  ready: ->
    @currentIndex = 1
    @list = new List("#{@get('node').id}",
       valueNames: ["label"]
       page: 10
       plugins: [ListPagination({ innerWindow: 10 })]
    )

    @pages = Math.round(@list.items.length / 10)

    autopaginator = setInterval(@nextPage, 5000)

    $('.pagination a').attr('href', '')

    $('.pagination a').click (event) ->
      event.preventDefault()
      console.log(autopaginator)
      clearInterval(autopaginator)

  nextPage: =>
    if (@currentIndex == @pages)
      @currentIndex = 0
    @list.show((@currentIndex * 10) + 1, 10)
    @currentIndex = @currentIndex + 1
