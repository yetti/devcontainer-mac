#!/usr/bin/bash

# Setup locales
echo "en_AU.UTF-8" | sudo tee -a /etc/locale.gen
export LANGUAGE="en_AU.UTF-8"
export LC_TYPE="en_AU.UTF-8"
export LANG="en_AU.UTF-8"
sudo locale-gen

sudo apt-get update
sudo apt-get upgrade -y

# Install basic system utilities
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends zsh telnet fzy tzdata direnv tmux file

# Install network utilities
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends iputils-ping dnsutils mtr iproute2 bmon iperf3

# Install system dependencies
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends build-essential libssl-dev automake autoconf patch rustc git-extras libjemalloc2

# Install buildpack
sudo add-apt-repository ppa:cncf-buildpacks/pack-cli -y --no-install-recomments
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends pack-cli

# Copy dotfiles and tool config
cp {.bashrc,.zshrc,.gitconfig,.gitignore_global,.gemrc,.czrc} ~/
cp -R .config ~/

# Change default shell to zsh
sudo chsh -s $(which zsh) vscode

# Install zinit
# export TERM=xterm-256color
# export NO_INPUT=1
# bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
# source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
# zinit self-update

# Install mise-en-place if it doesn't exist
cp .tool-versions ~/
[ -d '~/.local/bin/mise' ] || curl https://mise.run | sh
ln -s ~/.local/share/mise ~/.asdf
# This is hard coded in .zshrc
# echo 'eval "$(~/.local/bin/mise activate zsh)"' >> ~/.zshrc

# Install mise plugins
mise plugin i yarn
mise install

# Install base Ruby gems
gem install bundler rails foreman overmind
