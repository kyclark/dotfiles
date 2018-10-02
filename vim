" Install Pathogen:
" mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
" cd ~/.vim/bundle && git clone https://github.com/neovimhaskell/haskell-vim.git
" git clone --depth=1 https://github.com/rust-lang/rust.vim.git ~/.vim/bundle/rust.vim
execute pathogen#infect()

" Install Vim Plug:
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" Then ':PlugInstall' in vim
call plug#begin('~/.vim/plugged')
Plug 'elmcast/elm-vim'
Plug 'sheerun/vim-polyglot'
Plug 'scrooloose/syntastic'
Plug 'vim-airline/vim-airline'
Plug 'morhetz/gruvbox'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-sensible'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdcommenter'
call plug#end()

filetype plugin indent on
syntax on

inoremap <Del> 

map - 
map :Q :q!
map <F1> NUL
map <space> 
map K NUL
map Q NUL
nmap :U :u
nmap :W :w
nmap :X :x
map ,d :SyntasticReset
map <C-n> :NERDTreeToggle<CR>
set pastetoggle=<C-p>

" ctrl+c to toggle highlight.
let hlstate=0
nnoremap <c-c> :if (hlstate%2 == 0) \| nohlsearch \| else \| set hlsearch \| endif \| let hlstate=hlstate+1<cr>

let mapleader = ","

set backspace=2
set expandtab
set noerrorbells
set ruler
set shiftwidth=4 
set tabstop=4
set timeout
set timeoutlen=3000
set incsearch
set title
let loaded_matchparen=1

let g:rustfmt_autosave = 1
let g:rust_clip_command = 'pbcopy'
let g:haskell_enable_quantification   = 1 " to enable highlighting of `forall`
let g:haskell_enable_recursivedo      = 1 " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax      = 1 " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles        = 1 " to enable highlighting of type roles
let g:haskell_enable_static_pointers  = 1 " to enable highlighting of `static`
let g:haskell_backpack                = 1 " to enable highlighting of backpack keywords
let g:haskell_indent_if               = 4
let g:hindent_on_save = 1
let g:hindent_indent_size = 4

let g:airline_left_sep= '░'
let g:airline_right_sep= '░'
let g:syntastic_mode_map = { "mode": "passive" }
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 0
let g:airline#extensions#syntastic#enabled = 0
let g:elm_detailed_complete = 1
let g:elm_format_autosave = 1
let g:elm_syntastic_show_warnings = 1
let g:polyglot_disabled = ['elm']

let g:formatters_rust = ['rustfmt']
let g:syntastic_bash_checkers = ['shellcheck']
let g:syntastic_python_checkers = ['pylint']

if has("autocmd")
  au BufRead *.sxp,*.lisp call LispStuff()
  au BufRead *.html,*.svg,*.tmpl,*.tt,*.sql call HTMLStuff()
  au BufRead *.js,*.jade call JavaScriptStuff()
  au BufRead *.json call JSONStuff()
  au BufRead *.pod call PODStuff()
  au BufRead *.pl6,*.p6 call Perl6Stuff()
  au BufRead *.pl,*.pm,*.PL call Perl5Stuff()
  au BufRead *.py call PythonStuff()
  au BufRead *.rb call RubyStuff()
  au BufRead *.hs call HaskellStuff()
  au BufRead *.sh call BashStuff()
  au BufRead *.elm call ElmStuff()
  "au BufRead *.rs call RustStuff()
endif

function JavaScriptStuff()
    set filetype=javascript
    set et
    set ts=2
    set sw=2
    set tw=0
    set equalprg=jslint

    " REM (comment) out highlighted section
    map <Leader>r :s/^/\/\//

    " Un-REM
    map <Leader>u :s/^\/\///

    map <Leader>c :w ! jslint -process %
endfunction

function JSONStuff()
    set filetype=json
    set et
    set ts=2
    set sw=2
    set tw=0
    set equalprg=jsonlint

    map <Leader>c :w ! jsonlint %
endfunction

function HTMLStuff()
    set et
    set ts=2
    set sw=2
    set tw=0
    set equalprg=tidy
    set syntax=html
    set filetype=html
endfunction

function LispStuff()
    set filetype=lisp
    set et
    set ts=2
    set sw=2
    set tw=0
    set equalprg=lisp
    set showmatch
    set matchtime=1
endfunction

function PODStuff()
    set filetype=pod
    set et
    set ts=2
    set sw=2
    set tw=70
endfunction

function BashStuff()
    set filetype=sh
    set et
    set ts=4
    set sw=4
    set tw=0
    setlocal foldmethod=expr 

    map <Leader>r :s/^/#/
    map <Leader>u :s/^#//
    map <Leader>c :SyntasticCheck
    map <Leader>d :SyntasticReset
endfunction

function HaskellStuff()
    map <Leader>r :s/^/--/
    map <Leader>u :s/^--//
    map <Leader>f :%!brittany --indent 4
    set ts=4
    set sw=4
endfunction

function Perl5Stuff()
    set filetype=perl
    set et
    set ts=4
    set sw=4
    set tw=0
    set equalprg=perltidy
    setlocal foldmethod=expr 

    " REM (comment) out highlighted section
    map ,r :s/^/#/
    " Un-REM
    map ,u :s/^#//

    " Get Perl to do syntax check with warnings on this file
    map ,c :w ! perl -cw %

    " Check with Perl::Critic
    map ,z :w ! perlcritic %

    " Filter highlighted section through autoformat
    map ,f :! perl -MText::Autoformat -e'autoformat {all=>1,squeeze=>0}'

    " Filter highlighted section through perltidy
    map ,t :! perltidy

    " Find next "warn" statement
    map ,w :/^\s*warn

    " Set textwidth to 70
    map ,m :set tw=70

    " Check POD in current file
    map ,p :w ! perl -MPod::Checker -e 'podchecker shift' %

    map ,c :w ! perl -cw %

    " REM (comment) out highlighted section
    map ,r :s/^/#/
    " Un-REM
    map ,u :s/^#//
    set iskeyword+=$
    set iskeyword+=%
    set iskeyword+=@-@
    set iskeyword+=:
    set iskeyword-=,
endfunction

function Perl6Stuff()
    set et
    set ts=4
    set sw=4
    set tw=0
    "set equalprg=perltidy
    setlocal foldmethod=expr 
    set filetype=perl6
    map ,r :s/^/#/
    map ,u :s/^#//
    map ,c :w ! perl6 -c %
    set iskeyword+=$
    set iskeyword+=%
    set iskeyword+=@-@
    set iskeyword+=:
    set iskeyword-=,
endfunction

function PythonStuff()
    set filetype=python
    set et
    set ts=4
    set sw=4
    set tw=0
    set equalprg=yapf

    map ,c :SyntasticCheck
    map ,d :SyntasticReset
    map ,n :lnext
    map ,r :s/^/#/
    map ,u :s/^#//
    map ,w :%s/\s\+$//
    map ,f :0,$!yapf
    "autocmd BufWritePre *.py 0,$!yapf
endfunction

function RustStuff()
    set filetype=rust
    set ts=4
    set sw=4
    set tw=0
    set et
    map ,h O// <esc>50a-<esc>

    "map ,r :s/^/\/\/ /
    "map ,u :s/^\/\/ //
endfunction

function ElmStuff()
    set filetype=elm
    set ts=4
    set sw=4
    set tw=0
    set et

    map ,r :s/^/-- /
    map ,u :s/^-- //
endfunction

function RubyStuff()
    set filetype=ruby
    set et
    set ts=2
    set sw=2
    set tw=0

    map ,r :s/^/#/
    map ,u :s/^#//

    " Get Perl to do syntax check with warnings on this file
    map ,c :w ! ruby -c %<CR>
endfunction

" Work out what the comment character is, by filetype...
autocmd FileType             *sh,awk,python,perl,perl6,ruby    let b:cmt = exists('b:cmt') ? b:cmt : '#'
autocmd FileType             vim                               let b:cmt = exists('b:cmt') ? b:cmt : '"'
autocmd BufNewFile,BufRead   *.vim,.vimrc                      let b:cmt = exists('b:cmt') ? b:cmt : '"'
autocmd BufNewFile,BufRead   *                                 let b:cmt = exists('b:cmt') ? b:cmt : '#'
autocmd BufNewFile,BufRead   *.p[lm],.t                        let b:cmt = exists('b:cmt') ? b:cmt : '#'

" Work out whether the line has a comment then reverse that condition...
function! ToggleComment ()
    " What's the comment character???
    let comment_char = exists('b:cmt') ? b:cmt : '#'

    " Grab the line and work out whether it's commented...
    let currline = getline(".")

    " If so, remove it and rewrite the line...
    if currline =~ '^' . comment_char
        let repline = substitute(currline, '^' . comment_char, "", "")
        call setline(".", repline)

    " Otherwise, insert it...
    else
        let repline = substitute(currline, '^', comment_char, "")
        call setline(".", repline)
    endif
endfunction

nmap <silent> # :call ToggleComment()<CR>j0
vmap <silent> # :call ToggleBlock()<CR>

highlight Comment term=bold ctermfg=white

set matchpairs+=<:>,«:»
