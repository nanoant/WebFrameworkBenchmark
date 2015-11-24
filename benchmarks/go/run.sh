#!/bin/bash

cd $(dirname $0)

. ../common/threads.sh

if [ -z "$(type -p go)" -a -x /usr/local/go/bin/go ]; then
	go=/usr/local/go/bin/go
else
	go=go
fi

set -x
GOMAXPROCS=$threads exec $go run helloworldserver.go
