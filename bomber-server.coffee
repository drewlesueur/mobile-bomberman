screen = """
----------
-o-o-o-o--
----------
-o-o-o-o--
----------
-o-o-o-o--
----------
-o-o-o-o--
----------
-o-o-o-o--
----------
"""

users = []
removeByCid = (cid) ->
  for stream, index in users
    
    if (not stream) or (stream.__cid == cid)
      users.splice index, 1

ws = require("simple-websocket")
server = ws.createServer
  port: 9998
  hostname : "bomber.the.tl"
server.on "wsConnection", (stream) ->
  users.push stream
  stream.__cid = _.uniqueId()
  stream.x = 0
  stream.y = 0
  ws.write stream, JSON.stringify  ["renderScreen", screen]
  stream.on "wsMessage", (message) ->
    console.log "the message is " + message
    data = JSON.parse message
    console.log "the first part is" + data[0]
    if data[0] of handle
      handle[data[0]] stream, data[1]
    #ws.write stream, message + "say what"
server.listen ws.options.port


handle = {}
handle.repos = (stream, info) ->
  console.log "got here"
  stream.oldx = stream.x
  stream.oldy = stream.y
  stream.hasChanged = true
  stream.x = info.x
  stream.y = info.y
setInterval () ->
  changes = []
  
  
  for stream, index in users
    try
      if stream.hasChanged
        changes.push
          __cid: stream.__cid
          x: stream.x
          y: stream.y
        stream.hasChanged = false
    catch e
      users.splice index, 1
  for stream,index in users
    try
      if not stream
        users.splice index, 1
      if not stream.writable
        removeByCid stream.__cid
      else
        if changes.length > 0
          ws.write stream, JSON.stringify ["updateUsers", changes]
        #ws.write stream, JSON.stringify ["log", "chekup"]
      1
    catch e
      users.splice index, 1
, 33
