# soft link in root to files
cd ~
ln -s ./devconfig/zshrc .zshrc
ln -s ./devconfig/vimrc .vimrc
ln -s ./devconfig/tmux.conf .tmux.conf

# default shell zsh
chsh -s $(which zsh)

# install Homebrew for OSX
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# reinitialize .zshrc to use brew
source ~/.zshrc

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
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo "Run :PluginInstall in VIM to finish"
