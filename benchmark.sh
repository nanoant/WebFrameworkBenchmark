#!/bin/bash
exec wrk \
	-t4 -c100 -d10S \
	--timeout 2000 \
	-H 'Connection: keep-alive' \
	http://localhost:8080/
