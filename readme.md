<div align=center>

# Gookie

#### Google Cookies. In your hands

**[About](#about) - [Why](#why) - [How](#how) - [Usage](#usage)** - [License](#license)

> **Warning**
> This is a dangerous way to get Google Cookies, any program listening in port
> 5566 will receive the Google cookies sent by userscript too. **Use with caution**

</div>

## About

Take your Google session cookies with a line of Nim code!

## Why?

One of required session cookies for authentication, the `__Secure-1PSIDTS` expires in ~20 minutes. This makes impossible to automate things like using [Google Bard in nim](https://github.com/thisago/bard).

With this library, any time you want you can get the session cookies!

## How?

When you run:

```nim
discard getGoogleCookies()
```

it will start an HTTP server (using Jester) that will wait the userscript send
the cookies. The userscript sends it every second.

When the server receives the cookies, it will self close and return the cookie
for you.

## Usage

As said before, you can get the cookies with one call:

```nim
let cookies = getGoogleCookies()
```

but first you need to install the [client userscript](src/client.user.js), login
into your Google account and go to [Google homepage ↗](https://google.com)

## License

This library is FOSS, licensed over MIT license!
