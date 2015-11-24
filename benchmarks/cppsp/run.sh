#!/bin/bash

cd $(dirname $0)

[ -f cppsp_1.0.tar.xz ] || \
	curl -O 'http://cznic.dl.sourceforge.net/project/cpollcppsp/CPPSP%201.0/cppsp_1.0.tar.xz'

[ -d cppsp_1.0 ] || \
	tar xf cppsp_1.0.tar.xz
