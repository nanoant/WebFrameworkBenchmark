#!/bin/bash

cd $(dirname $0)
cd lib/onion

if [ ! -x examples/hello/hello ]; then
	if [ ! -f ../libev/.libs/libev.a ]; then
		( cd ../libev && configure && make -j8 )
	fi
	cmake -GNinja -DLIBEV_HEADER=$PWD/../libev -DLIBEV_LIB=$PWD/../libev/.libs/libev.a -DGNUTLS_LIB=/dev/null && \
	ninja examples/hello/hello
fi

ONION_LOG=noinfo exec examples/hello/hello
