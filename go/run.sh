#!/bin/bash

cd $(dirname $0)

GOMAXPROCS=8 exec go run helloworldserver.go
