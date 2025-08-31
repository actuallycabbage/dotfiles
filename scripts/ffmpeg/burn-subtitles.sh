#!/bin/bash

INPUT_FILE="$1"
OUTPUT_FILE="$2"
SUBTITLE_TRACK="$3"
QUALITY="$4"

ffmpeg -i "$INPUT_FILE" \
    -vf "subtitles='$INPUT_FILE':si=$SUBTITLE_TRACK,format=p010le" \
    -map 0:v:0 -map 0:a:m:language:eng \
    -c:a copy \
    -c:v hevc_videotoolbox -profile:v main10 -pix_fmt p010le \
    -q:v $QUALITY \
    -tag:v hvc1 \
    "$OUTPUT_FILE"

