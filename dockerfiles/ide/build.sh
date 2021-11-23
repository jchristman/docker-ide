#!/bin/bash

case $(uname -m) in
    x86_64) docker build . -t ide ;;
    arm64)  docker build -f Dockerfile.arm . -t ide ;;
esac
