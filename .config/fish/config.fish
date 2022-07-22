if status is-interactive
    # Commands to run in interactive sessions can go here
end

export EDITOR=vim

# to jump around
zoxide init fish | source

pyenv init - | source

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
  git fetch; and git branch --all | grep -v HEAD | string trim | fzf | awk -F/ '{print $NF}' | read -l result; and git switch "$result"; and git pull
end


function ranger
  set tempfile (mktemp -t tmp.XXXXXX)
  set command_argument "map Q chain shell echo %d > $tempfile; quitall"
  command ranger --cmd="$command_argument" $argv
  if test -s $tempfile
   set ranger_pwd (cat $tempfile)
   if test -n $ranger_pwd -a -d $ranger_pwd
    builtin cd -- $ranger_pwd
   end
  end

  command rm -f -- $tempfile
end
