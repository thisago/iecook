<div align=center>

# Gookie

#### Google Cookies. In your hands

**[About](#about) - [Installation](#installation)** - [License](#license)

</div>

## About

Take your Google session cookies with a line of Nim code!

> **Note**
> On every call, it will open the web browser, login into your account and close it.

## Why

One of required session cookies for authentication, the `__Secure-1PSIDTS` expires in ~20 minutes. This makes impossible to automate things like using [Google Bard in nim](https://github.com/thisago/bard).

With this library, any time you want you can get the session cookies!

## Installation

```bash
# Install geckodriver
pip install webdrivermanager
webdrivermanager firefox --linkpath ~/.local/bin/

# Instal this lib
nimble install gookie
```

## License

This library is FOSS, licensed over MIT license!
