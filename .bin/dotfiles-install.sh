git clone --bare git@github.com:wundor/dotfiles.git $HOME/.dotfiles

function dotfiles {
   /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}

mkdir -p .dotfiles-backup
dotfiles checkout
if [ $? = 0 ]; then
  echo "Checked out dotfiles.";
  else
    echo "Backing up pre-existing dotfiles.";
    dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} sh -c 'rsync --remove-source-files --mkpath {} .dotfiles-backup/{} || rsync --remove-source-files {} .dotfiles-backup/{}'
fi;
dotfiles checkout
dotfiles config status.showUntrackedFiles no

