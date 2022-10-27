# vim-tldr

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/e9eacee4a3cf469b96847aaf288d0794)](https://app.codacy.com/app/wlemuel/vim-tldr?utm_source=github.com&utm_medium=referral&utm_content=wlemuel/vim-tldr&utm_campaign=Badge_Grade_Dashboard)

[tldr](http://tldr-pages.github.io/) client for vim/neovim

## Requirements

-   Vim 7.0+
-   unzip (*unix)
-   curl (*unix)

## Screenshot

![image](https://user-images.githubusercontent.com/1510976/72673994-7fbb7900-3aac-11ea-96fa-6745c5dc1efb.png)

## Installation

vim-tldr follows the standard runtime path structure. Below are some helper lines
for popular package managers:

-   [Vim 8 packages](http://vimhelp.appspot.com/repeat.txt.html#packages)
    -   `git clone https://github.com/wlemuel/vim-tldr.git ~/.vim/pack/plugins/start/vim-tldr`

-   [Pathogen](https://github.com/tpope/vim-pathogen)
    -   `git clone https://github.com/wlemuel/vim-tldr.git ~/.vim/bundle/vim-tldr`

-   [vim-plug](https://github.com/junegunn/vim-plug)
    -   `Plug 'wlemuel/vim-tldr'`

-   [Vundle](https://github.com/VundleVim/Vundle.vim)
    -   `Plugin 'wlemuel/vim-tldr'`

## Basic Usage

-   Run `:Tldr [command]` to find the tldr of command.
-   Run `:TldrUpdateDocs` to get or update tldr docs.

## Basic Options

-   Change the default tldr directory path:

    ```vim
    let g:tldr_directory_path = '~/.cache/tldr'
    ```

-   Change the tldr split window type `["horizontal", "vertical", "tab"]`, Default is "vertical":

    ```vim
    let g:tldr_split_type = 'horizontal'
    ```

-   Set language, Default is English:

    The supported language list until 2021-12-26.

    | option | language             |
    |--------|----------------------|
    | ar     | Arabic               |
    | bn     | Bengali              |
    | bs     | Bosnian              |
    | da     | Danish               |
    | de     | German               |
    | en     | English              |
    | es     | Spanish              |
    | fa     | Persian              |
    | fr     | French               |
    | hi     | Hindi                |
    | id     | Indonesian           |
    | it     | Italian              |
    | ja     | Japanese             |
    | ko     | Korean               |
    | ml     | Malayalam            |
    | ne     | Nepali               |
    | nl     | Dutch                |
    | no     | Norwegian            |
    | pl     | Polish               |
    | pt_BR  | Brazilian Portuguese |
    | pt_PT  | Portuguese           |
    | ro     | Romanian             |
    | ru     | Russian              |
    | sh     | Serbo-Croatian       |
    | sr     | Serbian              |
    | sv     | Swedish              |
    | ta     | Tamil                |
    | th     | Thai                 |
    | tr     | Turkish              |
    | uk     | Ukrainian            |
    | uz     | Uzbek                |
    | zh     | Chinese              |
    | zh_TW  | Traditional Chinese  |

    If the tldr of specific language is missing, English will be the fallback.
    The contribution to tldr project is welcome, please refer to [Tldr Contributing](https://github.com/tldr-pages/tldr#contributing) for details.

    ```vim
    let g:tldr_language = 'zh'
    ```

Check `:help tldr-options` for other options.

## Appendix

I'd be glad to receive patches,
comments and your considered criticism.

_Have fun with vim-tldr!_
