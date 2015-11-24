#!/bin/bash
set -e
set -x
c++ -O3 \
	-std=c++11 \
	-Ilib/crow/include \
	-o helloworld \
	helloworld.cpp \
	-lboost_system \
	-lpthread
