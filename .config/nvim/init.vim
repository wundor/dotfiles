call plug#begin('~/.local/share/nvim/plugged')
" Plug 'SirVer/ultisnips'
" Plug 'honza/vim-snippets'

" Plug 'mcchrish/nnn.vim'

" Plug 'Quramy/tsuquyomi'

" syntax hightlight
" Plug 'sheerun/vim-polyglot'
" Plug 'plasticboy/vim-markdown'

" Plug 'autozimu/LanguageClient-neovim', {
"     \ 'branch': 'next',
"     \ 'do': 'bash install.sh',
"     \ }

" COLORZ
" Plug 'arcticicestudio/nord-vim', { 'as': 'nord'}
Plug 'altercation/vim-colors-solarized'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'zoubin/vim-gotofile'
Plug 'christoomey/vim-tmux-navigator'

" Plug 'francoiscabrol/ranger.vim'
" for ranger.vim
" Plug 'rbgrouleff/bclose.vim'

Plug 'tpope/vim-fugitive'
Plug 'christoomey/vim-system-copy'
Plug 'vim-scripts/vim-auto-save'
" Plug 'godlygeek/tabular'
" Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
" Plug 'easymotion/vim-easymotion'
Plug 'junegunn/fzf.vim'
Plug 'eugen0329/vim-esearch'
" Plug 'justinmk/vim-sneak'
Plug 'airblade/vim-gitgutter'
Plug 'osyo-manga/vim-anzu'
Plug 'suan/vim-instant-markdown'
Plug 'nathangrigg/vim-beancount'
" Plug 'junegunn/goyo.vim'
call plug#end()

" #######
" S E T S
" #######

" Spellcheck for markdown
" au FileType markdown setlocal spell spelllang=en_us

" sets
set hidden
set nocompatible
set path+=$PWD/**
set number relativenumber
set wildmenu
set wildmode=full
set wildignore+=*/node_modules/*,*/build/*
set showcmd
set scrolloff=20
set cursorline
" for markdown stuff to be shown in insert mode
set concealcursor=c

" coc asks that for better error messaging. It makes sense but I should do mapping for it
" set cmdheight=2

set encoding=utf-8

" keymap magic. Use ^6 to switch keymap
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0

" fast switch from insert mode to normal
set ttimeoutlen=10

set list listchars=trail:⛟

" new tabz for quickfixes
set switchbuf+=usetab,newtab

" better search
set hlsearch
set incsearch

" search with smart case sensitive, autocomplete without it
set ignorecase
set smartcase
au InsertEnter * set noignorecase
au InsertLeave * set ignorecase

" No default mode indicator
set noshowmode

" show existing tab with 4 spaces width
set tabstop=4
" On pressing tab, insert 4 spaces
set expandtab
" when indenting with '>', use 4 spaces width
set shiftwidth=4

set autoread

" Colors
set background=dark
set t_Co=256
set termguicolors
syntax enable

" for ALE, it is inserting text from completion why I don't need it
set completeopt=menu,menuone,preview,noselect,noinsert

" If 'color scheme is not found' - this is for the rescue:
" ln -s ~/.vim/bundle/vim/colors/dracula.vim  ~/.vim/colors/dracula.vim

" let g:jellybeans_use_term_italics = 1

" colorscheme nord
" colors nord
" colorscheme jellybeans
" colors jellybeans

syntax enable
set background=dark
colorscheme solarized

" black background
" highlight Normal guibg=black guifg=NONE

" transparent background
highlight Normal guibg=none
highlight NonText guibg=none

hi CursorLine   cterm=NONE ctermbg=black ctermfg=white guibg=Grey20 guifg=none
hi CursorColumn cterm=NONE ctermbg=black ctermfg=white guibg=none guifg=none

hi Visual  guifg=none guibg=Grey10 gui=none

" FZF path
set rtp+=~/git/fzf

" statusline for anzu
set statusline=%{anzu#search_status()}

" save on focus lost
au FocusLost * silent! wa

" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type z/ to toggle highlighting on/off.
" function! AutoHighlightToggle()
"     let @/ = ''
"     if exists('#auto_highlight')
"         au! auto_highlight
"         augroup! auto_highlight
"         " enable coc hightlight back
"         au CursorHold * silent call CocActionAsync('highlight')
"         echo 'Highlight current word: OFF'
"         return 0
"     else
"         augroup auto_highlight
"             au!
"             au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
"         augroup end
"         echo 'Highlight current word: ON'
"         return 1
"     endif
" endfunction

" NNN config
let g:nnn#command = 'nnn -li'
let g:nnn#set_default_mappings = 0
" Open files in splitz from nnn
let g:nnn#action = {
      \ '<c-t>': 'tab split',
      \ '<c-x>': 'split',
      \ '<c-v>': 'vsplit' }

" setup specific stuff
if filereadable($MYLOCALPLUGINZ)
    source $MYLOCALPLUGINZ
endif

let g:airline#extensions#keymap#enabled = 0
let g:airline#extensions#branch#enabled = 0
let g:airline_skip_empty_sections = 1
let g:airline_detect_spelllang = 0
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline#extensions#wordcount#enabled = 0
let g:airline#extensions#hunks#enabled = 0
let g:airline_section_z = '%l/%L : %c'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''

let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 0
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_new_list_item_indent = 0

let g:auto_save = 1
let g:auto_save_in_insert_mode = 0
let g:auto_save_silent = 1

let g:system_copy#copy_command='xclip -sel clipboard'
let g:system_copy#paste_command='xclip -sel clipboard -o'

let g:ranger_map_keys = 0

let g:esearch = {
  \ 'adapter':    'ag',
  \ 'backend':    'nvim',
  \ 'out':        'win',
  \ 'batch_size': 1000,
  \ 'use':        ['visual', 'hlsearch', 'last'],
  \}

function MyNerdToggle()
    if &filetype == 'nerdtree'
        :NERDTreeToggle
    else
        :NERDTreeFind
    endif
endfunction

" setup specific stuff
let $MYLOCALLETZ = $HOME . "/.config/vim/letz"
if filereadable($MYLOCALLETZ)
    source $MYLOCALLETZ
endif

let g:polyglot_disabled = ['markdown']

" ###############
" M A P P I N G S
" ###############

let mapleader = " "

" autocmd CursorHold * silent call CocActionAsync('highlight')

" No Ex mode. Who needs it that way anyway? :)
" map Q <Nop>
nnoremap Q @q
map <C-s> <Nop>
nnoremap <C-s> :w
nnoremap <C-Tab> :tabNext

nnoremap <C-e> 5<C-e>
nnoremap <C-y> 5<C-y>

command! W w !sudo tee % > /dev/null

" Prettier with coc
" command! -nargs=0 Prettier :CocCommand prettier.formatFile

" nnoremap <CR> :
nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>

nnoremap <leader><Tab> :Commands<CR>
nnoremap <leader>p :Buffers<CR>
nnoremap <leader>ggt :GitGutterToggle<CR>
nnoremap <leader>al :ALELint<CR>
" nnoremap <leader>af :ALEFix<CR>
nnoremap <leader>af :Prettier<CR>

" toggle line numbers
nnoremap <leader>tln :set nu! <bar> set rnu!<CR>

nnoremap <leader>r :Ranger<CR>
nnoremap <leader>sl :lvim <C-r><C-w> % <bar> lopen<CR>
nnoremap <leader>ggd :Gdiff<CR>

" go to definition for some nodejs require stuff
nnoremap <leader>gd gdf'wgf
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>f :Files<CR>
nnoremap <leader>ag :Ag<CR>
nnoremap <leader>rts :%s/\s\+$//e<CR>
" Start nnn in the current file's directory
nnoremap <leader>n :NnnPicker '%:p:h'<CR>

nnoremap <C-p> :GFiles<CR>
nnoremap <C-n> :call MyNerdToggle()<CR>

nnoremap <F4> :setlocal paste!<CR>
nnoremap <F5> :setlocal spell! spelllang=en_us<CR>

nnoremap ]h :GitGutterNextHunk<CR>
nnoremap [h :GitGutterPrevHunk<CR>

" move through the location list
nnoremap ]l :lnext<CR>
nnoremap [l :lprevious<CR>

nnoremap ]e :ALENext<CR>
nnoremap [e :ALEPrevious<CR>
" Move up and down by displayed lines, not the actual ones
noremap j gj
noremap k gk

" Remap keys for gotos
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)

" nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
" nnoremap <silent> gd :ALEGoToDefinition<CR>

" To recover accidental ^u and ^w deletes with u in normal mode
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

" Clear search hightlight with Backspace
nnoremap <BS> :noh<CR>

" Keep search result in the middle of the screen
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" double slash in visual mode search selected text
vnoremap // y/<C-R>"<CR>

" mapping for anzu. dunno if I need it or not
" nmap n <Plug>(anzu-n-with-echo)
" nmap N <Plug>(anzu-N-with-echo)
" nmap * <Plug>(anzu-star-with-echo)
" nmap # <Plug>(anzu-sharp-with-echo)

" clear status for anzu
nmap <Esc><Esc> <Plug>(anzu-clear-search-status)

" if start anzu-mode key mapping
" anzu-mode is anzu(12/51) in screen
" nmap n <Plug>(anzu-mode-n)
" nmap N <Plug>(anzu-mode-N)

" Zoom / Restore window.
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction

command! ZoomToggle call s:ZoomToggle()

nnoremap <silent> <leader>z :ZoomToggle<CR>

" If the current buffer has never been saved, it will have no name,
" call the file browser to save it, otherwise just save it.
command! -nargs=0 -bar Update if &modified
    \|    if empty(bufname('%'))
    \|        browse confirm write
    \|    else
    \|        confirm write
    \|    endif
    \|endif
nnoremap <silent> <C-S> :<C-u>Update<CR>

" markdown preview
nnoremap <leader>mp :w!<CR>:w!~/tmp/vim-markdown.md<CR>:!pandoc -s -f markdown -t html -o ~/tmp/vim-markdown.html ~/tmp/vim-markdown.md<CR>:!qutebrowser ~/tmp/vim-markdown.html > /dev/null 2> /dev/null&<CR><CR>
