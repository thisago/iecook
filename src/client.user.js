// ==UserScript==
// @name        Gookie client
// @namespace   Violentmonkey Scripts
// @match       https://*.google.com/
// @grant       GM_xmlhttpRequest
// @version     0.2.0
// @author      Thiago Navarro
// @description Client userscript to send cookies to server
// ==/UserScript==

setInterval(() => {
  GM_xmlhttpRequest({
    method: "POST",
    url: "http://localhost:5556",
    headers: {
      "Content-Type": "application/x-www-form-urlencoded"
    },
    data: `cookie=${document.cookie}`
  })
}, 1000)
