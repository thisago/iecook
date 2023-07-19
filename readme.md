<div align=center>

# Gookie

#### Google Cookies. In your hands

**[About](#about) - [Why](#why) - [How](#how) - [Usage](#usage)** - [License](#license)

> **Warning**
> This is a dangerous way to get Google Cookies, any program listening in port
> 5566 will receive the Google cookies sent by extension too.  
> **Don't forget to disable the extension after use!**

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

it will start an HTTP server (using Jester) that will wait the extension send
the cookies. The extension sends it every second.

When the server receives the cookies, it will self close and return the cookie
for you.

## Usage

As said before, you can get the cookies with one call:

```nim
let cookies = getGoogleCookies()
```

But first you need to install the client extension:

**In Firefox**
1. Go to `about:debugging#/runtime/this-firefox`
2. Click in "Load Temporary Add-on..."
3. Select the file: [client/extension/manifest.json](client/extension/manifest.json)

**In Chrome**
1. Go to `chrome://extensions`
2. Activate "Developer mode"
3. Click "Load unpacked"
4. Select [client/extension](client/extension) dir

Then you need to be logged in into your Google account.

> **Note**
> Don't forget to keep your browser open! :)

## License

This library is FOSS, licensed over MIT license!
