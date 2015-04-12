#!/bin/bash

cd $(dirname $0)

[ -f target/undertow-1.0-SNAPSHOT.jar ] || \
	mvn package

exec mvn exec:java
