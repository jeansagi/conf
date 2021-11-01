"
" vimrc -- Debería funcionar para Windows/Linux con/sin GUI
"

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
" Avoid side effects when it was already reset.
if &compatible
	set nocompatible
endif

" When the +eval feature is missing, the set command above will be skipped.
" Use a trick to reset compatible only when the +eval feature is missing.
silent! while 0
	set nocompatible
silent! endwhile

" TODO: Seguir revisando c:\\Program\ Files\\Git\\usr\\share\\vim\\vim82\\defaults.vim

" --- --- ---

"
" Temporal
"
set noeb
set vb
set t_vb=

set nowrap
set nu

set hlsearch

"set guifont=Consolas:h12:cANSI
"set guifont=Cascadia_Code_PL_ExtraLight:h12:W200:cANSI:qDRAFT
set guifont=Cascadia_Code_PL_ExtraLight:h14:W200:cANSI:qDRAFT

nmap <silent> <leader>gf :set guifont=*<CR>

syn on
set ts=4

"enable ligatures
set encoding=utf-8
set renderoptions=type:directx,geom:1,renmode:5,taamode:1

"
"----------------------------------------------------
" Inicio: Habilitar gruvbox con colores 24bit
"----------------------------------------------------
"
" The "^[" is a single character. You enter it by pressing Ctrl+v and then ESC.
set t_8f=[38;2;%lu;%lu;%lum
set t_8b=[48;2;%lu;%lu;%lum

" Change the color scheme here.
" HABILITAR LA SIGUIENTE LINEA CUANDO YA SE HAYA ORGANIZADO VIM y se haya instalado GRUVBOX
"colorscheme gruvbox
"colorscheme darkblue
"set background=dark
"colorscheme slate

" Makes the background transparent. Leave these out if you're not using a transparent
" terminal.
highlight Normal ctermbg=NONE guibg=NONE
highlight NonText ctermbg=NONE guibg=NONE

" This is what sets vim to use 24-bit colors. It will also work for any version of neovim
" newer than 0.1.4.
set termguicolors
"
"----------------------------------------------------
" Inicio: Habilitar gruvbox con colores 24bit
"----------------------------------------------------
"
if has("gui_running")
	if has("autocmd")
		autocmd GUIEnter * set vb t_vb=
	endif
endif

"set background=light
"colorscheme morning
set background=dark
colorscheme slate














" Ensayo de la opción guioptions !
if has('win32')
	" Default :				No GUI controls			!
	set guioptions+=a		" Selected text gets copied !

	set guioptions-=m		" No MenuBar			!
	set guioptions-=t		" No scissors on menus	!
	set guioptions-=T		" No ToolBar			!
	set guioptions-=r		" No Right ScrollBar	!
	set guioptions-=b		" No Bottom ScrollBar	!
	set guioptions-=l		" No Left ScrollBar		!

	" Offer mappings to enable/disable gui controls
	"	Ctrl-F1	:	(m)	Enable/Disable MenuBar
	"	Ctrl-F2	:	(T)	Enable/Disable ToolBar
	"	Ctrl-F3	:	(r)	Enable/Disable Right ScrollBar
	"	Ctrl-F4	:	(b)	Enable/Disable Bottom ScrollBar
	"	Ctrl-F5	:	(l)	Enable/Disable Left ScrollBar
	nnoremap <C-F1> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>
	nnoremap <C-F2> :if &go=~#'T'<Bar>set go-=T<Bar>else<Bar>set go+=T<Bar>endif<CR>
	nnoremap <C-F3> :if &go=~#'r'<Bar>set go-=r<Bar>else<Bar>set go+=r<Bar>endif<CR>
	nnoremap <C-F4> :if &go=~#'b'<Bar>set go-=b<Bar>else<Bar>set go+=b<Bar>endif<CR>
	nnoremap <C-F5> :if &go=~#'l'<Bar>set go-=l<Bar>else<Bar>set go+=l<Bar>endif<CR>
endif

