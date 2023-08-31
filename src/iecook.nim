import std/asyncdispatch
from std/asynchttpserver import newAsyncHttpServer, Request, HttpPost, close,
                                listen, acceptRequest, respond, HttpGet, Http200
from std/strtabs import newStringTable, modeCaseInsensitive, `[]=`, `[]`
export strtabs.`[]`

from std/base64 import decode
from std/strutils import join
from std/json import parseJson, JsonNode, keys, items, `[]`, getStr

const defaultPort = 5556

type
  IeCookList* = seq[IeCook]
    ## List of all containers with their cookies
  IeCook* = tuple
    ## List of all cookies
    context: string
    cookies: seq[GoogleCookie]
  GoogleCookie* = tuple
    ## One cookie
    name, value: string

proc toIeCookList(node: JsonNode): IeCookList =
  ## Transform JSON sent by client extension into a IeCook list
  var i = 0
  for key in node.keys:
    result.add IeCook (
      context: key,
      cookies: @[]
    )
    for cookie in node[key]:
      result[i].cookies.add GoogleCookie (
        name: cookie["name"].getStr,
        value: cookie["value"].getStr
      )
    inc i

func hasKey*(self: IeCook; key: string): bool =
  ## CHeck if cookie key exists in cookies
  result = false
  for cookie in self.cookies:
    if cookie.name == key:
      return true


func `[]`*(self: IeCook; key: string): string =
  ## Get key value in cookies list
  for cookie in self.cookies:
    if cookie.name == key:
      return cookie.value
  raise newException(ValueError, "Key '" & key & "' not exists")

func `$`*(cookies: seq[GoogleCookie]): string =
  ## Stringify cookies
  var strCookies: seq[string]
  for cookie in cookies:
    strCookies.add cookie.name & "=" & cookie.value
  result = strCookies.join ";"

proc ieCook*(domain: string): IeCookList =
  ## Get all cookies for `domain`
  var
    server = newAsyncHttpServer()
    cookies: type result

  proc cb(req: Request) {.async.} =
    if req.reqMethod == HttpPost and req.url.path == "/cookies":
      cookies = toIeCookList parseJson decode req.body
      close server
    elif req.reqMethod == HttpGet and req.url.path == "/domain":
      await req.respond(Http200, domain)

  server.listen Port defaultPort
  try:
    while true:
      waitFor server.acceptRequest cb
  except OSError:
    result = cookies

when isMainModule:
  echo ieCook "https://google.com"
