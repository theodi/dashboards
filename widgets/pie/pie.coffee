class Dashing.Pie extends Dashing.Widget
  @accessor 'value'

  onData: (data) ->
    $(@node).fadeOut().fadeIn()
    @render(data.value)

  render: (data) ->
    if !data
      data = @get("value")
    if !data
       return
    #console.log "FullPie new"
# this is a fix because data binding seems otherwise not work


    $(@node).children(".title").text($(@node).attr("data-title"))
    $(@node).children(".more-info").text($(@node).attr("data-moreinfo"))
    $(@node).children(".updated-at").text(@get('updatedAtMessage'))

    width = 260 #width
    height = 260 #height
    radius = 130 #radius

    colours =  @get("colours") || ['#D60303','#ff6700','#F9BC26','#67EF67','#0DBC37','#1dd3a7','#2254f4','#ef3aab','#b13198']

    $(@node).children("svg").remove();

    vis = d3.select(@node).append("svg:svg")
      .data([data])
        .attr("width", width)
        .attr("height", height)
      .append("svg:g")
        .attr("transform", "translate(" + radius + "," + radius + ")")

    arc = d3.svg.arc().outerRadius(radius)
    pie = d3.layout.pie().value((d) -> d.value)

    arcs = vis.selectAll("g.slice")
      .data(pie)
      .enter().append("svg:g").attr("class", "slice")

    arcs.append("svg:path").attr("fill", (d, i) -> colours[i])
      .attr("d", arc)

    sum=0
    for val in data
      sum += val.value

    legend = d3.select(@node).append("svg:svg")
      .attr("height", 180)
      .attr("width", width)
      .attr("x", 0)
      .append("g")
      .attr("class", "legend")
      .attr("x", 0)
      .attr("y", height + 30)

    legend.selectAll('g')
      .data(data)
      .enter()
      .append('g')
      .each((d,i) ->
        g = d3.select(this);
        g.append("rect")
          .attr("x", 0)
          .attr("y", 17 + (i * 22))
          .attr("width", 12)
          .attr("height", 12)
          .attr("fill", colours[i] )

        g.append("text")
          .attr("x", 24)
          .attr("y", 29 + (i * 22))
          .attr("width", 130)
          .attr("fill", '#fff')
          .attr("font-size", "15px")
          .text((d, i) -> d.label + " - " + Math.round(d.value/sum * 100) + '%')
      )


    # arcs.append("svg:text").attr("transform", (d, i) ->
    #   procent_val = Math.round(data[i].value/sum * 100)
    #   d.innerRadius = (radius * (100-procent_val)/100) - 45  #45=max text size/2
    #   d.outerRadius = radius
    #   "translate(" + arc.centroid(d) + ")")
    #   .attr('fill', "#fff")
    #   #.attr("text-anchor", "middle").text((d, i) -> data[i].label if data[i].value > 0)
    #   .append('svg:tspan')
    #   .attr('x', 0)
    #   .attr('dy', 15)
    #   .attr('font-size', '70%')
    #   .text((d,i) -> Math.round(data[i].value/sum * 100) + '%' if data[i].value > 0)
