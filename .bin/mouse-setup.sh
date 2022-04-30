#!/bin/bash
STR=$1

xinput set-prop 'Logitech USB Trackball' 'libinput Scroll Method Enabled' 0, 0, 1
xinput set-prop 'Logitech USB Trackball' 'libinput Accel Speed' 1
xinput set-prop 'Logitech USB Trackball' 'libinput Natural Scrolling Enabled' 0

xinput set-prop 'Kensington Kensington Slimblade Trackball' 'libinput Scroll Method Enabled' 0, 0, 1
xinput set-prop 'Kensington Kensington Slimblade Trackball' 'libinput Natural Scrolling Enabled' 0

# for laptop trackpad
xinput set-prop 12 "libinput Tapping Enabled" 1
xinput set-prop 12 "libinput Natural Scrolling Enabled" 1

if [ $STR = 'l' ]; then
  xinput set-button-map "Logitech USB Trackball" 3 8 1 4 5 6 7 2 2
    xinput set-prop 'Logitech USB Trackball' 'libinput Button Scrolling Button' 9

    xinput set-prop "pointer:Kensington Kensington Slimblade Trackball" 'libinput Scroll Method Enabled' 0 0 1
    xinput set-prop 'Kensington Kensington Slimblade Trackball' 'libinput Button Scrolling Button' 7
    xinput set-prop 'Kensington Kensington Slimblade Trackball' 'libinput Middle Emulation Enabled' 1
    xinput set-button-map "Kensington Kensington Slimblade Trackball" 3 2 1 4 5 6 7 8 2
    xinput set-button-map $(xinput list --id-only 'pointer:Lenovo Lenovo Legion M600 Wireless Gaming Mouse') 3 2 1 4 5 6 7 8 9 10 11
    # xinput set-button-map "Kensington Kensington Slimblade Trackball" 1 2 3 4 5 6 7 8 9

fi

if [ $STR = 'r' ]; then
  xinput set-button-map "Logitech USB Trackball" 1 8 3 4 5 6 7 2 2
    xinput set-prop 'Logitech USB Trackball' 'libinput Button Scrolling Button' 8

    xinput set-prop 'Kensington Kensington Slimblade Trackball' 'libinput Button Scrolling Button' 8
    xinput set-button-map "Kensington Kensington Slimblade Trackball" 1 8 3 4 5 6 7 2 2
    xinput set-prop 'Kensington Kensington Slimblade Trackball' 'libinput Middle Emulation Enabled' 1

    xinput set-prop "pointer:ELECOM TrackBall Mouse HUGE TrackBall" 'libinput Scroll Method Enabled' 0 0 1
    xinput set-prop "pointer:ELECOM TrackBall Mouse HUGE TrackBall" 'libinput Button Scrolling Button' 12
    xinput set-prop $(xinput list --id-only 'pointer:ELECOM TrackBall Mouse HUGE TrackBall') 'libinput Middle Emulation Enabled' 1
    xinput set-button-map $(xinput list --id-only 'pointer:ELECOM TrackBall Mouse HUGE TrackBall') 1 8 3 4 5 6 7 9 8 10 11 2
    xinput set-button-map $(xinput list --id-only 'pointer:Lenovo Lenovo Legion M600 Wireless Gaming Mouse') 1 2 3 4 5 6 7 8 9 10 11
fi
