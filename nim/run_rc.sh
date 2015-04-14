#!/bin/bash

cd $(dirname $0)

[ -f helloworldserver ] || \
	${NIM-nim} c -d:release helloworldserver.nim

exec ./helloworldserver
