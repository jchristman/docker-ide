# Docker IDE

The goal of this repository is to make it easy to have a portable IDE that isn't dependent on a setting up on a particular platform. This docker setup has auto-completion for C families, Python, Golang, and JavaScript using YouCompleteMe.

*VIM Demo:*  
![](https://github.com/jchristman/docker-ide/blob/readme-gif/ide-demo.gif?raw=true)

*ARM-X Demo:*  
![](https://github.com/jchristman/docker-ide/blob/readme-gif/docker-armx-demo.gif?raw=true)

There are also a couple of other convenience environments set up for doing Android Reverse Engineering and ARM pwn development.

Setup
=====

To build all docker images (takes a long time):

```
git clone https://github.com/jchristman/docker-ide
cd docker-ide
./build-all.sh
```

To build just an individual image, you can `cd` to a dockerfiles directory and just run the individual `build.sh` script.

Usage
=====

```
cd docker-ide
source work

# To fire up a vim IDE
ide

# To fire up an Android RE environment
android-re

# To fire up an Pwn environment
pwn

# To fire up ARM-X
arm-x
```

After running the `source` command, you can run the `ide` command from anywhere and it will mount your current directory into the docker container and start vim
