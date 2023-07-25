import std/asyncdispatch
import std/asynchttpserver

const defaultPort = 5556

proc getGoogleCookies*: string =
  var
    server = newAsyncHttpServer()
    cookie = ""

  proc cb(req: Request) {.async.} =
    if req.reqMethod == HttpPost:
      cookie = req.body
      await req.respond(Http200, "")
      close server

  server.listen Port defaultPort
  try:
    while true:
      waitFor server.acceptRequest cb
  except OSError:
    result = cookie
