FROM node:lts-alpine

RUN set -ex && mkdir /app
RUN apk add --no-cache python3 youtube-dl
RUN wget https://ghproxy.com/https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -O /usr/local/bin/yt-dlp && chmod a+rx /usr/local/bin/yt-dlp

COPY ./precompiled/* /app/
COPY ./*.crt /app/
COPY ./*.key /app/

ENV SIGN_CERT /app/server.crt
ENV SIGN_KEY /app/server.key
ENV NODE_ENV production

WORKDIR /app

EXPOSE 80 6789 8080 8081

ENTRYPOINT ["node", "app.js"]
