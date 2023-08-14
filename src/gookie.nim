import std/asyncdispatch
from std/asynchttpserver import newAsyncHttpServer, Request, HttpPost, close,
                                listen, acceptRequest
from std/strtabs import newStringTable, modeCaseInsensitive, `[]=`, `[]`
export strtabs.`[]`

from std/base64 import decode
from std/json import parseJson, JsonNode, keys, items, `[]`, getStr

const defaultPort = 5556

type
  GoogleCookiesList* = seq[GoogleCookies]
  GoogleCookies* = tuple
    ## List of all Google's cookies
    context: string
    cookies: seq[GoogleCookie]
  GoogleCookie* = tuple
    ## One Google cookie
    name, value: string

proc toGoogleCookiesList(node: JsonNode): GoogleCookiesList =
  ## Transform JSON sent by client extension into a GoogleCookies list
  var i = 0
  for key in node.keys:
    result.add GoogleCookies (
      context: key,
      cookies: @[]
    )
    for cookie in node[key]:
      result[i].cookies.add GoogleCookie (
        name: cookie["name"].getStr,
        value: cookie["value"].getStr
      )
    inc i

proc getGoogleCookies*: GoogleCookiesList =
  ## Waits the userscript send all Google cookies available and returns
  var
    server = newAsyncHttpServer()
    cookies: type result

  proc cb(req: Request) {.async.} =
    if req.reqMethod == HttpPost:
      cookies = toGoogleCookiesList parseJson decode req.body
      close server

  server.listen Port defaultPort
  try:
    while true:
      waitFor server.acceptRequest cb
  except OSError:
    result = cookies
