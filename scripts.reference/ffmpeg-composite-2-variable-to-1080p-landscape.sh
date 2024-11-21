#! /usr/bin/bash

# Compress two IG portait inputs to one landcape output (centered vertically)
# input files are 1080 x 1350 pixels
# output files are 1920 x 1080 pixels
#
# so 2-up h that is 2160 x 1350 pixels per frame, needs 20% reduction
# 1080 x .8 = 864
# 1350 x .8 = 1080

# x offsets are (864 * 2 ) == 1728, 1920 - 1728 == 192,
# -> 192 / 2 = 96 each pad
# -> 192 / 4 = 48 each pad
# -> offsets are 48 left and (960 + 48 == 1008) right



inONE=$1
inTWO=$2


hONE=`ffprobe -v error -select_streams v:0 -show_entries stream=height -of csv=s=x:p=0 ${inONE}`
wONE=`ffprobe -v error -select_streams v:0 -show_entries stream=width -of csv=s=x:p=0 ${inONE}`



ffmpeg \
    -f lavfi -i color=c=white:size=1920x1080 -i $inONE -i $inTWO \
    -filter_complex "nullsrc=size=1920x1080 [base]; [0:v] setpts=PTS-STARTPTS [deepspace]; [1:v] setpts=PTS-STARTPTS, scale=864x1080 [left]; [2:v] setpts=PTS-STARTPTS, scale=864x1080 [right]; [base][deepspace] overlay=shortest=1 [tmp1]; [tmp1][left] overlay=shortest=1:x=48:y=0 [tmp2]; [tmp2][right] overlay=shortest=1:x=1008:y=0 " \
    -c:v libx264 merge-2-channel.mkv;
