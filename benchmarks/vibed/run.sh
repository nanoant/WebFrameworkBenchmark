#!/bin/bash

cd $(dirname "$0")

set -x
exec dub run -b release
