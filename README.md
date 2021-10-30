My Dotfiles for my MacOS environments
===

This repository contains stuff to manage settings and apps running on my MacOS environments. This is heavily inspired by [Dries Vints' Dotfiles](https://github.com/driesvints/dotfiles). Check out his repository and also [his awesome blog post](https://medium.com/@driesvints/getting-started-with-dotfiles-76bf046d035c) if you are interested in getting started into dotfiles as well!

Setting up your Mac
---

1. Update macOS to the latest version with the App Store
2. Install Xcode from the App Store, open it and accept the license agreement
3. Install macOS Command Line Tools by running `xcode-select --install`
4. Copy public and private SSH keys to `~/.ssh` and make sure they're set to 600
4. Clone this repo to `~/.dotfiles`
5. Append `/usr/local/bin/zsh` to the end of your `/etc/shells` file
6. Run `install.sh` to start the installation
7. Restore preferences by running `mackup restore`
8. Restart your computer to finalize the process
9. Your Mac is now ready to use!

License
---
The MIT License (MIT). Please see [License File](LICENSE) for more information.
