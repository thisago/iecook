import std/asyncdispatch
import std/options
import pkg/webdriver

proc waitForElements*(
  session: Session;
  selector: string;
  strategy = CssSelector;
  timeout = 20000;
  pollTime = 50
): Future[seq[Element]] {.async.} =
  ## https://github.com/nim-lang/nimforum/blob/master/tests/browsertests/common.nim#L102
  var waitTime = 0

  while true:
    result = session.findElements(selector, strategy)
    if result.len > 0:
      return

    await sleepAsync pollTime
    waitTime += pollTime

    if waitTime > timeout:
      return

proc waitForElement*(
  session: Session;
  selector: string;
  strategy = CssSelector;
  timeout = 20000;
  pollTime = 50
): Future[Option[Element]] {.async.} =
  ## https://github.com/nim-lang/nimforum/blob/master/tests/browsertests/common.nim#L79
  let els = await session.waitForElements(selector, strategy, timeout, pollTime)
  if els.len > 0:
    result = some els[0]
