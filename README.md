# Docker IDE

The goal of this repository is to make it easy to have a portable IDE that isn't dependent on a setting up on a particular platform. This docker setup has auto-completion for C families, Python, Golang, and JavaScript using YouCompleteMe.

*VIM Demo:*  
![](https://github.com/jchristman/docker-ide/blob/readme-gif/ide-demo.gif?raw=true)

# Docker ARM-X

This is a dockerized version of the [ARM-X](https://armx.exploitlab.net/) environment with some helpful wrapper scripts and additional tooling installed.

*ARM-X Demo:*  
![](https://github.com/jchristman/docker-ide/blob/readme-gif/docker-armx-demo.gif?raw=true)

## Specialized Scripts

 1. `armxstart` - Equivalent to the `ARM-X Console` from the VM. Execute this to start a `tmux` session with the framework starting
 2. `armxconnect` - Equivalent to the `ARM-X Terminal` from the VM. Execute this after starting the framework to start the emulated software or connect to HostFS shell.
 3. `armxstop` - Quits the tmux session and kills any emulated software.
 4. `portfwd` - Convenience wrapper script to iptables that port forwards docker ports to the emulated firmware devices. Useful for doing things against a device from your native host machine.

## Extra tools pre-installed

 1. [pwndbg](https://github.com/pwndbg/pwndbg) for better gdb awesomeness
 2. [pwntools](https://github.com/Gallopsled/pwntools) for exploit dev

## Other key differences

 1. The Alpine Linux is against edge repositores instead of stable so that gdb-multiarch could be used instead of the specific one from the VM.
 2. Docker is kind of weird with filesystems. NFS wasn't happy with the default file system so I had to write an entrypoint script to move the `/armx` contents into that volume at container start. It's pretty quick, so it turned out to be not an issue.
 3. This is not an Open RC docker container, so nothing is done with services. Could maybe lead to stability issues? I haven't tested extensively yet, but you can always just restart the docker container if you need to.
 4. Wherever you execute the `arm-x` helper script from will mount your current working directory into the docker container at /home/armx/workspace. Use this to have persistent storage across container runs.

# Docker Others

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
