# My Dotfiles

This repository contains my personal configuration files (dotfiles). It uses [GNU Stow](https://www.gnu.org/software/stow/) to manage symlinking these files into the correct locations in your home directory.

## Prerequisites

*   **GNU Stow**: You must have `stow` installed. You can find installation instructions on the [GNU Stow website](https://www.gnu.org/software/stow/).
*   **Git**: For cloning this repository.

## Setup

The recommended way to install these dotfiles is by using the provided `setup.sh` script:

1.  **Clone the repository:**
    ```bash
    git clone <repository_url> ~/.dotfiles 
    # (Replace <repository_url> with the actual URL of this repository)
    cd ~/.dotfiles
    ```

2.  **Run the setup script:**
    ```bash
    ./setup.sh
    ```

The `setup.sh` script will attempt to create symbolic links for all available configuration modules.

**Important:** If you already have existing configuration files in your home directory (e.g., `~/.bashrc`, `~/.vimrc`), `stow` (and thus `setup.sh`) will typically not overwrite them unless they are already symlinks managed by `stow` from this dotfiles directory. If `stow` finds a conflicting file, it will report an error for that module. Before running `setup.sh`, you should:
    *   **Back up any existing configurations** you want to keep.
    *   **Move or delete** your old dotfiles if you want them to be replaced by the ones in this repository.
    *   Alternatively, for advanced users, `stow` offers an `--adopt` flag that can be used manually to integrate existing files into the stow package.

## Available Modules

The `setup.sh` script manages the following modules:

*   `bash`
*   `fastfetch`
*   `fzf`
*   `git`
*   `ssh`
*   `vim`
*   `zsh`

## Manual Stow Usage (Optional)

While `setup.sh` is recommended, you can also manage individual modules manually using `stow` commands from the root of this repository (e.g., `~/.dotfiles`):

*   To stow a module: `stow <module_name>` (e.g., `stow vim`)
*   To unstow (remove symlinks for) a module: `stow -D <module_name>` (e.g., `stow -D vim`)
*   To restow (update links for) a module: `stow -R <module_name>` (e.g., `stow -R vim`)

Using `setup.sh` effectively runs `stow -R <module_name>` for all modules.

#dotfiles #unix #macos #linux