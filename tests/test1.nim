from std/strutils import split
import std/unittest

import gookie

suite "Gookie":
  test "Get it":
    for i in 0..5:
      echo i
      let cookies = getGoogleCookies()
      require cookies.len > 0
      require cookies[0].cookies.len > 3
