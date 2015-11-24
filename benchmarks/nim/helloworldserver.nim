import asynchttpserver, asyncdispatch, strtabs

var server = newAsyncHttpServer()
proc cb(req: Request) {.async.} =
  await req.respond(Http200, "Hello World", {"Content-Type": "text/html"}.newStringTable())

asyncCheck server.serve(Port(8080), cb)
runForever()
