FROM debian:latest

# Set the shell to bash
SHELL ["/bin/bash", "-c"]

# Make sure all is up to date
RUN apt update && apt upgrade -y

# Install some tools
RUN apt-get install -y wget curl git build-essential procps file \
                       qemu qemu-user qemu-user-static 'binfmt*' \
                       libc6-armel-cross libc6-arm64-cross

RUN mkdir /etc/qemu-binfmt
RUN ln -s /usr/arm-linux-gnueabihf /etc/qemu-binfmt/arm
RUN ln -s /usr/aarch64-linux-gnu /etc/qemu-binfmt/aarch64

# Create a user to setup for developing
RUN useradd -ms /bin/bash dev

# We are purposely not dropping privs here to make debugging easier
#USER dev

WORKDIR /home/dev
RUN tail -n +10 /home/dev/.bashrc > /root/.bashrc
RUN echo >> /root/.bashrc
RUN echo 'export LC_CTYPE=C.UTF-8' >> /root/.bashrc

# And setup the workspace
RUN mkdir /home/dev/workspace
WORKDIR /home/dev/workspace

CMD /bin/bash
