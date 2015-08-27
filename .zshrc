READNULLCMD=${PAGER:-/usr/bin/pager}

## Set basic environment variables

# Something basic from RichiH's dotfile
XDG_CONFIG_HOME="$HOME/.config"
XDG_CACHE_HOME="$HOME/.cache"

## Basic oh-my-zsh configuration stuff
# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(adb git debian dirhistory extract git-flow github gpg-agent nmap python pip rsync screen)

# User configuration

# PATH-variables

# oh-my-zsh:
# export PATH="/usr/lib/ccache:/usr/lib/x86_64-linux-gnu/libfm:/usr/local/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games"
# export MANPATH="/usr/local/man:$MANPATH"

# RichiH
PATH+=:/usr/bin
PATH=/usr/local/bin:$PATH
[[ -d /usr/lib/ccache ]] && PATH=/usr/lib/ccache:$PATH
[[ -d ~/.bin ]] && PATH=~/.bin:$PATH
[[ -d ~/bin ]] && PATH=~/bin:$PATH
[[ -d /usr/local/vim_extended/bin ]] && PATH=/usr/local/vim_extended/bin:$PATH

# oh-my-zsh:
source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

watch=(notme)
LOGCHECK=300
WATCHFMT='%n %a %l from %m at %t.'

HISTFILE=~/.zsh_history
SAVEHIST=50000
HISTSIZE=50000

# RichiH:
EDITOR="vim"

# oh-my-zsh:
# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

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

# oh-my-zsh:
# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Source keybindings
source ~/.zshrc.keybindings;

# Source completion settings
source ~/.zshrc.completion;

# Source setopt options
source ~/.zshrc.setopt;

# oh-my-zsh:
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# RichiH:
# Source aliases
source ~/.zshrc.aliases;

# Source named directories
source ~/.zshrc.named-dirs;

# Source ZLE settings
source ~/.zshrc.zle;

## Load other dotfiles
# RichiH
startup

# source any local settings we might have
foreach dotfile (/etc/zsh/local ~/.zshrc.local ~/.zshrc.$HOST ~/.zshrc.$USER); do
	if [[ -r $dotfile ]]; then; echo "Sourcing $dotfile"; source $dotfile; fi
done
