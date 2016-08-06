FROM smartentry/alpine:3.4-beta

MAINTAINER Yifan Gao <docker@yfgao.com>

ADD docker /etc/docker-assets

ENV HOMEBREW_BOTTLE_DOMAIN="http://homebrew.bintray.com" \
    ENABLE_UNSET_ENV_VARIBLES=false

RUN smartentry.sh build

ADD . /root/.linuxbrew/Library/Taps/gaoyifan/homebrew-bottle-mirror

VOLUME /root/.cache/Homebrew /var/log

ENTRYPOINT ["/sbin/smartentry.sh"]

CMD sync.sh
