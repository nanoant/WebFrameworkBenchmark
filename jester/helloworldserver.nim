import jester, asyncdispatch, strutils, math, os, asyncnet, re

settings:
  port = Port(8080)

routes:
  get "/":
    resp "Hello World"

runForever()
