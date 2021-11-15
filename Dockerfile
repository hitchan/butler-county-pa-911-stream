FROM restreamio/gstreamer:latest-prod-dbg

ARG SCANNER_IP
ARG BROADCASTIFY_HOST
ARG USERNAME
ARG PASSWORD
ARG STREAM_NAME
ARG MOUNT

ENV SCANNER_IP=${SCANNER_IP}
ENV BROADCASTIFY_HOST=${BROADCASTIFY_HOST}
ENV USERNAME=${USERNAME}
ENV PASSWORD=${PASSWORD}
ENV STREAM_NAME=${STREAM_NAME}
ENV MOUNT=${MOUNT}

ENTRYPOINT gst-launch-1.0 rtspsrc location=rtsp://${SCANNER_IP}/au:scanner.au ! decodebin ! audioconvert ! audioresample ! lamemp3enc bitrate=32 mono=true target=bitrate cbr=true ! shout2send ip=${BROADCASTIFY_HOST} username=${USERNAME} password=${PASSWORD} public=true streamname=${STREAM_NAME} mount=${MOUNT}