#!/bin/bash

if [ -f /app/config ]; then
    source /app/config
fi

: "${VIDEO_SRC:=videotestsrc is-live=true pattern=ball}"
: "${ENCODER:=x264enc tune=zerolatency bitrate=512 speed-preset=superfast}"
: "${PAYLOADER:=rtph264pay config-interval=1 pt=96}"
: "${UDP_SINK:=udpsink host=127.0.0.1 port=5000}"

: "${HLS_PAYLOADER:=mpegtsmux}"
: "${HLS_SINK:=hlssink max-files=5 target-duration=2 playlist-root=http://localhost:8080 location=/app/hls/segment_%05d.ts playlist-location=/app/hls/playlist.m3u8}"

mkdir -p /app/hls

echo "[INFO] Starting NGINX server..."
nginx

echo "[INFO] Starting GStreamer pipelines..."
gst-launch-1.0 -v $VIDEO_SRC ! $ENCODER ! $PAYLOADER ! $UDP_SINK &
gst-launch-1.0 -v $VIDEO_SRC ! $ENCODER ! $HLS_PAYLOADER ! $HLS_SINK
