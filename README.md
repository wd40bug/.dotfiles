# Configuration Files

## Installation

### Rust
[Installation Guide](https://www.rust-lang.org/tools/install)
`curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh`
`rustup component add rustfmt`
`rustup component add clippy`

### Neovim

[Installation Guide](https://github.com/neovim/neovim/blob/master/INSTALL.md)
[Most Recent Version](https://github.com/neovim/neovim/releases/latest/)
Install nightly version
`brew install --HEAD neovim`

### Homebrew
[Installation Guide](https://brew.sh/)
`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`

### GH
[Installation Guide](https://github.com/cli/cli)
`brew install gh`

### Oh-My-Posh
[Installation Guide](https://ohmyposh.dev/docs/installation/linux)
`brew install jandedobbeleer/oh-my-posh/oh-my-posh`
`oh-my-posh font install`
Select JetBrainsMono
reload bash with `exec bash`

### Helix
[Installation Guide](https://docs.helix-editor.com/install.html#linux)

`brew install helix`

### Git
Almost certainly available through package manager
[Installation Guide](https://git-scm.com/downloads)

## Configuration
[Video Reference](https://youtu.be/y6XCebnB9gs?si=iZB0fwRJ_Zbfr7Ip)

Move Dotfiles to ~/.dotfiles by using 
`
cd ~
gh repo clone wd40bug/.dotfiles
`
Then create symbolic links by using
`
stow .
cd .dotfiles
`

May have to delete existing files

To add configuration directory to .dotfiles:
`
cd ~
cp -r ~/.config/[dir] ~/.dotfiles/config/[dir]
mv ~/.config/[dir] ~/.config/[dir].bak
cd ~/.dotfiles
stow .
git commit -am "Message Describing addition of file"
`
