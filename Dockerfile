FROM alpine:latest
ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]
CMD ["help"]
WORKDIR /app

RUN apk --no-cache --update add ffmpeg python3 py3-requests youtube-dl \
    && python3 -m pip uninstall --yes setuptools pip \
    && find / | grep -E "(__pycache__|\.pyc|\.exe|\.pyo$)" | xargs rm -rf \
    && wget https://github.com/oliverjrose99/Recordurbate/archive/master.tar.gz -qO- | tar xzf - --strip-components=2 -C /app \
    && addgroup -g 1000 app && adduser -h /app -u 1000 -H -S -G app app \
    && sed -i 's/"./list.txt",/"logs/list.txt",/' /app/configs/config.json
    && mkdir -p /app/videos /app/configs /app/logs && chown 1000:1000 -R /app

VOLUME /app/videos /app/configs /app/logs