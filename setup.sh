# soft link in root to files
ln -s ./zshrc $HOME/.zshrc
ln -s ./vimrc $HOME/.vimrc
ln -s ./tmux.conf $HOME/.tmux.conf

# create .local_zshrc for specific local configurations
touch $HOME/.local_zshrc

# default shell zsh
echo "Switching default shell to zsh."
chsh -s $(which zsh)

# install Homebrew for OSX or Linuxbrew for Linux
if  [[ "$(uname)" == "Darwin" ]] && [[ ! -x "$(command -v brew)" ]]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
elif [[ "$(expr substr $(uname -s) 1 5)" == "Linux" ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
    test -d $HOME/.linuxbrew && PATH="$HOME/.linuxbrew/bin:$HOME/.linuxbrew/sbin:$PATH"
    test -d /home/linuxbrew/.linuxbrew && PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH"
    test -r $HOME/dotfiles/zshrc && echo "export PATH='$(brew --prefix)/bin:$(brew --prefix)/sbin'":'"$PATH"' >>$HOME/.local_zshrc
    echo "export PATH='$(brew --prefix)/bin:$(brew --prefix)/sbin'":'"$PATH"' >>$HOME/.local_zshrc
fi

# reinitialize .zshrc to use brew
source $HOME/.zshrc

# install vscode
if brew ls --versions visual-studio-code > /dev/null; then
    echo "visual-studio-code already installed."
else
    brew cask install visual-studio-code
fi

# install tmux details
if brew ls --versions tmux > /dev/null; then
    echo "tmux already installed."
else
    brew install tmux
fi

if brew ls --versions reattach-to-user-namespace > /dev/null; then
    echo "reattach-to-user-namespace already installed."
else
    brew install reattach-to-user-namespace
fi

# fetch color schemes
mkdir temp
git clone https://github.com/morhetz/gruvbox-contrib.git ./temp/gruvbox-contrib
git clone https://github.com/morhetz/gruvbox.git ./temp/gruvbox

# install vim color scheme
mkdir -p $HOME/.vim
mkdir -p $HOME/.vim/colors

# copy colors to desired destinations
cp ./temp/gruvbox/colors/gruvbox.vim $HOME/.vim/colors/gruvbox.vim
cp ./temp/gruvbox-contrib/iterm2/gruvbox-dark.itermcolors $HOME/gruvbox-dark.itermcolors
rm -rf ./temp

echo "Done."
