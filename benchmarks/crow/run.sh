#!/bin/bash
set -e
cd $(dirname $0)
set -x
c++ -O3 \
	-std=c++11 \
	-Ilib/crow/include \
	-o helloworld \
	helloworld.cpp \
	-lboost_system \
	-lpthread \
	&& \
exec ./helloworld
