#!/bin/bash
[ -d logs ] || mkdir logs
exec /usr/local/openresty/nginx/sbin/nginx \
	-p $PWD/ \
	-c nginx.conf
