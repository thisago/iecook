import std/[
  asyncdispatch,
  osproc
]
from std/options import get
from std/strformat import fmt

import pkg/webdriver

import gookie/util

type
  GoogleUser* = ref object
    username, password: string
    cookies*: seq[tuple[name, value: string]]

func newGoogleUser*(username, password: string): GoogleUser =
  ## Creates new Google user instance
  new result
  result.username = username
  result.password = password

template withWebdriver(webdriverStartDelay: int; body: untyped): untyped =
  ## Run with webdriver executed
  let p = startProcess(
    "geckodriver -p 4444",
    options = {
      poStdErrToStdOut,
      poEvalCommand
    }
  )
  await sleepAsync webdriverStartDelay
  block:
    body
  close p

proc setText(text: string; el: Element) =
  click el
  el.sendKeys text

proc doLogin*(self: GoogleUser; webdriverStartDelay = 500) {.async.} =
  ## Login account in Google website and save your session cookies
  withWebdriver webdriverStartDelay:
    let
      driver = newWebDriver()
      session = createSession driver
    session.navigate("https://accounts.google.com")
    self.username.setText get await session.waitForElement "#identifierId"
    await sleepAsync 200
    click get await session.waitForElement "#identifierNext button"
    self.password.setText get await session.waitForElement "#password input"

    let cookies = getAllCookies session
    for cookie in cookies:
      self.cookies.add (cookie.name, cookie.value)
    session.close()
