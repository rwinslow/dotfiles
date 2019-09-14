# install Homebrew for OSX or Linuxbrew for Linux
if [[ $(command -v brew) == "" ]]; then
    echo "installing homebrew"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    echo "updating homebrew"
    brew update
fi

# soft link in root to files
echo "softlinking config files"
ln -sf $HOME/dotfiles/zshrc $HOME/.zshrc
ln -sf $HOME/dotfiles/vimrc $HOME/.vimrc
ln -sf $HOME/dotfiles/tmux.conf $HOME/.tmux.conf

# create .local_zshrc for specific local configurations
touch $HOME/.local_zshrc

# reinitialize .zshrc to use brew
echo "reinitializing with .zshrc"
source $HOME/.zshrc

echo "installing zsh"
brew install zsh

echo "installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "installing miniconda"
brew cask install miniconda

echo "installing hack font"
brew tap caskroom/fonts
brew cask install font-hack

# install vscode
if brew ls --versions visual-studio-code > /dev/null; then
    echo "visual-studio-code already installed."
else
    brew cask install visual-studio-code
fi

# install tmux details
if brew ls --versions tmux > /dev/null; then
    echo "tmux already installed"
else
    brew install tmux
fi

if brew ls --versions reattach-to-user-namespace > /dev/null; then
    echo "reattach-to-user-namespace already installed"
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
rm -rf ./temp

echo "Done"
