READNULLCMD=${PAGER:-/usr/bin/pager}

## set variables

XDG_CONFIG_HOME="$HOME/.config"
XDG_CACHE_HOME="$HOME/.cache"

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

# Source keybindings
source ~/.zshrc.keybindings;

# Source completion settings
source ~/.zshrc.completion;

# Source setopt options
source ~/.zshrc.setopt;

# Source aliases
source ~/.zshrc.aliases;

# Source named directories
source ~/.zshrc.named-dirs;

# Source ZLE settings
source ~/.zshrc.zle;

startup

# source any local settings we might have
foreach dotfile (/etc/zsh/local ~/.zshrc.local ~/.zshrc.$HOST ~/.zshrc.$USER); do
	if [[ -r $dotfile ]]; then; echo "Sourcing $dotfile"; source $dotfile; fi
done
