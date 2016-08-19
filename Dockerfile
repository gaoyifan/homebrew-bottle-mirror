FROM smartentry/alpine:3.4-beta

MAINTAINER Yifan Gao <docker@yfgao.com>

ADD docker $ASSETS_DIR

ENV HOMEBREW_BOTTLE_DOMAIN="http://homebrew.bintray.com" \
    HOMEBREW_CACHE="/srv/data" \
    ENABLE_UNSET_ENV_VARIBLES=false

RUN smartentry.sh build

ADD . /root/.linuxbrew/Library/Taps/gaoyifan/homebrew-bottle-mirror

VOLUME /root/.cache/Homebrew /var/log

ENTRYPOINT ["/sbin/smartentry.sh"]

CMD sync.sh
