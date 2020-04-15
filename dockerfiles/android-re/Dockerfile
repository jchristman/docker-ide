FROM debian:latest

# Set the shell to bash
SHELL ["/bin/bash", "-c"]

# Make sure all is up to date
RUN apt update && apt upgrade -y

# Install libraries
RUN apt-get install -y \
    default-jre default-jdk git \
    python3 python3-dev python3-pip \
    libpq-dev sqlite3

RUN pip3 install sqlcrush

# Create a user to setup for developing
RUN useradd -ms /bin/bash dev
USER dev

WORKDIR /home/dev
RUN tail -n +9 /home/dev/.bashrc > /home/dev/.bashrc
RUN echo >> /home/dev/.bashrc
RUN echo 'export PATH=$PATH:/usr/local/go/bin:/home/dev/tools/jadx/build/jadx/bin' >> /home/dev/.bashrc

RUN mkdir /home/dev/tools
WORKDIR /home/dev/tools
RUN git clone https://github.com/skylot/jadx.git
WORKDIR /home/dev/tools/jadx
RUN ./gradlew dist

# Change to the workspace directory
WORKDIR /home/dev/workspace

CMD /bin/bash
