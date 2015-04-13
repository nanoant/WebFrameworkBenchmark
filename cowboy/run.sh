#!/bin/bash

cd $(dirname $0)

[ -f erlang.mk ] || \
	curl -O https://raw.githubusercontent.com/ninenines/erlang.mk/master/erlang.mk

[ -d _rel ] || make

exec ./_rel/hello_release/bin/hello_release foreground
