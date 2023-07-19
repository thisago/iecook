import std/asyncdispatch
from std/asynchttpserver import close

import pkg/jester

proc getGoogleCookies*: string =
  var
    cookie = ""
    server: Jester
  proc match(request: Request): Future[ResponseData] {.async.} =
    if request.reqMethod == HttpPost:
      case request.pathInfo:
        of "/":
          cookie = @"cookie"
          if cookie.len > 0:
            close server.httpServer

  server = match.initJester newSettings(port = 5556.Port)
  try:
    serve server
  except:
    result = cookie
