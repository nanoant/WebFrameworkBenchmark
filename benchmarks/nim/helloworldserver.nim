import asynchttpserver, asyncdispatch, strtabs, parseopt, os, osproc, sequtils,
       strutils, times

const
  usage = """
Usage: helloworldserver [opts]

Options:
  -h, --help     Show this help.
  -f, --prefork  Pre-fork using num-CPUs.
  -r, --reuse    Re-use port.

For more information read the Github readme:
  https://github.com/nim-lang/nimble#readme
"""

var
  prefork = false
  reuse = false

for kind, key, val in getOpt():
  case kind
    of cmdArgument: assert(false) # cannot happen
    of cmdShortOption:
      case key
      of "f": prefork = true
      of "r": reuse = true
      of "h": echo usage
      else:
        raise newException(ValueError, "Unknown option: -" & key)
    of cmdLongOption:
      case key
      of "fork":  prefork = true
      of "reuse": reuse = true
      of "help":  echo usage
      else:
        raise newException(ValueError, "Unknown option: --" & key)
    else:
      raise newException(ValueError, "Unknown option: --" & key)

if not prefork:
  when defined(reuse):
    var server = newAsyncHttpServer(true, reuse)
  else:
    var server = newAsyncHttpServer(true)
  proc cb(req: Request) {.async.} =
    when not defined(nodate):
      let date = getTime().getGMTime().format("ddd, d MMM yyyy HH:mm:ss") & " +0000"
      await req.respond(Http200, "Hello World",
        {"Content-Type": "text/html", "Date": date}.newStringTable())
    else:
      await req.respond(Http200, "Hello World",
        {"Content-Type": "text/html"}.newStringTable())

  asyncCheck server.serve(Port(8080), cb)
  runForever()

else:
  let numCPUs = countProcessors()
  var args = commandLineParams()
  args.insert(paramStr(0), 0)
  args.keepIf(proc(arg: string): bool = arg != "-f" and arg != "--prefork")
  args.add("--reuse")
  var cmds: seq[string] = @[]
  for cpu in 0..<numCPUs:
    cmds.add(args.join(" "))
    echo "CPU ", cpu, " -> ", args.join(" ")
  discard execProcesses(cmds, {poStdErrToStdOut, poParentStreams, poEchoCmd})
