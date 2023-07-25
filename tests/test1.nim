import std/unittest

import gookie

suite "Gookie":
  test "Get it":
    for i in 0..2:
      echo i
      require getGoogleCookies().len >= 0
