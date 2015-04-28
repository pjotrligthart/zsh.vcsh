READNULLCMD=${PAGER:-/usr/bin/pager}

## set variables

XDG_CONFIG_HOME="$HOME/.config"
XDG_CACHE_HOME="$HOME/.cache"

# Source keybindings
source ~/.zshrc.keybindings;

# grep for running process, like: 'any vim'
any() {
	if [[ -z "$1" ]] ; then
		echo "any - grep for process(es) by keyword" >&2
		echo "Usage: any <keyword>" >&2 ; return 1
	else
		local STRING=$1
		local LENGTH=$(expr length $STRING)
		local FIRSCHAR=$(echo $(expr substr $STRING 1 1))
		local REST=$(echo $(expr substr $STRING 2 $LENGTH))
		ps xauwww| grep "[$FIRSCHAR]$REST"
	fi
}

# Source completion settings
source ~/.zshrc.completion;

# ZLE highlighting. Will not work on 4.3.6 or before, but it will not hurt, either
zle_highlight=(isearch:underline)

# make sure our function directories exist and load from them
foreach function_directory (~/.zsh/functions ~/.zsh/functions/hooks); do;
[[ -d $function_directory ]] || print -P "$fg_bold[red]WARNING:$fg_no_bold[default] $function_directory does not exist. Shell functionality will be severely limited!"
done;
fpath+=(~/.zsh/functions ~/.zsh/functions/hooks)
autoload -- ~/.zsh/functions/[^_]*(:t) ~/.zsh/functions/hooks/[^_]*(:t)


RPROMPT="%(?..${fg_light_gray}[$fg_red%U%?%u${fg_light_gray}]$fg_no_colour) %h %D{%T %a %e.%m.%Y}"
#PS2='%_ > '                                     # show for i in 1 2 3 \r foo >
#RPS2="<%^"                                      # _right_ PS2
SPROMPT="zsh: correct '%R' to '%r'? [N/y/a/e] "  # the prompt we see when being asked for substitutions


PATH+=:/usr/bin
PATH=/usr/local/bin:$PATH
[[ -d /usr/lib/ccache ]] && PATH=/usr/lib/ccache:$PATH
[[ -d ~/.bin ]] && PATH=~/.bin:$PATH
[[ -d ~/bin ]] && PATH=~/bin:$PATH
[[ -d /usr/local/vim_extended/bin ]] && PATH=/usr/local/vim_extended/bin:$PATH

watch=(notme)
LOGCHECK=300
WATCHFMT='%n %a %l from %m at %t.'

HISTFILE=~/.zsh_history
SAVEHIST=50000
HISTSIZE=50000

EDITOR="vim"

CORRECT_IGNORE='_*'

if [[ -x $( which less) ]]
export LESS='-Ri'
export LESSCHARSET="utf-8"
then
	export PAGER="less"
	if [[ $terminfo[colors] -ge 8 ]]
	then
		export LESS_TERMCAP_mb=$'\E[01;31m'
		export LESS_TERMCAP_md=$'\E[01;31m'
		export LESS_TERMCAP_me=$'\E[0m'
		export LESS_TERMCAP_se=$'\E[0m'
		export LESS_TERMCAP_so=$'\E[01;44;33m'
		export LESS_TERMCAP_ue=$'\E[0m'
		export LESS_TERMCAP_us=$'\E[01;32m'
	fi
else
	export PAGER="more"
fi

[[ -x $(which colordiff) ]] && alias diff=colordiff

([[ -x $(which w3m) ]]       && export BROWSER="w3m")      || \
([[ -x $(which links2) ]]    && export BROWSER="links2")   || \
([[ -x $(which elinks) ]]    && export BROWSER="elinks")   || \
([[ -x $(which lynx) ]]      && export BROWSER="lynx")     || \
([[ -x $(which links) ]]     && export BROWSER="links")    || \
echo "WARNING: You do not have any browser installed!"

([[ -x $(which vimdiff) ]]   && export DIFFER="vimdiff")   || \
([[ -x $(which colordiff) ]] && export DIFFER="colordiff") || \
([[ -x $(which diff) ]]      && export DIFFER="diff")      || \
echo "WARNING: You do not have any differ installed!"


# Source setopt options
source ~/.zshrc.setopt;




# make ^W on foo | bar delete 'bar', not '| bar'
typeset WORDCHARS='|'$WORDCHARS


# quick editor commands
alias vimrc="$EDITOR ~/.vimrc"
alias zshrc="$EDITOR ~/.zshrc"
alias zshrc.staging="$EDITOR ~/.zshrc.staging"
alias zshrc.local="$EDITOR ~/.zshrc.$HOST"


# shortcuts
alias a='aptitude'
alias ai='aptitude install'
alias as='aptitude search'
alias ass='aptitude show'
alias au='aptitude update'
alias asu='aptitude safe-upgrade'

alias afu='apt-file update'
alias afs='apt-file search'
alias afsl='apt-file -l search'

#alias a=alias
alias ua=unalias

alias ls='ls --color=auto'
alias la='ls -a'
alias ll='ls -l'
alias lll="ll $* | less -r"
alias lh='ls -lh'
alias ld='ls -ld'
alias l='ll'

alias v='vim'

alias sr='screen -r'
alias sdr='screen -D -r'
alias scls='screen -ls'
alias scdr='screen -dr'

#edit without a trace
alias vim-noswap='vim -n -i NONE --cmd "setlocal noswapfile" --cmd "set nocompatible" --cmd "set tabstop=4" -u NONE'

alias dd_status='kill -SIGUSR1 $(pidof dd)'

# various stuff to make the commands more sane
alias mv='nocorrect mv -i'      # prompt before overwriting files
alias mkdir='nocorrect mkdir'   # don't correct mkdir
alias man='nocorrect man'
alias wget='noglob wget'
alias whois='whois -H'
alias gpg='gpg --no-use-agent'
alias grep='grep --color=auto'
alias scp='noglob scp_wrap'
alias vimdiff='vimdiff -O2'

alias why='whence -ca'

# useful to see what hogs your disk (this is so i can actually find this damn alias in here: find disk space)
# this will most likely die soon. ncdu is way better
alias sz='du -ax | sort -n | tail -n 10'

# various stuff from thailand
alias s='sync'
alias dt='dmesg | tail'
alias dh='df -h'
alias dm='df -m'

# ebg13 vf frpher
alias rot13='tr a-zA-Z n-za-mN-ZA-M <<<'

# base64 conversion
alias base64-encode='perl -MMIME::Base64 -e "print encode_base64(<>)" <<<'
alias base64-decode='perl -MMIME::Base64 -e "print decode_base64(<>)" <<<'



# display the ten newest files
alias lsnew="ls -rl *(D.om[1,10])"
# display the ten oldest files
alias lsold="ls -rtlh *(D.om[1,10])"
# display the ten smallest files
alias lssmall="ls -Srl *(.oL[1,10])"

#ssh & scp without security checks
alias ssh-noverify='ssh -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null"'
alias scp-noverify='scp -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null"'

# serial console stuff
alias serial_115200_7bit='screen /dev/ttyUSB0 115200,cs7'
alias serial_2400_8bit_noflow='screen /dev/ttyUSB0 2400,cs8,ixoff'
alias serial_9600_8bit='screen /dev/ttyUSB0 9600,cs8'

# git stuff
alias gcd='git checkout'

# global aliases. use with care!
alias -g C='| wc -l'
alias -g N='1>/dev/null 2>/dev/null'
alias -g E='| egrep'
alias -g G='| grep -i'
alias -g GV='| grep -iv'
alias -g H='| head'
alias -g H1='| head -n1'
alias -g H5='| head -n5'
alias -g H10='| head -n10'
alias -g T='| tail'
alias -g T1='| tail -n1'
alias -g T5='| tail -n5'
alias -g T10='| tail -n10'
alias -g L='| $PAGER'
alias -g V='| vim -'
alias -g X='| xargs'
alias -g      ...=../..
alias -g     ....=../../..
alias -g    .....=../../../..
alias -g   ......=../../../../..
alias -g  .......=../../../../../..
alias -g ........=../../../../../../..

alias -g S='| sort'
alias -g SN='| sort -n'
alias -g SNR='| sort -nr'
alias -g SHR='| sort -Hr'

alias -g A='| awk '
alias -g A1="| awk '{print \$1}'"
alias -g A2="| awk '{print \$2}'"
alias -g A3="| awk '{print \$3}'"
alias -g A4="| awk '{print \$4}'"
alias -g A5="| awk '{print \$5}'"

# named directories

hash -d deb=/var/cache/apt/archives
hash -d doc=/usr/share/doc
hash -d grub=/boot/grub
hash -d log=/var/log
hash -d www=/var/www
hash -d git=$HOME/work/git
hash -d func=$HOME/.zsh/functions
hash -d mr=$XDG_CONFIG_HOME/mr
hash -d repo.d=$XDG_CONFIG_HOME/vcsh/repo.d

# move cursor between chars when typing '', "", (), [], and {}
magic-single-quotes()   { if [[ $LBUFFER[-1] == \' ]]; then zle self-insert; zle .backward-char; else zle self-insert; fi }; bindkey \' magic-single-quotes
magic-double-quotes()   { if [[ $LBUFFER[-1] == \" ]]; then zle self-insert; zle .backward-char; else zle self-insert; fi }; bindkey \" magic-double-quotes
magic-parentheses()     { if [[ $LBUFFER[-1] == \( ]]; then zle self-insert; zle .backward-char; else zle self-insert; fi }; bindkey \) magic-parentheses
magic-square-brackets() { if [[ $LBUFFER[-1] == \[ ]]; then zle self-insert; zle .backward-char; else zle self-insert; fi }; bindkey \] magic-square-brackets
magic-curly-brackets()  { if [[ $LBUFFER[-1] == \{ ]]; then zle self-insert; zle .backward-char; else zle self-insert; fi }; bindkey \} magic-curly-brackets
magic-angle-brackets()  { if [[ $LBUFFER[-1] == \< ]]; then zle self-insert; zle .backward-char; else zle self-insert; fi }; bindkey \> magic-angle-brackets
zle -N magic-single-quotes
zle -N magic-double-quotes
zle -N magic-parentheses
zle -N magic-square-brackets
zle -N magic-curly-brackets
zle -N magic-angle-brackets

# escape URLs automagically
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# "ctrl-e e" : open iZLE buffer in $EDITOR
autoload      edit-command-line
zle -N        edit-command-line
bindkey '^ee' edit-command-line
bindkey '^e^e' edit-command-line

## This function allows you type a file pattern,
## and see the results of the expansion at each step.
## When you hit return, they will be inserted into the command line.
autoload -U   insert-files
zle -N        insert-files
bindkey "^Xf" insert-files ## C-x-f

# "ctrl-e r" : search backwards using globbing
autoload -U   history-pattern-search
zle -N        history-pattern-search-backward history-pattern-search
bindkey '^er' history-pattern-search-backward

## Allow known mime types to be used as 'command'
autoload -U zsh-mime-setup
zsh-mime-setup

# Show what the completion system is trying to complete with at a given point
bindkey '^Xh' _complete_help


# "ctrl-x t" : tetris
autoload -U   tetris
zle -N        tetris
bindkey "^et" tetris ## C-x-t to play

# My own completions

compdef _options toggleopt      # tab completion for toggleopt
compdef _mkdir   mcd            # tab completion for mcd


# "alt-h" : run run-help.
# fancy stuff like "git add" starting man git-add works
autoload run-help


startup

# source any local settings we might have
foreach dotfile (/etc/zsh/local ~/.zshrc.local ~/.zshrc.$HOST ~/.zshrc.$USER); do
	if [[ -r $dotfile ]]; then; echo "Sourcing $dotfile"; source $dotfile; fi
done
