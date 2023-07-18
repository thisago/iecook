import std/asyncdispatch
import std/unittest
from std/os import getEnv

import pkg/dotenv

import gookie

dotenv.load()

suite "Gookie":
  test "Get it":
    let user = newGoogleUser(
      username = getEnv("google_username"),
      password = getEnv("google_password")
    )
    waitFor user.doLogin
    require user.cookies.len != 0
