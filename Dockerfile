FROM smartentry/alpine:3.4-0.3.0

MAINTAINER Yifan Gao <docker@yfgao.com>

ADD docker $ASSETS_DIR

ENV HOMEBREW_BOTTLE_DOMAIN="http://homebrew.bintray.com" \
    HOMEBREW_CACHE="/srv/data"

RUN smartentry.sh build

ADD . /root/.linuxbrew/Library/Taps/gaoyifan/homebrew-bottle-mirror

VOLUME /srv/data /var/log

ENTRYPOINT ["/sbin/smartentry.sh"]

CMD sync.sh
