# Changelog

## Version 0.5.0 (2023/08/14)

- Added support to Firefox Containers (Cookie Stores)
- Now `getGoogleCookies` returns a Nim object instead a string
- The data sent by client extension is now a base64 encoded JSON

## Version 0.4.1 (2023/07/25)

- Base64 encode/decode cookies

## Version 0.4.0 (2023/07/25)

- Changed server from Jester to asynchttpserver; Fixed #2
- Removed request headers from extension

## Version 0.3.1 (2023/07/20)

- Fixed client extension duplicated requests and error handling
  
## Version 0.3.0 (2023/07/19)

- Removed userscript because it haven't permission to get `httpOnly` cookies
- Added client extension (tested in Firefox and Chrome); Closes #1

## Version 0.2.0 (2023/07/19)

- Added disposable server to get cookie
- Added client userscript

## Version 0.1.0 (2023/07/18)

- Init
