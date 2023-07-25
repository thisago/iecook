import std/unittest

import gookie

suite "Gookie":
  test "Get it":
    let cookies = getGoogleCookies() # wait extension to send
    require cookies.len != 0
    echo cookies
