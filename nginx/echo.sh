#!/bin/bash
cd $(dirname $0)
[ -d logs ] || mkdir logs
exec /usr/local/openresty/nginx/sbin/nginx \
	-p $PWD/ \
	-c conf/echo.conf
