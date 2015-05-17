#!/usr/bin/env bash
#    ^------ makes OSX use my own Bash 4

. common/threads.sh

[ -z "$1" ] && \
exec wrk \
	-t$threads -c100 -d10S \
	--timeout 2000 \
	-H 'Connection: keep-alive' \
	http://localhost:8080/

for i in {01..04}; do
	echo === results/${1}_${i}.txt
	wrk \
		-t$threads -c100 -d20S \
		--timeout 2000 \
		-H 'Connection: keep-alive' \
		--latency \
		http://localhost:8080/ | \
	tee results/${1}_${i}.txt
done
