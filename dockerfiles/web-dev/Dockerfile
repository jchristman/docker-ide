FROM debian:latest

# Set the shell to bash
SHELL ["/bin/bash", "-c"]

# Make sure all is up to date
RUN apt-get update && apt-get upgrade -y

# Prereqs for mysql dpkg
RUN apt-get install -y \
    wget lsb-release gnupg

WORKDIR /tmp
RUN wget https://dev.mysql.com/get/mysql-apt-config_0.8.15-1_all.deb
RUN echo 4 | dpkg -i mysql-apt-config_0.8.15-1_all.deb

RUN apt-get update

# Install some tools
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
    curl git build-essential procps file lsof \
    dos2unix netcat python3 python3-dev python3-pip \
    apache2 mysql-server php php-mysql libapache2-mod-php

# Install node
RUN curl -sL https://deb.nodesource.com/setup_13.x | bash -
RUN apt-get install -y nodejs
RUN npm install -g npm

# Good pwn dev tools
RUN pip3 install requests

# Create a user to setup for developing
RUN useradd -ms /bin/bash dev
RUN chmod -R 777 /var/www/

USER dev

WORKDIR /home/dev
RUN tail -n +10 /home/dev/.bashrc > /home/dev/.bashrc
RUN echo >> /home/dev/.bashrc
RUN echo 'export LC_CTYPE=C.UTF-8' >> /home/dev/.bashrc

# And setup the workspace
RUN mkdir /home/dev/workspace
WORKDIR /home/dev/workspace

CMD /bin/bash
