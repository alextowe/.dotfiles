#!/bin/zsh

IMAGE=/tmp/i3lock.png
LOCK=~/.config/sway/lock.png
LOCKARGS=""
 
for OUTPUT in `swaymsg -t get_outputs | jq -r '.[] | select(.active == true) | .name'`
do
    IMAGE=/tmp/$OUTPUT-lock.png
    grim -o $OUTPUT $IMAGE
    magick $IMAGE -scale 10% -blur 0x2 -resize 1000% $IMAGE
    composite -gravity center $IMAGE $IMAGE
    LOCKARGS="${LOCKARGS} --image ${OUTPUT}:${IMAGE}"
    IMAGES="${IMAGES} ${IMAGE}"
done

swaylock $LOCKARGS \
	--ignore-empty-password \
	--indicator-radius 60 \
	--text-color=ffffff00 \
	--ring-color=22222299 \
	--inside-color=ffffff00 \
	--line-color=ffffff00 \
	--key-hl-color=2f364099 \
	--bs-hl-color=2f364099 \
	--caps-lock-key-hl-color=2f364099 \
	--caps-lock-bs-hl-color=2f364099 \
	--separator-color=ffffff00 \
	--text-ver-color=ffffff00 \
	--ring-ver-color=44db3233 \
	--inside-ver-color=ffffff00 \
	--line-ver-color=ffffff00 \
	--text-clear-color=ffffff00 \
	--ring-clear-color=2f364099 \
	--inside-clear-color=ffffff00 \
	--line-clear-color=ffffff00 \
	--text-wrong-color=ffffff00 \
	--ring-wrong-color=c2361633 \
	--inside-wrong-color=ffffff00 \
	--line-wrong-color=ffffff00

rm $IMAGES
