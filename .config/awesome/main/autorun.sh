#!/usr/bin/env bash

function run {
    if ! pgrep -f $1 ;
    then
        $@&
    fi
}

# music
# run mpd
# run mpDris2 # add playerctl support to mpd

sleep 10

# compositor
picom --experimental-backends

# auth
run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1

python $HOME/.bin/mic-mute.py

$HOME/.bin/keyboard-setup.sh
$HOME/.bin/webcam-setup.sh
$HOME/.bin/mouse-setup.sh r
run xbanish
run flameshot
run nextcloud
run kdeconnect-indicator
# for logitech receiver
run solaar -w hide
# for elecom huge buttons
evrouter -q
rm /tmp/.evrouter*
run evrouter /dev/input/event*
