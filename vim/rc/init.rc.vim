"---------------------------------------------------------------------------
" Initialize:
"

if exists('&regexpengine')
  " Use old regexp engine.
  " set regexpengine=1
endif

" Use English interface.
if IsWindows()
  " For Windows.
  language message en
else
  " For Linux.
  language message C
endif

" Use ',' instead of '\'.
" Use <Leader> in global plugin.
let g:mapleader = ','
" Use <LocalLeader> in filetype plugin.
let g:maplocalleader = 'm'

" Release keymappings for plug-in.
nnoremap ;  <Nop>
xnoremap ;  <Nop>
nnoremap m  <Nop>
xnoremap m  <Nop>
nnoremap ,  <Nop>
xnoremap ,  <Nop>

if IsWindows()
  " Exchange path separator.
  set shellslash
endif

let $CACHE = expand('~/.cache')

if !isdirectory(expand($CACHE))
  call mkdir(expand($CACHE), 'p')
endif

" Set augroup.
augroup MyAutoCmd
  autocmd!
augroup END

if filereadable(expand('~/.secret_vimrc'))
  execute 'source' expand('~/.secret_vimrc')
endif

if has('vim_starting') "{{{
  " Set runtimepath.
  if IsWindows()
    let &runtimepath = join([
          \ expand('~/.vim'),
          \ expand('$VIM/runtime'),
          \ expand('~/.vim/after')], ',')
  endif

  " Load neobundle.
  let s:neobundle_dir = finddir('neobundle.vim', '.;')
  if s:neobundle_dir != ''
    execute 'set runtimepath^=' .
          \ fnamemodify(s:neobundle_dir, ':p')
  elseif &runtimepath !~ '/neobundle.vim'
    let s:neobundle_dir = expand('$CACHE/neobundle').'/neobundle.vim'

    if !isdirectory(s:neobundle_dir)
      execute printf('!git clone %s://github.com/Shougo/neobundle.vim.git',
            \ (exists('$http_proxy') ? 'https' : 'git'))
            \ s:neobundle_dir
    endif

    execute 'set runtimepath^=' . s:neobundle_dir
  endif
endif
"}}}

let g:neobundle#default_options = {}
" let g:neobundle#default_options._ = { 'verbose' : 1, 'focus' : 1 }

"---------------------------------------------------------------------------
" Disable default plugins

" Disable menu.vim
if has('gui_running')
  set guioptions=Mc
endif

" Disable GetLatestVimPlugin.vim
if !&verbose
  let g:loaded_getscriptPlugin = 1
endif

let g:loaded_netrwPlugin = 1
let g:loaded_matchparen = 1
let g:loaded_2html_plugin = 1
let g:loaded_vimballPlugin = 1
