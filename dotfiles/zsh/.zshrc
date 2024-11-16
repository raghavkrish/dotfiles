# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
zstyle ':omz:plugins:eza' 'icons' yes
zstyle ':omz:plugins:eza' 'dirs-first' yes
zstyle ':omz:plugins:eza' 'header' yes
zstyle ':omz:plugins:eza' 'git-status' no
if [ -f "$HOME/.dracula-zsh-syntax" ]; then
  source "$HOME/.dracula-zsh-syntax"
fi
plugins=(git httpie jsontools macos zsh-autosuggestions zsh-syntax-highlighting sublime you-should-use chucknorris sudo)

# Load brew completions

## Use this if you get insecure directories error
## chmod go-w "$(brew --prefix)/share"
## chmod -R go-w "$(brew --prefix)/share/zsh"
# FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
# autoload -Uz compinit
# compinit


source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# custom env vars
export FD_EXCLUDE_DIRS="(.git|node_modules)"
EZA_DEFAULT_OPTIONS="--color=always --icons=always"

# Load eza Dracula theme
if [ -f "$HOME/.config/eza/dracula.sh" ]; then
    source "$HOME/.config/eza/dracula.sh"
fi

# eza aliases
alias ls="eza ${EZA_DEFAULT_OPTIONS}"
alias lf="eza ${EZA_DEFAULT_OPTIONS} -f"
alias lff="eza ${EZA_DEFAULT_OPTIONS} -af"
alias ld="eza ${EZA_DEFAULT_OPTIONS} -D"
alias ldd="eza ${EZA_DEFAULT_OPTIONS} -aD"
alias le="eza -al"
alias lst="eza ${EZA_DEFAULT_OPTIONS} --tree --group-directories-first"

# zoxide config
export _ZO_ECHO=1
export _ZO_RESOLVE_SYMLINKS=1
export _ZO_FZF_OPTS="--info=inline --select-1 --exit-0 --height=50% --layout=reverse --keep-right --preview-window=right --preview='\command eza -1 ${EZA_DEFAULT_OPTIONS} --all --group-directories-first {2..}'"

# source packages
source <(fzf --zsh)
eval $(thefuck --alias)
eval "$(zoxide init --cmd cd zsh)"

# fzf opts and searching
export FZF_DEFAULT_OPTS="--tmux --reverse --preview 'bat -n --color=always {} --style=numbers'"
export FZF_CTRL_T_OPTS="--height=100%"
export FZF_ALT_C_OPTS="--preview 'eza --all --group-directories-first {2..} --color=always --icons=always {}'"
export FZF_COMPLETION_OPTS='--border --info=inline'
alias fs="fd --type f | fzf-tmux -p --reverse | xargs subl"
alias fsh="fd --type f --hidden | fzf-tmux -p --reverse | xargs subl"
alias fn="fd --type f | fzf-tmux -p --reverse | xargs nvim"
alias fnh="fd --type f --hidden | fzf-tmux -p --reverse | xargs nvim"

# bat config
export BAT_THEME=Dracula
alias cat='bat'

# brew aliases
alias bi="brew install"
alias bci="brew install --cask"
alias br="brew remove"
alias bd="brew doctor"
alias bl="brew list"
alias bcu="brew cleanup"
alias bu="brew update"
alias bubc="brew update && brew upgrade & brew cleanup"
alias bsstart='brew services start'
alias bsstop='brew services stop'

# load curl to path
export PATH="/opt/homebrew/opt/curl/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/curl/lib"
export CPPFLAGS="-I/opt/homebrew/opt/curl/include"

# general aliases
alias rl='source ~/.zshrc'
alias pf="fzf ${FZF_CTRL_T_OPTS}"
alias lg='lazygit'
alias dsize='du -hsc'
alias cl='clear'
alias hide='chflags hidden'
alias unhide='chflags nohidden'
alias asitop='/Users/raghav/misc/custom-commands/asitop'
alias scheduler='/Users/raghav/misc/custom-commands/scheduler'
alias zshconf='subl ~/dotfiles/.zshrc'
alias zshconfig='vi ~/dotfiles/.zshrc'
alias free='btop'
alias y='yazi'

# zellij aliases
alias z="zellij"
alias zc="zellij --layout compact"
alias zs="zellij -s"
alias zls="zellij ls"
alias za="zellij a"
alias zk="zellij k"
alias zka="zellij ka"
alias zd="zellij d"
alias zda="zellij da"
alias zrf="zellij run --floating -- "
alias zrb="zellij run -c -- "

# Docker aliases
alias di="docker images"
alias dia='docker images -a'
alias dca="docker ps -a -q"
alias dcr='docker ps'
alias drc='docker rm'
alias dri='docker rmi'
alias drac="docker rm $(docker ps -a -q)"
alias drai="docker rmi $(docker images -a -q)"
alias dstop="docker stop"
alias dstart='docker start'
alias dbl='docker build'
alias dsp='docker system prune'

dssh() {
  docker exec -it $1 /bin/bash
}

# functions
rdf() {
  if [ $# -lt 2 ]
  then
    echo "Usage: $funcstack[1] <dir> <filename>"
    return
  fi
  find $1 -name $2
  find $1 -name $2 -delete
}

cdn() {
  mkdir -p $1
  cd $1
}

copy() {
  cat $1 | pbcopy
}

# load nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
source /Users/raghav/.rvm/scripts/rvm

# typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
# chuck_cow
eval "$(atuin init zsh)"
. /opt/homebrew/opt/asdf/libexec/asdf.sh
. ~/.asdf/plugins/golang/set-env.zsh

# export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
# zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
# source <(carapace _carapace)
