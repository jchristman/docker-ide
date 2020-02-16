FROM debian:latest

# Set the shell to bash
SHELL ["/bin/bash", "-c"]

# Make sure all is up to date
RUN apt update && apt upgrade -y

# Install neovim and build libraries for autocompletion
RUN apt-get install -y neovim python-pip python3-pip git curl \
                       build-essential cmake python3-dev

# Setup Golang
WORKDIR /tmp
RUN curl -O https://dl.google.com/go/go1.13.8.linux-amd64.tar.gz
RUN tar xvf go1.13.8.linux-amd64.tar.gz
RUN mv go /usr/local

# Setup nodejs (for autocompletion)
RUN curl -sL https://deb.nodesource.com/setup_13.x | bash -
RUN apt-get install -y nodejs

# Get the neovim python plugin
RUN pip2 install pynvim
RUN pip3 install pynvim

# Create a user to setup for developing
RUN useradd -ms /bin/bash dev
USER dev
WORKDIR /home/dev
RUN tail -n +9 /home/dev/.bashrc > /home/dev/.bashrc
RUN echo >> /home/dev/.bashrc
RUN echo 'export GOPATH=$HOME/work' >> /home/dev/.bashrc
RUN echo 'export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin' >> /home/dev/.bashrc

# Setup vim
RUN mkdir -p /home/dev/.config/nvim/bundle
COPY --chown=dev:dev vimrc /home/dev/.config/nvim/init.vim

# Install vundle and all plugins
RUN git clone https://github.com/VundleVim/Vundle.vim.git /home/dev/.config/nvim/bundle/Vundle.vim
RUN bash -c 'echo | echo | vim +PluginInstall +qall &>/dev/null'

# Install YCM
WORKDIR /home/dev/.vim/bundle/YouCompleteMe
RUN /bin/bash -c '. /home/dev/.bashrc; python3 install.py --clang-completer --go-completer --ts-completer'

# Change to the workspace directory
WORKDIR /home/dev/workspace

CMD vim
