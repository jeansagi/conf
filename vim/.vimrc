"
" vimrc -- Debería funcionar para Windows/Linux con/sin GUI
"

"
" VER: http://www.sromero.org/wiki/linux/aplicaciones/manual_vim
"	   https://www.marblestation.com/?p=910
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
	" Para lo que sigue es necesario crear un 
	" directorio .vim en $HOME si no existe
	if !isdirectory($HOME."/.vim")
		call mkdir($HOME."/.vim", "", 0770)
	endif

	" Undo Persistente (incluso después de cerrar el archivo editado)
	if has('persistent_undo')
		" Crear un directorio para archivos undo si no existiere
		if !isdirectory($HOME."/.vim/undo-dir")
			call mkdir($HOME."/.vim/undo-dir", "", 0700)
		endif
		" Permitir un archivo para deshacer (incluso después de cerrar)
		set undodir=~/.vim/undo-dir//,.
		set undofile
	endif

	" Archivos de Backup (permite retaurar una versión anterior)
	" Crear un directorio para archivos de backup si no existiere
	if !isdirectory($HOME."/.vim/backup-dir")
		call mkdir($HOME."/.vim/backup-dir", "", 0700)
	endif
	set backupdir=~/.vim/backup-dir//,.
	set backup

	" Archivos de Swap
	" Crear un directorio para archivos de swap si no existiere
	if !isdirectory($HOME."/.vim/swap-dir")
		call mkdir($HOME."/.vim/swap-dir", "", 0700)
	endif
	set directory=~/.vim/swap-dir//,.
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


set updatetime=100				" Actualizar con más frecuencia! (ej:GitGutter)
set history=10000				" Una buena historia !
set number						" habilitar números de línea (nu)
set relativenumber				" Order de numeración natural!
set cursorline					" Resalta la línea actual
set cursorlineopt=number		" Pero solo el número de línea (culopt=both, resalta todo)
set nocursorcolumn				" No resalta la columna actual
set colorcolumn=0				" No definir columna de margen
set nolist						" Disable showing invisible characters
set nowrap						" Long lines don't go to next line
set nolinebreak					" Word on the right border cut if wrapping enabled
set tabstop=4					" Tabs equals 4 spaces (ts)
set softtabstop=4				" when hitting <BS>, pretend like a tab is removed, even if spaces
set shiftwidth=4				" number of spaces to use for autoindenting
set shiftround					" use multiple of shiftwidth when indenting with '<' and '>'
set backspace=indent,eol,start	" allow backspacing over everything in insert mode
set autoindent					" always set autoindenting on
set copyindent					" copy the previous indentation on autoindenting
set confirm						" En operaciones de archivo pide confirmación en lugar de fallar
set diffopt-=inline:simple		" Si existiese inline:simple se quita.
set diffopt+=inline:char		" Mejora resaltar las diferencias al comparar (char > word)!

set hlsearch					" Enable search highlighting
set incsearch					" Enable incremental searching while typing
set showmatch					" Enable showing matching parenthesis
set ignorecase					" Enable case insensitive search
set smartcase					" Enable ignoring case if all lowercase pattern used, don't otherwise

set showmode					" Show editing mode
set hidden						" Esconder buffers aunque estén 'sucios'

set	scrollfocus					" Desplaza el buffer bajo el mouse (así no sea el activo)
set scrolloff=0					" No dejar lineas fijas al desplazar
set smoothscroll				" Better scroll <<<? 
set display=lastline			" @@@ at the end of the lastline 

set splitbelow					" Splits horizontales hacia abajo
set splitright					" Splits verticales hacia la derecha
" Cambio entre Splits:
"	Alt-← : Ir al split de la izquierda
"	Alt-↓ : Ir al split de la abajo
"	Alt-↑ : Ir al split de la arriba
"	Alt-→ : Ir al split de la derecha
if has("gui_running")
	" Command mode
	nnoremap <silent> <A-Left> :wincmd h<CR>
	nnoremap <silent> <A-Down> :wincmd j<CR>
	nnoremap <silent> <A-Up> :wincmd k<CR>	
	nnoremap <silent> <A-Right> :wincmd l<CR>

	" Insert mode
	inoremap <silent> <A-Left> <C-o>:wincmd h<CR>
	inoremap <silent> <A-Down> <C-o>:wincmd j<CR>
	inoremap <silent> <A-Up> <C-o>:wincmd k<CR>
	inoremap <silent> <A-Right> <C-o>:wincmd l<CR>
endif

let mapleader=","				" Maps default leader '\' to ','
let maplocaleader="\\"			" Set local leader to Backslash

"Complements / and ? with to \v -> Very Magic !!
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v

" Busca el patrón ([<ip>])...
"	Bueno en realidad ([<<num>.<num>.<num>.<num>>]) que es casi casi...
nnoremap <silent> <leader>ip /([\d\+\.\d\+\d\+\.\d\+\.\d\+\])<CR>:noh<CR>

" Des-ilumina la última búsqueda
nnoremap <silent> <leader>. :noh<CR>

syntax on						" Enable Color Syntax Highlighting (syn)


" guioptions options
if has('win32') || has("win64") || has("win16")
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

	" Fix the shell to something windows-sensible if indeed we're on windows
	if &shell=~#'bash'
		set shell=$COMSPEC
	endif
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

" TODO:	Revisar como funciona vimgrep
"		Revisar como funciona las QuickLists... Quickfix?
"		Revisar shortcuts para Spell: ]s [s zg z=

" --- --- ---

"
" Temporal?
"
set noeb
set vb
set t_vb=

"set guifont=Consolas:h12:cANSI

"set guifont=Cascadia_Code_PL_ExtraLight:h12:W200:cANSI:qDRAFT
"set guifont=Cascadia_Code_PL_ExtraLight:h14:W100:cANSI:qDRAFT
"set guifont=Cascadia_Code_PL_SemiLight:h12:W350:cANSI:qDRAFT
"set guifont=Cascadia_Code_PL:h12:cANSI:qDRAFT
"set guifont=Cascadia_Code_PL:h14:cANSI:qDRAFT

"set guifont=CaskaydiaCove_NF:h14:cANSI:qDRAFT
"set guifont=FiraCode_NF:h14:W200:cANSI:qDRAFT
"set guifont=FiraCode_NF:h14:W500:cANSI:qDRAFT
"set guifont=FiraCode_NF:h11:cANSI:qDRAFT
"set guifont=FiraCode_NFM:h12:cANSI:qDRAFT
set guifont=FiraCode_Nerd_Font_Mono:h12:cANSI:qDRAFT

nmap <silent> <leader>gf :set guifont=*<CR>

"enable ligatures
set encoding=utf-8
"set renderoptions=type:directx,geom:1,renmode:5,taamode:1
"set renderoptions=type:directx,gamma:1.0,constrast:0.5,level:1,geom:1,renmode:4,taamode:1
"set renderoptions=type:directx,gamma:1.0,level:1,geom:1,renmode:4,taamode:1
set renderoptions=type:directx,gamma:2.0,level:1,geom:1,renmode:5,taamode:1

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
call plug#begin()

	" Temas
	Plug 'morhetz/gruvbox'					" GruvBox color theme
	Plug 'arcticicestudio/nord-vim'			" Nord color therme

	" Plugins 
	Plug 'tpope/vim-repeat'					" Repetir inteligente
	Plug 'tpope/vim-speeddating'			" Aumentar/Disminuir fechas
	Plug 'tpope/vim-surround'				" Acciones alrrededor
	Plug 'tpope/vim-commentary'				" Comentarios
	Plug 'tpope/vim-fugitive'				" So awesome it should be illegal
	Plug 'vim-airline/vim-airline'			" Línea de estado mejorada
	Plug 'vim-airline/vim-airline-themes'	" Línea de estado mejorada
	Plug 'junegunn/goyo.vim'				" Distraction free Vim
	Plug 'junegunn/limelight.vim'			" Focus on current
	Plug 'junegunn/vim-peekaboo'			" Easier register handling
	Plug 'mechatroner/rainbow_csv'			" Usar archivos tipo CSV
	Plug 'szw/vim-maximizer'				" Maximizar el split activo
	Plug 'jlanzarotta/bufexplorer'			" Explorador de Buffers
	Plug 'airblade/vim-gitgutter'			" Modificaciones por Git
	Plug 'godlygeek/tabular'				" Alineación con base a patrón
	Plug 'mg979/vim-visual-multi'			" Múltiples cursores como en Sublime/Code

	" Otros
	Plug 'sts10/vim-closed-captioning'		" Manipulación de .srt's

call plug#end()

"set background=dark
set background=light

" Mapeos para cambiar entre fondo claro y oscuro
"
" 1era. Opción: Usando if then else endif
"nnoremap <silent> <F12> :if &bg=='dark'<Bar>set bg=light<Bar>else<Bar>set bg=dark<Bar>endif<CR>
"
" 2da.  Opción: Usando  <Expr> ? <Action if-true> : <Action if-false>
" Me gusta más esta opción me parece mas limpia.
nnoremap <silent> <expr> <F12> &bg=='dark' ? ':set bg=light<CR>' : ':set bg=dark<CR>'


" Mapeos para abrir archivos
nnoremap <silent> <F9> :browse confirm e<CR>
inoremap <silent> <F9> <C-o>:browse confirm e<CR>

" Mapeo para reseleccionar texto recién pegado
nnoremap gp `[v`]

" Que se puedan abrir archivos con espacios en el nombre con gf
set isfname+=32

"Permite cambiar / por \ en un rango.
command! -range Bslash <line1>,<line2>s;/;\\;g
"O viceversa!
command! -range Fslash <line1>,<line2>s;\\;/;g
"Mapeos para ello
vnoremap ,b :Bslash<CR>:noh<CR>
vnoremap ,f :Fslash<CR>:noh<CR>

"	gruvbox - Configuración
let g:gruvbox_transparent_bg=1				" Con fondo transparente?
let g:gruvbox_contrast_light='hard'			" Mejor contraste para ligth
let g:gruvbox_contrast_dark='hard'			" Mejor contraste para hard
let g:gruvbox_number_column='bg0'			" Color del fondo de la línea actual
let g:gruvbox_italic=1						" Habilitar itálicas

" Try to set gruvbox if available else morning
try
	colorscheme gruvbox
	"colorscheme nord
catch
	colorscheme morning
endtry

set noshowmode								" No mostrar el mode de vim
set laststatus=2							" Mostrar siempre la línea de estado

"	Airline - Configuración
let g:airline_powerline_fonts=1				" Mostrar símbolos cool !
let g:airline_experimental=1				" Usar Vim9 language !
let g:airline#extensions#tabline#enabled = 1
let g:airline_statusline_ontop=0
let g:airline_skip_empty_sections=1
let g:airline_theme='gruvbox'
"let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'
let g:airline_solarized_dark_inactive_background=1 
let g:airline_solarized_dark_inactive_border=1
"let airline_solarized_enable_command_color=1

"	Goyo + Limelight - Configuración
let g:goyo_width = 72
let g:limelight_default_coefficient=0.8
"let g:limelight_paragraph_span = 1

"	Maximizer - Configuración
let g:maximizer_default_mapping_key = '<F11>'

map <leader>gy :Goyo<CR>
map <leader>ll :Limelight!!<CR>
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" Vim-GitGutter - Configuración
nmap { <Plug>(GitGutterPrevHunk)
nmap } <Plug>(GitGutterNextHunk)

" Tabular Configuración
inoremap <buffer><silent> <Bar> <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/\\\@<!|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

" Al abrir un URL con gx esto hace que se use toda la URL... creo!?
let g:netrw_gx="<cWORD>"


" set statusline=						// TODO: Definir un statusline... pero esto como influye con vim-airline????

" Spell languages
set spelllang+=es

" Reload file automatically if changed outside while in vim
set autoread


"
" Revisar si esto vale la pena agregarlo el día de mañana... Tal vez matchit? 
"
" packadd! matchit
" packadd! editorconfig
"

"
"	Atón Kayé
"
