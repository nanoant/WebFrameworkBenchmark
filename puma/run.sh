#!/bin/bash

cd $(dirname $0)

exec /usr/local/ruby-2.2.1/bin/puma -t 8:32 -w 8 -p 8080 -e production
