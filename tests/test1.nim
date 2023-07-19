import std/unittest

import gookie

suite "Gookie":
  test "Get it":
    let cookies = getGoogleCookies() # wait userscript to send
    require cookies.len != 0
    echo cookies
