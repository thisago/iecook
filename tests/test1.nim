from std/strutils import split
import std/unittest

import iecook

suite "Gookie":
  test "Get it":
    for i in 0..5:
      echo i
      let cookies = ieCook "https://google.com"
      echo cookies
      require cookies.len > 0
      require cookies[0].cookies.len > 2
