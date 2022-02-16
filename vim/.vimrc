"
" vimrc -- Debería funcionar para Windows/Linux con/sin GUI
"

" Cuando vim se inicia como evim, evim.vim, con seguridad ya ha hecho su trabajo.
if v:progname =~? "evim"
  finish
endif

" TODO: Analizar lo que hace defaults.vim para ver que opciones no aplican !
" Establecer las características por defecto que la mayoría de usuarios desean.
source $VIMRUNTIME/defaults.vim

" TODO: Analizar lo que hace mswin.vim para ver que opciones no aplican !
source $VIMRUNTIME/mswin.vim
behave mswin

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









set number						" Enable line numbering (nu)
set cursorline					" Resalta la línea actual
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

" Habilitar listchars para que los invisibles se vean bien cuando se revelen.
set listchars=eol:¶,tab:└─▷,nbsp:▧,trail:∘,precedes:◀,extends:▶
if has('patch-7.4.710')
	set listchars+=lead:∘
	set listchars+=space:∙			" No que no mi Bram !!
endif
" Caracter para mostrar cuando se habilita el wrapping
let &showbreak = '↳'
" Caracter para las diviciones horizontales...
set fillchars-=vert:\|		" Quitamos el pipe si lo hubiese
set fillchars+=vert:\│		" y Agregamos un unicode mejor!

" Enable Listing or not invisible characters in different   modes   
nnoremap <F4> :set list! list?<CR>
inoremap <F4> <C-o>:set list!<CR>
cnoremap <F4> <C-c>:set list!<CR>
vnoremap <F4> :set list!<CR>

" Permitir que el mouse se pueda utilizar en la terminal
" TODO: Esto como que no funciona muy bien en la terminal... Investigar
set mouse=a


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
"set guifont=Cascadia_Code_PL_ExtraLight:h14:W100:cANSI:qDRAFT
"set guifont=Cascadia_Code_PL_SemiLight:h12:W350:cANSI:qDRAFT
"set guifont=Cascadia_Code_PL:h12:cANSI:qDRAFT
set guifont=Cascadia_Code_PL:h14:cANSI:qDRAFT

"set guifont=CaskaydiaCove_NF:h14:cANSI:qDRAFT
"set guifont=FiraCode_NF:h14:W200:cANSI:qDRAFT

nmap <silent> <leader>gf :set guifont=*<CR>

"enable ligatures
set encoding=utf-8
"set renderoptions=type:directx,geom:1,renmode:5,taamode:1
"set renderoptions=type:directx,gamma:1.0,constrast:0.5,level:1,geom:1,renmode:4,taamode:1
set renderoptions=type:directx,gamma:1.0,level:1,geom:1,renmode:4,taamode:1

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
"set background=dark
"colorscheme slate








" Plugins
call plug#begin( '~/vimfiles/plugged' )

	" Temas
	Plug 'morhetz/gruvbox'					" GruvBox color theme
	Plug 'arcticicestudio/nord-vim'			" Nord color therme

	" Plugins 
	Plug 'tpope/vim-repeat'					" Repetir inteligente
	Plug 'tpope/speeddating'				" Aumentar/Disminuir fechas
	Plug 'tpope/vim-surround'				" Acciones alrrededor
	Plug 'vim-airline/vim-airline'			" Línea de estado mejorada
	Plug 'vim-airline/vim-airline-themes'	" Línea de estado mejorada
	Plug 'junegunn/goyo.vim'				" Distraction free Vim
	Plug 'junegunn/limelight.vim'			" Focus on current
	Plug 'mechatroner/rainbow_csv'			" Usar archivos tipo CSV

	" Otros
	Plug 'sts10/vim-closed-captioning'		" Manipulación de .srt's

call plug#end()

set background=dark
set background=light

let g:gruvbox_transparent_bg=1				" Con fondo transparente?
let g:gruvbox_contrast_light='soft'			" Mejor contraste para ligth
let g:gruvbox_contrast_hard='hard'			" Mejor contraste para hard
let g:gruvbox_number_column='bg0'			" Color de la línea actual

colorscheme gruvbox
"colorscheme nord

set noshowmode								" No mostrar el mode de vim
set laststatus=2							" Mostrar siempre la línea de estado

"	Airline - Configuración
let g:airline_powerline_fonts=1				" Mostrar símbolos cool !
let g:airline_experimental=1				" Usar Vim9 language !
let g:airline#extensions#tabline#enabled = 1
let g:airline_statusline_ontop=0
let g:airline_skip_empty_sections=1
let g:airline_theme='gruvbox'
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'
let g:airline_solarized_dark_inactive_background=1 
let g:airline_solarized_dark_inactive_border=1
"let airline_solarized_enable_command_color=1

"	Goyo + Limelight - Configuración
let g:goyo_width = 72
let g:limelight_default_coefficient=0.8
"let g:limelight_paragraph_span = 1

map <leader>gy :Goyo<CR>
map <leader>ll :Limelight!!<CR>
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!


"set statusline=						" TODO: Definir un statusline... pero esto como influye con vim-airline????
set norelativenumber






"	Atòn Kayé
