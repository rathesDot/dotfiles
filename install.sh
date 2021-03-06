#!/bin/sh

echo "Setting up your Mac..."

# hide "last login" line when starting a new terminal session
touch $HOME/.hushlogin

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle

# Install Pure
mkdir -p "$HOME/.zsh"
git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"

# Make ZSH the default shell environment
chsh -s $(which zsh)

# Install PHP extensions with PECL
pecl install imagick

# Install Oh-My-Zsh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# Install Powerline fonts
git clone https://github.com/powerline/fonts.git --depth=1 $HOME/fonts
cd $HOME/fonts
./install.sh
rm -rf $HOME/fonts
cd $HOME/.dotfiles

# copy global gitignore files
cp .gitignore $HOME/.gitignore

# Install Composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# Install global Composer packages
/usr/local/bin/composer global require laravel/installer laravel/valet friendsofphp/php-cs-fixer

# Install Laravel Valet
$HOME/.composer/vendor/bin/valet install

# Install global NPM packages
yarn global add gatsby-cli

# Install python packages
pip3 install flake8
pip3 install yapf

# Create a Sites directory
# This is a default directory for macOS user accounts but doesn't comes pre-installed
mkdir $HOME/Sites

# Symlink the Mackup config file to the home directory
ln -s ./.dotfiles/mackup.cfg $HOME/.mackup.cfg

source ./install-code-extensions.sh

# Set macOS preferences
# We will run this last because this will reload the shell
source .macos