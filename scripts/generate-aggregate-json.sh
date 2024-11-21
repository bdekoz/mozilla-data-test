#!/usr/bin/env bash

get_aggregate() {
    TESTN="$1"
    PLATFORMN="$2"
    ISODATE="$3"
    TPLATFORM="${PLATFORMN}-${TESTN}"
    ARTIFACT_BASE="${ISODATE}-${TPLATFORM}";

    ./generate_aggregate_json_by_date.py "$TESTN" "$PLATFORMN" "$ISODATE" "${ARTIFACT_BASE}-side-by-side.mp4" "${ARTIFACT_BASE}-firefox-filmstrip.json" "${ARTIFACT_BASE}-firefox-cold-browsertime-metrics.json" "${ARTIFACT_BASE}-chrome-filmstrip.json" "${ARTIFACT_BASE}-chrome-cold-browsertime-metrics.json"
}

#get_aggregate "amazon" "android" "2024-11-15"
get_aggregate "amazon" "linux" "2024-11-20"
get_aggregate "amazon" "win11" "2024-11-20"

#get_aggregate "amazon" "android" "2024-11-11"
