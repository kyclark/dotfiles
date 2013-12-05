set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'MatchTagAlways'

filetype plugin indent on 

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
filetype on
syntax on
let loaded_matchparen=1

inoremap <Del> 

map K NUL
map <F1> NUL
map <space> 
map - 
map Q NUL
map :Q :q!
nmap :W :w
nmap :X :x
nmap :U :u

iab psb  #!/usr/bin/env perluse strict;use warnings;use feature 'say';use autodie;
iab pdbg use Data::Dumper 'Dumper';warn "data = ", Dumper(), "\n";h

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

if has("autocmd")
  au BufRead *.sxp,*.lisp call LispStuff()
  au BufRead *.html,*.svg,*.tmpl,*.sql call HTMLStuff()
  au BufRead *.js,*.jade call JavaScriptStuff()
  au BufRead *.json call JSONStuff()
  au BufRead *.pod call PODStuff()
  au BufRead *.pl,*.pm,*.PL call PerlStuff()
endif

function GetPerlFold() 
   if getline(v:lnum) =~ '^\s*sub' 
      return ">1" 
   elseif getline(v:lnum + 2) =~ '^\s*sub' && getline(v:lnum + 1) =~ '^\s*$' 
      return "<1" 
   else 
      return "=" 
   endif 
endfunction 

function JavaScriptStuff()
    set et
    set ts=2
    set sw=2
    set tw=0
    set equalprg=jslint

    " REM (comment) out highlighted section
    map ,r :s/^/\/\//

    " Un-REM
    map ,u :s/^\/\///

    map ,c :w ! jslint -process %

endfunction

function JSONStuff()
    set et
    set ts=2
    set sw=2
    set tw=0
    set equalprg=jsonlint

    map ,c :w ! jsonlint %
endfunction

function HTMLStuff()
    set et
    set ts=2
    set sw=2
    set tw=0
    set equalprg=tidy
endfunction

function LispStuff()
    set et
    set ts=2
    set sw=2
    set tw=0
    set equalprg=lisp
    set showmatch
    set matchtime=1
endfunction

function PODStuff()
    set et
    set ts=2
    set sw=2
    set tw=70
endfunction

function PerlStuff()
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

endfunction

" Toggle Spell Check
map ,s :call Toggle_spell()
function Toggle_spell()
    if has("spell")
        set spell!
    else
        set spell
    endif
endfunction
