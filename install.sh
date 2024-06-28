#!/bin/sh

echo "Setting up your Mac..."

# hide "last login" line when starting a new terminal session
touch $HOME/.hushlogin

# Check for Oh My Zsh and install if we don't have it
if test ! $(which omz); then
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
fi

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf $HOME/.zshrc
ln -sw $HOME/.dotfiles/.zshrc $HOME/.zshrc

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle --file ./Brewfile

# Make ZSH the default shell environment
chsh -s $(which zsh)

# copy global gitignore files
cp .gitignore $HOME/.gitignore

# Install global Composer packages
$(which composer) global require laravel/installer

# Create a Herd/Sites directories
mkdir $HOME/Herd
mkdir $HOME/Sites

# Symlink the Mackup config file to the home directory
ln -s ./.dotfiles/mackup.cfg $HOME/.mackup.cfg

# Install vs code extensions
cat vscode-extensions.txt | while read i; do
   code --install-extension $i --force
done

# Set macOS preferences
# We will run this last because this will reload the shell
source .macos
