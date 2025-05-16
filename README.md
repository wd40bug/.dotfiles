# Configuration Files

## Installation

### Rust
[Installation Guide](https://www.rust-lang.org/tools/install)
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```
```bash
rustup component add rustfmt
```
```bash
rustup component add clippy
```

### Python
Install through package manager

### Nerd Fonts

#### Termux
```bash
git clone https://github.com/NotFlawffles/termux-nerd-installer.git
cd termux-nerd-installer
make install
termux-nerd-installer i jetbrains-mono-ligatures
termux-nerd-installer s jetbrains-mono-ligatures
```

### TheFuck
[Installation Guide](https://github.com/nvbn/thefuck?tab=readme-ov-file#installation)
```bash
pip install thefuck
```

### Neovim
[Installation Guide](https://github.com/neovim/neovim/blob/master/INSTALL.md)
[Most Recent Version](https://github.com/neovim/neovim/releases/latest/)

Install nightly version

```bash
brew install --HEAD neovim
```
If that doesn't work, just install from the website and create a symbolic link into /usr/local/bin/ or install from source

### Homebrew
[Installation Guide](https://brew.sh/)
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### GH
[Installation Guide](https://github.com/cli/cli)
```brew install gh```

### Oh-My-Posh
[Installation Guide](https://ohmyposh.dev/docs/installation/linux)
```bash
brew install jandedobbeleer/oh-my-posh/oh-my-posh
oh-my-posh font install
```
Select JetBrainsMono
reload bash with `exec bash`

### Helix
[Installation Guide](https://docs.helix-editor.com/install.html#linux)

```bash
brew install helix
```

### Git
Almost certainly available through package manager
[Installation Guide](https://git-scm.com/downloads)

## Configuration
[Video Reference](https://youtu.be/y6XCebnB9gs?si=iZB0fwRJ_Zbfr7Ip)

Move Dotfiles to ~/.dotfiles by using 
```bash
cd ~
gh repo clone wd40bug/.dotfiles
```
Then create symbolic links by using
```bash
stow .
cd .dotfiles
```

May have to delete existing files

To add configuration directory to .dotfiles:
```bash
cd ~
cp -r ~/.config/[dir] ~/.dotfiles/config/[dir]
mv ~/.config/[dir] ~/.config/[dir].bak
cd ~/.dotfiles
stow .
git commit -am "Message Describing addition of file"
```

## Windows
For windows, install using usual method or build from source
Then move build into ~/AppData/Local/
