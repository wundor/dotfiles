#! /bin/bash

dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

$dotfiles ls-tree -rt HEAD:./ | awk '{if ($2 == "tree") print $4;}' | sed '/\.config$/d' | xargs -I{} $dotfiles add -v {}

echo "done"
