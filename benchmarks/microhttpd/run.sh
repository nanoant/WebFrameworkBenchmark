#!/bin/bash
set -e
cd $(dirname $0)
set -x
cc -O3 \
	-o helloworld \
	helloworld.c \
	-lmicrohttpd \
	&& \
exec ./helloworld
