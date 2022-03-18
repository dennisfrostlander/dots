# Start profiling
# zmodload zsh/zprof

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# export NVM_DIR="$HOME/.nvm"
#   [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
#   [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
export PATH="/Users/frostlander/.nvm/versions/node/v12.22.6/bin:$PATH"
export PATH="/usr/local/opt/curl/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/projects/lua-language-server/bin:$PATH"
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="/usr/local/opt/ruby@2.7/bin:$PATH"
export PATH=~/bin:$PATH

export VISUAL=nvim;
export EDITOR=nvim;
export ANDROID_SDK_ROOT=~/Library/Android/sdk;
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_281.jdk/Contents/Home;

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  # npm
  # git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

DISABLE_AUTO_UPDATE="true"
source ~/.oh-my-zsh/oh-my-zsh.sh

# User configuration
[ -f /etc/bash_completion.d/g4d ] && source /etc/bash_completion.d/g4d
[ -f /etc/bash_completion.d/hgd ] && source /etc/bash_completion.d/hgd

prompt_hg() {}
git_prompt_info() {
  ws=$(pwd | sed -n -E -e "s/\/google\/src\/cloud\/${USER}\/(.*)\/.*/\1/p")
  if ! [[ -z ${ws} ]]; then
    YELLOW='\033[0;33m'
    NC='\033[0m'
    echo "(${ws}) "
  fi
}

bindkey '^I' expand-or-complete-prefix
bindkey '^u' autosuggest-accept

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

function run-again {
    zle up-history
    zle accept-line
}
zle -N run-again
bindkey '^n' run-again

bindkey "^o" up-line-or-search
bindkey "^b" down-line-or-search

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

setopt    append_history     #Append history to the history file (no overwriting)
setopt    share_history      #Share history across terminals
setopt    inc_append_history  #Immediately append to the history file, not just when a term is killed

pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

# aliases
alias b="blaze build"
alias bo="blaze build -c opt"
alias bd="blaze build -c dbg"
alias bi="iblaze build"
alias bc="build_cleaner"
alias r="blaze run"
alias ri="iblaze run"
alias t="blaze test --test_output=errors --trim_test_configuration"
alias ti="iblaze test --test_output=errors --trim_test_configuration"
alias td="fetch-merge-test-results && TRUST_DIFF_DRIVER_EXIT_CODE=1 vimdiff-test-results"
alias d="debug -gdb=gdb"
alias h="hg xl"
alias hup="hg update"
alias hu="hg uploadchain"
alias hua="hg amend && hg uploadchain"
alias ham="hg amend"
alias hc="hg commit"
alias hm="hg mail -m"
alias hma="hg mail --autosubmit -m"
alias hs="hg sync"
alias hss="hg shelve && hg sync && hg unshelve"
alias hh="hg update p4head"
alias hr="hg rebase -s tip -d p4head"
alias hev="hg evolve"
alias hamt="hg amend && hg evolve && hg update tip"
alias hd="hg --pager always diff"
# Npm
alias ni="npm install"
alias ns="npm start"
alias nt="npm test"
alias nb="npm run build"
# Editing
alias vim="nvim"
alias vimdiff='nvim -d'
alias e='nvim'
alias en='nvim -u ~/.vimrc_napa'
# Navigation
alias gt="cd ~/projects/travelhub-client"
alias gtb="cd ~/projects/travelhub-build"

alias fixjs=/google/src/components/head/google3/third_party/java_src/jscomp/java/com/google/javascript/jscomp/lint/fixjs.sh
alias gsa=/google/src/files/head/depot/google3/java/com/google/android/apps/gsa/tools/gsa_cli/gsa_cli.sh

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#696969"

rsync_watch() {
  rsync --copy-links --progress --recursive "$1" "$2"
  while inotifywait -r -e create,delete,modify "$(p4 g4d)/$1";
    do rsync --copy-links --progress --recursive "$1" "$2"
    done
  }

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# bindkey -v

function set-title-precmd() {
  printf "\e]2;%s\a" "${PWD/#$HOME/~}"
}

function set-title-preexec() {
  printf "\e]2;%s\a" "$1"
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd set-title-precmd
add-zsh-hook preexec set-title-preexec
# function zle-line-init zle-keymap-select {
   #VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]%  %{$reset_color%}"
   #RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
   #zle reset-prompt
# }

# zle -N zle-line-init
# zle -N zle-keymap-select

# export KEYTIMEOUT=1

source ~/.zshrc_icons
eval $(gdircolors ~/.dir_colors)

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/frostlander/google-cloud-sdk/path.zsh.inc' ];
  then . '/Users/frostlander/google-cloud-sdk/path.zsh.inc';
fi

# The next line enables shell command completion for gcloud.
# if [ -f '/Users/frostlander/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/frostlander/google-cloud-sdk/completion.zsh.inc'; fi

# After lf exits, cd to last visited dir.
l() {
  tmp="$(mktemp)"
  /usr/local/bin/lf --last-dir-path="$tmp" "$@"
  if [ -f "$tmp" ]; then
    dir="$(cat "$tmp")"
    rm -f "$tmp"
    if [ -d "$dir" ]; then
      if [ "$dir" != "$(pwd)" ]; then
          cd "$dir"
      fi
    fi
  fi
}

dx() {
  curl -O --output-dir ~/Downloads $1
  f=$(echo $1 | sed -n -E -e "s/.*\/(.*)/\1/p")
  b=$(echo "$f" | sed -n -E -e "s/(.*)\.zip/\1/p")
  unzip -o ~/Downloads/"$f" -d ~/Downloads/"$b"
  lf ~/Downloads/"$b"
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# End profiling
# zprof

