" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

" NERDTree
noremap <C-N><C-N> :NERDTreeToggle<CR>
noremap <C-N><C-F> :NERDTreeFind<CR>
noremap <C-N><C-M> :NERDTreeClose<CR>
let NERDTreeShowHidden = 1
let NERDTreeQuitOnOpen = 1

if v:version > 701
  let &colorcolumn=join(range(81, 272),",")
endif

syntax on
colorscheme sublimemonokai

set number
set expandtab shiftwidth=2 softtabstop=2 smarttab
set foldmethod=manual
set hls
set list " Mark tabs, EOL, trailing whitespace, etc
exec "set listchars=tab:--,trail:\uB7,nbsp:~,eol:↓,extends:>,precedes:<,space:\uB7"

nmap <C-S-T> :call <SID>SynStack()<CR>

function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif

  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

filetype on                 " Enable filetype detection
filetype plugin on          " Enable filetype dection for plugins
filetype indent on          " Enable indention by filetype
syntax   enable             " Turn on syntax highlighting

" Auto-backup files and .swp files don't go to pwd
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set undodir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set clipboard=unnamed

autocmd Filetype php setlocal ts=4 sw=4 expandtab

" INDENT LINE: draw lines every intention
" Custom color
let g:indentLine_color_term = 239
" enables them by default
let g:indentLine_enabled = 1
" By default, every indent level gets a `|`. This will give a different character for each level of indent
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

"let g:vim_jsx_pretty_colorful_config = 1 " default 
"let g:vim_jsx_pretty_template_tags = ['html', 'raw']
"let g:vim_jsx_pretty_highlight_close_tag = 1

" CTRL-P
map <leader>j :CtrlPBuffer<cr>
let g:ctrlp_custom_ignore = 'node_modules\|DS_STORE\|git\|vendor\|public'
let g:ctrlp_working_path_mode = 'ra'

if executable('ag')
  nnoremap <Leader>a :Ack!<Space>
  let g:ackprg = 'ag --nogroup --nocolor --column'
endif

" Ack searching
map <leader>a :Ack!<space>

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
let g:syntastic_enable_signs  = 1
"let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers=['eslint']
"let g:syntastic_javascript_eslint_exe='node_modules/.bin/eslint'
"let g:syntastic_javascript_eslint_exe='$(npm bin)/eslint'
"let g:syntastic_javascript_eslint_exe = 'npm run lint --'

" Airline
let g:airline#extensions#syntastic#enabled  = 1
set laststatus=2            " Always show the statusline; must be on for airline
let g:airline#extensions#tagbar#enabled = 0 " IF you have Tagbar installed
let g:airline#extensions#whitespace#enabled = 1

