
$(document).ready () ->
 
 window.ws = new WebSocket "ws://bomber.the.tl:9998/"
 ws.onopen = () ->
   console.log "open"
   ws.send "hahaha"
 ws.onmessage = (e) ->
   console.log "data is", e.data
   data = JSON.parse e.data
   console.log data
   app[data[0]] data[1] 
 ws.onclose = (e) ->
   console.log "closed!!"
 ws.onerror = (e) ->
    console.log "error"

window.app = {}
app.addField = () ->
  app.field = document.createElement "div"
  $(app.field).css
    height: "320px"
    width: "320px"
  $(app.field).attr "id", "field"
  $('#wrapper').append app.field



app.log = (str) ->
  console.log str
app.tileWidth = 32
app.tileHeight = 32
app.renderScreen = (tiles) ->
  app.addField()
  console.log "rendering screen"
  x = 0
  y = 0
  if _.isString tiles
    tiles = tiles.split "\n"
  
  for row in tiles
    if _.isString row
      row = row.split ""
    for cell in row
      if _.isString cell
        str = cell
        cell = {}
        if str is "-"
          cell.color = "green"
        else if str is "o"
          cell.color = "#aaaaaa"

      tile = document.createElement "div"
      if "color" of cell
        $(tile).css "background-color" : cell.color
      $(tile).attr("data-pos", "#{x},#{y}").css
        position : "absolute"
        left: app.tileWidth * x + "px"
        top: app.tileHeight * y + "px"
        width: app.tileWidth + "px"
        height: app.tileHeight + "px"
      $('#field').append tile
      x++
    x = 0
    y++

