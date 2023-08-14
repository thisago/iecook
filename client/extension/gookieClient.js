setInterval(async () => {
  const isArr = (obj) => (obj?.length ?? -1) >= 0
  const cleanCookies = (arr) =>
    arr.map((x) => ({ name: x.name, value: x.value }))
  const sendCookies = async (cookies) => {
    let json = {}

    if (isArr(cookies)) json = { default: cleanCookies(cookies) }
    else
      for (const storeId in cookies)
        json[storeId] = cleanCookies(cookies[storeId])

    try {
      await fetch("http://localhost:5556", {
        method: "POST",
        body: btoa(JSON.stringify(json)),
      })
    } catch {}
  }
  const conf = {
    url: "https://www.google.com/",
  }
  if (window.chrome && !window.browser) chrome.cookies.getAll(conf, sendCookies)
  else {
    let cookies = {}
    for (const store of await browser.cookies.getAllCookieStores())
      cookies[store.id] = await browser.cookies.getAll({
        ...conf,
        storeId: store.id,
      })
    sendCookies(cookies)
  }
}, 1000)
