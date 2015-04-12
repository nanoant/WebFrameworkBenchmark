#!/bin/bash

cd $(dirname $0)

[ -d download ] || mkdir download

[ -f download/cppsp_1.0.tar.xz ] || \
	curl -o download/cppsp_1.0.tar.xz 'http://cznic.dl.sourceforge.net/project/cpollcppsp/CPPSP%201.0/cppsp_1.0.tar.xz'

[ -d download/cppsp_1.0 ] || \
	tar xf download/cppsp_1.0.tar.xz -C download
