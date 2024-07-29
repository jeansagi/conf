#export TERM=xterm-24bit
export COLORTERM=24bit
export TERM=xterm-direct
#export COLORTERM=truecolor

# Nice colors
eval "$(dircolors)"

# LESS configuration
export LESS="$LESS -R -Q -X -F"

#fzf bash completions and key-bindings
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# https://github.com/sharkdp/fd#using-fd-with-fzf
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='--ansi -e -m --height 80% --layout=reverse --info=inline --border --preview-window right:60% --color "fg:#bbccdd,fg+:#ddeeff,bg:#334455,preview-bg:#223344,border:#778899"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export EDITOR=hvim

# bash aliases
alias c=cd
alias cconf='cd ~/src/conf;cls;tree -d;echo;git status -uall; echo'
alias cbis='cd ~/src/bisionplus;cls;tree -d;echo;git status -uall; echo'
alias cls=clear
#alias ll='ls -la --color=always --show-control-chars --block-size="'\''"1'
alias oll='ls -la --color=always --show-control-chars --block-size="'\''"1'
alias ll='lsd -l'
alias open=explorer
#alias tree=tree.bat
alias tree='lsd --tree'
alias vim=vim.bat
alias gvim=gvim.bat
alias uvim=uvim.bat
#
alias bye=bye.bat
alias rinit=rinit.bat
alias anular=Anular.bat
alias apagar=Apagar.bat
alias cerrar=Cerrar.bat
alias bloquear=Bloquear.bat
alias reiniciar=Reiniciar.bat
alias suspender=Suspender.bat
alias sus=Suspender.bat
alias co=co.bat
alias tping=tping.bat
alias mrauto="/c/Program\ Files/Macrium/Reflect/mrauto.exe"
alias r=r.bat
alias hvim=hvim.bat
alias dr=dr.bat
alias ass="s sysdm.cpl"
alias todo="hvim 'C:/Users/chuch/OneDrive/Desktop/TODO.txt'"
alias cht='cd ~/src/ht'
alias bios='sudo bios.bat'
alias vlc=vlc.bat
alias obs='sudo obs.bat'
alias oracloud='ssh -i ~/.ssh/ssh-key-2022-11-20.key ubuntu@144.22.240.195'
alias 1v=scrcpy.bat
alias evo=git-evo.bat
alias cup=cup.bat
alias ttb='s ttb'
alias rtb='rtb.bat'
alias rt='rt.bat'
alias d=docker
alias up='up.bat'
alias fvl=fvl.bat

#
alias ppath='echo -e PATH =\\t$PATH | sed "s/:/:\n\t/g"'
alias mp=multipass
alias e=explorer
alias s='start ""'
alias cuni='c /c/unix'
alias so=source
alias ecase='shopt -s nocaseglob'
alias dcase='shopt -u nocaseglob'
#
shopt -s nocaseglob

# Use zoxide but not z nor zi instead cd and cdi
eval "$(zoxide init --cmd cd bash)"

#Oh-My-Posh
#clear
#eval "$(oh-my-posh init bash --config ~/.config/ohmyposh/themes/kushal.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/ohmyposh/themes/gruvbox.omp.json)"
eval "$(oh-my-posh init bash --config ~/.config/ohmyposh/themes/night-owl.omp.json)"
#eval "$(oh-my-posh init bash --config ~/.config/ohmyposh/themes/montys.omp.json)"
clear

# functions

f() {
	# TODO	:	As long as f invoques fzf it should support fzf's arguments!
	#			So a part from -c as the first argument for f the rest of f should be passed along to fzf

	#local	fzf_opt='--preview "bat --italic-text=always --style=header,grid,numbers --color=always --theme=Coldark-Dark --line-range :300 {}"' \
	#local	fzf_opt='--preview "bat --italic-text=always --style=full --color=always --theme=Coldark-Dark --line-range :300 {}"' \
	local	fzf_opt='--preview "bat --italic-text=always --style=full -f --theme=gruvbox-dark --line-range :300 {}"' \
			fzf_color=${FZF_DEFAULT_COMMAND} \
			fzf_which \
			fzf_cmd

	if fzf_which="$(command -v fzf)"; then
		fzf_cmd="${fzf_which} ${fzf_opt}"
	else
		echo 'Error: fzf is not accesible and it should if you want to use f.'
		return 1
	fi

	if [ "$1" = "-c" -o "$1" = "--color" ]; then
		if [[ -z "${FZF_DEFAULT_COMMAND}" ]]; then
			# Sensible default if no FZF_DEFAULT_COMMAND env is defined (Asumes fd is installed!)
			fzf_color='fd --type f --color=always'
		else
			# If color option present FZF_DEFAULT_COMMAND respect it otherwise force the use of color
			[[ ! "$FZF_DEFAULT_COMMAND" =~ .*color.* ]] && fzf_color="${FZF_DEFAULT_COMMAND} --color=always"
		fi
	fi

	# "Temporarily" resets FZF_DEFAULT_COMMAND while executing ${fzf_cmd}
	FZF_DEFAULT_COMMAND=${fzf_color} eval ${fzf_cmd}
	return 0
}


# As f return lines, fl returns a single line with every original line quoted!
fl() {
	if [ "$1" == '-q' ]; then
		f "$@" | sed "s/.*/'&'/g" | sed -z "s/\n/ /g"
	else
		if [ "$1" == '-dq' ]; then
			f "$@" | sed 's/.*/"&"/g' | sed -z 's/\n/ /g'
		else
			f "$@" | sed -z "s/\n/ /g"
		fi
	fi

	echo
	return 0
}


#show() { local var=$1; echo $1="${!var}"; }		# No fué TAN fácil esto!!
show() {											# Versión más útil !
	local	green_fg="\e[1;49;92m" \
			green_bg="\e[7;49;92m" \
			red_fg="\e[1;49;91m" \
			cyan_fg="\e[1;49;96m" \
			reset="\e[0m" \
			start="" \
			sep="\t" \
			finish=""

	local	expand=0

	if [[ -z "$@" ]]; then
		echo Error: Nothing to show
		return 1
	fi

	if [ "$1" == '-e' ]; then
		if [ -z "$2" ]; then
			echo Error: Nothing to show
			return 2
		else
			expand=1
			shift
		fi
	fi

	# No se esta línea por que estaba aquí así que se comenta y no se borra
	# por si se ellegara a necesitar!
	# [[ ! "$FZF_DEFAULT_COMMAND" =~ .*color.* ]] && fzf_color="${FZF_DEFAULT_COMMAND} --color=always"

	for arg in "$@"; do
		if [ $expand -eq 1 ] ; then
			arg_upper=${arg^^}
			arg_lower=${arg,,}

			echo -e ${start}${green_fg}${arg}${cyan_fg}=${green_bg}"${!arg}"${reset}${sep}
			echo -e ${start}${green_fg}${arg_upper}${cyan_fg}=${green_bg}"${!arg_upper}"${reset}${sep}
			echo -e ${start}${green_fg}${arg_lower}${cyan_fg}=${green_bg}"${!arg_lower}"${reset}
			echo
		else
			echo -e ${start}${green_fg}${arg}${cyan_fg}=${green_bg}"${!arg}"${reset}${finish}
		fi
	done
	return 0
}


show_colors() {
	#Background
	for clbg in $(seq 40 47) $(seq 100 107) 49 ; do
		#Foreground
		for clfg in $(seq 30 37) $(seq 90 97) 39 ; do
			#Formatting
			for attr in 0 1 2 4 5 7 ; do
				#Print the result
				printf "\e[${attr};${clbg};${clfg}m ^[${attr};${clbg};${clfg}m \e[0m"
			done
			echo #Newline
		done
	done
}


test_24bit_colors() {
	awk 'BEGIN{
	s="/\\/\\/\\/\\/\\"; s=s s s s s s s s;
	for (colnum = 0; colnum<77; colnum++) {
		r = 255-(colnum*255/76);
		g = (colnum*510/76);
		b = (colnum*255/76);
	
		if (g>255) g = 510-g;
			printf "\033[48;2;%d;%d;%dm", r,g,b;
			printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
			printf "%s\033[0m", substr(s,colnum+1,1);
		}
		printf "\n";
	}'
}


#1v() {
#	echo adb tcpip 5555;
#	adb tcpip 5555;
#	echo;
#
#	echo adb connect 192.168.1.2;
#	adb connect 192.168.1.2;
#	echo;
#
#	echo scrcpy.bat;
#	scrcpy.bat
#}


2ac3() {
	if [[ -z "$@" ]]; then
		echo Error: Nothing to convert to ac3
		return 1
	fi
	local	in=${1}	\
			in_name	\
			in_ext	\
			out

	in_name=${in%.*}
	in_ext=${in##*.}
	out=${in_name}_ac3.${in_ext}

	ffmpeg -y -loglevel panic -hwaccel cuda -hwaccel_output_format cuda -threads 3 -i ${in} -map 0 -vcodec copy -scodec copy -acodec ac3 -b:a 640k ${out}

	return 0
}
