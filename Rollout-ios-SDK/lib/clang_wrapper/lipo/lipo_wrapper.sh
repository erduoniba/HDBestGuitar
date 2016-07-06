#!/bin/bash

set -e

lipo_path=`/usr/bin/xcrun -f $(basename "$0")`

"$lipo_path" "$@"
