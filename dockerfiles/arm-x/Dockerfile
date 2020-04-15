FROM alpine:latest

# Install packages
RUN apk update
RUN apk add \
        bash sudo tar vim dialog iptables \
        tmux openssh-client nfs-utils \
        --no-cache

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

# Needs to be a volume in order to export
VOLUME /armx

# Add the armx tarball and untar it
COPY files/armx.tar /armx.tar

# Now setup the nfs file share
RUN echo '/armx   192.168.100.0/24(rw,sync,no_root_squash,no_subtree_check)' >> /etc/exports

# Now add the tmux shortcut
COPY files/armx/run/tmux-shortcut /armx/run/tmux-shortcut

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

USER armx

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/bin/bash"]
