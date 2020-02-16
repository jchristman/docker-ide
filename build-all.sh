#!/bin/zsh

echo ----------- Building IDE -----------
echo

cd dockerfiles/ide
./build.sh

cd ../..

echo
echo -------- IDE Build Complete --------
