# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="custom_candy"

export NVM_LAZY_LOAD=true
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    # git
    # vi-mode
    poetry
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-vim-mode
    colored-man-pages
    zsh-nvm
    # tmux
)

# ZSH_TMUX_AUTOSTART=true
VIM_MODE_VICMD_KEY='jk'
# export ZVM_VI_ESCAPE_BINDKEY=jk
source $ZSH/oh-my-zsh.sh

MODE_INDICATOR_VIINS='%F{15}<%F{8}INSERT>%f'
MODE_INDICATOR_VICMD='%F{10}<%F{2}NORMAL>%f'
MODE_INDICATOR_REPLACE='%F{9}<%F{1}REPLACE>%f'
MODE_INDICATOR_SEARCH='%F{13}<%F{5}SEARCH>%f'
MODE_INDICATOR_VISUAL='%F{12}<%F{4}VISUAL>%f'
MODE_INDICATOR_VLINE='%F{12}<%F{4}V-LINE>%f'
#
# Example aliases
# if [[ $DISPLAY ]]; then
#     # If not running interactively, do not do anything
#     [[ $- != *i* ]] && return
#     [[ -z "$TMUX" ]] && exec tmux
# fi

setopt transientrprompt
source ~/.alias
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$($HOME'/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if type rg &> /dev/null; then
    export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --no-messages --glob '!.git/*'"
    # export FZF_DEFAULT_COMMAND="rg --files --hidden"
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi
# export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"
export FZF_DEFAULT_OPTS="--bind 'ctrl-d:preview-half-page-down,ctrl-u:preview-half-page-up'"
export FZF_CTRL_T_OPTS="
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
export FZF_CTRL_R_OPTS="
  --preview 'echo {}' --preview-window down:5:wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"
# export FZF_TMUX_OPTS='-p80%,60%'

export PATH="$HOME/.local/bin:$PATH"
export MANPAGER="nvim +Man!"
export EDITOR="nvim"
export VISUAL="nvim"
export DISABLE_AUTO_TITLE='true'

function _switch_cuda {
   v=$1
   export PATH=$PATH:/usr/local/cuda-$v/bin
   export CUDADIR=/usr/local/cuda-$v
   export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-$v/lib64
   nvcc --version
}
function gi() { curl -sLw n https://www.toptal.com/developers/gitignore/api/$@ ;}

eval "$(zoxide init zsh)"

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

function _glogshow(){
    git log \
        $(if [ -z ${2+x} ]; then echo "HEAD"; else echo "$2"; fi ) \
        --color=always \
        --format="%C(cyan)%h %C(auto)%s %C(yellow)%ar %C(red)%d %C(green)%ae" | \
        ( if [ $1 = "preview" ]; then
            fzf -i -e +s --reverse --ansi --preview="echo {} | cut -f 1 -d ' ' |  xargs git show --color=always" 
        else
            fzf -i -e +s --ansi --reverse
        fi)
}

function glp () {
    _glogshow "preview" $1
}

function glg() {
    _glogshow "--no-preview" $1
}
