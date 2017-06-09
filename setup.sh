# Soft link in root to files
cd ~
ln -s ./dotfiles/zshrc .zshrc
ln -s ./dotfiles/vimrc .vimrc
ln -s ./dotfiles/tmux.conf .tmux.conf

# Install Homebrew for OSX
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install tmux details
brew install reattach-to-user-namespace

# Install badwolf vim color scheme
mkdir -p ./.vim
mkdir -p ./.vim/colors

git clone https://github.com/sjl/badwolf.git
cp ./badwolf/colors/badwolf.vim ./.vim/colors/badwolf.vim
rm -rf ./badwolf

# Install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo "Run :PluginInstall in VIM to finish"
