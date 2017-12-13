#!/usr/bin/env bash
CURFILE=$(date +%Y%m%d_%H%M%S)
ffmpeg -t 2 -r 30 -f avfoundation -i "0" $CURFILE.mov
ffmpeg -y -i $CURFILE.mov -vf "fps=5,scale=320:-1:flags=lanczos,palettegen=stats_mode=diff" palette.png
ffmpeg -i $CURFILE.mov -i palette.png -filter_complex "fps=5,scale=320:-1:flags=lanczos[x];[x][1:v]paletteuse" -f gif - | gifsicle --optimize=3 --delay=8 > $CURFILE.gif
rm palette.png
rm $CURFILE.mov
FNAME=$(curl -F "UPLOADCARE_PUB_KEY=$UPLOADCARE_PUBLIC" \
     -F "UPLOADCARE_STORE=1" \
     -F "file=@$CURFILE.gif" \
     "https://upload.uploadcare.com/base/" | awk -F ':' '{print $2}' | tr -d '\"}')
URL="https://ucarecdn.com/$FNAME/$CURFILE.gif"
open -a Safari $URL
