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
ws = require("simple-websocket")
server = ws.createServer
  port: 9998
  hostname : "bomber.the.tl"
server.on "wsConnection", (stream) ->
  users.push stream
  ws.write stream, JSON.stringify  ["renderScreen", screen]
  stream.on "wsMessage", (message) ->
    1
    #ws.write stream, message + "say what"
server.listen ws.options.port



setInterval () ->
  for stream in users
    ws.write stream, JSON.stringify ["log", "chekup"]
, 10000
