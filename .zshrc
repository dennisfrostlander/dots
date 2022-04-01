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
export PATH="$HOME/.local/bin:$PATH"
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="/usr/local/opt/ruby@2.7/bin:$PATH"
export PATH=~/bin:$PATH

export VISUAL=nvim;
export EDITOR=nvim;
export ANDROID_SDK_ROOT=~/Library/Android/sdk;
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_281.jdk/Contents/Home;

source ~/.antigen.zsh
antigen use oh-my-zsh
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

THEME=robbyrussell
antigen list | grep $THEME; if [ $? -ne 0 ]; then antigen theme $THEME; fi

antigen apply

# User configuration
[ -f /etc/bash_completion.d/g4d ] && source /etc/bash_completion.d/g4d
[ -f /etc/bash_completion.d/hgd ] && source /etc/bash_completion.d/hgd

git_prompt_info() {
  ws=$(pwd | sed -n -E -e "s/\/google\/src\/cloud\/${USER}\/(.*)\/.*/\1/p")
  if ! [[ -z ${ws} ]]; then
    BLUE='\033[0;36m'
    NC='\033[0m'
    echo "${BLUE}[${ws}]${NC} "
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

bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

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

rsync_watch() {
  rsync --copy-links --progress --recursive "$1" "$2"
  while inotifywait -r -e create,delete,modify "$(p4 g4d)/$1";
    do rsync --copy-links --progress --recursive "$1" "$2"
    done
  }

[ -f ~/.zshrc_icons ] && source ~/.zshrc_icons
(command -v gdircolors &> /dev/null) && eval $(gdircolors ~/.dir_colors)
(command -v dircolors &> /dev/null) && eval $(dircolors ~/.dir_colors)

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/frostlander/google-cloud-sdk/path.zsh.inc' ];
  then . '/Users/frostlander/google-cloud-sdk/path.zsh.inc';
fi

# The next line enables shell command completion for gcloud.
# if [ -f '/Users/frostlander/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/frostlander/google-cloud-sdk/completion.zsh.inc'; fi

# After lf exits, cd to last visited dir.
[[ $(alias l) ]] && unalias l
l() {
  tmp="$(mktemp)"
  lf --last-dir-path="$tmp" "$@"
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

