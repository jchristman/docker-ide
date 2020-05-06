FROM debian:latest

# Set the shell to bash
SHELL ["/bin/bash", "-c"]

# Install packages
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y \
        qemu qemu-user qemu-system python3 python3-pip \
        gdb build-essential bc git fakeroot libncurses5-dev \
        libssl-dev ccache flex bison libelf-dev wget \
        cpio unzip rsync

WORKDIR /root/workspace

RUN wget -O ~/.gdbinit-gef.py -q https://github.com/hugsy/gef/raw/master/gef.py
RUN echo source ~/.gdbinit-gef.py >> ~/.gdbinit

RUN git clone https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
WORKDIR /root/workspace/linux-next
RUN git checkout master
RUN git fetch origin
RUN git reset --hard remotes/origin/master
COPY linux-next_config .config
RUN make -j12

WORKDIR /root/workspace
RUN git clone git://git.buildroot.net/buildroot
WORKDIR /root/workspace/buildroot
COPY buildroot_config .config
RUN FORCE_UNSAFE_CONFIGURE=1 make -j12

RUN echo 'export LC_CTYPE=C.UTF-8' >> /root/.bashrc

WORKDIR /root/workspace

CMD ["/bin/bash"]
