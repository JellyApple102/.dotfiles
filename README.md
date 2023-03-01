# .dotfiles

This is where I will keep my personal dotfiles in an attempt to stay organized and keep them available on multiple machines.
I mainly develop on my M1 Mac, this repo is organized in such a way to use `stow` to manage the dotfiles as packages to be
installed to the home directory.

# neovim

The `lua-init` branch houses my current config. It is more organized an written in lua rather than vimscript.
The `main` branch has my old and (most likely) outdated init.vim.

## notes

init.lua sources sub-components of the config to stay organized.

Using [packer.nvim](https://github.com/wbthomason/packer.nvim) as the package manager. Remember to use `:PackerSync`.
