import std/[
  asyncdispatch,
  osproc,
  json
]
from std/options import get
from std/strformat import fmt

import pkg/webdriver/chromedriver

type
  GoogleUser* = ref object
    username, password: string
    cookies*: seq[tuple[name, value: string]]

func newGoogleUser*(username, password: string): GoogleUser =
  ## Creates new Google user instance
  new result
  result.username = username
  result.password = password

proc doLogin*(self: GoogleUser; webdriverStartDelay = 500) {.async.} =
  ## Login account in Google website and save your session cookies
  var driver = newChromeDriver()
  var options = %*{
    "excludeSwitches": ["enable-automation"],
  }
  await driver.startSession(options)
  
  await driver.setUrl("https://accounts.google.com")
  var elem_username = await driver.getElementBySelector("#identifierId")
  await driver.send_keys(elem_username, self.username)
  var elem_loginbtn = await driver.getElementBySelector("#identifierNext button")
  await driver.elementClick(elem_loginbtn)
  var elem_password = await driver.getElementBySelector("#password input")
  await driver.send_keys(elem_password, self.password)
  # var elem_loginbtn = await driver.getElementBySelector("#btnLogin2")
  # await driver.elementClick(elem_loginbtn)

  await driver.close()
    # let cookies = getAllCookies session
    # for cookie in cookies:
    #   self.cookies.add (cookie.name, cookie.value)
    # session.close()
