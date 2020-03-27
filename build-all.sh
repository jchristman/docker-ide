#!/bin/zsh

echo ----------- Building IDE -----------
echo

cd dockerfiles/ide
./build.sh

cd ../..

echo
echo -------- IDE Build Complete --------
echo
echo


echo ----- Building Android RE Env ------
echo

cd dockerfiles/android-re
./build.sh

cd ../..

echo
echo --- Android RE Env Build Complete --
echo
echo


echo ----- Building ARM Pwn Env ---------
echo

cd dockerfiles/arm-pwn
./build.sh

cd ../..

echo
echo --- ARM Pwn Env    Build Complete --
echo
echo
