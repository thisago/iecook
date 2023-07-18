# Package

version       = "0.1.0"
author        = "Thiago Navarro"
description   = "Google Cookies. In your hands"
license       = "MIT"
srcDir        = "src"


# Dependencies

requires "nim >= 1.6.0"

requires "https://github.com/yglukhov/webdriver"

taskRequires "test", "dotenv"
