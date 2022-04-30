#!/bin/bash

scrot /tmp/lock.png
convert /tmp/lock.png /tmp/lock.jpg
file=/tmp/lock.jpg

function datamosh() {
	fileSize=$(wc -c < "$file")
	headerSize=1000
	skip=$(shuf -i "$headerSize"-"$fileSize" -n 1)
	count=$(shuf -i 1-10 -n 1)
	for i in $(seq 1 $count);do byteStr=$byteStr'\x'$(shuf -i 0-255 -n 1); done;
	printf $byteStr | dd of="$file" bs=1 seek=$skip count=$count conv=notrunc >/dev/null 2>&1
}

steps=$(shuf -i 40-70 -n 1)
for i in $(seq 1 $steps);do datamosh "$file"; done

LOCK=()
while read LINE
do
	if [[ "$LINE" =~ ([0-9]+)x([0-9]+)\+([0-9]+)\+([0-9]+) ]]; then
		W=${BASH_REMATCH[1]}
		H=${BASH_REMATCH[2]}
		Xoff=${BASH_REMATCH[3]}
		Yoff=${BASH_REMATCH[4]}
	fi
done <<<"$(xrandr)"

convert /tmp/lock.jpg /tmp/lock.png >/dev/null 2>&1
rm /tmp/lock.jpg
file=/tmp/lock.png
convert "$file" "${LOCK[@]}" "$file"
[[ -f $1 ]] && convert "$file" $1 -gravity center -composite -matte "$file"
i3lock -n "${PARAM[@]}" -i "$file" > /dev/null 2>&1

##############
# OLD VERSION:
##############
# sleep 0.5
# TMPBG=/tmp/screen.png
# scrot $TMPBG
# convert $TMPBG -scale 10% -scale 1000% $TMPBG
# i3lock -i $TMPBG
# rm $TMPBG
