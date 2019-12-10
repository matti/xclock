FROM alpine:3.10
ENV DISPLAY=:0

RUN apk add --no-cache \
  bash \
  xclock

WORKDIR /app
COPY app .

ENTRYPOINT [ "/app/entrypoint.sh" ]
