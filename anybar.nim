import rawsockets
import net
import posix
import parseopt2
from strutils import parseInt

const
  VERSION* = "0.0.2"
  colors = ["white", "red", "orange", "yellow", "green", "cyan", "blue", "purple", "black", "question", "exclamation"]

type
  Anybar = ref object of RootObj
    address: string
    port: Port
    socket: Socket


proc newAnybar*(port: Port = Port(1738), address: string = "localhost"): Anybar =
  ## Create new client instance
  assert address != ""
  assert port != Port(0)

  new(result)
  result.address = address
  result.port = port
  result.socket = newSocket(sockType = rawsockets.SOCK_DGRAM, protocol = rawsockets.IPPROTO_UDP)



proc change*(self: Anybar, color: string) =
  ## Tell AnyBar to change the color of icon
  if not(color in colors):
    raise newException(ValueError, "Color is not valid.")

  discard self.socket.sendTo(self.address, self.port, color)

proc quit*(self: Anybar) =
  ## Tell AnyBar instance to quit
  discard self.socket.sendTo(self.address, self.port, "quit")

proc printUsage() =
  echo """Usage:
  anybar [-h:host] [-p:port] color|quit

Options:
  --help          Show this screen.
  -v, --version   Show version.
  -p, --port      The port of the AnyBar instance (default: 1738).
  -h, --host      The address of the AnyBar instance (default: localhost).
"""
  quit(0)

proc printVersion() =
  echo "anybar version ", VERSION
  quit(0)

when isMainModule:
  var host, port, color = ""
  for kind, key, val in getopt():
    case kind
    of cmdArgument:
      color = key
    of cmdLongOption, cmdShortOption:
      case key
      of "help":
        printUsage()
      of "version", "v":
        printVersion()
      of "p", "port":
        port = val
      of "h", "host":
        host = val
      else:
        printUsage()
    else:
      discard

  if color == "":
    printUsage()
  else:
    var tPort = Port(1738)
    if port != "":
      echo port
      tPort = Port(port.parseInt)

    if host == "":
      host = "localhost"

    if color == "quit":
      newAnybar(tPort, host).quit()
    else:
      newAnybar(tPort, host).change(color)
