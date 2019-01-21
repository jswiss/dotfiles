#!/bin/bash
set -euo pipefail

# Display message 'Setting up your Mac...'
echo "Setting up your Mac..."

# Homebrew - Installation

echo "Installing Homebrew"

if test ! $(which brew); then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
nvm install 8.11.1

# Install Homebrew Packages

cd ~
echo "Installing Homebrew packages"

homebrew_packages=(
  "git"
  "mysql"
  "php"
  "sqlite"
)

for homebrew_package in "${homebrew_packages[@]}"; do
  brew install "$homebrew_package"
done

# Install Casks
echo "Installing Homebrew cask packages"
brew tap caskroom/fonts

homebrew_cask_packages=(
  "authy"
  "google-backup-and-sync"
  "discord"
  "droplr"
  "balenaetcher"
  "filezilla"
  "flux"
  "font-fira-mono"
  "font-quicksand"
  "google-chrome"
  "insomnia"
  "iterm"
  "notion"
  "onedrive"
  "opendns-updater"
  "propresenter"
  "rocket"
  "slack"
  "spotify"
  "sublime-text"
  "sequel-pro"
  "sketch"
  "teamviewer"
  "visual-studio-code"
  "vlc"
  "whatsapp"
)

for homebrew_cask_package in "${homebrew_cask_packages[@]}"; do
  brew cask install "$homebrew_cask_package"
done

# Install Composer
echo "Installing Composer"
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# Install Global Composer Packages
echo "Installing Global Composer Packages"
/usr/local/bin/composer global require laravel/installer laravel/valet statamic/cli

# Install Laravel Valet
echo "Installing Laravel Valet"
$HOME/.composer/vendor/bin/valet install

# Create Sites directory
echo "Creating a Sites directory"
mkdir $HOME/Sites

# Start MySQL for the first time
echo "Starting MySQL for the first time"
brew services start mysql

# Configure Laravel Valet
cd ~/Sites
valet park && cd ~
echo "Configuring Laravel Valet"
cd ~

# iTerm
echo "Setting up iTerm"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install VS Code extentions
echo "Installing VS Code extentions"

code_extensions=(
  "formulahendry.auto-close-tag"
  "formulahendry.auto-rename-tag"
  "CoenraadS.bracket-pair-colorizer"
  "dbaeumer.vscode-eslint"
  "eamodio.gitlens"
  "ginfuru.vscode-jekyll-snippets"
  "onecentlin.laravel-blade"
  "npm"
  "christian-kohler.npm-intellisense"
  "felixfbecker.php-intellisense"
  "MehediDracula.php-namespace-resolver"
  "alexcvzz.vscode-sqlite"
  "ahdesign.language-antlers"
  "bradlc.vscode-tailwindcss"
  "whatwedo.twig"
  "octref.vetur"
  "shyykoserhiy.vscode-spotify"
)

for code_extension in "${code_extensions[@]}"; do
  code --install-extension "$code_extension"
done

# Complete
echo "Installation Complete"