#!/bin/bash

set -e

clang_path=`/usr/bin/xcrun -f $(basename "$0")`

"$clang_path" "$@"
