FROM debian:latest

ENV TERM linux

# Set the shell to bash
SHELL ["/bin/bash", "-c"]

# Make sure all is up to date
RUN apt update && apt upgrade -y

# Install some tools
RUN apt-get install -y \
    wget curl git build-essential procps file lsof \
    strace dos2unix xxd netcat python3 python3-dev \
    python3-pip gdb-multiarch \
    qemu qemu-user qemu-user-static 'binfmt*' \
    libc6-armel-cross libc6-arm64-cross \
    libc6-armhf-cross

RUN mkdir /etc/qemu-binfmt
#RUN ln -s /usr/arm-linux-gnueabi /etc/qemu-binfmt/arm
RUN ln -s /usr/arm-linux-gnueabihf /etc/qemu-binfmt/arm
RUN ln -s /usr/aarch64-linux-gnu /etc/qemu-binfmt/aarch64

# Good pwn dev tools
RUN pip3 install capstone keystone-engine ropper ropgadget pwntools

# Create a user to setup for developing
RUN useradd -ms /bin/bash dev

# We are purposely not dropping privs here to make debugging easier
#USER dev

WORKDIR /home/dev
RUN tail -n +10 /home/dev/.bashrc > /root/.bashrc
RUN echo >> /root/.bashrc
RUN echo 'export LC_CTYPE=C.UTF-8' >> /root/.bashrc

# Setup pwndbg
RUN git clone https://github.com/pwndbg/pwndbg
WORKDIR /home/dev/pwndbg
RUN ./setup.sh

# gdbinit tweaks
RUN echo "set show-flags on" >> /root/.gdbinit
RUN echo "set show-retaddr-reg on" >> /root/.gdbinit

# And setup the workspace
RUN mkdir /home/dev/workspace
WORKDIR /home/dev/workspace

CMD /bin/bash
