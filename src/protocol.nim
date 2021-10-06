import json

type
  Message* = object
    username*: string
    message*: string

proc parseMessage*(data: string): Message =
  let dataJson: JsonNode = parseJson(data)
  result.username = dataJson["username"].getStr()
  result.message = dataJson["message"].getStr()

proc createMessage*(username, message: string): string =
  result = $(%{
    "username": %username,
    "message": %message,
  }) & "\c\l"

when isMainModule:
  block `test parse valid message`:
    const data = """
    {
      "username": "Mini",
      "message": "Hi!"
    }
    """
    let message = parseMessage(data)
    doAssert message.username == "Mini"
    doAssert message.message == "Hi!"

  block `test parse invalid message`:
    let data = """invalid"""
    try:
      discard parseMessage(data)
      doAssert false
    except JsonParsingError:
      doAssert true
    except:
      doAssert false

  block `test create message`:
    let want = """{"username":"Mini","message":"Hi!"}""" & "\c\l"
    let got = createMessage("Mini", "Hi!")
    doAssert got == want

  echo("All tests passed!")
