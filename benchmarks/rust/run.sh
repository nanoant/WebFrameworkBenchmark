#!/bin/bash

cd $(dirname $0)

[ -d target/release ] || \
	cargo build --release

exec ./target/release/helloworld
