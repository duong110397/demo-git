ARG RUBY_VERSION
FROM ruby:$RUBY_VERSION
ARG RUBY_BUNDLER_VERSION
ENV LANG C.UTF-8
RUN apt-get update -qq && apt-get install apt-transport-https -yq
RUN curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list

RUN apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends nodejs xvfb ca-certificates unzip build-essential  libappindicator1 fonts-liberation google-chrome-stable default-mysql-client vim\
    && curl -o /tmp/noto.zip https://noto-website-2.storage.googleapis.com/pkgs/NotoSansCJKjp-hinted.zip \
    && mkdir /usr/share/fonts/noto \
    && unzip /tmp/noto.zip -d /usr/share/fonts/noto/ \
    && fc-cache -v \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && truncate -s 0 /var/log/*log

WORKDIR /build
RUN gem update --system &&\
    gem install -v $RUBY_BUNDLER_VERSION bundler
WORKDIR /kindy-rw-back
COPY . /kindy-rw-back
RUN mkdir -p tmp/sockets
ENV DISPLAY :99
ENV BUNDLER_VERSION $RUBY_BUNDLER_VERSION
RUN printf '#!/bin/sh\nXvfb :99 -screen 0 1280x1024x24 &\nexec "$@"\n' > /docker-entrypoint.sh && chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
