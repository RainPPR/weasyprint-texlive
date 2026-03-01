# syntax=docker/dockerfile:1
FROM python:alpine

RUN --mount=type=cache,target=/var/cache/apk,sharing=locked \
    apk add --update-cache \
    make bash tini tar zstd git ca-certificates curl wget \
    ghostscript biber fontconfig texlive-full \
    font-noto-cjk font-noto font-noto-extra font-noto-emoji \
    font-wqy-zenhei font-noto-cjk-extra \
    font-ipa font-ipaex font-dejavu font-unifont \
    font-liberation font-linux-libertine \
    weasyprint font-liberation font-liberation-sans-narrow ttf-linux-libertine \
    so:libgobject-2.0.so.0 so:libpango-1.0.so.0 so:libharfbuzz.so.0 so:libharfbuzz-subset.so.0 so:libfontconfig.so.1 so:libpangoft2-1.0.so.0 \
    gcc musl-dev python3-dev zlib-dev jpeg-dev openjpeg-dev libwebp-dev g++ libffi-dev \
    && fc-cache -fv

RUN pip install --no-cache-dir weasyprint
RUN curl -sSLf https://gist.github.com/jumanjiman/f9d3db977846c163df12/raw/9c88ada4af1df5fae66474b54b53fc4201e545f0/harden.sh | sh

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["weasyprint", "--version"]