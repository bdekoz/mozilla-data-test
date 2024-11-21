#!/usr/bin/env bash

ODIR=tmp
if [ ! -d tmp ]; then
    mkdir $ODIR
fi

get_side_by_side() {
    TPLATFORM="$1"
    ISODATE="$2"
    ARTIFACT_BASE="$ISODATE-$TPLATFORM";

    # firefox left, chrome right
    LEFT="$ARTIFACT_BASE-firefox.mp4"
    RIGHT="$ARTIFACT_BASE-chrome.mp4"

    ./generate_video_side_by_side_standalone.py --base-video $LEFT --new-video $RIGHT --remove-orange

    # rename
    mv custom-side-by-side.mp4 ${ODIR}/${ARTIFACT_BASE}-side-by-side.mp4
    mv before-rs.mp4 ${ODIR}/${ARTIFACT_BASE}-firefox.mp4
    mv after-rs.mp4 ${ODIR}/${ARTIFACT_BASE}-chrome.mp4

    # remove gen
    rm after*.mp4
    rm before*.mp4
}

#get_side_by_side "android-amazon" "2024-11-11"
get_side_by_side "linux-amazon" "2024-11-20"
get_side_by_side "win11-amazon" "2024-11-20"
