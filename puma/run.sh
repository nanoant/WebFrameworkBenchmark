#!/bin/bash

cd $(dirname $0)

. ../common/threads.sh

exec puma -t $threads:32 -w 8 -p 8080 -e production
