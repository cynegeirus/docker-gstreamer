FROM ubuntu

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Istanbul
ENV LANG=tr_TR.UTF-8
ENV LANGUAGE=tr_TR.UTF-8
ENV LC_ALL=tr_TR.UTF-8

RUN apt update 
RUN apt install -y gstreamer1.0-tools gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-libav nginx curl bash supervisor sudo vim nano wget curl net-tools locales bzip2 wmctrl software-properties-common ttf-wqy-zenhei 
RUN apt clean
RUN rm -rf /var/lib/apt/lists/*
RUN locale-gen tr_TR.UTF-8

WORKDIR /app

COPY streamer/nginx.conf /etc/nginx/nginx.conf
COPY streamer/entrypoint.sh /app/entrypoint.sh
COPY streamer/entrypoint.sh /app/entrypoint.sh

RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]
