#!/bin/bash

cd $(dirname $0)

[ -d target/release ] || \
	carge build --release

exec ./target/release/helloworld
