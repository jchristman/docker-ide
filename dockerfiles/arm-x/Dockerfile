FROM alpine:latest

# Switch to edge repo
RUN sed -i -e 's/v[[:digit:]]\..*\//edge\//g' /etc/apk/repositories

# Install packages
RUN apk update
RUN apk add \
        bash sudo tar vim dialog iptables \
        curl tmux openssh-client nfs-utils \
        python2 python2-dev py2-setuptools git \
        gdb-multiarch build-base openssl openssl-dev \
        --no-cache

RUN easy_install-2.7 pip

# Create a user to work as
RUN adduser --disabled-password --gecos "" armx
RUN echo 'armx ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

# Change default user shells to bash
RUN sed -i 's!/bin/ash!/bin/bash!g' /etc/passwd

# https://github.com/sudo-project/sudo/issues/42
# This is temporary until the package repos for alpine are updated with most
# recent build of sudo which silently ignores the error caused by running
# sudo in a container. It does not break anything to do this, it just saves
# an error being printed to the screen
RUN echo "Set disable_coredump false" >> /etc/sudo.conf

# Copy network tunnel startup script
COPY files/etc/local.d/10-tun-network.start /etc/local.d/10-tun-network.start
RUN chmod 755 /etc/local.d/10-tun-network.start

# Copy the nfsd startup script
COPY files/etc/init.d/nfs /etc/init.d/nfs
RUN chmod 755 /etc/init.d/nfs

# Setup the working directory
WORKDIR /home/armx

# Add a bashrc that just doesn't look like crap
COPY --chown=armx files/home/armx/bashrc .bashrc
COPY --chown=armx files/home/armx/bash_profile .bash_profile
COPY --chown=armx files/home/armx/tmux.conf .tmux.conf
COPY --chown=armx files/home/armx/ssh .ssh
COPY --chown=root files/home/armx/bashrc /root/.bashrc
COPY --chown=root files/home/armx/bash_profile /root/.bash_profile
COPY --chown=root files/home/armx/tmux.conf /root/.tmux.conf
COPY --chown=root files/home/armx/ssh /root/.ssh

# Finally, set up the initialization script. This will execute CMD as the armx
# user after running some initialization scripts
COPY docker-entrypoint.sh /usr/local/bin/

# Drop privileges and setup for work
USER armx

# Install pwndbg as armx so the right gdbinit is written to
# Note that this is a modified version of pwndbg clone locally while
# getting the alpine support into the main repo is worked on.
COPY --chown=armx files/home/armx/pwndbg pwndbg
WORKDIR /home/armx/pwndbg
RUN ./setup.sh

# Set some options in the gdbinit
RUN echo "set follow-fork-mode child" >> ~/.gdbinit
RUN echo "set detach-on-fork off" >> ~/.gdbinit
RUN echo "set show-retaddr-reg on" >> ~/.gdbinit
RUN echo "set show-flags on" >> ~/.gdbinit

WORKDIR /home/armx

# Install checksec script
RUN git clone https://github.com/slimm609/checksec.sh
RUN sudo ln -s checksec.sh/checksec /usr/local/bin/checksec

# Go back to the workspace
WORKDIR /home/armx/workspace

RUN pip3 install pwntools ropper ropgadget

################################################################

# Switch back to root to do armx stuff
USER root

# Needs to be a volume in order to export
VOLUME /armx

# Add the armx to a docker directory so that docker-entrypoint can move the files over the /armx dir
COPY files/armx /armx-docker

# Untar all of the emulated systems that have special file types
WORKDIR /armx-docker
RUN tar xvf DVAR.tar && rm DVAR.tar
RUN tar xvf TRI227WF.tar && rm TRI227WF.tar
RUN sudo chown -R armx:armx /armx-docker

# Now setup the nfs file share
RUN echo '/armx   192.168.100.0/24(rw,sync,no_root_squash,no_subtree_check)' >> /etc/exports

################################################################

# Switch back to user armx
USER armx
WORKDIR /home/armx/workspace

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/bin/bash"]
