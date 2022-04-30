#!/bin/bash
# v4l2-ctl -d /dev/video0 --set-ctrl=exposure_auto=1
v4l2-ctl -d /dev/video0 --set-ctrl=exposure_absolute=300
v4l2-ctl -d /dev/video0 --set-ctrl=zoom_absolute=140
v4l2-ctl -d /dev/video0 --set-ctrl=sharpness=100
v4l2-ctl -d /dev/video0 --set-ctrl=gain=200
