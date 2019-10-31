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

# temp directory for storing install files
mkdir temp

# fetch color schemes
git clone https://github.com/dracula/vim.git ./temp/vim
git clone https://github.com/dracula/iterm.git ./temp/iterm

# install vim color scheme
mkdir -p $HOME/.vim
mkdir -p $HOME/.vim/colors
mkdir -p $HOME/.vim/autoload
cp ./temp/vim/colors/dracula.vim $HOME/.vim/colors/dracula.vim
cp ./temp/vim/autoload/dracula.vim $HOME/.vim/autoload/dracula.vim

# move dracula iterm theme into home dir
cp ./temp/iterm/Dracula.itermcolors $HOME/Dracula.itermcolors

# remove temp directory
rm -rf ./temp

echo "Done"
