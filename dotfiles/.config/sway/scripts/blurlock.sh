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
	--ring-color=2222223e \
	--inside-color=ffffff00 \
	--line-color=ffffff00 \
	--key-hl-color=2F36403e \
	--bs-hl-color=2F36403e \
	--caps-lock-key-hl-color=22222280 \
	--caps-lock-bs-hl-color=22222280 \
	--separator-color=ffffff00 \
	--text-ver-color=ffffff00 \
	--ring-ver-color=44BD323e \
	--inside-ver-color=ffffff00 \
	--line-ver-color=ffffff00 \
	--text-clear-color=ffffff00 \
	--ring-clear-color=2F36403e \
	--inside-clear-color=ffffff00 \
	--line-clear-color=ffffff00 \
	--text-wrong-color=ffffff00 \
	--ring-wrong-color=c236163e \
	--inside-wrong-color=ffffff00 \
	--line-wrong-color=ffffff00

rm $IMAGES
