import threadpool

# Reads a message from the stdin
proc readMessage(): string =
  try:
    result = stdin.readLine()
  except EOFError:
    result = ""


when isMainModule:
  while true:
    let message = ^(spawn readMessage())
    if message == "":
      echo("Disconnecting and exiting.")
      quit(0)
    echo("Sending \"", message, "\"")
