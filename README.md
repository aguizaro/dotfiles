# Dotfiles

This repository contains my personal workstation configuration files.

## Included Configurations

- zsh configuration  
- tmux configuration  
- vim configuration  
- iTerm2 preferences (stored in `iterm2/`)  
- Optional Homebrew package installation support  

## Repository Structure

```

dotfiles/
├── install.sh
├── zsh/
│   └── zshrc
├── tmux/
│   └── tmux.conf
├── vim/
│   └── vimrc
├── iterm2/
│   ├── com.googlecode.iterm2.plist
│   └── com.googlecode.iterm2.private.plist

````

## Installation

Clone the repository:

```bash
git clone <repo-url> ~/Desktop/Projects/dotfiles
cd ~/Desktop/Projects/dotfiles
````

Make the installer executable:

```bash
chmod +x install.sh
```

Run the installer:

```bash
./install.sh [options]
```

## Installation Options

| Flag     | Description                            |
| -------- | -------------------------------------- |
| `--zsh`  | Install zsh configuration              |
| `--tmux` | Install tmux configuration             |
| `--vim`  | Install vim configuration              |
| `--brew` | Install Homebrew and required packages |
| `--all`  | Install everything                     |

Example:

```bash
./install.sh --all
```

## Work Machine Setup

On work machines using Oh My Zsh, custom configuration can be placed in:

```
~/.oh-my-zsh/custom/
```

## Notes

* Existing configuration files will be backed up before linking.
* Configuration files are managed using symbolic links.
