import std/asyncdispatch
import pkg/webdriver

type
  GoogleUser* = ref object
    username, password: string
    cookies*: string

func newGoogleUser*(username, password: string): GoogleUser =
  ## Creates new Google user instance
  new result
  result.username = username
  result.password = password

proc doLogin*(self: GoogleUser) {.async.} =
  ## Login account in Google website and save your session cookies
  self.cookies = "test"
