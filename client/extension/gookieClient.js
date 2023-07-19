setInterval(() => {
  const sendCookies = (cookies) => {
    let cookie = ""
    cookies.map((x) => {
      cookie += `${x.name}=${x.value}; `
    })
    console.log(cookie)
    try {
      fetch("http://localhost:5556", {
        method: "POST",
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: `cookie=${encodeURIComponent(cookie)}`,
      })
    } catch {}
  }
  if (window.chrome) {
    chrome.cookies.getAll(
      {
        url: "https://www.google.com/",
      },
      sendCookies
    )
  }
  browser.cookies
    .getAll({
      url: "https://www.google.com/",
    })
    .then(sendCookies)
}, 1000)
