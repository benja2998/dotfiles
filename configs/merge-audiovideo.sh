#!/bin/bash

VIDEO=""
AUDIO=""
MODE="replace"
OUTPUT="output.mp4"

while getopts "v:a:m:o:" opt; do
    case $opt in
	v) VIDEO="$OPTARG" ;;
	a) AUDIO="$OPTARG" ;;
	m) MODE="$OPTARG" ;;
	o) OUTPUT="$OPTARG" ;;
	*) echo "Usage: $0 -v video.mp4 -a audio.wav [-m replace|add|mix] [-o output.mp4]"; exit 1 ;;
    esac
done

if [ -z "$VIDEO" ] || [ -z "$AUDIO" ]; then
    echo "Error: Video and audio are required."
    exit 1
fi

if ! command -v ffmpeg &> /dev/null; then
    echo "ffmpeg not found. Please install ffmpeg."
    exit 1
fi

case $MODE in
    replace)
	ffmpeg -i "$VIDEO" -i "$AUDIO" -c:v copy -c:a aac -map 0:v:0 -map 1:a:0 -shortest "$OUTPUT"
	;;
    add)
	ffmpeg -i "$VIDEO" -i "$AUDIO" -c:v copy -c:a aac -map 0 -map 1:a:0 -shortest "$OUTPUT"
	;;
    mix)
	ffmpeg -i "$VIDEO" -i "$AUDIO" -filter_complex "[1:a]volume=0.5[a1];[0:a][a1]amix=inputs=2:duration=shortest[a]" -map 0:v:0 -map "[a]" -c:v copy -c:a aac "$OUTPUT"
	;;
    *)
	echo "Invalid mode. Use replace, add, or mix."
	exit 1
	;;
esac

echo "Done! Output: $OUTPUT"
