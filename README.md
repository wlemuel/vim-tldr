# vim-tldr
tldr client for vim/neovim

## Requirements

* Vim 7.0+
* unzip
* curl

## Installation

vim-tldr follows the standard runtime path structure. Below are some helper lines
for popular package managers:

* [Vim 8 packages](http://vimhelp.appspot.com/repeat.txt.html#packages)
  * `git clone https://github.com/wlemuel/vim-tldr.git ~/.vim/pack/plugins/start/vim-tldr`
* [Pathogen](https://github.com/tpope/vim-pathogen)
  * `git clone https://github.com/wlemuel/vim-tldr.git ~/.vim/bundle/vim-tldr`
* [vim-plug](https://github.com/junegunn/vim-plug)
  * `Plug 'wlemuel/vim-tldr'`
* [Vundle](https://github.com/VundleVim/Vundle.vim)
  * `Plugin 'wlemuel/vim-tldr'`

## Basic Usage
* Run `:Tldr [command]` to find the tldr of command.
* Run `:TldrUpdateDocs` to get or update tldr docs.

## Basic Options
* Change the default tldr directory path:

    ```vim
    let g:tldr_directory_path = '~/.cache/tldr'
    ```

* Change the tldr split window type `["horizontal", "vertical", "tab"]`, Default is "vertical":

    ```vim
    let g:tldr_split_type = 'horizontal'
    ```

Check `:help tldr-options` for other options.

## Appendix

I'd be glad to receive patches,
comments and your considered criticism.

_Have fun with vim-tldr!_
