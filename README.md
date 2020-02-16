# Docker IDE

The goal of this repository is to make it easy to have a portable IDE that isn't dependent on a setting up on a particular platform. This docker setup has auto-completion for C families, Python, Golang, and JavaScript using YouCompleteMe.

Setup
=====

```
git clone https://github.com/jchristman/docker-ide
cd docker-ide
./build-all.sh
```

Usage
=====

```
cd docker-ide
source dev.rc
ide
```

After running the `source` command, you can run the `ide` command from anywhere and it will mount your current directory into the docker container and start vim
