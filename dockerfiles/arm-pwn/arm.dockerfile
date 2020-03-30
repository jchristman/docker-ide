#FROM arm64v8/debian:latest
FROM arm32v7/debian:latest

# Set the shell to bash
SHELL ["/bin/bash", "-c"]

# Make sure all is up to date
RUN apt-get update && apt upgrade -y

# Install some tools
RUN apt-get install -y \
    wget curl git gdb build-essential procps strace \
    python3 python3-dev python3-pip

# Install some extra goodness
RUN pip3 install capstone keystone-engine ropper

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

# And setup the workspace
RUN mkdir /home/dev/workspace
WORKDIR /home/dev/workspace

CMD /bin/bash
