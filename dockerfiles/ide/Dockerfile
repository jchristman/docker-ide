FROM debian:buster-slim

# Set the shell to bash
SHELL ["/bin/bash", "-c"]

# Make sure all is up to date
RUN apt update && apt upgrade -y

# Install neovim and build libraries for autocompletion
RUN apt-get install -y python3-pip git curl \
                       build-essential cmake python3-dev

# Setup Golang
WORKDIR /tmp
RUN curl -O https://dl.google.com/go/go1.13.8.linux-amd64.tar.gz
RUN tar xvf go1.13.8.linux-amd64.tar.gz
RUN mv go /usr/local

# Setup nodejs (for autocompletion)
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install -y nodejs

# Setup neovim
RUN curl -LO https://github.com/neovim/neovim/releases/download/v0.4.4/nvim-linux64.tar.gz
RUN tar xzf nvim-linux64.tar.gz
RUN cp nvim-linux64/bin/nvim /usr/bin/nvim
RUN cp -R nvim-linux64/share/* /usr/share
RUN update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 1
RUN rm -rf nvim*

# Get the neovim python plugin
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
RUN bash -c 'echo | echo | vim --headless +PluginInstall +qall 2>/dev/null'

# Install YCM
WORKDIR /home/dev/.vim/bundle/YouCompleteMe
RUN /bin/bash -c '. /home/dev/.bashrc; python3 install.py --clang-completer --go-completer --ts-completer'

# Add a default YCM semantic completion for C config
WORKDIR /home/dev
COPY --chown=dev:dev default_ycm_extra_conf.py /home/dev/.ycm_extra_conf.py

# Install Prettier
WORKDIR /home/dev/.vim/bundle/vim-prettier
RUN npm install

# Finally install commonly used libraries for auto-complete
RUN pip3 install requests pwntools

# Change to the workspace directory
WORKDIR /home/dev/workspace

USER root

RUN apt-get install cscope

USER dev

RUN mkdir -p /home/dev/.config/nvim/plugin
RUN curl http://cscope.sourceforge.net/cscope_maps.vim > /home/dev/.config/nvim/plugin/cscope_maps.vim

CMD vim
