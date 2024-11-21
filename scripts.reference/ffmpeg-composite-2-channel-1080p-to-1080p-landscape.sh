#! /usr/bin/bash

# compress two landscape inputs to one landcape output (centered vertically)
# input files
inONE=$1
inTWO=$2
filterF="nullsrc=size=1920x1080 [base]; [0:v] setpts=PTS-STARTPTS [deepspace]; [1:v] setpts=PTS-STARTPTS, scale=960x540 [left]; [2:v] setpts=PTS-STARTPTS, scale=960x540 [right]; [base][deepspace] overlay=shortest=1 [tmp1]; [tmp1][left] overlay=shortest=1:x=0:y=270 [tmp2]; [tmp2][right] overlay=shortest=1:x=960:y=270 "


ffmpeg \
    -f lavfi -i color=c=white:size=1920x1080 -i $inONE -i $inTWO \
    -filter_complex "nullsrc=size=1920x1080 [base]; [0:v] setpts=PTS-STARTPTS [deepspace]; [1:v] setpts=PTS-STARTPTS, scale=960x540 [left]; [2:v] setpts=PTS-STARTPTS, scale=960x540 [right]; [base][deepspace] overlay=shortest=1 [tmp1]; [tmp1][left] overlay=shortest=1:x=0:y=270 [tmp2]; [tmp2][right] overlay=shortest=1:x=960:y=270 " \
    -c:v libx264 merge-2-channel.mkv;
