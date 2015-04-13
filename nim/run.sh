#!/bin/bash

cd $(dirname $0)

[ -f helloworldserver ] || \
	nim c -d:release helloworldserver.nim

exec ./helloworldserver
