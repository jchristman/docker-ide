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

cd dockerfiles/pwn
./build.sh

cd ../..

echo
echo --- ARM Pwn Env    Build Complete --
echo
echo

echo ----- Building Web Env -------------
echo

cd dockerfiles/web-pwn
./build.sh

cd ../..

cd dockerfiles/web-dev
./build.sh

cd ../..

echo
echo --- Web Env        Build Complete --
echo
echo

echo ----- Building ARM-X System --------
echo

cd dockerfiles/arm-x
./build.sh

cd ../..

echo
echo --- ARM-X System   Build Complete --
echo
echo

#echo ----- Building Kernel Debugger -----
#echo
#
#cd dockerfiles/kernel-debug
#./build.sh
#
#cd ../..
#
#echo
#echo -- Kernel Debugger Build Complete --
#echo
#echo
