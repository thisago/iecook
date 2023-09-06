<div align=center>

# ieCook

#### Cook all your browser cookies!

**[About](#about) - [Why](#why) - [How](#how) - [Usage](#usage)** - [License](#license)

> **Warning**
> This is a dangerous way to get cookies, any program listening in port 5566 can
> request the cookies sent by extension too.  
> **So don't forget to disable the extension after use!**

</div>

## About

Have you ever needed to get `httpOnly` cookies to use in your application?
No? Doesn't matter, this library gives you this power!

It gets all cookies from all Firefox containers too! :D

## Why?

This is needed to interface with authentication in some websites.

Currently, you can see this library used in [thisago/bard](https://github.com/thisago/bard)

## How?

It will start an HTTP server that waits the extension requests the website which
you want the cookies and send to server the wanted cookies.

When the server receives the cookies, it closes itself and return the cookie for
you!

## Setup

Tou need to install the client extension:
**In Firefox**

> **Note**
> Firefox automatically deletes on close. **More secure**

1. Go to `about:debugging#/runtime/this-firefox`
2. Click in "Load Temporary Add-on..."
3. Select the file: [client/extension/manifest.json](client/extension/manifest.json)

**In Chrome**

1. Go to `chrome://extensions`
2. Activate "Developer mode"
3. Click "Load unpacked"
4. Select [client/extension](client/extension) dir

> **Note**
> Don't forget to keep your browser open! :)

## Usage

The usage is pretty simple

```nim
let cooked = ieCook "google.com"
```

It returns to you a `seq[GoogleCookies]`

## License

This library is FOSS, licensed over MIT license!
