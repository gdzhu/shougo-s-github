"---------------------------------------------------------------------------
" Plugin:
"

" changelog.vim"{{{
autocmd MyAutoCmd BufNewFile,BufRead *.changelog setf changelog
let g:changelog_timeformat = "%Y-%m-%d"
let g:changelog_username = "Shougo "
"}}}

" python.vim
let python_highlight_all = 1

" netrw.vim"{{{
let g:netrw_list_hide= '*.swp'
" Change default directory.
set browsedir=current
"}}}

if neobundle#tap('deoplete.nvim') && has('nvim') "{{{
  let g:deoplete#enable_at_startup = 1
  let neobundle#hooks.on_source =
        \ '~/.vim/rc/plugins/deoplete.rc.vim'

  call neobundle#untap()
endif "}}}

if neobundle#tap('neocomplete.vim') && has('lua') "{{{
  let g:neocomplete#enable_at_startup = 1
  let neobundle#hooks.on_source =
        \ '~/.vim/rc/plugins/neocomplete.rc.vim'

  call neobundle#untap()
endif "}}}

if neobundle#tap('neocomplcache.vim') "{{{
  let g:neocomplcache_enable_at_startup = 0
  let neobundle#hooks.on_source =
        \ '~/.vim/rc/plugins/neocomplcache.rc.vim'

  call neobundle#untap()
endif "}}}

if neobundle#tap('neosnippet.vim') "{{{
  let neobundle#hooks.on_source =
        \ '~/.vim/rc/plugins/neosnippet.rc.vim'

  call neobundle#untap()
endif "}}}

if neobundle#tap('echodoc.vim') "{{{
  let g:echodoc_enable_at_startup = 1

  call neobundle#untap()
endif "}}}

if neobundle#tap('vimshell.vim') "{{{
  " <C-Space>: switch to vimshell.
  nmap <C-@>  <Plug>(vimshell_switch)
  nnoremap !  q:VimShellExecute<Space>
  nnoremap [Space]i  q:VimShellInteractive<Space>
  nnoremap [Space]t  q:VimShellTerminal<Space>

  let neobundle#hooks.on_source =
        \ '~/.vim/rc/plugins/vimshell.rc.vim'

  call neobundle#untap()
endif "}}}

if neobundle#tap('vinarise.vim') "{{{
  let g:vinarise_enable_auto_detect = 1

  call neobundle#untap()
endif "}}}

if neobundle#tap('unite.vim') "{{{
  " The prefix key.
  nnoremap    [unite]   <Nop>
  xnoremap    [unite]   <Nop>
  nmap    ;u [unite]
  xmap    ;u [unite]

  nnoremap <silent> ;b
        \ :<C-u>Unite -buffer-name=build`tabpagenr()` -no-quit build<CR>
  nnoremap <silent> ;t
        \ :<C-u>Unite -buffer-name=test`tabpagenr()` -no-quit build::test<CR>
  nnoremap <silent> ;o
        \ :<C-u>Unite outline -no-start-insert -resume<CR>
  nnoremap <silent> ;t
        \ :<C-u>UniteWithCursorWord -buffer-name=tag tag tag/include<CR>
  xnoremap <silent> ;r
        \ d:<C-u>Unite -buffer-name=register
        \ -default-action=append register history/yank<CR>
  nnoremap <silent> <C-k>
        \ :<C-u>Unite change jump<CR>
  nnoremap <silent> ;g
        \ :<C-u>Unite grep -buffer-name=grep`tabpagenr()`
        \ -auto-preview -no-split -no-empty -resume<CR>
  nnoremap <silent> ;r
        \ :<C-u>Unite -buffer-name=register
        \ -default-action=append register history/yank<CR>

  " <C-t>: Tab pages
  nnoremap <silent> <C-t>
        \ :<C-u>Unite -auto-resize -select=`tabpagenr()-1` tab<CR>

  nnoremap <silent> [Window]s
        \ :<C-u>Unite -buffer-name=files -no-split -multi-line -unique -silent
        \ jump_point file_point file_mru
        \ `finddir('.git', ';') != '' ? 'file_rec/git' : 'file_rec/async'`
        \ buffer_tab:- file file/new<CR>

  nnoremap <silent> [Window]r
        \ :<C-u>Unite -start-insert ref/`ref#detect()`<CR>
  nnoremap <silent> [Window]<Space>
        \ :<C-u>Unite -buffer-name=files -path=~/.vim/rc file_rec<CR>
  nnoremap <silent> [Window]n
        \ :<C-u>Unite -start-insert -default-action=lcd neobundle<CR>
  nnoremap <silent> [Window]g
        \ :<C-u>Unite -start-insert ghq<CR>
  nnoremap <silent> [Window]t
        \ :<C-u>Unite -start-insert tig<CR>

  nnoremap <silent> [Window]f
        \ :<C-u>Unite <CR>

  nnoremap <silent> <C-w>
        \ :<C-u>Unite window:all:no-current<CR>
  nnoremap <silent> [Space]b
        \ :<C-u>UniteBookmarkAdd<CR>

  " t: tags-and-searches "{{{
  " The prefix key.
  nnoremap    [Tag]   <Nop>
  nmap    t [Tag]
  " Jump.
  " nnoremap [Tag]t  g<C-]>
  nnoremap <silent><expr> [Tag]t  &filetype == 'help' ?  "g\<C-]>" :
        \ ":\<C-u>UniteWithCursorWord -buffer-name=tag -immediately
        \  tag tag/include\<CR>"
  nnoremap <silent><expr> [Tag]p  &filetype == 'help' ?
        \ ":\<C-u>pop\<CR>" : ":\<C-u>Unite jump\<CR>"
  "}}}

  " Execute help.
  nnoremap <silent> <C-h>  :<C-u>Unite -buffer-name=help help<CR>

  " Execute help by cursor keyword.
  nnoremap <silent> g<C-h>  :<C-u>UniteWithCursorWord help<CR>

  " Search.
  nnoremap <silent> /
        \ :<C-u>Unite -buffer-name=search%`bufnr('%')`
        \ -start-insert line:forward:wrap<CR>
  nnoremap <silent> ?
        \ :<C-u>Unite -buffer-name=search%`bufnr('%')`
        \ -start-insert line:backward<CR>
  nnoremap <silent> *
        \ :<C-u>UniteWithCursorWord -buffer-name=search%`bufnr('%')`
        \ line:forward:wrap<CR>
  nnoremap [Alt]/       /
  nnoremap [Alt]?       ?

  nnoremap <silent> n
        \ :<C-u>UniteResume search%`bufnr('%')`
        \  -no-start-insert -force-redraw<CR>

  let neobundle#hooks.on_source =
        \ '~/.vim/rc/plugins/unite.rc.vim'

  call neobundle#untap()
endif "}}}

if neobundle#tap('CamelCaseMotion') "{{{
  nmap <silent> W <Plug>CamelCaseMotion_w
  xmap <silent> W <Plug>CamelCaseMotion_w
  omap <silent> W <Plug>CamelCaseMotion_w
  nmap <silent> B <Plug>CamelCaseMotion_b
  xmap <silent> B <Plug>CamelCaseMotion_b
  omap <silent> B <Plug>CamelCaseMotion_b

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-smartchr') "{{{
  let neobundle#hooks.on_source =
        \ '~/.vim/rc/plugins/smartchr.rc.vim'

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-quickrun') "{{{
  nmap <silent> <Leader>r <Plug>(quickrun)

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-ref') "{{{
  function! neobundle#hooks.on_source(bundle)
    let g:ref_cache_dir = expand('$CACHE/ref')
    let g:ref_use_vimproc = 1
    if IsWindows()
      let g:ref_refe_encoding = 'cp932'
    endif

    " ref-lynx.
    if IsWindows()
      let lynx = 'C:/lynx/lynx.exe'
      let cfg  = 'C:/lynx/lynx.cfg'
      let g:ref_lynx_cmd = s:lynx.' -cfg='.s:cfg.' -dump -nonumbers %s'
      let g:ref_alc_cmd = s:lynx.' -cfg='.s:cfg.' -dump %s'
    endif

    let g:ref_lynx_use_cache = 1
    let g:ref_lynx_start_linenumber = 0 " Skip.
    let g:ref_lynx_hide_url_number = 0

    autocmd MyAutoCmd FileType ref call s:ref_my_settings()
    function! s:ref_my_settings() "{{{
      " Overwrite settings.
      nmap <buffer> [Tag]t  <Plug>(ref-keyword)
      nmap <buffer> [Tag]p  <Plug>(ref-back)
    endfunction"}}}
  endfunction

  call neobundle#untap()
endif"}}}

if neobundle#tap('vimfiler.vim') "{{{
  nnoremap <silent>   [Space]v   :<C-u>VimFiler -invisible<CR>
  nnoremap    [Space]ff   :<C-u>VimFilerExplorer<CR>

  let neobundle#hooks.on_source =
        \ '~/.vim/rc/plugins/vimfiler.rc.vim'

  call neobundle#untap()
endif "}}}

if neobundle#tap('eskk.vim') "{{{
  imap <C-j>     <Plug>(eskk:toggle)
  cmap <C-j>     <Plug>(eskk:toggle)

  let neobundle#hooks.on_source =
        \ '~/.vim/rc/plugins/eskk.rc.vim'

  call neobundle#untap()
endif "}}}

if neobundle#tap('J6uil.vim') "{{{
  function! neobundle#hooks.on_source(bundle)
    let g:J6uil_config_dir = expand('$CACHE/J6uil')
    let g:J6uil_no_default_keymappings = 1
    let g:J6uil_display_offline  = 0
    let g:J6uil_display_online   = 0
    let g:J6uil_echo_presence    = 1
    let g:J6uil_display_icon     = 1
    let g:J6uil_display_interval = 0
    let g:J6uil_updatetime       = 1000
    let g:J6uil_align_message    = 0

    silent! delcommand NeoComplCacheCachingBuffer

    autocmd MyAutoCmd FileType J6uil call s:j6uil_settings()
    autocmd MyAutoCmd FileType J6uil_say call s:j6uil_say_settings()

    function! s:j6uil_settings()
      setlocal wrap
      setlocal nofoldenable
      setlocal foldcolumn=0
      nmap <buffer> o <Plug>(J6uil_open_say_buffer)
      nmap <silent> <buffer> <CR> <Plug>(J6uil_action_enter)
      call neocomplete#initialize()
      NeoCompleteBufferMakeCache
    endfunction

    function! s:j6uil_say_settings()
      setlocal wrap
      setlocal nofoldenable
      setlocal foldcolumn=0
    endfunction
  endfunction

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-operator-surround') "{{{
  nmap <silent>sa <Plug>(operator-surround-append)a
  nmap <silent>sd <Plug>(operator-surround-delete)a
  nmap <silent>sr <Plug>(operator-surround-replace)a
  nmap <silent>sc <Plug>(operator-surround-replace)a

  call neobundle#untap()
endif "}}}

if neobundle#tap('qfreplace.vim') "{{{
  autocmd MyAutoCmd FileType qf nnoremap <buffer> r :<C-u>Qfreplace<CR>

  call neobundle#untap()
endif "}}}

if neobundle#tap('open-browser.vim') "{{{
  nmap gs <Plug>(open-browser-wwwsearch)

  function! neobundle#hooks.on_source(bundle)
    nnoremap <Plug>(open-browser-wwwsearch)
          \ :<C-u>call <SID>www_search()<CR>
    function! s:www_search()
      let search_word = input('Please input search word: ')
      if search_word != ''
        execute 'OpenBrowserSearch' escape(search_word, '"')
      endif
    endfunction
  endfunction

  call neobundle#untap()
endif "}}}

if neobundle#tap('caw.vim') "{{{
  autocmd MyAutoCmd FileType * call s:init_caw()
  function! s:init_caw()
    if !&l:modifiable
      silent! nunmap <buffer> gc
      silent! xunmap <buffer> gc
      silent! nunmap <buffer> gcc
      silent! xunmap <buffer> gcc
    else
      nmap <buffer> gc <Plug>(caw:prefix)
      xmap <buffer> gc <Plug>(caw:prefix)
      nmap <buffer> gcc <Plug>(caw:i:toggle)
      xmap <buffer> gcc <Plug>(caw:i:toggle)
    endif
  endfunction

  call neobundle#untap()
endif "}}}

if neobundle#tap('accelerated-jk') "{{{
  nmap <silent>j <Plug>(accelerated_jk_gj)
  nmap gj j
  nmap <silent>k <Plug>(accelerated_jk_gk)
  nmap gk k

  call neobundle#untap()
endif "}}}

if neobundle#tap('concealedyank.vim') "{{{
  xmap Y <Plug>(operator-concealedyank)

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-gita') "{{{
  nnoremap <silent> [Space]gs  :<C-u>Gita status<CR>
  nnoremap <silent> [Space]gc  :<C-u>Gita commit<CR>
  nnoremap <silent> [Space]gd  :<C-u>Gita diff<CR>

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-choosewin') "{{{
  nmap g<C-w>  <Plug>(choosewin)
  let g:choosewin_overlay_enable = 1
  let g:choosewin_overlay_clear_multibyte = 1
  let g:choosewin_blink_on_land = 0

  call neobundle#untap()
endif "}}}

if neobundle#tap('matchit.zip') "{{{
  function! neobundle#hooks.on_post_source(bundle)
    silent! execute 'doautocmd Filetype' &filetype
  endfunction

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-fontzoom') "{{{
  nmap + <Plug>(fontzoom-larger)
  nmap _ <Plug>(fontzoom-smaller)

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-operator-replace') "{{{
  xmap p <Plug>(operator-replace)

  call neobundle#untap()
endif "}}}

if neobundle#tap('restart.vim') "{{{
  let g:restart_save_window_values = 0
  nnoremap <silent> [Space]re  :<C-u>Restart<CR>

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-niceblock') "{{{
  xmap I  <Plug>(niceblock-I)
  xmap A  <Plug>(niceblock-A)

  call neobundle#untap()
endif "}}}

if neobundle#tap('winmove.vim') "{{{
  nmap <Up>      <Plug>(winmove-up)
  nmap <Down>    <Plug>(winmove-down)
  nmap <Left>    <Plug>(winmove-left)
  nmap <Right>   <Plug>(winmove-right)

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-fullscreen') "{{{
  nmap <C-CR> <Plug>(fullscreen-toggle)

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-textobj-user') "{{{
  omap ab <Plug>(textobj-multiblock-a)
  omap ib <Plug>(textobj-multiblock-i)
  xmap ab <Plug>(textobj-multiblock-a)
  xmap ib <Plug>(textobj-multiblock-i)

  call neobundle#untap()
endif "}}}

if neobundle#tap('glowshi-ft.vim') "{{{
  let g:glowshi_ft_no_default_key_mappings = 1
  map f <Plug>(glowshi-ft-f)
  map F <Plug>(glowshi-ft-F)

  let g:glowshi_ft_timeoutlen = 1000

  call neobundle#untap()
endif "}}}

if neobundle#tap('junkfile.vim') "{{{
  nnoremap <silent> [Window]e  :<C-u>Unite junkfile/new junkfile -start-insert<CR>

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-jplus') "{{{
  nmap J <Plug>(jplus)
  vmap J <Plug>(jplus)

  call neobundle#untap()
endif "}}}

if neobundle#tap('indentLine') "{{{
  let g:indentLine_faster = 1
  nmap <silent><Leader>i :<C-u>IndentLinesToggle<CR>

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-themis') "{{{
  " Set to $PATH.
  let s:bin = neobundle#get('vim-themis').rtp . 'bin'
  let $PATH = neobundle#util#join_envpath(
        \ neobundle#util#uniq(insert(
        \    neobundle#util#split_envpath($PATH), s:bin)), $PATH, s:bin)
  let $THEMIS_HOME = neobundle#get('vim-themis').rtp
  let $THEMIS_VIM = printf('%s/%s',
        \ fnamemodify(exepath(v:progpath), ':h'),
        \ (has('nvim') ? 'nvim' : 'vim'))

  unlet s:bin

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-gista') "{{{
  let g:gista#github_user = 'Shougo'

  call neobundle#untap()
endif "}}}

if neobundle#tap('jedi-vim') "{{{
  autocmd MyAutoCmd FileType python
        \ if has('python') || has('python3') |
        \   setlocal omnifunc=jedi#completions |
        \ else |
        \   setlocal omnifunc= |
        \ endif
  let g:jedi#completions_enabled = 0
  let g:jedi#auto_vim_configuration = 0

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-expand-region') "{{{
  xmap v <Plug>(expand_region_expand)
  xmap <C-v> <Plug>(expand_region_shrink)

  call neobundle#untap()
endif "}}}

if neobundle#tap('racer') "{{{
  let $RUST_SRC_PATH = expand('~/src/rust/src')

  call neobundle#untap()
endif "}}}
