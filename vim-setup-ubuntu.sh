#!/bin/bash

set -e

echo "Updating packages..."
sudo apt update && sudo apt install -y vim curl git

echo "Creating .vim directories..."
mkdir -p ~/.vim/autoload ~/.vim/plugged

echo "Installing vim-plug..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Writing default .vimrc..."
cat << 'EOF' > ~/.vimrc
" Plugin manager
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'

call plug#end()

" General settings
set number                  " Show line numbers
set relativenumber          " Relative line numbers
set mouse=a                 " Enable mouse support
syntax on                   " Enable syntax highlighting
set clipboard=unnamedplus   " Use system clipboard
set hidden                  " Allow buffer switching without saving
set nobackup
set nowritebackup
set noswapfile
set incsearch               " Incremental search
set hlsearch                " Highlight search matches
set expandtab               " Use spaces instead of tabs
set shiftwidth=4
set tabstop=4
set autoindent
set smartindent
set cursorline
set wildmenu
set ttyfast

" Key bindings
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-p> :Files<CR>

" Airline
let g:airline#extensions#tabline#enabled = 1

" Theme (optional)
colorscheme desert
EOF

echo "Installing plugins using vim-plug..."
vim +PlugInstall +qall

echo "✅ Vim is now configured with awesome defaults!"
