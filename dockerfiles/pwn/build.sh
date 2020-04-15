docker run --rm --privileged hypriot/qemu-register

#docker build . -t arm-pwn -f arm.dockerfile
#docker build . -t arm-pwn-gdbserver -f x86.dockerfile

docker-compose build
