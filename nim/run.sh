#!/bin/bash

cd $(dirname $0)

[ -f helloworldserver ] || \
	nim c -d:release --gc:markandsweep helloworldserver.nim
	# nim c -d:release --gc:boehm helloworldserver.nim

exec ./helloworldserver
