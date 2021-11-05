"
" vimrc -- Debería funcionar para Windows/Linux con/sin GUI
"

"
" Los siguientes 2 bloques se comentan ya que esto está incluido en defaults.vim
"
" <<< INICIO
"
" " Use Vim settings, rather than Vi settings (much better!).
" " This must be first, because it changes other options as a side effect.
" " Avoid side effects when it was already reset.
" if &compatible
	" set nocompatible
" endif
" 
" " When the +eval feature is missing, the set command above will be skipped.
" " Use a trick to reset compatible only when the +eval feature is missing.
" silent! while 0
	" set nocompatible
" silent! endwhile
"
" FIN >>>
"

" Cuando vim se inicia como evim, evim.vim, con seguridad ya ha hecho su trabajo.
if v:progname =~? "evim"
  finish
endif

" TODO: Analizar lo que hace defaults.vim para ver que opciones no aplican !
" Establecer las características por defecto que la myoría de usuarios desean.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" vms no implementa backups. Hay que usar versiones
else
  set backup		" Permitir backup (permite retaurar una versión anterior)
  if has('persistent_undo')
    set undofile	" Permitir un archivo para deshacer (incluso después de cerrar)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Habilitar resaltado del último patrón de busqueda
  set hlsearch
endif

"
" No veo como esto sea una opción que le guste a todos los usuarios de VIM !!
"
" " Put these in an autocmd group, so that we can delete them easily.
" " Poner esto en un grupo de automcmd, de forma que se pueda borrar facilmente
" augroup vimrcEx
"   au!
" 
"   " Para todos los archivos de texto establecer 'textwidth' a 78 caracteres
"   autocmd FileType text setlocal textwidth=80
" augroup END
"
"
"

" Añadir paquetes opcionales.
"
" El plugin matchit hace que el comando % funcione mejor, pero no es compatible
" hacia atrás.
" El signo ! significa que el paquete no será cargado de inmediato sino cuando
" se carguen los plugins durante la inicialización.
if has('syntax') && has('eval')
  packadd! matchit
endif

"
" TODO:	Agregar el comportamiento de mswin.vim
"		Creo que se puede ver en el _vimrc de 'Crystal'
"







set number						" Enable line numbering (nu)
set nolist						" Disable showing invisible characters
set nowrap						" Long lines don't go to next line
set tabstop=4					" Tabs equals 4 spaces (ts)
set softtabstop=4				" when hitting <BS>, pretend like a tab is removed, even if spaces
set shiftwidth=4				" number of spaces to use for autoindenting
set shiftround					" use multiple of shiftwidth when indenting with '<' and '>'
set backspace=indent,eol,start	" allow backspacing over everything in insert mode
set autoindent					" always set autoindenting on
set copyindent					" copy the previous indentation on autoindenting

set hlsearch					" Enable search highlighting
set incsearch					" Enable incremental searching while typing
set showmatch					" Enable showing matching parenthesis
set ignorecase					" Enable case insensitive search
set smartcase					" Enable ignoring case if all lowercase pattern used, don't otherwise

set showmode					" Show editing mode

syntax on						" Enable Color Syntax Highlighting (syn)

let mapleader=","				" Maps default leader '\' to ','
let maplocaleader="\\"			" Set local leader to Backslash









" guioptions options
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

" Enable Listing or not invisible characters in different modes
nnoremap <F4> :set list! list?<CR>
inoremap <F4> <C-o>:set list!<CR>
cnoremap <F4> <C-c>:set list!<CR>
vnoremap <F4> :set list!<CR>


" TODO:	* Seguir revisando c:\\Program\ Files\\Git\\usr\\share\\vim\\vim82\\defaults.vim
"		- Cuando ya se termine .vimrc (o al menos cuando esté adelantado), trabajar en .gvimrc...
" 

" --- --- ---

"
" Temporal
"
set noeb
set vb
set t_vb=

"set guifont=Consolas:h12:cANSI
"set guifont=Cascadia_Code_PL_ExtraLight:h12:W200:cANSI:qDRAFT
set guifont=Cascadia_Code_PL_ExtraLight:h14:W200:cANSI:qDRAFT

nmap <silent> <leader>gf :set guifont=*<CR>

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





"	Atòn Kayé
