import os, threadpool

# Reads a message from the stdin
proc readMessage(): string =
  try:
    result = stdin.readLine()
  except EOFError:
    result = ""


when isMainModule:
  echo("Chat application started")

  if paramCount() == 0:
    quit("Please specify the server address, e.g. ./client localhost")

  let serverAddr = paramStr(1)
  echo("Connecting to ", serverAddr)

  while true:
    let message = ^(spawn readMessage())
    if message == "":
      echo("Disconnecting and exiting.")
      quit(0)
    echo("Sending \"", message, "\"")
