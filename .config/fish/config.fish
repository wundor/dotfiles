if status is-interactive
    # Commands to run in interactive sessions can go here
end

export EDITOR=vim

# to jump around
zoxide init fish | source

#######
# FZF #
#######
# faster search - do not follow links and ignore hidden files
export FZF_CTRL_T_COMMAND='fd --type f'
set -U FZF_COMPLETE 0
export FZF_TMUX=1

bind \t '__fzf_complete'

###########
# ALIASES #
###########

alias gst="git status"
alias v="nvim"
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias r="TERM=xterm-256color ranger"

function gcb -d "Fuzzy-find and checkout a branch"
  git branch --all | grep -v HEAD | string trim | fzf | read -l result; and git checkout "$result"
end
