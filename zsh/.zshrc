# zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
autoload -U compinit
compinit
_comp_options+=(globdots)
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=1000
setopt SHARE_HISTORY

zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

VIM_MODE_VICMD_KEY='jk'
# VIM_MODE_INITIAL_KEYMAP='vicmd'
eval "$(starship init zsh)"
source ~/.zsh_plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh_plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
source ~/.zsh_plugins/zsh-vim-mode/zsh-vim-mode.plugin.zsh

MODE_INDICATOR_VIINS='%F{8}INSERT%f'
MODE_INDICATOR_VICMD='%F{2}NORMAL%f'
MODE_INDICATOR_REPLACE='%F{1}REPLACE%f'
MODE_INDICATOR_SEARCH='%F{5}SEARCH%f'
MODE_INDICATOR_VISUAL='%F{4}VISUAL%f'
MODE_INDICATOR_VLINE='%F{4}V-LINE%f'

MODE_CURSOR_VIINS="bar"
MODE_CURSOR_VICMD="block"
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

export PATH="$PATH:$HOME/.local/bin:$HOME/.cargo/bin"
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
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

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
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
