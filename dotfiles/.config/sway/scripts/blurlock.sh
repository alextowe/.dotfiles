#!/bin/zsh

IMAGE=/tmp/i3lock.png
LOCK=~/.config/sway/lock.png
LOCKARGS=""
 
for OUTPUT in `swaymsg -t get_outputs | jq -r '.[] | select(.active == true) | .name'`
do
    IMAGE=/tmp/$OUTPUT-lock.png
    grim -o $OUTPUT $IMAGE
    magick $IMAGE -blur 0x8 $IMAGE
    composite -gravity center $LOCK $IMAGE $IMAGE
    LOCKARGS="${LOCKARGS} --image ${OUTPUT}:${IMAGE}"
    IMAGES="${IMAGES} ${IMAGE}"
done
swaylock $LOCKARGS \
	--ignore-empty-password \
	--indicator-radius 60 \
	--text-color=ffffff00 \
	--ring-color=ffffff3e \
	--inside-color=ffffff00 \
	--line-color=ffffff00 \
	--key-hl-color=00000080 \
	--bs-hl-color=9933333e \
	--caps-lock-key-hl-color=00000080 \
	--caps-lock-bs-hl-color=9933333e \
	--separator-color=00000080 \
	--text-ver-color=ffffff00 \
	--ring-ver-color=0099333e \
	--inside-ver-color=ffffff00 \
	--line-ver-color=ffffff00 \
	--text-clear-color=ffffff00 \
	--ring-clear-color=ff99003e \
	--inside-clear-color=ffffff00 \
	--line-clear-color=ffffff00 \
	--text-wrong-color=ffffff00 \
	--ring-wrong-color=9933333e \
	--inside-wrong-color=ffffff00 \
	--line-wrong-color=ffffff00

rm $IMAGES
