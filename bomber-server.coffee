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
    if stream.__cid == cid
      users.splice index, 1

ws = require("simple-websocket")
server = ws.createServer
  port: 9998
  hostname : "bomber.the.tl"
server.on "wsConnection", (stream) ->
  users.push stream
  stream.__cid = _.uniqueId()
  
  ws.write stream, JSON.stringify  ["renderScreen", screen]
  stream.on "wsMessage", (message) ->
    1
    #ws.write stream, message + "say what"
server.listen ws.options.port



setInterval () ->
  for stream in users
    if not stream.writable
      removeByCid stream.__cid
    else
      ws.write stream, JSON.stringify ["log", "chekup"]
, 10000
