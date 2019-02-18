FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:0
RUN apt-get update && apt-get install -y xvfb imagemagick x11-apps busybox

WORKDIR /app
COPY app .

ENTRYPOINT [ "/app/entrypoint.sh" ]
