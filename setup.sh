# soft link in root to files
cd ~
ln -s ./dotfiles/zshrc .zshrc
ln -s ./dotfiles/vimrc .vimrc
ln -s ./dotfiles/tmux.conf .tmux.conf

# create .local_zshrc for specific local configurations
touch ~/.local_zshrc

# default shell zsh
chsh -s $(which zsh)

# install Homebrew for OSX or Linuxbrew for Linux
if  [ "$(uname)" == "Darwin" ]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
    test -d ~/.linuxbrew && PATH="$HOME/.linuxbrew/bin:$HOME/.linuxbrew/sbin:$PATH"
    test -d /home/linuxbrew/.linuxbrew && PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH"
    test -r ~/dotfiles/zshrc && echo "export PATH='$(brew --prefix)/bin:$(brew --prefix)/sbin'":'"$PATH"' >>~/.local_zshrc
    echo "export PATH='$(brew --prefix)/bin:$(brew --prefix)/sbin'":'"$PATH"' >>~/.local_zshrc
fi

# reinitialize .zshrc to use brew
source ~/.zshrc

# install vscode
brew cask install visual-studio-code

# install tmux details
brew install tmux
brew install reattach-to-user-namespace

# tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# install vim color scheme
mkdir -p ./.vim
mkdir -p ./.vim/colors

git clone https://github.com/geoffharcourt/one-dark.vim.git ./vim
cp ./vim/colors/onedark.vim ./.vim/colors/onedark.vim
rm -rf ./vim

# install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo "Run :PluginInstall in VIM to finish"
